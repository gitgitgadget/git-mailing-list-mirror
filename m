Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 930B61F461
	for <e@80x24.org>; Thu, 18 Jul 2019 09:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733131AbfGRJaf (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jul 2019 05:30:35 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41677 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfGRJaf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jul 2019 05:30:35 -0400
Received: by mail-wr1-f65.google.com with SMTP id c2so24677704wrm.8
        for <git@vger.kernel.org>; Thu, 18 Jul 2019 02:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=p7eP5Sc6L2fqVToLGvbuRAYmJvldRFimIuxrVEy3uco=;
        b=aLiSNxtOVkmuF6Yy9B4e99+XZQit0sqJFxo1ynsvA66KdnR2T+GpmQgyJxk35coXWX
         MwWbFVv873E1VJLnnTovILH/SwBz+UhYR9UtQ95KFJqOmYDzX7p5N/xYkGe+weoMQSJ5
         /13pa76hSy4tl4gtnWDAS2qKmuHHdB2RV2VtJwyp1QfMQ05hQDv3EIBQ1NsH90h55Anc
         XnIiAStI3jxtEdzO6RB/6gHdnoM05XOAmUXWlf+6G+eR50gKzTHk2/+ZJQNmBUGgK4Iu
         ePqo8vVQgZ4RiMQuawXMMAdzK1KYw4Pz9Qg+/y5f6uYM+6B5/z6hw3Z6Ol0eAmOe5Bqp
         gqVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=p7eP5Sc6L2fqVToLGvbuRAYmJvldRFimIuxrVEy3uco=;
        b=T+NbOf13veBRt4FqG67+00/KzAPowxBlNzJNegtpr/MSlK9QVNMZ9Yz8gfx7m9l1hG
         bk/rOwavpy/t8AW/kAYwPQkd4o+2d8xqlRo+WhtNeJ+JSawDDPziPOC8WmTZ+UWIfmpa
         GjUTNaGhEB+G4WayBUM+psCcuYDxSzksGRHSdOtfe6Th4eyRUAKiZ7OmnvUrXnjrutYv
         WB335LjQXF99cciV4E9eXYK/lbkLPALdpjqCTLLtfWXq3DA1R9enExa8W4/oqGUzglBK
         fhKladHZPZrikzcGjswZEKJG28GH+8Gs+bLQoSqCiShmaLzM+t5eiOwSIzEsfh64OnAm
         dXrw==
X-Gm-Message-State: APjAAAUKQ+dpLgPSsSVAtaYtqzUZRU6EMyVB03PZxAxjAR0pzUtOfUuX
        36JzkHd5wQ30twNK1Znv8FHVt6qT
X-Google-Smtp-Source: APXvYqx/VnrylAptPYdrugqjPu7aPoACHAUfYNRvHrRuL1hQDZAsGn4/1QdcTQrbCeMfPdQqNr/sgg==
X-Received: by 2002:a5d:4484:: with SMTP id j4mr48733120wrq.143.1563442232744;
        Thu, 18 Jul 2019 02:30:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o7sm22608588wmc.36.2019.07.18.02.30.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 02:30:32 -0700 (PDT)
Date:   Thu, 18 Jul 2019 02:30:32 -0700 (PDT)
X-Google-Original-Date: Thu, 18 Jul 2019 09:30:30 GMT
Message-Id: <pull.219.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.219.git.gitgitgadget@gmail.com>
References: <pull.219.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/1] Show an error if too-long paths are seen by git clean -dfx
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe_=3Cl=2Es=2Er=40web=2Ede=3E=2C_SZEDER_G=C3=A1bor?= 
        <szeder.dev@gmail.com>, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is particularly important on Windows, where PATH_MAX is very small
compared to Unix/Linux.

Changes since v1:

 * Matched the warning message style to existing ones,
 * Fixed test in multiple ways: * Avoiding touch in favor of : >.
    * Using test_config.
    * Using test_i18ngrep instead of grep to avoid localization problems.
    * Add helpful comments.
   
   
 * The commit message now talks about lstat() instead of stat().
 * The commit message also explains where that core.longpaths comes from.

Johannes Schindelin (1):
  clean: show an error message when the path is too long

 builtin/clean.c  |  3 ++-
 t/t7300-clean.sh | 12 ++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)


base-commit: aa25c82427ae70aebf3b8f970f2afd54e9a2a8c6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-219%2Fdscho%2Fclean-long-paths-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-219/dscho/clean-long-paths-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/219

Range-diff vs v1:

 1:  36677556a2 ! 1:  c7b11fe410 clean: show an error message when the path is too long
     @@ -2,7 +2,7 @@
      
          clean: show an error message when the path is too long
      
     -    Without an error message when stat() failed, e.g. `git clean` would
     +    Without an error message when `lstat()` failed, `git clean` would
          abort without an error message, leaving the user quite puzzled.
      
          In particular on Windows, where the default maximum path length is quite
     @@ -15,18 +15,32 @@
      
                  https://github.com/git-for-windows/git/issues/521
      
     +    Note that we temporarily set `core.longpaths = false` in the regression
     +    test; This ensures forward-compatibility with the `core.longpaths`
     +    feature that has not yet been upstreamed from Git for Windows.
     +
     +    Helped-by: René Scharfe <l.s.r@web.de>
     +    Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       diff --git a/builtin/clean.c b/builtin/clean.c
       --- a/builtin/clean.c
       +++ b/builtin/clean.c
     +@@
     + static const char *msg_skip_git_dir = N_("Skipping repository %s\n");
     + static const char *msg_would_skip_git_dir = N_("Would skip repository %s\n");
     + static const char *msg_warn_remove_failed = N_("failed to remove %s");
     ++static const char *msg_warn_lstat_failed = N_("could not lstat %s\n");
     + 
     + enum color_clean {
     + 	CLEAN_COLOR_RESET = 0,
      @@
       		strbuf_setlen(path, len);
       		strbuf_addstr(path, e->d_name);
       		if (lstat(path->buf, &st))
      -			; /* fall thru */
     -+			warning("Could not stat path '%s': %s",
     -+				path->buf, strerror(errno));
     ++			warning_errno(_(msg_warn_lstat_failed), path->buf);
       		else if (S_ISDIR(st.st_mode)) {
       			if (remove_dirs(path, prefix, force_flag, dry_run, quiet, &gone))
       				ret = 1;
     @@ -39,14 +53,15 @@
       '
       
      +test_expect_success MINGW 'handle clean & core.longpaths = false nicely' '
     -+	git config core.longpaths false &&
     -+	test_when_finished git config --unset core.longpaths &&
     ++	test_config core.longpaths false &&
      +	a50=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa &&
      +	mkdir -p $a50$a50/$a50$a50/$a50$a50 &&
     -+	touch $a50$a50/test.txt &&
     -+	touch $a50$a50/$a50$a50/$a50$a50/test.txt &&
     ++	: >"$a50$a50/test.txt" 2>"$a50$a50/$a50$a50/$a50$a50/test.txt" &&
     ++	# create a temporary outside the working tree to hide from "git clean"
      +	test_must_fail git clean -xdf 2>.git/err &&
     -+	grep "too long" .git/err
     ++	# grepping for a strerror string is unportable but it is OK here with
     ++	# MINGW prereq
     ++	test_i18ngrep "too long" .git/err
      +'
      +
       test_done

-- 
gitgitgadget
