Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8BEC1F404
	for <e@80x24.org>; Mon, 29 Jan 2018 22:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752326AbeA2WjB (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 17:39:01 -0500
Received: from mail-yb0-f201.google.com ([209.85.213.201]:46802 "EHLO
        mail-yb0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751875AbeA2Wi4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 17:38:56 -0500
Received: by mail-yb0-f201.google.com with SMTP id f142so6638835yba.13
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 14:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=OtDNBTkJauSTMtaJ6wiRhWXK3YMEnUDL0PZnYGVIUBE=;
        b=bDNDoow48VvEf21i/El+aeC/JfqpnldScb4ggZ4qyvLkJLhvkoc+ZbMCh415S9G4O8
         GThoyWmclTG6b752oLPIyqBfuat0WKVLQbry7zxH50H/S/04knD9abaka/uDkwKx2XUI
         azwrLUw/Cfe149oR6O7IdkxqsVPNMCw6grxxFPZ0lUAi1vNhPzki51/HRhZInOguCESN
         WliZLZDojfL+WEbf5Y9SHfo1pV9rwO8MTjCfBGATd2Os4Eju9aaHIdoWkpPWd6+F8qF3
         FqGZSlwuqi5YN9RcLgylfZ2ldyBFdVKpfCYRcG6tOQhzQQhy6GgaQeoHEuyWokg1FpPo
         pCqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=OtDNBTkJauSTMtaJ6wiRhWXK3YMEnUDL0PZnYGVIUBE=;
        b=psNhManiCy5b8VMrg/6wijCpww4YFrfEmqh+woydmITVUR1kDJKcxXnbL9kgHSRgzD
         C2IHExJr1tq2jE9HD6l2Q6P7xZgGSBoKuO/yqmbzPcF+KuSHPY91TstWhZtu7X9RrxrZ
         pMR4rMpwuzq/VFnj9iUAipjTdcb9hXlKDw6Jdq8bpXXNe46M3vMlHXrJ0B9ddKDYBZai
         CDm7aecmLrFPGtJM1dFo9jgOHK6RDq3+/kAMTcYkyrenomJiYIXFv9BBmZmV2n+tSriY
         /6+sI9qk13aOPd1kGAhVePffbpLBEa84zaAVTcRLJWOC6V3JixhEHa6hozOv/upvfHMY
         3mdQ==
X-Gm-Message-State: AKwxytf6RuZZ3pq9UlU3yCzUf9QAoo2ie74ypn3AX3MRp1rPJn+7fP+k
        MXce6N4WdV1399fiHIttr3giAPkzyc96/J7xsaWo7D0wPAyshmuJietJZCwi6OBtdX1xUj7RkRC
        px/caJvaDGi1uer9PNv8q6cWGnU0tqP/UDo+CMNWPdIgH1mACNi5KNa64pQ==
X-Google-Smtp-Source: AH8x2264ROrAYRIswCg8tQhz1WAWMuazeni8jx1tQV2jc47Wu2DNrpy1Io53Ah83iJnyvMWabudZO+NHOz0=
MIME-Version: 1.0
X-Received: by 10.13.222.69 with SMTP id h66mr11766901ywe.82.1517265535549;
 Mon, 29 Jan 2018 14:38:55 -0800 (PST)
Date:   Mon, 29 Jan 2018 14:37:23 -0800
In-Reply-To: <20180129223728.30569-1-bmwill@google.com>
Message-Id: <20180129223728.30569-33-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH 32/37] diff: rename 'template' variables
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, avarab@gmail.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename C++ keyword in order to bring the codebase closer to being able
to be compiled with a C++ compiler.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 diff.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index d49732b3b..142a633e1 100644
--- a/diff.c
+++ b/diff.c
@@ -3660,15 +3660,15 @@ static void prep_temp_blob(const char *path, struct diff_tempfile *temp,
 			   int mode)
 {
 	struct strbuf buf = STRBUF_INIT;
-	struct strbuf template = STRBUF_INIT;
+	struct strbuf tempfile = STRBUF_INIT;
 	char *path_dup = xstrdup(path);
 	const char *base = basename(path_dup);
 
 	/* Generate "XXXXXX_basename.ext" */
-	strbuf_addstr(&template, "XXXXXX_");
-	strbuf_addstr(&template, base);
+	strbuf_addstr(&tempfile, "XXXXXX_");
+	strbuf_addstr(&tempfile, base);
 
-	temp->tempfile = mks_tempfile_ts(template.buf, strlen(base) + 1);
+	temp->tempfile = mks_tempfile_ts(tempfile.buf, strlen(base) + 1);
 	if (!temp->tempfile)
 		die_errno("unable to create temp-file");
 	if (convert_to_working_tree(path,
@@ -3683,7 +3683,7 @@ static void prep_temp_blob(const char *path, struct diff_tempfile *temp,
 	oid_to_hex_r(temp->hex, oid);
 	xsnprintf(temp->mode, sizeof(temp->mode), "%06o", mode);
 	strbuf_release(&buf);
-	strbuf_release(&template);
+	strbuf_release(&tempfile);
 	free(path_dup);
 }
 
-- 
2.16.0.rc1.238.g530d649a79-goog

