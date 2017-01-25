Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A6FB1F437
	for <e@80x24.org>; Wed, 25 Jan 2017 05:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751287AbdAYF2B (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 00:28:01 -0500
Received: from mail-ua0-f194.google.com ([209.85.217.194]:33269 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751276AbdAYF2A (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 00:28:00 -0500
Received: by mail-ua0-f194.google.com with SMTP id d5so18337958uag.0
        for <git@vger.kernel.org>; Tue, 24 Jan 2017 21:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ji/yXEGSmXKyZ4BnVPhpPr/xCZZyCmIKXbkZVomNJaY=;
        b=C2G4RSx0OlPEd3BZl+T7DmaDGJdta2eJLktzIM5LDeSo0Y+0emMsb01hPlAIrXZ1vZ
         W3LSH8ckOVAPBs8Z1s4sA/PXzUtR8D16CNZLaaUB7qAfNo/F8oFv/H/2YbT9is3Ph1ng
         twzecfUpVZSMrhxYfEGt9N2AFIN/u4VxHoW2UlKg+OgyC3P0AxXPMp0EdSAOARTfkrCR
         z6VMddDyyZrqMHpTHWu2436nxHjoDYXdb0KeqZFKs/ly3DS/ZkPQ+WU23iDsPTba2mYs
         E76AhPGsQrwkGQEa5BK9LwybzH/zA6D91Q1m8smf9+HVApJbFM1pwasFjSU/ZPv1j4Af
         Y4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ji/yXEGSmXKyZ4BnVPhpPr/xCZZyCmIKXbkZVomNJaY=;
        b=EC7xLiz25hsbnOeco0TsbExBBhHz6GmrlItxzSq+lTdAPE+3vcO9U8js7+jdtSYIsr
         RoJIZeb1cVffFGJLNU4K3NOsx8l/ZCLOM+59XI6KeaEA4NopluyIZAGkYO5Ve3R7FS6S
         nfXvtvpb0I8D814Y6ARasTD7ARd2daJR6w239pbJNQUVHejHdVCtJNmhVUjP3f5a28OZ
         S08tp3U3elbNkrhP+SSZpeOEebZykN+gtmPDNxXoVIIRatgP+c6yDAPHCugjh6SRbpHX
         3dWUweer8pFV+QrqhCoKjfHp+BEez7yfdz0r3wWYOMQlvGqQk89rH4IAbkzLR5jkOM+t
         FX7g==
X-Gm-Message-State: AIkVDXIsjXE2g4ApZznxL6c3bNQhMvALmrB1EbA5oOE4OfaSt4fb9zG9pbnWyaYoLcSAeQ==
X-Received: by 10.176.81.51 with SMTP id e48mr16821916uaa.100.1485322079799;
        Tue, 24 Jan 2017 21:27:59 -0800 (PST)
Received: from linuxerio.cabletica.com (ip203-162-64-186.ct.co.cr. [186.64.162.203])
        by smtp.gmail.com with ESMTPSA id d9sm8794212uag.4.2017.01.24.21.27.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jan 2017 21:27:59 -0800 (PST)
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
To:     git@vger.kernel.org
Cc:     apelisse@gmail.com, kevin@sb.org, gitster@pobox.com, peff@peff.net,
        Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: [PATCH v1 3/3] blame: add --color option
Date:   Tue, 24 Jan 2017 23:27:34 -0600
Message-Id: <20170125052734.17550-3-eantoranz@gmail.com>
X-Mailer: git-send-email 2.11.0.rc1
In-Reply-To: <20170125052734.17550-1-eantoranz@gmail.com>
References: <20170125052734.17550-1-eantoranz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Revision information will be highlighted so that it's easier
to tell from content of the file being "blamed".

Signed-off-by: Edmundo Carmona Antoranz <eantoranz@gmail.com>
---
 Documentation/blame-options.txt |  5 +++++
 Documentation/git-blame.txt     |  2 +-
 builtin/blame.c                 | 13 +++++++++++++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index 64858a631..4abb4eb7e 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -57,6 +57,11 @@ include::line-range-format.txt[]
 	Show revision hints on aggregated information about the revision.
 	Implies --aggregate.
 
+--[no-]color::
+	Revision information will be highlighted on normal output
+	when running git from a terminal. This option allows
+	for color to be forcibly enabled or disabled.
+
 --encoding=<encoding>::
 	Specifies the encoding used to output author names
 	and commit summaries. Setting it to `none` makes blame
diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index ed8b119fa..d25cbc5ef 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 [verse]
 'git blame' [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-e] [-p] [-w] [--incremental]
 	    [-L <range>] [-S <revs-file>] [-M] [-C] [-C] [-C] [--since=<date>]
-	    [--progress] [--abbrev=<n>] [--aggregate] [--hint]
+	    [--progress] [--abbrev=<n>] [--aggregate] [--hint] [--color]
 	    [<rev> | --contents <file> | --reverse <rev>..<rev>] [--] <file>
 
 DESCRIPTION
diff --git a/builtin/blame.c b/builtin/blame.c
index 7473b50e9..c661dd538 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1886,6 +1886,7 @@ static const char *format_time(unsigned long time, const char *tz_str,
 #define OUTPUT_LINE_PORCELAIN 01000
 #define OUTPUT_AGGREGATE      02000
 #define OUTPUT_HINT           04000
+#define OUTPUT_COLOR         010000
 
 static void emit_porcelain_details(struct origin *suspect, int repeat)
 {
@@ -1943,6 +1944,8 @@ static void emit_porcelain(struct scoreboard *sb, struct blame_entry *ent,
 static void print_revision_info(char* revision_hex, int revision_length, struct blame_entry* ent,
 		struct commit_info ci, int opt, int show_raw_time, int line_number)
 {
+	if (opt & OUTPUT_COLOR)
+		printf("%s", GIT_COLOR_BOLD);
 	if (!line_number)
 		printf("\t");
 	int length = revision_length;
@@ -2008,6 +2011,8 @@ static void print_revision_info(char* revision_hex, int revision_length, struct
 			printf(" %s", ci.summary.buf);
 		printf("\n");
 	}
+	if (opt & OUTPUT_COLOR)
+		printf("%s", GIT_COLOR_RESET);
 }
 
 static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
@@ -2608,6 +2613,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	char *final_commit_name = NULL;
 	enum object_type type;
 	struct commit *final_commit = NULL;
+	int show_color;
 
 	struct string_list range_list = STRING_LIST_INIT_NODUP;
 	int output_option = 0, opt = 0;
@@ -2647,6 +2653,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		OPT_STRING_LIST('L', NULL, &range_list, N_("n,m"), N_("Process only line range n,m, counting from 1")),
 		OPT_BIT(0, "aggregate", &output_option, N_("Aggregate output"), OUTPUT_AGGREGATE),
 		OPT_BIT(0, "hint", &output_option, N_("Show revision hints"), OUTPUT_HINT),
+		OPT_BOOL(0, "color", &show_color, N_("Show colors on revision information")),
 		OPT__ABBREV(&abbrev),
 		OPT_END()
 	};
@@ -2666,6 +2673,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	save_commit_buffer = 0;
 	dashdash_pos = 0;
 	show_progress = -1;
+	show_color = -1;
 
 	parse_options_start(&ctx, argc, argv, prefix, options,
 			    PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_ARGV0);
@@ -2698,6 +2706,11 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	} else if (show_progress < 0)
 		show_progress = isatty(2);
 
+	if (show_color < 0)
+		show_color = isatty(1);
+	if (show_color)
+		output_option = output_option | OUTPUT_COLOR;
+
 	if (0 < abbrev && abbrev < GIT_SHA1_HEXSZ)
 		/* one more abbrev length is needed for the boundary commit */
 		abbrev++;
-- 
2.11.0.rc1

