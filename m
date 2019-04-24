Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F22E91F453
	for <e@80x24.org>; Wed, 24 Apr 2019 15:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730687AbfDXPWd (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 11:22:33 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40753 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730666AbfDXPWd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 11:22:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id h4so25724939wre.7
        for <git@vger.kernel.org>; Wed, 24 Apr 2019 08:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WpwQqL0dC6JyBKU6qbuPMyLqVH3tcPeO7tvdXQ4bwRc=;
        b=KEzPsnvxXMdvZLjf2kJrjxfkG6Xl2rN8Reoncj/02BiLZkOCiKuS8otRokhnxfltjk
         s9LPg9h/l1MgJ87wgG+nqUJbg0zA/bf4vEOhGTfyCNEBa7zW86HCHbWR+I+1eaM8ccQP
         2kf+dsKAn3hSs87gaVjibsCdVczOUOU8uxA5VKtsG+W0zk/eQ10/Fi6xcIs+efcib6L0
         NZ+2P+6WmXQ4Bg92/B4wG4l5mADccmX9m1QCu+4+6Twe0bu5BBFZNLMKL8aWwqVCLk64
         7myaliqo6mVXP5Do9II89X8j+ix8WnNq/eut9iUbBR26xdHFKOiHhIThFqz55tZjsTQL
         /ykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WpwQqL0dC6JyBKU6qbuPMyLqVH3tcPeO7tvdXQ4bwRc=;
        b=Xo6WTqfW82ataDAqC9VFEOKN2fkE6c5acV8Qu00dFPhaoPTji808aCta/7PrWLBUrC
         Qy8lISeTbxSJnaCHJpSyA1g1ac6Xk/gR+bygX4de7ACaPkcR3h1dWKk+bHfBYdV+XcSY
         a2/UFcoALE4Ss/CnVshOMPyH9UKxhJvleOy7B2IOL9lNCOxy6zdT1hzSVGkOF8fqW2m6
         xwQuADmQI0YsCmMq49+E1W8X5WxRw3Y9zAsLyFQY907MpWP3d646SeAP/F/akbtsMYlK
         zBVW4LxBgzV8YHhMuMoHfEOI6BLJNHH9Cd8ec7e7TqMEQGE87V8yE5SzBEud+jytHQJZ
         EpTg==
X-Gm-Message-State: APjAAAXi3Q4OA+wTTULI1yZiNRrD3T/mrMrUX8GUBV4VRvFSqqGrM6os
        oSUEjmzooqabA7Mb8evJWVERlwO4
X-Google-Smtp-Source: APXvYqzdsRNmJ+vMJBHOhhKQjTdTRt+I8kfHoq5A5b5OLAptbwPA0b86kHDu41xDcZlqB/L9lkHawQ==
X-Received: by 2002:a5d:4445:: with SMTP id x5mr1068292wrr.120.1556119350710;
        Wed, 24 Apr 2019 08:22:30 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d187sm3289802wmd.42.2019.04.24.08.22.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Apr 2019 08:22:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Jeff King <peff@peff.net>, Julia Lawall <julia.lawall@lip6.fr>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] diffcore-pickaxe: add --pickaxe-raw-diff for use with -G
Date:   Wed, 24 Apr 2019 17:22:15 +0200
Message-Id: <20190424152215.16251-3-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18
In-Reply-To: <20190424102609.GA19697@vmlxhi-102.adit-jv.com>
References: <20190424102609.GA19697@vmlxhi-102.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the ability for the -G<regex> pickaxe to search only through added
or removed lines in the diff, or even through an arbitrary amount of
context lines when combined with -U<n>.

This has been requested[1][2] a few times in the past, and isn't
currently possible. Instead users need to do -G<regex> and then write
their own post-parsing script to see if the <regex> matched added or
removed lines, or both. There was no way to match the adjacent context
lines other than running and grepping the equivalent of a "log -p -U<n>".

1. https://public-inbox.org/git/xmqqwoqrr8y2.fsf@gitster-ct.c.googlers.com/
2. https://public-inbox.org/git/20190424102609.GA19697@vmlxhi-102.adit-jv.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/diff-options.txt | 17 +++++++++++++
 diff.c                         |  3 +++
 diff.h                         |  2 ++
 diffcore-pickaxe.c             | 34 ++++++++++++++++++++++---
 t/t4013-diff-various.sh        |  1 +
 t/t4209-log-pickaxe.sh         | 45 ++++++++++++++++++++++++++++++++++
 6 files changed, 98 insertions(+), 4 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 09faee3b44..f367b40362 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -579,6 +579,9 @@ occurrences of that string did not change).
 Unless `--text` is supplied patches of binary files without a textconv
 filter will be ignored.
 +
+When `--pickaxe-raw-diff` is supplied the whole diff is searched
+instead of just added/removed lines. See below.
++
 See the 'pickaxe' entry in linkgit:gitdiffcore[7] for more
 information.
 
@@ -600,6 +603,20 @@ The object can be a blob or a submodule commit. It implies the `-t` option in
 	Treat the <string> given to `-S` as an extended POSIX regular
 	expression to match.
 
+--pickaxe-raw-diff::
+	When `-G` looks for a change a diff will be generated, and
+	only the added/removed lines will be matched against with the
+	"+" or "-" stripped.
++
+Supplying this option skips that pre-processing. This makes it
+possible to match only lines that added or removed something matching
+a <regex> with "\^\+<regex>" and "^-<regex>", respectively.
++
+It also allows for finding something in the diff context. E.g. "\^
+<regex>" will match the context lines (see `-U<n>` above) around the
+added/removed lines, and doing an unanchored match will match any of
+the the added/removed lines & diff context.
+
 endif::git-format-patch[]
 
 -O<orderfile>::
diff --git a/diff.c b/diff.c
index 4d3cf83a27..4cdc000ee5 100644
--- a/diff.c
+++ b/diff.c
@@ -5503,6 +5503,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_BIT_F(0, "pickaxe-regex", &options->pickaxe_opts,
 			  N_("treat <string> in -S as extended POSIX regular expression"),
 			  DIFF_PICKAXE_REGEX, PARSE_OPT_NONEG),
+		OPT_BIT_F(0, "pickaxe-raw-diff", &options->pickaxe_opts,
+			  N_("have <string> in -G match the raw diff output"),
+			  DIFF_PICKAXE_G_RAW_DIFF, PARSE_OPT_NONEG),
 		OPT_FILENAME('O', NULL, &options->orderfile,
 			     N_("control the order in which files appear in the output")),
 		OPT_CALLBACK_F(0, "find-object", options, N_("<object-id>"),
diff --git a/diff.h b/diff.h
index b20cbcc091..d431fbc602 100644
--- a/diff.h
+++ b/diff.h
@@ -370,6 +370,8 @@ int git_config_rename(const char *var, const char *value);
 				 DIFF_PICKAXE_KIND_OBJFIND)
 
 #define DIFF_PICKAXE_IGNORE_CASE	32
+#define DIFF_PICKAXE_G_RAW_DIFF		64
+
 
 void diffcore_std(struct diff_options *);
 void diffcore_fix_diff_index(void);
diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 3c6416bfe2..e23f04b4f0 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -17,14 +17,18 @@ typedef int (*pickaxe_fn)(mmfile_t *one, mmfile_t *two,
 struct diffgrep_cb {
 	regex_t *regexp;
 	int hit;
+	int raw_diff;
 };
 
 static void diffgrep_consume(void *priv, char *line, unsigned long len)
 {
 	struct diffgrep_cb *data = priv;
 	regmatch_t regmatch;
+	int raw_diff = data->raw_diff;
+	const char *string = raw_diff ? line : line + 1;
+	size_t size = raw_diff ? len : len - 1;
 
-	if (line[0] != '+' && line[0] != '-')
+	if (!raw_diff && line[0] != '+' && line[0] != '-')
 		return;
 	if (data->hit)
 		/*
@@ -32,7 +36,7 @@ static void diffgrep_consume(void *priv, char *line, unsigned long len)
 		 * caller early.
 		 */
 		return;
-	data->hit = !regexec_buf(data->regexp, line + 1, len - 1, 1,
+	data->hit = !regexec_buf(data->regexp, string, size, 1,
 				 &regmatch, 0);
 }
 
@@ -44,15 +48,36 @@ static int diff_grep(mmfile_t *one, mmfile_t *two,
 	struct diffgrep_cb ecbdata;
 	xpparam_t xpp;
 	xdemitconf_t xecfg;
+	int raw_diff = o->pickaxe_opts & DIFF_PICKAXE_G_RAW_DIFF;
+	struct strbuf sb = STRBUF_INIT;
+	char *string;
+	size_t size;
 
 	if (!one || !two) {
 		mmfile_t *which = one ? one : two;
 		int ret;
-		char *string = which->ptr;
-		size_t size = which->size;
 		assert(!(!one && !two));
+		if (raw_diff) {
+			/*
+			 * When we have created/deleted files with
+			 * --pickaxe-raw-diff we need to fake up the
+			 * "+" and "-" at the start of the lines, a
+			 * plain -G without --pickaxe-raw-diff didn't
+			 * care since it would indiscriminately search
+			 * through both added and removed lines.
+			 */
+			strbuf_add_lines(&sb, !one ? "+" : "-", which->ptr,
+					 which->size);
+			string = sb.buf;
+			size = sb.len;
+		} else {
+			string = which->ptr;
+			size = which->size;
+		}
 		ret = !regexec_buf(regexp, string, size,
 				   1, &regmatch, 0);
+		if (raw_diff)
+			strbuf_release(&sb);
 		return ret;
 	}
 
@@ -64,6 +89,7 @@ static int diff_grep(mmfile_t *one, mmfile_t *two,
 	memset(&xecfg, 0, sizeof(xecfg));
 	ecbdata.regexp = regexp;
 	ecbdata.hit = 0;
+	ecbdata.raw_diff = raw_diff;
 	xecfg.ctxlen = o->context;
 	xecfg.interhunkctxlen = o->interhunkcontext;
 	if (xdi_diff_outf(one, two, discard_hunk_line, diffgrep_consume,
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 9f8f0e84ad..39a1f6c230 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -276,6 +276,7 @@ log -SF master --max-count=1
 log -SF master --max-count=2
 log -GF master
 log -GF -p master
+log -GF -p --pickaxe-raw-diff master
 log -GF -p --pickaxe-all master
 log --decorate --all
 log --decorate=full --all
diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
index 5d06f5f45e..2d98318d23 100755
--- a/t/t4209-log-pickaxe.sh
+++ b/t/t4209-log-pickaxe.sh
@@ -141,4 +141,49 @@ test_expect_success 'log -S looks into binary files' '
 	test_cmp log full-log
 '
 
+test_expect_success 'setup log -G --pickaxe-raw-diff' '
+	git checkout --orphan G-raw-diff &&
+	test_write_lines A B C D E F G >file &&
+	git add file &&
+	git commit --allow-empty-message file &&
+	sed -i -e "s/B/2/" file &&
+	git add file &&
+	git commit --allow-empty-message file &&
+	sed -i -e "s/D/4/" file &&
+	git add file &&
+	git commit --allow-empty-message file &&
+	git rm file &&
+	git commit --allow-empty-message &&
+	git log --oneline -1 HEAD~0 >file.fourth &&
+	git log --oneline -1 HEAD~1 >file.third &&
+	git log --oneline -1 HEAD~2 >file.second &&
+	git log --oneline -1 HEAD~3 >file.first
+'
+
+test_expect_success 'log -G --pickaxe-raw-diff skips header and range information' '
+	git log --pickaxe-raw-diff -p -G"(@@|file)" >log &&
+	test_must_be_empty log
+'
+
+test_expect_success 'log -G --pickaxe-raw-diff searching in context' '
+	git log --oneline --pickaxe-raw-diff -G"^ F" -U2 -s >log &&
+	test_cmp file.third log &&
+	git log --oneline --pickaxe-raw-diff -G"^ F" -U1 -s >log &&
+	test_must_be_empty log
+'
+
+test_expect_success 'log -G --pickaxe-raw-diff searching added / removed lines (skip create/delete)' '
+	git log --oneline --pickaxe-raw-diff -G"^-[D2]" -s HEAD~1 >log &&
+	test_cmp file.third log &&
+	git log --oneline --pickaxe-raw-diff -G"^\+[D2]" -s -1 >log &&
+	test_cmp file.second log
+'
+
+test_expect_success 'log -G --pickaxe-raw-diff searching created / deleted files' '
+	git log --oneline --pickaxe-raw-diff -G"^\+A" -s >log &&
+	test_cmp file.first log &&
+	git log --oneline --pickaxe-raw-diff -G"^\-A" -s >log &&
+	test_cmp file.fourth log
+'
+
 test_done
-- 
2.21.0.593.g511ec345e18

