Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DAA61F404
	for <e@80x24.org>; Fri, 13 Apr 2018 21:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751793AbeDMVDv (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 17:03:51 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33266 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751657AbeDMVDu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Apr 2018 17:03:50 -0400
Received: by mail-wr0-f195.google.com with SMTP id z73so11272117wrb.0
        for <git@vger.kernel.org>; Fri, 13 Apr 2018 14:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=Zz4K1JB8KHdsywhGJDE4wSrvkMRyr+EyLGbDrpDDHSQ=;
        b=SKK/7fWWtgKPF4kqKWIBy/qAkPXQ6VKS1Qd9wc7krje/ncIFZ6L38ywahRBAzRgfTq
         j+XzmkmVPhyjihaRJmFtqsJaAiPDJkxGDqCtB6D34KQ0jDqvHNQTNvFJ60L/mk2c5G0t
         fhaLD3pYulO5sSmZW+Q3Ol4CZ1zjXsg4PrvNkkx14BeoiT3ST4DwEjZajZQv/M0G9sFa
         9ImWEUi52WqBZ+g/9nj8Bwvvc+LBhxiu5jltu7JxzIG1/yJkgBPg01KMbMEzsNwuA6Gd
         CLFHG5VKP75cGx/mdtttdYLac1FeVzXnu0/mQywqP0PKReGvI8zhtTWP8GHenp78198W
         9xDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=Zz4K1JB8KHdsywhGJDE4wSrvkMRyr+EyLGbDrpDDHSQ=;
        b=B/mdF1WbxQwr+fGHqUQ1ovYucwm6mKXrE/NEuOacrEbv0UGbcDT2c44BxjTyu8RT4r
         c+d/USZXMcFyPdzVPSppeebDTfaJ3e4Txc71/X687Wq2LHI/asYbMvfy8tUJu2yKRMbh
         iA3VCkrt/Lu+hk/c2pmvazdr7q89BgGAFCu5lnTczzS0Mg+KTRzXMzPHk4bfawc1cNoW
         SkACjv+l+3OokZEvelUW8i5nW8EXc4SCrnKnAtTo2M8Kq4518ZF3xurZDbx4pWB/H+E4
         b/dYu/MRiGEDIhzjmcPKDxGSzW1L5BhdJ69x504FOSibFLrenqFeFfBq5okFqn3HvJSD
         W8gQ==
X-Gm-Message-State: ALQs6tAO0QIxsw6yqXE47xsxwiX0zeeI+m28cYo1kCs8IP+0BqDN8Qx0
        Jco6P9YH/x1k0GS94JQslYs=
X-Google-Smtp-Source: AIpwx48EhATp/5m2MVwd3riU2LTZ9NtIAijGOfhQ5GlLZWTtZtAqwCK9JDdiAKDs4/DCQhBwN/D9LQ==
X-Received: by 10.80.244.167 with SMTP id s36mr22441299edm.262.1523653428808;
        Fri, 13 Apr 2018 14:03:48 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id y28sm4085996edc.0.2018.04.13.14.03.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Apr 2018 14:03:47 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Michael Vogt <mvo@ubuntu.com>
Cc:     sbeller@google.com, git@vger.kernel.org
Subject: Re: [PATCH] support: git show --follow-symlinks HEAD:symlink
References: <87h8oegavn.fsf@evledraar.gmail.com> <20180413194829.23990-1-mvo@ubuntu.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180413194829.23990-1-mvo@ubuntu.com>
Date:   Fri, 13 Apr 2018 23:03:46 +0200
Message-ID: <87fu3yg6od.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 13 2018, Michael Vogt wrote:

> Add support for the `--follow-symlinks` options to git-show. This
> allows to write:
>
>     git show --follow-symlink HEAD:path-a-symlink
>
> to get the content of the symlinked file.

Thanks. Commit message would be better as something like:

    show: add --follow-symlinks option for <rev>:<path>

    Add a --follow-symlinks option that'll resolve symlinks to their
    targets when the target is of the form <rev>:<path>.

    Without it, git will show the path of the link itself if the symlink
    is the leaf node of <path>, or otherwise an error if some component
    of <path> is a symlink to another location in the repository. With
    the new --follow-symlinks option both will be resolved to their
    target, and its content shown instead.

I.e. start with "<command>: " ("show" in this case), and explain how it
impacts the dirlink case.

> Signed-off-by: Michael Vogt <mvo@ubuntu.com>
> ---
>  Documentation/git-show.txt |  6 +++++
>  builtin/log.c              |  7 ++++--
>  revision.c                 |  2 ++
>  revision.h                 |  1 +
>  t/t1800-git-show.sh        | 46 ++++++++++++++++++++++++++++++++++++++
>  5 files changed, 60 insertions(+), 2 deletions(-)
>  create mode 100755 t/t1800-git-show.sh
>
> diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
> index e73ef5401..d9f7fd90c 100644
> --- a/Documentation/git-show.txt
> +++ b/Documentation/git-show.txt
> @@ -39,6 +39,12 @@ OPTIONS
>  	For a more complete list of ways to spell object names, see
>  	"SPECIFYING REVISIONS" section in linkgit:gitrevisions[7].
>
> +--follow-symlinks::
> +	Follow symlinks inside the repository when requesting objects
> +	in extended revision syntax of the form tree-ish:path-in-tree.
> +	Instead of output about the link itself, provide output about
> +	the linked-to object.
> +
>  include::pretty-options.txt[]

This needs to document the dirlink case I noted above.

> diff --git a/builtin/log.c b/builtin/log.c
> index 94ee177d5..e92af4fc7 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -142,7 +142,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
>  			 struct rev_info *rev, struct setup_revision_opt *opt)
>  {
>  	struct userformat_want w;
> -	int quiet = 0, source = 0, mailmap = 0;
> +	int quiet = 0, source = 0, mailmap = 0, follow_symlinks = 0;
>  	static struct line_opt_callback_data line_cb = {NULL, NULL, STRING_LIST_INIT_DUP};
>  	static struct string_list decorate_refs_exclude = STRING_LIST_INIT_NODUP;
>  	static struct string_list decorate_refs_include = STRING_LIST_INIT_NODUP;
> @@ -162,6 +162,8 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
>  		OPT_CALLBACK('L', NULL, &line_cb, "n,m:file",
>  			     N_("Process line range n,m in file, counting from 1"),
>  			     log_line_range_callback),
> +		OPT_BOOL(0, "follow-symlinks", &follow_symlinks,
> +			 N_("follow in-tree symlinks (used when showing file content)")),
>  		OPT_END()
>  	};
>
> @@ -173,9 +175,10 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
>  			     builtin_log_options, builtin_log_usage,
>  			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN |
>  			     PARSE_OPT_KEEP_DASHDASH);
> -

Stray line deletion here.

>  	if (quiet)
>  		rev->diffopt.output_format |= DIFF_FORMAT_NO_OUTPUT;
> +	if (follow_symlinks)
> +		rev->follow_symlinks = 1;
>  	argc = setup_revisions(argc, argv, rev, opt);
>
>  	/* Any arguments at this point are not recognized */
> diff --git a/revision.c b/revision.c
> index b42c836d7..4ab22313f 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1678,6 +1678,8 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
>
>  	if (revarg_opt & REVARG_COMMITTISH)
>  		get_sha1_flags |= GET_OID_COMMITTISH;
> +	if (revs && revs->follow_symlinks)
> +		get_sha1_flags |= GET_OID_FOLLOW_SYMLINKS;
>
>  	if (get_oid_with_context(arg, get_sha1_flags, &oid, &oc))
>  		return revs->ignore_missing ? 0 : -1;
> diff --git a/revision.h b/revision.h
> index b8c47b98e..060f1038a 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -122,6 +122,7 @@ struct rev_info {
>  			first_parent_only:1,
>  			line_level_traverse:1,
>  			tree_blobs_in_commit_order:1,
> +			follow_symlinks:1,
>
>  			/* for internal use only */
>  			exclude_promisor_objects:1;
> diff --git a/t/t1800-git-show.sh b/t/t1800-git-show.sh
> new file mode 100755
> index 000000000..85541b4db
> --- /dev/null
> +++ b/t/t1800-git-show.sh
> @@ -0,0 +1,46 @@
> +#!/bin/sh
> +
> +test_description='Test git show works'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'verify git show HEAD:foo works' '
> +    printf "foo content\n" >foo &&
> +    git add foo &&
> +    git commit -m "added foo" &&
> +    git show HEAD:foo >actual &&
> +    printf "foo content\n" >expected &&
> +    test_cmp expected actual
> +'
> +
> +test_expect_success 'verify git show HEAD:symlink shows symlink points to foo' '
> +    printf "foo content\n" >foo &&
> +    ln -s foo symlink &&
> +    git add foo symlink &&
> +    git commit -m "added foo and a symlink to foo" &&
> +    git show HEAD:foo >actual &&
> +    printf "foo content\n" >expected &&
> +    test_cmp expected actual &&
> +    git show HEAD:symlink >actual &&
> +    printf "foo" >expected &&
> +    test_cmp expected actual
> +'
> +
> +test_expect_success 'verify git show --follow-symlinks HEAD:symlink shows foo' '
> +    git show --follow-symlinks HEAD:symlink >actual &&
> +    printf "foo content\n" >expected &&
> +    test_cmp expected actual
> +'
> +
> +test_expect_success 'verify git show --follow-symlinks HEAD:symlink works with subdirs' '
> +    mkdir dir &&
> +    ln -s dir symlink-to-dir &&
> +    printf "bar content\n" >dir/bar &&
> +    git add dir symlink-to-dir &&
> +    git commit -m "add dir and symlink-to-dir" &&
> +    git show --follow-symlinks HEAD:symlink-to-dir/bar >actual &&
> +    printf "bar content\n" >expected &&
> +    test_cmp expected actual
> +'
> +
> +test_done

There's a few issues with this test code I noticed:

 1) Doesn't indent with tabs
 2) Doesn't use the test_commit helper, less verbose
 3) Your 2nd test is just repeating the setup of the 1st test, which is
    not needed
 4) You don't test without --follow-symlinks in the dirlink case
 5) You don't guard with the SYMLINKS prereq (this test will fail on Windows et al)
 6) printf "foo\n" instead of just "echo foo"

Below is a local fixup for this that I came up with (also for that line
deletion above), should be squash-able into a v2.

It would also be worth testing for the case where we don't have SYMLINKS
but *do* clone a repo that has symlinks, but I have no idea what git
does in that case, just copy the file?

 builtin/log.c       |  1 +
 t/t1800-git-show.sh | 55 ++++++++++++++++++++++++-----------------------------
 2 files changed, 26 insertions(+), 30 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 2990f9b1b9..5d920a893a 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -175,6 +175,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 			     builtin_log_options, builtin_log_usage,
 			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN |
 			     PARSE_OPT_KEEP_DASHDASH);
+
 	if (quiet)
 		rev->diffopt.output_format |= DIFF_FORMAT_NO_OUTPUT;
 	if (follow_symlinks)
diff --git a/t/t1800-git-show.sh b/t/t1800-git-show.sh
index 85541b4db3..7a02438ecf 100755
--- a/t/t1800-git-show.sh
+++ b/t/t1800-git-show.sh
@@ -5,42 +5,37 @@ test_description='Test git show works'
 . ./test-lib.sh

 test_expect_success 'verify git show HEAD:foo works' '
-    printf "foo content\n" >foo &&
-    git add foo &&
-    git commit -m "added foo" &&
-    git show HEAD:foo >actual &&
-    printf "foo content\n" >expected &&
-    test_cmp expected actual
+	test_commit A &&
+	git show HEAD:A.t >actual &&
+	echo A >expected &&
+	test_cmp expected actual
 '

-test_expect_success 'verify git show HEAD:symlink shows symlink points to foo' '
-    printf "foo content\n" >foo &&
-    ln -s foo symlink &&
-    git add foo symlink &&
-    git commit -m "added foo and a symlink to foo" &&
-    git show HEAD:foo >actual &&
-    printf "foo content\n" >expected &&
-    test_cmp expected actual &&
-    git show HEAD:symlink >actual &&
-    printf "foo" >expected &&
-    test_cmp expected actual
+test_expect_success SYMLINKS 'verify git show HEAD:symlink shows symlink points to foo' '
+	ln -s A.t A.link &&
+	git add A.link &&
+	git commit -m"Added symlink to A.t" &&
+	git show HEAD:A.link >actual &&
+	printf "%s" A.t >expected &&
+	test_cmp expected actual
 '

-test_expect_success 'verify git show --follow-symlinks HEAD:symlink shows foo' '
-    git show --follow-symlinks HEAD:symlink >actual &&
-    printf "foo content\n" >expected &&
-    test_cmp expected actual
+test_expect_success SYMLINKS 'verify git show --follow-symlinks HEAD:symlink shows foo' '
+	git show --follow-symlinks HEAD:A.link >actual &&
+	echo A >expected &&
+	test_cmp expected actual
 '

-test_expect_success 'verify git show --follow-symlinks HEAD:symlink works with subdirs' '
-    mkdir dir &&
-    ln -s dir symlink-to-dir &&
-    printf "bar content\n" >dir/bar &&
-    git add dir symlink-to-dir &&
-    git commit -m "add dir and symlink-to-dir" &&
-    git show --follow-symlinks HEAD:symlink-to-dir/bar >actual &&
-    printf "bar content\n" >expected &&
-    test_cmp expected actual
+test_expect_success SYMLINKS 'verify git show --follow-symlinks HEAD:symlink works with subdirs' '
+	mkdir dir &&
+	ln -s dir symlink-to-dir &&
+	test_commit dir/B &&
+	git add dir symlink-to-dir &&
+	git commit -m "add dir and symlink-to-dir" &&
+	test_must_fail git show HEAD:symlink-to-dir/B.t >actual &&
+	git show --follow-symlinks HEAD:symlink-to-dir/B.t >actual &&
+	echo dir/B >expected &&
+	test_cmp expected actual
 '

 test_done
