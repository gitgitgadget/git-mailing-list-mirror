Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FC321F404
	for <e@80x24.org>; Wed, 20 Dec 2017 19:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756267AbdLTTjE (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Dec 2017 14:39:04 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33928 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755740AbdLTTjD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Dec 2017 14:39:03 -0500
Received: by mail-wm0-f65.google.com with SMTP id y82so17099022wmg.1
        for <git@vger.kernel.org>; Wed, 20 Dec 2017 11:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RxLTLQ7VlKXdp49TbjtmBls1W+PwgOCXTuv9FTpEUGw=;
        b=Bo6giYMtjq7vXJrOjEVxSbvQZOQfVyxo7JEdYIVznRtJGs8M7fUx7Wkkr9rg5c/jpm
         W6hpOmQUNZHRvHdbrf6SrCM/QlXkzyjrM86Gx2Gl77KC3NC59Q0K7ySLp03xIQanFUxF
         KvCjHL4pKP2nXXc7VHmGD16YuDPzZR3USd2jHLLDuMiaN5bBaWWDa6p3ln5/IKak+Muj
         pwxntg5WWxXtikF8WPV3pGabmnkucz8a+h2HdNTrIY+JWfySWWKkJe7z27rYUnrtmhxg
         rd6T+C1ItZr0tNftJtPYu+s3S9dFSh5IVbR6pzRwb4CiStwWQN7AXLgucJijdmlzWU9C
         Rt4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RxLTLQ7VlKXdp49TbjtmBls1W+PwgOCXTuv9FTpEUGw=;
        b=bKpKgXyfhm6VAuUsQ7ixPBa3MIOnJ2GMvIu1IyD5SjHtARtu3rQe3u1XEyaX5IVI7K
         BGDxgexJRbI8dAx2bBo2xD8LAXGHBNk/sJ8YeKQjQzAL7MGj+uEV+1nwl2/2u+VWlpk/
         Y2sSuP0E4ulhK+3nWZ0yKXd80bNywt7GLjODiMD6G1FBPGgy5g+vMKAvzFtgKER+0abD
         jqGbP/R5Kk2sRvZvYZiKHTTfMUK8on5pkrMx1N2r3Tm6UqWHlJWlmxMEWBZNCNtzacgK
         WRCD7ZzDLoOYN0HEHaFd2mKnEKnNPUkKxVXzrhEu0k7BdUSm4h6s8AaR0BHPi17Dvn7F
         yIhQ==
X-Gm-Message-State: AKGB3mLlLwlXul/Ok888a3NCEaCkKzSt3rlzxDy6PwNR0XC7/l73zdEs
        6IRGiIgGbq/xle5mo+uRV0Sph0CL
X-Google-Smtp-Source: ACJfBou4nWOLq0LULoH+l3ERyPqzb+dPb9tUBUQoxfMbZx0aCdx4HeluFEcYMoXzv7nqfBBXclLJSA==
X-Received: by 10.80.170.207 with SMTP id r15mr7347238edc.220.1513798741732;
        Wed, 20 Dec 2017 11:39:01 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k42sm15509500edb.94.2017.12.20.11.39.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Dec 2017 11:39:00 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Pat Notz <patnotz@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] commit: add support for --fixup <commit> -m"<extra message>"
Date:   Wed, 20 Dec 2017 19:38:45 +0000
Message-Id: <20171220193845.11754-2-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20171220193845.11754-1-avarab@gmail.com>
References: <20171220193845.11754-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add support for supplying the -m option with --fixup. Doing so has
errored out ever since --fixup was introduced. Before this, the only
way to amend the fixup message while committing was to use --edit and
amend it in the editor.

The use-case for this feature is one of:

 * Leaving a quick note to self when creating a --fixup commit when
   it's not self-evident why the commit should be squashed without a
   note into another one.

 * (Ab)using the --fixup feature to "fix up" commits that have already
   been pushed to a branch that doesn't allow non-fast-forwards,
   i.e. just noting "this should have been part of that other commit",
   and if the history ever got rewritten in the future the two should
   be combined.

   In such a case you might want to leave a small message,
   e.g. "forgot this part, which broke XYZ".

When the --fixup option was initially added the "Option -m cannot be
combined" error was expanded from -c, -C and -F to also include
--fixup[1]

Those options could also support combining with -m, but given what
they do I can't think of a good use-case for doing that, so I have not
made the more invasive change of splitting up the logic in commit.c to
first act on those, and then on -m options.

1. d71b8ba7c9 ("commit: --fixup option for use with rebase
   --autosquash", 2010-11-02)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-commit.txt | 4 ++--
 builtin/commit.c             | 8 +++++---
 t/t7500-commit.sh            | 9 ++++++++-
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index df83176314..4489677fd1 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -145,8 +145,8 @@ OPTIONS
 	If multiple `-m` options are given, their values are
 	concatenated as separate paragraphs.
 +
-Combining the `-m` option and any of `-c`, `-C`, `-F` or `--fixup`
-will result in an error.
+Combining the `-m` option and any of `-c`, `-C` or `-F` will result in
+an error.
 
 -t <file>::
 --template=<file>::
diff --git a/builtin/commit.c b/builtin/commit.c
index 8a87701414..4e68394391 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -701,7 +701,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		}
 	}
 
-	if (have_option_m) {
+	if (have_option_m && !fixup_message) {
 		strbuf_addbuf(&sb, &message);
 		hook_arg1 = "message";
 	} else if (logfile && !strcmp(logfile, "-")) {
@@ -731,6 +731,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		ctx.output_encoding = get_commit_output_encoding();
 		format_commit_message(commit, "fixup! %s\n\n",
 				      &sb, &ctx);
+		if (have_option_m)
+			strbuf_addbuf(&sb, &message);
 		hook_arg1 = "message";
 	} else if (!stat(git_path_merge_msg(), &statbuf)) {
 		/*
@@ -1197,8 +1199,8 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		f++;
 	if (f > 1)
 		die(_("Only one of -c/-C/-F/--fixup can be used."));
-	if (have_option_m && f > 0)
-		die((_("Option -m cannot be combined with -c/-C/-F/--fixup.")));
+	if (have_option_m && (edit_message || use_message || logfile))
+		die((_("Option -m cannot be combined with -c/-C/-F.")));
 	if (f || have_option_m)
 		template_file = NULL;
 	if (edit_message)
diff --git a/t/t7500-commit.sh b/t/t7500-commit.sh
index 5739d3ed23..2d95778b74 100755
--- a/t/t7500-commit.sh
+++ b/t/t7500-commit.sh
@@ -272,6 +272,14 @@ test_expect_success 'commit --fixup provides correct one-line commit message' '
 	commit_msg_is "fixup! target message subject line"
 '
 
+test_expect_success 'commit --fixup -m"something" -m"extra"' '
+	commit_for_rebase_autosquash_setup &&
+	git commit --fixup HEAD~1 -m"something" -m"extra" &&
+	commit_msg_is "fixup! target message subject linesomething
+
+extra"
+'
+
 test_expect_success 'commit --squash works with -F' '
 	commit_for_rebase_autosquash_setup &&
 	echo "log message from file" >msgfile &&
@@ -325,7 +333,6 @@ test_expect_success 'invalid message options when using --fixup' '
 	test_must_fail git commit --fixup HEAD~1 --squash HEAD~2 &&
 	test_must_fail git commit --fixup HEAD~1 -C HEAD~2 &&
 	test_must_fail git commit --fixup HEAD~1 -c HEAD~2 &&
-	test_must_fail git commit --fixup HEAD~1 -m "cmdline message" &&
 	test_must_fail git commit --fixup HEAD~1 -F log
 '
 
-- 
2.15.1.424.g9478a66081

