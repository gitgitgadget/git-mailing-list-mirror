Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598BDC27C76
	for <git@archiver.kernel.org>; Wed, 25 Jan 2023 04:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjAYEEB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Jan 2023 23:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjAYEEA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2023 23:04:00 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249114858F
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 20:03:58 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id m7so2122491wru.8
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 20:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+absRAsyDsjJgibL9ECgQH7oh0dJQHQUDuybKZDqu4=;
        b=J6Jt3GCRUMgDJAcXfDb4Ww2r8Yn4+FkC9NeO8zFTl7I0zghMAECP+Z18Jo/nUTJjhb
         l6p0YTjYH1BVTrIQKsDu+CSoYIdKLXY4EoVjvMChMxtqUOYcOeNO9Ereo0hM5xqcKRDU
         OLaEfjuK0jG3U3Qsj0tAngKuU+/mc2ZzVMlSRy0lWMyZ/RPrgFM1/Cwvk2r7+jIN4IT6
         mn5kFivquVUF19UafJA4LX+ziDKmTIHJbkUsgoUMJFdWNgPxSVw7uwvdhOtqiqS2BGwh
         PPHPa1zYpjBdjTz9It8Dt9RuV2r6QgKJsS0czCXaXBwJ29p0rabIF7fjocLNdqeYcvJl
         0Y2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c+absRAsyDsjJgibL9ECgQH7oh0dJQHQUDuybKZDqu4=;
        b=kZh/CkCcOuqpFCYOHBlLJdyRUr3roq9Q124Mj7iMhdMa8t8LdAdtarajBMmIEQmMfO
         bsL7cAvNfzo1ZrsxLjTYvEMJAEykgIhTPUulg8KGj41n6XAyy50G3DYLnl8T13ugy8EX
         uFqxfxyRtULNPjyh5AR7M3qfuW0vDW9tniSNZqRYIGDnanCikzt1dL5sU1qXtA3lxtrw
         qqFEmkQmrbz6XzrLyq88UX07GDIpBNdceeQ868nJ1my3tzjEvbypM0qoV3qpHEzp9izL
         yUHseAcnlQd5HRzoFBnKzm7kgO6bu+CH8xGhw3GUTb9r4rkm2MjXOu2FHuOhXD0RZv3u
         kHNw==
X-Gm-Message-State: AFqh2kp74ccr9nwNSmIEAPyR/cMS2LF2xnxVbRJhbM0CTt27/xjCWa11
        uxGup7biyIRN97m1u8GTJDYrTXzx36w=
X-Google-Smtp-Source: AMrXdXt+LQ0zr7X2VZAtab4QZRaZ34Kl3O60gxji4RpSFtBftQREWkjAH5dkFGxtgLAZAVYbRJP0uw==
X-Received: by 2002:a05:6000:38a:b0:2be:4c32:a7df with SMTP id u10-20020a056000038a00b002be4c32a7dfmr19604303wrf.63.1674619436311;
        Tue, 24 Jan 2023 20:03:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t12-20020adfe10c000000b002bdd96d88b4sm27125wrz.75.2023.01.24.20.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 20:03:55 -0800 (PST)
Message-Id: <pull.1466.v5.git.1674619434.gitgitgadget@gmail.com>
In-Reply-To: <pull.1466.v4.git.1674367961.gitgitgadget@gmail.com>
References: <pull.1466.v4.git.1674367961.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 Jan 2023 04:03:44 +0000
Subject: [PATCH v5 00/10] rebase: fix several code/testing/documentation issues around flag
 incompatibilities
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We had a report about --update-refs being ignored when --whitespace=fix was
passed, confusing an end user. These were already marked as incompatible in
the manual, but the code didn't check for the incompatibility and provide an
error to the user.

Folks brought up other flags tangentially when reviewing an earlier round of
this series, and I found we had more that were missing checks, and that we
were missing some testcases, and that the documentation was wrong on some of
the relevant options. So, I ended up getting lots of little fixes to
straighten these all out.

Changes since v4:

 * Pulled out the changes regarding incompatibility detection for
   --[no-]reapply-cherry-picks into a separate patch. Phillip helped a lot
   with understanding the behavior, suggesting changes, and getting the
   wording right, and I think it deserves its own patch with its own
   explanation.

Changes since v3:

 * Corrected the code surrounding --[no-]reapply-cherry-picks, and extended
   the testcases (Thanks to Phillip for pointing out my error)
 * I went ahead and implemented the better error message when the merge
   backend is triggered solely via config options.

Changes since v2:

 * Remove the extra patch and reword the comment in t3422 more thoroughly.
 * Add tests for other flag incompatibilities that were missing
 * Add code that was missing for checking various flag incompatibilities
 * Fix incorrect claims in the documentation around incompatible options
 * A few other miscellaneous fixups noticed while doing all the above

Changes since v1:

 * Add a patch nuking the -C option to rebase (fixes confusion around the
   comment in t3422 and acknowledges the fact that the option is totally and
   utterly useless and always has been. It literally never affects the
   results of a rebase.)

Signed-off-by: Elijah Newren newren@gmail.com

Elijah Newren (10):
  rebase: mark --update-refs as requiring the merge backend
  rebase: flag --apply and --merge as incompatible
  rebase: remove --allow-empty-message from incompatible opts
  rebase: fix docs about incompatibilities with --root
  rebase: fix incompatiblity checks for --[no-]reapply-cherry-picks
  rebase: add coverage of other incompatible options
  rebase: clarify the OPT_CMDMODE incompatibilities
  rebase: fix formatting of rebase --reapply-cherry-picks option in docs
  rebase: put rebase_options initialization in single place
  rebase: provide better error message for apply options vs. merge
    config

 Documentation/git-rebase.txt           | 77 ++++++++++++-------------
 builtin/rebase.c                       | 79 +++++++++++++++++++-------
 t/t3422-rebase-incompatible-options.sh | 71 +++++++++++++++++++++--
 3 files changed, 163 insertions(+), 64 deletions(-)


base-commit: 56c8fb1e95377900ec9d53c07886022af0a5d3c2
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1466%2Fnewren%2Frebase-update-refs-imply-merge-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1466/newren/rebase-update-refs-imply-merge-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1466

Range-diff vs v4:

  1:  8a676e6ec1a =  1:  8a676e6ec1a rebase: mark --update-refs as requiring the merge backend
  2:  cc129b87185 =  2:  cc129b87185 rebase: flag --apply and --merge as incompatible
  3:  9464bbbe9ba =  3:  9464bbbe9ba rebase: remove --allow-empty-message from incompatible opts
  4:  b702f15ed7c =  4:  b702f15ed7c rebase: fix docs about incompatibilities with --root
  -:  ----------- >  5:  3a8429f3d2b rebase: fix incompatiblity checks for --[no-]reapply-cherry-picks
  5:  5e4851e611e !  6:  2777dd2788a rebase: add coverage of other incompatible options
     @@ Commit message
      
          The git-rebase manual noted several sets of incompatible options, but
          we were missing tests for a few of these.  Further, we were missing
     -    code checks for some of these, which could result in command line
     +    code checks for one of these, which could result in command line
          options being silently ignored.
      
          Also, note that adding a check for autosquash means that using
     @@ Commit message
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     - ## Documentation/git-rebase.txt ##
     -@@ Documentation/git-rebase.txt: are incompatible with the following options:
     -  * --exec
     -  * --no-keep-empty
     -  * --empty=
     -- * --reapply-cherry-picks
     -+ * --[no-]reapply-cherry-picks
     -  * --edit-todo
     -  * --update-refs
     -  * --root when used without --onto
     -
       ## builtin/rebase.c ##
     -@@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
     - 		if (options.fork_point < 0)
     - 			options.fork_point = 0;
     - 	}
     -+	/*
     -+	 * The apply backend does not support --[no-]reapply-cherry-picks.
     -+	 * The behavior it implements by default is equivalent to
     -+	 * --no-reapply-cherry-picks (due to passing --cherry-picks to
     -+	 * format-patch), but --keep-base alters the upstream such that no
     -+	 * cherry-picks can be found (effectively making it act like
     -+	 * --reapply-cherry-picks).
     -+	 *
     -+	 * Now, if the user does specify --[no-]reapply-cherry-picks, but
     -+	 * does so in such a way that options.reapply_cherry_picks ==
     -+	 * keep_base, then the behavior they get will match what they
     -+	 * expect despite options.reapply_cherry_picks being ignored.  We
     -+	 * could just allow the flag in that case, but it seems better to
     -+	 * just alert the user that they've specified a flag that the
     -+	 * backend ignores.
     -+	 */
     -+	if (options.reapply_cherry_picks >= 0)
     -+		imply_merge(&options, options.reapply_cherry_picks ? "--reapply-cherry-picks" :
     -+								     "--no-reapply-cherry-picks");
     -+
     - 	/*
     - 	 * --keep-base defaults to --reapply-cherry-picks to avoid losing
     - 	 * commits when using this option.
     -@@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
     - 	if (options.empty != EMPTY_UNSPECIFIED)
     - 		imply_merge(&options, "--empty");
     - 
     --	/*
     --	 * --keep-base implements --reapply-cherry-picks by altering upstream so
     --	 * it works with both backends.
     --	 */
     --	if (options.reapply_cherry_picks && !keep_base)
     --		imply_merge(&options, "--reapply-cherry-picks");
     --
     - 	if (gpg_sign)
     - 		options.gpg_sign_opt = xstrfmt("-S%s", gpg_sign);
     - 
      @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
       	if (options.update_refs)
       		imply_merge(&options, "--update-refs");
     @@ t/t3422-rebase-incompatible-options.sh: test_rebase_am_only () {
      +		test_must_fail git rebase $opt --empty=ask A
      +	"
      +
     -+	test_expect_success "$opt incompatible with --no-reapply-cherry-picks" "
     -+		git checkout B^0 &&
     -+		test_must_fail git rebase $opt --no-reapply-cherry-picks A
     -+	"
     -+
     -+	test_expect_success "$opt incompatible with --reapply-cherry-picks" "
     -+		git checkout B^0 &&
     -+		test_must_fail git rebase $opt --reapply-cherry-picks A
     -+	"
     -+
     - 	test_expect_success "$opt incompatible with --update-refs" "
     + 	test_expect_success "$opt incompatible with --no-reapply-cherry-picks" "
       		git checkout B^0 &&
     - 		test_must_fail git rebase $opt --update-refs A
     + 		test_must_fail git rebase $opt --no-reapply-cherry-picks A
  6:  21ae9e05313 !  7:  0d0541ea243 rebase: clarify the OPT_CMDMODE incompatibilities
     @@ Documentation/git-rebase.txt: See also INCOMPATIBLE OPTIONS below.
      @@ Documentation/git-rebase.txt: are incompatible with the following options:
        * --no-keep-empty
        * --empty=
     -  * --[no-]reapply-cherry-picks
     +  * --[no-]reapply-cherry-picks when used without --keep-base
      - * --edit-todo
        * --update-refs
        * --root when used without --onto
  7:  74a216bf0c0 =  8:  01808cf84a8 rebase: fix formatting of rebase --reapply-cherry-picks option in docs
  8:  a8adf7fda61 =  9:  f646abee524 rebase: put rebase_options initialization in single place
  9:  5cb00e5103b = 10:  328f5a1d534 rebase: provide better error message for apply options vs. merge config

-- 
gitgitgadget
