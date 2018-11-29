Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A40F4211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 13:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbeK3AHM (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 19:07:12 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41490 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbeK3AHM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 19:07:12 -0500
Received: by mail-pf1-f196.google.com with SMTP id b7so975196pfi.8
        for <git@vger.kernel.org>; Thu, 29 Nov 2018 05:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:mime-version
         :content-transfer-encoding:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=F9uFRrGiJmHyy1pXBmTGnhM3mJnwKT+ClZdw/Z1CyT8=;
        b=pe/ryjIEHCURwQodxCLExA34UfR9o0aW68pR+PH5EXisilJrdh9of6J4u3WX+jSdNj
         QLWVjPPscyHziI4eigTjKv/zViyeu/+ce4V9dlnssosTllkfx6ofrg6CDgB+EtPf24GB
         Ks0OdYdYRFD7HqWbu/4SotfsBKEakbwC6LEPWV8St7aFLEDdRnk09Vsp3xuZm+2Z7AIG
         0aT5da62PwXzUeUpvz1zK9Ju1U+wSZNtwH3aMuLqU8XInDe4MShgCeP+s/JcmdLetUH7
         IN25EnHX+PlQNwzETbd7Tnabilnt+ok4sWSkAWtva6FWYNZ/bOQ+Fnc6DtiSVqREm8hn
         8s3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:mime-version:content-transfer-encoding:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=F9uFRrGiJmHyy1pXBmTGnhM3mJnwKT+ClZdw/Z1CyT8=;
        b=bEiRjjQ4En1eFZbv00pTNFwBHM2seKUli7rJJ/CwBp0VDCA0XDplAN/CMZUDLPUxKx
         5qcUNHZERsrywJeyN73ljqP79vfbyI+A3SYv2Jv2iTuQdncTCV2qWUz9D6HOOenkwwBk
         F5j+LGpXdWrKp3ozvXF1BTP8t+9CTeqNstBzyQevHLjf9esa9q+IZn2fyVFrvzVNVgkS
         vPpDDQJfoss748fXRJgrLwOcDifMY3JLeJtjEBuD6r7Yql435Xd6cnqN058DvbrqyuPU
         S1LomL9cXZyGlkyFFbOhxMEe4EAxhudo+punY1squTDvkUBRBPwV10JFljOqU6bsvKZH
         U2MQ==
X-Gm-Message-State: AA+aEWY3l4PlUeFdm2zILdN9lPsXsGshYk2LWPRBysZ7ozqpqfUUdrx8
        0mEp5+tNFYO2rtajPujDrwTTMfXB
X-Google-Smtp-Source: AFSGD/XOpVkze2sW+s3FvFq/FKZ+xb670QqMIl9yiJYqA7hrST/oY69G50MEXqJjkQ7qufT1VVO+6g==
X-Received: by 2002:a63:e156:: with SMTP id h22mr1148087pgk.255.1543496513725;
        Thu, 29 Nov 2018 05:01:53 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id y6sm3073412pfl.187.2018.11.29.05.01.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 05:01:52 -0800 (PST)
Date:   Thu, 29 Nov 2018 05:01:52 -0800 (PST)
X-Google-Original-Date: Thu, 29 Nov 2018 13:01:49 GMT
Message-Id: <pull.88.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.88.git.gitgitgadget@gmail.com>
References: <pull.88.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/1] Fix git rebase --stat -i <unrelated-history>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We're really entering obscure territory here, I would say.

To trigger the bug, two things have to come together: the user must have
asked for a diffstat afterwards, and the commits need to have been rebased
onto a completely unrelated commit history (i.e. there must exist no merge
base between the pre-rebase HEAD and the post-rebase HEAD).

Please note that this bug existed already in the scripted rebase, but it was
never detected because the scripted version would not even perform any error
checking.

It will make Junio very happy that I squashed the regression test in to the
patch that fixes it. The reason, however, was not to make Junio happy (I
hope to make him happy by fixing bugs), but simply that an earlier iteration
of test would only fail with the built-in rebase, but not with the scripted
version. The current version would fail with the scripted version, but I'll
save the time to split the patch again now.

Changes since v1:

 * The commit message now talks more about what we should do in case that
   there is no merge base, rather than stressing the differences between the
   way scripted vs built-in rebase handled it (both buggy, and fixed by this
   patch).
 * In case that there is no merge base, it no longer reports "Changes from
   (empty) to ..." but "Changes to ...", which should be a lot less
   controversial.

Johannes Schindelin (1):
  rebase --stat: fix when rebasing to an unrelated history

 builtin/rebase.c          | 18 ++++++++++++------
 git-legacy-rebase.sh      | 10 ++++++++--
 t/t3406-rebase-message.sh | 10 ++++++++++
 3 files changed, 30 insertions(+), 8 deletions(-)


base-commit: a1598010f775d82b5adf12c29d0f5bc9b41434c6
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-88%2Fdscho%2Frebase-stat-fix-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-88/dscho/rebase-stat-fix-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/88

Range-diff vs v1:

 1:  680385e4bd ! 1:  190c7856ad rebase --stat: fix when rebasing to an unrelated history
     @@ -3,22 +3,21 @@
          rebase --stat: fix when rebasing to an unrelated history
      
          When rebasing to a commit history that has no common commits with the
     -    current branch, there is no merge base. The scripted version of the `git
     -    rebase` command was not prepared for that and spewed out
     +    current branch, there is no merge base. In diffstat mode, this means
     +    that we cannot compare to the merge base, but we have to compare to the
     +    empty tree instead.
      
     -            fatal: ambiguous argument '': unknown revision or path not in
     -            the working tree.
     +    Also, if running in verbose diffstat mode, we should not output
      
     -    but then continued (due to lack of error checking).
     +            Changes from <merge-base> to <onto>
      
     -    The built-in version of the `git rebase` command blindly translated that
     -    shell script code, assuming that there is no need to test whether there
     -    *was* a merge base, and due to its better error checking, exited with a
     -    fatal error (because it tried to read the object with hash 00000000...
     -    as a tree).
     +    as that does not make sense without any merge base.
      
     -    Fix both scripted and built-in versions to output something sensibly,
     -    and add a regression test to keep this working in all eternity.
     +    Note: neither scripted nor built-in versoin of `git rebase` were
     +    prepared for this situation well. We use this opportunity not only to
     +    fix the bug(s), but also to make both versions' output consistent in
     +    this instance. And add a regression test to keep this working in all
     +    eternity.
      
          Reported-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
     @@ -27,15 +26,25 @@
      --- a/builtin/rebase.c
      +++ b/builtin/rebase.c
      @@
     + 	if (options.flags & REBASE_DIFFSTAT) {
     + 		struct diff_options opts;
       
     - 		if (options.flags & REBASE_VERBOSE)
     - 			printf(_("Changes from %s to %s:\n"),
     +-		if (options.flags & REBASE_VERBOSE)
     +-			printf(_("Changes from %s to %s:\n"),
      -				oid_to_hex(&merge_base),
     -+				is_null_oid(&merge_base) ?
     -+				"(empty)" : oid_to_hex(&merge_base),
     - 				oid_to_hex(&options.onto->object.oid));
     +-				oid_to_hex(&options.onto->object.oid));
     ++		if (options.flags & REBASE_VERBOSE) {
     ++			if (is_null_oid(&merge_base))
     ++				printf(_("Changes to %s:\n"),
     ++				       oid_to_hex(&options.onto->object.oid));
     ++			else
     ++				printf(_("Changes from %s to %s:\n"),
     ++				       oid_to_hex(&merge_base),
     ++				       oid_to_hex(&options.onto->object.oid));
     ++		}
       
       		/* We want color (if set), but no pager */
     + 		diff_setup(&opts);
      @@
       			DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT;
       		opts.detect_rename = DIFF_DETECT_RENAME;
     @@ -57,8 +66,12 @@
       	if test -n "$verbose"
       	then
      -		echo "$(eval_gettext "Changes from \$mb to \$onto:")"
     -+		mb_display="${mb:-(empty)}"
     -+		echo "$(eval_gettext "Changes from \$mb_display to \$onto:")"
     ++		if test -z "$mb"
     ++		then
     ++			echo "$(eval_gettext "Changes to \$onto:")"
     ++		else
     ++			echo "$(eval_gettext "Changes from \$mb to \$onto:")"
     ++		fi
       	fi
      +	mb_tree="${mb:-$(git hash-object -t tree /dev/null)}"
       	# We want color (if set), but no pager
     @@ -81,7 +94,7 @@
      +	git -C unrelated remote add -f origin "$PWD" &&
      +	git -C unrelated branch --set-upstream-to=origin/master &&
      +	git -C unrelated -c core.editor=true rebase -i -v --stat >actual &&
     -+	test_i18ngrep "Changes from (empty)" actual &&
     ++	test_i18ngrep "Changes to " actual &&
      +	test_i18ngrep "5 files changed" actual
      +'
      +

-- 
gitgitgadget
