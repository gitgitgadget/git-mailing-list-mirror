Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FA0F201B0
	for <e@80x24.org>; Sat, 18 Feb 2017 13:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753262AbdBRNdm (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Feb 2017 08:33:42 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36312 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753015AbdBRNdl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2017 08:33:41 -0500
Received: by mail-pg0-f67.google.com with SMTP id a123so4596727pgc.3
        for <git@vger.kernel.org>; Sat, 18 Feb 2017 05:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zQMBYTl5z2uUp9ONozyIgCiABGzTn4X3+WIxsP+yUVk=;
        b=QSZV/1QY5TQdfjO0+bfxHUxdVdKWp69dRt6YLs7wnvue2GH6j2AdKkdHoZzPTRM36o
         IA4HvLb3s6M/Ax8ILV9F+0lVT4Din59Sxixnot/f/HK9feZhClKFLF3C9QDaiEPC9Q6F
         /06rhzwt1Qqvadvd6IhN7r5nzxxF17hs0m6LySOQxea+5lWYBztsOlNF7Amq4HHI1MgU
         CkatqCH64R1ixOds9LdIZQ9ssrggipk+lEEQSMrNDvhAuE0syfGVxkP8RIf/9Y/6RhEh
         nk05OMIQABhmd8MD29hDoDQoi6AV4pqM5xenzVVjceo6WHLEQL4Hv8rVi5yh0ElYfoel
         jBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zQMBYTl5z2uUp9ONozyIgCiABGzTn4X3+WIxsP+yUVk=;
        b=exHSQcrH9iQ0fWDQo2TgX9IgQlmjs6c8xMjRvm9d4BCb8CVS6ghRCxWOrw9Miuhifv
         SWq5o0LVXWhdDYxupnigvQlPlm82Pay+Fj532V9bsXFW1I7b2sSu92bm16TuK7XX8OoU
         btAsHGj2rtDDwKiLBZEmq4tXx+i2OGvADFT+W9Pa0XAMrps+wkoeTp4VtQFEykDzSFhw
         MJCGJcsrf/jDs3g0q88ac2CktdGZR2lk/HDTDh7ItK4sr0lz9VKKlsS3XFWffpnCSRhb
         Nc0rBSdrSP4j+smfXK3Hcj/bIzV1IDwY7JHDeFLnsjA0b4nVFRBwYcxXK9EhXKFQNtQT
         aoEg==
X-Gm-Message-State: AMke39krTehojvjSn75qZAY999+GLn9/eeu3w/o0oeNUvEK4nRcYvKyCsbc0P89umJNJPA==
X-Received: by 10.99.39.195 with SMTP id n186mr3332566pgn.178.1487424820491;
        Sat, 18 Feb 2017 05:33:40 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id b18sm25429555pfd.106.2017.02.18.05.33.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Feb 2017 05:33:39 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 18 Feb 2017 20:33:33 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 03/15] files-backend: add files_path()
Date:   Sat, 18 Feb 2017 20:32:51 +0700
Message-Id: <20170218133303.3682-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170218133303.3682-1-pclouds@gmail.com>
References: <20170217140436.17336-1-pclouds@gmail.com>
 <20170218133303.3682-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This will be the replacement for both git_path() and git_path_submodule()
in this file. The idea is backend takes a git path and use that,
oblivious of submodule, linked worktrees and such.

This is the middle step towards that. Eventually the "submodule" field
in 'struct files_ref_store' should be replaced by "gitdir". And a
compound ref_store is created to combine two files backends together,
one represents the shared refs in $GIT_COMMON_DIR, one per-worktree. At
that point, files_path() becomes a wrapper of strbuf_vaddf().

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs/files-backend.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index c6c86f850..7eaf28bd6 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -930,6 +930,24 @@ struct files_ref_store {
 /* Lock used for the main packed-refs file: */
 static struct lock_file packlock;
 
+__attribute__((format (printf, 3, 4)))
+static void files_path(struct files_ref_store *refs, struct strbuf *sb,
+		       const char *fmt, ...)
+{
+	struct strbuf tmp = STRBUF_INIT;
+	va_list vap;
+
+	va_start(vap, fmt);
+	strbuf_vaddf(&tmp, fmt, vap);
+	va_end(vap);
+	if (refs->submodule)
+		strbuf_git_path_submodule(sb, refs->submodule,
+					  "%s", tmp.buf);
+	else
+		strbuf_git_path(sb, "%s", tmp.buf);
+	strbuf_release(&tmp);
+}
+
 /*
  * Increment the reference count of *packed_refs.
  */
-- 
2.11.0.157.gd943d85

