Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 986541F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 00:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfKSAVe (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 19:21:34 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43912 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbfKSAVe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 19:21:34 -0500
Received: by mail-pl1-f195.google.com with SMTP id a18so10710511plm.10
        for <git@vger.kernel.org>; Mon, 18 Nov 2019 16:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+DuWSaSw2KKTA7WWYkN2ewxoi/zE0qtU5sUrQkjNYGQ=;
        b=hLdQt0qLliL12UXDDey93GYV9dNhWQBCzCLZoMrl5lsculGCM3uF2BZV4ewyA1zjNX
         5JuPAiHB4vncOXzSBVB8Cwpwpfjjq/pduM5ziyeUKUYrE17aB1Oq09weHybLVdAzzFS3
         e8ACQXIuEmWP1eH/24I7e1F8gBTdvnN/x7f6px5WH563Zj8mE37BeIEmwpDGwPsWm2g+
         pQmRsyu5U0JJYeNQKAgI9ud3fikneRmLvwmmL4CLcvTV5TWyLAheTkKWiuHzxRTPKOwL
         s67y1BQ4C1KS4VI+cEiPYMOiNOtNNufzH4eEjVuaATHHuQFwcyJ32vXTjHudAdeGqn/T
         Rsew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+DuWSaSw2KKTA7WWYkN2ewxoi/zE0qtU5sUrQkjNYGQ=;
        b=sE6DeDD6avQz0zWoRKOC0703Xs+OjGwe8yCFD8j8aBHefKMuxZmmhQPIf5q40td0Mq
         SnhjOZamOhyEeGmLhokVbaUEicsF5WvmWTXQYDnwdmM91gdZ7kZe5Dg3DVoC0JVhdNSo
         JxEz2KniUaoTVDZ63b1bmti89MvmJ9rSLHSL6XuJPl/VhF7UxhVkE0wQiCSzRHt2sEYK
         kgRNkvpten41KIsn+K/5k48c+YousyL2BZtNLEUEWm8CVJ0jOHX2xV5OarQxCXxyhr57
         SHW+/a5/NBeb5ilzfN7bWKVciNPwnUhr+DOXqhxP1BcU+Fn+6HD4Ua5yMG9n0N4b1dFD
         yyMQ==
X-Gm-Message-State: APjAAAUFQY/+K/3oUrsdSTExaamhrBPboZkfg2KDqa7CmlslbsFPx3HL
        hnsUB4FX5s9MWOS/fnnW2tvSchDi
X-Google-Smtp-Source: APXvYqwrxiI7j15VgRSvVDGSFjPuAUAhyy/rFm1DXCc+2GTPNF4b8vfvSyJpNZVppxhEE8ZQEpcYzg==
X-Received: by 2002:a17:902:6b4b:: with SMTP id g11mr14080753plt.196.1574122893127;
        Mon, 18 Nov 2019 16:21:33 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id k84sm25190777pfd.157.2019.11.18.16.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 16:21:32 -0800 (PST)
Date:   Mon, 18 Nov 2019 16:21:30 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Todd Zullinger <tmz@pobox.com>
Subject: [PATCH v4 09/11] pretty: implement 'reference' format
Message-ID: <5042161d738215dda2966566e53a3097ed8d457f.1574122784.git.liu.denton@gmail.com>
References: <cover.1573764280.git.liu.denton@gmail.com>
 <cover.1574122784.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1574122784.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The standard format for referencing other commits within some projects
(such as git.git) is the reference format. This is described in
Documentation/SubmittingPatches as

	If you want to reference a previous commit in the history of a stable
	branch, use the format "abbreviated hash (subject, date)", like this:

	....
		Commit f86a374 (pack-bitmap.c: fix a memleak, 2015-03-30)
		noticed that ...
	....

Since this format is so commonly used, standardize it as a pretty
format.

The tests that are implemented essentially show that the format-string
does not change in response to various log options. This is useful
because, for future developers, it shows that we've considered the
limitations of the "canned format-string" approach and we are fine with
them.

Based-on-a-patch-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/pretty-formats.txt       |  9 +++++++
 Documentation/pretty-options.txt       |  2 +-
 Documentation/rev-list-options.txt     |  4 ++-
 contrib/completion/git-completion.bash |  2 +-
 pretty.c                               |  4 ++-
 t/t4205-log-pretty-formats.sh          | 36 ++++++++++++++++++++++++++
 6 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 11979301ff..ccd0921123 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -63,6 +63,15 @@ This is designed to be as compact as possible.
 
 	       <full commit message>
 
+* 'reference'
+
+	  <abbrev hash> (<title line>, <short author date>)
++
+This format is used to refer to another commit in a commit message and
+is the same as `--pretty='format:%C(auto)%h (%s, %as)'`.  As with any
+`format:` with format placeholders, its output is not affected by other
+options like `--decorate` and `--walk-reflogs`.
+
 * 'email'
 
 	  From <hash> <date>
diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index e44fc8f738..a59426eefd 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -3,7 +3,7 @@
 
 	Pretty-print the contents of the commit logs in a given format,
 	where '<format>' can be one of 'oneline', 'short', 'medium',
-	'full', 'fuller', 'email', 'raw', 'format:<string>'
+	'full', 'fuller', 'reference', 'email', 'raw', 'format:<string>'
 	and 'tformat:<string>'.  When '<format>' is none of the above,
 	and has '%placeholder' in it, it acts as if
 	'--pretty=tformat:<format>' were given.
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 90ff9e2bea..dfa83bddee 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -269,7 +269,7 @@ list.
 	exclude (that is, '{caret}commit', 'commit1..commit2',
 	and 'commit1\...commit2' notations cannot be used).
 +
-With `--pretty` format other than `oneline` (for obvious reasons),
+With `--pretty` format other than `oneline` and `reference` (for obvious reasons),
 this causes the output to have two extra lines of information
 taken from the reflog.  The reflog designator in the output may be shown
 as `ref@{Nth}` (where `Nth` is the reverse-chronological index in the
@@ -293,6 +293,8 @@ Under `--pretty=oneline`, the commit message is
 prefixed with this information on the same line.
 This option cannot be combined with `--reverse`.
 See also linkgit:git-reflog[1].
++
+Under `--pretty=reference`, this information will not be shown at all.
 
 --merge::
 	After a failed merge, show refs that touch files having a
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 557d0373c3..007e6a06d6 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1749,7 +1749,7 @@ __git_log_shortlog_options="
 	--all-match --invert-grep
 "
 
-__git_log_pretty_formats="oneline short medium full fuller email raw format: tformat: mboxrd"
+__git_log_pretty_formats="oneline short medium full fuller reference email raw format: tformat: mboxrd"
 __git_log_date_formats="relative iso8601 iso8601-strict rfc2822 short local default raw unix format:"
 
 _git_log ()
diff --git a/pretty.c b/pretty.c
index 4d7f5e9aab..88a3bc621d 100644
--- a/pretty.c
+++ b/pretty.c
@@ -97,7 +97,9 @@ static void setup_commit_formats(void)
 		{ "mboxrd",	CMIT_FMT_MBOXRD,	0,	0 },
 		{ "fuller",	CMIT_FMT_FULLER,	0,	8 },
 		{ "full",	CMIT_FMT_FULL,		0,	8 },
-		{ "oneline",	CMIT_FMT_ONELINE,	1,	0 }
+		{ "oneline",	CMIT_FMT_ONELINE,	1,	0 },
+		{ "reference",	CMIT_FMT_USERFORMAT,	1,	0,
+			0, "%C(auto)%h (%s, %as)" },
 		/*
 		 * Please update $__git_log_pretty_formats in
 		 * git-completion.bash when you add new formats.
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index da9cacffea..9a9a18f104 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -824,4 +824,40 @@ test_expect_success '%S in git log --format works with other placeholders (part
 	test_cmp expect actual
 '
 
+test_expect_success 'log --pretty=reference' '
+	git log --pretty="tformat:%h (%s, %as)" >expect &&
+	git log --pretty=reference >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --pretty=reference always uses short date' '
+	git log --pretty="tformat:%h (%s, %as)" >expect &&
+	git log --date=rfc --pretty=reference >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --pretty=reference is never unabbreviated' '
+	git log --pretty="tformat:%h (%s, %as)" >expect &&
+	git log --no-abbrev-commit --pretty=reference >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --pretty=reference is never decorated' '
+	git log --pretty="tformat:%h (%s, %as)" >expect &&
+	git log --decorate=short --pretty=reference >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --pretty=reference does not output reflog info' '
+	git log --walk-reflogs --pretty="tformat:%h (%s, %as)" >expect &&
+	git log --walk-reflogs --pretty=reference >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --pretty=reference is colored appropriately' '
+	git log --color=always --pretty="tformat:%C(auto)%h (%s, %as)" >expect &&
+	git log --color=always --pretty=reference >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.24.0.420.g9ac4901264

