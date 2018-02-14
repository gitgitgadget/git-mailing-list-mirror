Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE4351F404
	for <e@80x24.org>; Wed, 14 Feb 2018 19:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162557AbeBNTBn (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 14:01:43 -0500
Received: from mail-ot0-f201.google.com ([74.125.82.201]:34162 "EHLO
        mail-ot0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162545AbeBNTBj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 14:01:39 -0500
Received: by mail-ot0-f201.google.com with SMTP id l18so9417957otd.1
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 11:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=hgI8f9akeioZHb8nuu3CAGL5WtgtU1Koo40bxhbQzU0=;
        b=iziXMBVV2kd6jgwN8Sccpfd7inPXL8jy3zwajYi9Qv5Oul+xYoqFEtXdOWsQ2b4qev
         kabheEUK5YeYVVb7y1GI73BBsdyKpx9U4VPv9TpOUww9+HWlbGsjEfJSm/zRZ1xGbjSx
         9dcI2EkBM/Ic4ihoHOIvToKiFsFhKHmmBYHY9yYEAFbDnSZKaUIYXQkraq2TLBo1J3PN
         +GyTqZX89rhNXSEcyBvs8q+f0ruDLUPptPkrYLRVQPYtc37ymBxhKzvGjQSSMHcPbhXv
         ZzjrMMoYgtqYYpw47ZcQQttnHoS4JS8OJA7G14Pst/O1BbDYLnl1lGPzNzS+DjMNpjCy
         t5aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=hgI8f9akeioZHb8nuu3CAGL5WtgtU1Koo40bxhbQzU0=;
        b=hcRq8aGWCTJDtUysgkyDNbkICssDhJBeewkJP7BFFmhNRdYGY+QUDw88FcgoKXxPPm
         NVAPmuvBAR6neeJ9StQ9ncJTskby6BF/4EAV//FW/PWQDJYJ1W0YicwCQRoh7gs634IN
         IWN1+fcBWgiiiLP88H0S0Cw2ww05Cs8jCJeceNHS+7OxgAkicEORx2OIXYLRJ2KVMD25
         dLp+NOy9lcImxLFtC0S3naiip3lN/H/NffhksRm9KtE7e61iVG1Wu5mE+KBrsgykHh6/
         KBqx49v870DIuvPFdsAFrgUni74SZN3wEIfRakeQdBSAPNlRmJo3aV2L+ZuHtjpsuJp3
         b4Pg==
X-Gm-Message-State: APf1xPAzVhe7ylgIcKSjpAEomH/vNWAHGcL3zbpUVMooEHmybfIsyYyz
        amfeRyJ5bn5vQ1xJ/aFbsyyraNUOIGiR2e8QPs8/TQvDhi9KHiREjLaYr2lWyB1Db+e/l9q4jh3
        Hy1nSsp3OT1vc7Z0dAkdbmr0Wwin/HIvSZQgqG5x60NQrtE4YBuKXjxLtnA==
X-Google-Smtp-Source: AH8x2245i4JuQbxcvtANBE2Z77mnw9w1smqPfNxN2uEmz5EAkLIy6W6urqL5oIBSZbY6MeVpe/MuvqFH9YM=
MIME-Version: 1.0
X-Received: by 10.157.115.207 with SMTP id m15mr22750otk.102.1518634898632;
 Wed, 14 Feb 2018 11:01:38 -0800 (PST)
Date:   Wed, 14 Feb 2018 10:59:43 -0800
In-Reply-To: <20180214185959.221906-1-bmwill@google.com>
Message-Id: <20180214185959.221906-22-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com> <20180214185959.221906-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.109.g93438bbb9.dirty
Subject: [PATCH v2 21/37] imap-send: rename 'new' variables
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, sbeller@google.com, avarab@gmail.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename C++ keyword in order to bring the codebase closer to being able
to be compiled with a C++ compiler.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 imap-send.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 36c7c1b4f..ffb0a6eca 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1189,11 +1189,11 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, char *f
  */
 static void lf_to_crlf(struct strbuf *msg)
 {
-	char *new;
+	char *new_msg;
 	size_t i, j;
 	char lastc;
 
-	/* First pass: tally, in j, the size of the new string: */
+	/* First pass: tally, in j, the size of the new_msg string: */
 	for (i = j = 0, lastc = '\0'; i < msg->len; i++) {
 		if (msg->buf[i] == '\n' && lastc != '\r')
 			j++; /* a CR will need to be added here */
@@ -1201,18 +1201,18 @@ static void lf_to_crlf(struct strbuf *msg)
 		j++;
 	}
 
-	new = xmallocz(j);
+	new_msg = xmallocz(j);
 
 	/*
-	 * Second pass: write the new string.  Note that this loop is
+	 * Second pass: write the new_msg string.  Note that this loop is
 	 * otherwise identical to the first pass.
 	 */
 	for (i = j = 0, lastc = '\0'; i < msg->len; i++) {
 		if (msg->buf[i] == '\n' && lastc != '\r')
-			new[j++] = '\r';
-		lastc = new[j++] = msg->buf[i];
+			new_msg[j++] = '\r';
+		lastc = new_msg[j++] = msg->buf[i];
 	}
-	strbuf_attach(msg, new, j, j + 1);
+	strbuf_attach(msg, new_msg, j, j + 1);
 }
 
 /*
-- 
2.16.1.291.g4437f3f132-goog

