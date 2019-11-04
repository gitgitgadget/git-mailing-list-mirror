Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D1F41F454
	for <e@80x24.org>; Mon,  4 Nov 2019 19:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbfKDT0t (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 14:26:49 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55787 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbfKDT0t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 14:26:49 -0500
Received: by mail-wm1-f66.google.com with SMTP id m17so8740443wmi.5
        for <git@vger.kernel.org>; Mon, 04 Nov 2019 11:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mkN9BsfCc/iz/xm43gSyr+9Ztt/ivVWqUwClJKeE5WA=;
        b=akXIUkpRfy+95Igs/+nTnSiia+ujTZYrJepag76H/eMyc4KMBlixUX0tgFTPPkbD5e
         ogGwFvli3TC9+XUoaB+dGsV9+XSxa1wwIUJdYaT9NANIzZfIGnyprGACBmJHyLqJE2kQ
         MkO+jvKTd3cy5YRPDXfVUK9EPR9E+wX5II9nt2aTSE7+pDbWcXskonVeZ3aQ8JD8k4oJ
         Gx4SEcJmdax0fZjy9oOahI3X7sabxxpapglcsT/9BiN5qtUB+uOPJZC6BQLEruJblsgo
         mxnQ6qrFnrhl7ckk7shtjE026/2/cdg7P7d4Qcy+e7+enIZnwW04SzEtBRYnbg47qAkF
         PXJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mkN9BsfCc/iz/xm43gSyr+9Ztt/ivVWqUwClJKeE5WA=;
        b=rMmM1Ds/fN1QibaXhGMeTqWxxSZL9iU0o6IdY7k5FqRRts4aw6Dae3URjjrk9Uk/HT
         cc0WiE1xFlGBQ70yLeQg+YmK87R5LWLyrNYpTMVPnNJHdGZg4RFHGNU1tGoeist4qQL6
         OHlScqFSDPBxXCSTKZUNtJhDVyx9BjzjsClOGjgrgPchbIUaBkAL9bg4urmdfzjjE629
         iZ6weV8jxHkRhTXW/kUdgqxuel6rJGUNcT0kMgObNyFf1c4G/u8N3e4FV35ybDi0nWZ0
         iuaMRiQyJ+MAKhjEVVQhQDvdtsTm1zJG91mH4TRLwhH9PQ5dusDZX7h23TBkLItLmYae
         czkA==
X-Gm-Message-State: APjAAAUHT5BU3knKbVgmFTFpAUqS5NuVZj38ofl7FnmcLneCgpTRQ+Eu
        IQOghpsaJxTsae1smJ1n9ogZYima
X-Google-Smtp-Source: APXvYqzyZ3WcYecDWI3+6fXcWXKvxzpVNC1R1S+7jYVphi5LQh5QnQO0o5cLBgRG7zaSd3LwiDqtrQ==
X-Received: by 2002:a1c:b4c1:: with SMTP id d184mr575133wmf.37.1572895607147;
        Mon, 04 Nov 2019 11:26:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a206sm25308400wmf.15.2019.11.04.11.26.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 11:26:46 -0800 (PST)
Message-Id: <52e7a84a2ee61d6481286f6a32751107efc234d0.1572895605.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.445.git.1572895605.gitgitgadget@gmail.com>
References: <pull.445.git.1572895605.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 Nov 2019 19:26:41 +0000
Subject: [PATCH 1/5] pathspec: add new function to parse file
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

This will be used to support the new option '--pathspec-from-file' in
`git add`, `git-commit`, `git reset` etc.

Note also that we specifically handle CR/LF line endings to support
Windows better.

To simplify code, file is first parsed into `argv_array`. This allows
to avoid refactoring `parse_pathspec()`.

I considered adding `nul_term_line` to `flags` instead, but decided
that it doesn't fit there.

The new code is mostly taken from `cmd_update_index()` and
`split_mail_conv()`.

Co-authored-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 pathspec.c | 41 +++++++++++++++++++++++++++++++++++++++++
 pathspec.h | 10 ++++++++++
 2 files changed, 51 insertions(+)

diff --git a/pathspec.c b/pathspec.c
index 12c2b322b3..97d4e77875 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -3,6 +3,8 @@
 #include "dir.h"
 #include "pathspec.h"
 #include "attr.h"
+#include "argv-array.h"
+#include "quote.h"
 
 /*
  * Finds which of the given pathspecs match items in the index.
@@ -613,6 +615,45 @@ void parse_pathspec(struct pathspec *pathspec,
 	}
 }
 
+void parse_pathspec_file(struct pathspec *pathspec, unsigned magic_mask,
+			 unsigned flags, const char *prefix,
+			 const char *file, int nul_term_line)
+{
+	struct argv_array parsed_file = ARGV_ARRAY_INIT;
+	strbuf_getline_fn getline_fn = nul_term_line ? strbuf_getline_nul :
+						       strbuf_getline;
+	struct strbuf buf = STRBUF_INIT;
+	struct strbuf unquoted = STRBUF_INIT;
+	FILE *in = NULL;
+
+	if (!strcmp(file, "-"))
+		in = stdin;
+	else
+		in = fopen(file, "r");
+
+	if (!in)
+		die(_("could not open '%s' for reading"), file);
+
+	while (getline_fn(&buf, in) != EOF) {
+		if (!nul_term_line && buf.buf[0] == '"') {
+			strbuf_reset(&unquoted);
+			if (unquote_c_style(&unquoted, buf.buf, NULL))
+				die(_("line is badly quoted"));
+			strbuf_swap(&buf, &unquoted);
+		}
+		argv_array_push(&parsed_file, buf.buf);
+		strbuf_reset(&buf);
+	}
+
+	strbuf_release(&unquoted);
+	strbuf_release(&buf);
+	if (in != stdin)
+		fclose(in);
+
+	parse_pathspec(pathspec, magic_mask, flags, prefix, parsed_file.argv);
+	argv_array_clear(&parsed_file);
+}
+
 void copy_pathspec(struct pathspec *dst, const struct pathspec *src)
 {
 	int i, j;
diff --git a/pathspec.h b/pathspec.h
index 1c18a2c90c..d72e0b4c4a 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -85,6 +85,16 @@ void parse_pathspec(struct pathspec *pathspec,
 		    unsigned flags,
 		    const char *prefix,
 		    const char **args);
+/*
+ * Same as parse_pathspec() but uses file as input.
+ * When 'file' is exactly "-" it uses 'stdin' instead.
+ */
+void parse_pathspec_file(struct pathspec *pathspec,
+		    unsigned magic_mask,
+		    unsigned flags,
+		    const char *prefix,
+		    const char *file,
+		    int nul_term_line);
 void copy_pathspec(struct pathspec *dst, const struct pathspec *src);
 void clear_pathspec(struct pathspec *);
 
-- 
gitgitgadget

