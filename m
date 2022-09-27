Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B27C07E9D
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 13:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbiI0N5H (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 09:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbiI0N5F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 09:57:05 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4525313F2A6
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 06:57:04 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so5523448wmb.0
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 06:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=vvlPW+uVrgU2Ek71aQDEtfMZ+aBwmfBeDFV4qfU9SRg=;
        b=ldrLCQvteQcDxCmb/ADFVOJSrTlwvpxN5QKGrGfZCwRsLhnGj34BugewrUHGkYB6K/
         5nMLX2bIXimAgwbCRh/wFCTvJPtzXd9ecf44HnEXw9pPped/jCbudkAAnFKz7jKLZBPb
         p9lMULBO6QYXgt66R+hs/BDRmZreYqlAvxSU6NKLNl1CQom84l4R7uE6ANTO1cX8r+ZY
         5Ex8Jr44qpc/hqXfTmfk9mBTG9HGsi0bXoMH5OfLsc1A2WdK+tr5+x5ytHYg38wlnmIA
         5JhDqjoVgiw7I1LWbGwJncqRYLr8CQPMRtjpxk6+fPS1Wf1IUTOKzofpxeyW9zoe0Kh7
         HAbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=vvlPW+uVrgU2Ek71aQDEtfMZ+aBwmfBeDFV4qfU9SRg=;
        b=AEuBO4XxF3+vY5IROdkIhrIhbPM8YElgJmVwSRO+IX8XIHpgd6DrUbDMA4LNLzgBxK
         5KjMlZmww89SWKcvcwDV08rpjRkM5NyP/mjn7Xcjtvbfki4VBEFa3YK1lt+Je+wDqPxn
         9gLXggFn4N6UqOETI1JZT5rGliqAc+PGdPGu1wmZMLm3yMZyAw3QQuF5qka2Uk9w/M37
         vfwRqFxOLJk4t7OjbHf8GHfQkvD3SMsDeKa3Dqzr2BH0Xab997IShdzWxjweXl7H/nc+
         OSOcrbzZT/zsjNuOP9wiG6bcxbA7adzeptTJ8Ub9uLsVa9Ibrs/gapdEEiwgUhiBm++r
         yP4w==
X-Gm-Message-State: ACrzQf0KngGNliWIG6XYkvtdsYgUFtbSYudWAu7CetkXIvXtdWQBjJhK
        vXne0smvX2t+lRPdNKEPhSHW7bSQchI=
X-Google-Smtp-Source: AMsMyM4NTp+fVXfMHznYFXHhIT1jN0y4M2r/hLzKVV7bqenwlflMwZmkApHGR5t4Dx1YjDDPfosaVA==
X-Received: by 2002:a05:600c:41c3:b0:3b4:9668:655a with SMTP id t3-20020a05600c41c300b003b49668655amr2832510wmh.36.1664287022426;
        Tue, 27 Sep 2022 06:57:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bg42-20020a05600c3caa00b003a5f4fccd4asm15172032wmb.35.2022.09.27.06.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 06:57:01 -0700 (PDT)
Message-Id: <pull.1358.v4.git.1664287021.gitgitgadget@gmail.com>
In-Reply-To: <pull.1358.v3.git.1664218087.gitgitgadget@gmail.com>
References: <pull.1358.v3.git.1664218087.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Sep 2022 13:56:57 +0000
Subject: [PATCH v4 0/4] scalar: make unregister idempotent
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I noticed this while we were updating the microsoft/git fork to include
v2.38.0-rc0. I don't think 'git maintenance unregister' was idempotent
before, but instead some change in 'scalar unregister' led to it relying on
the return code of 'git maintenance unregister'. Our functional tests expect
'scalar unregister' to be idempotent, and I think that's a good pattern for
'git maintenance unregister', so I'm fixing it at that layer.

Despite finding this during the 2.38.0-rc0 integration, this isn't critical
to the release.

Perhaps an argument could be made that "failure means it wasn't registered
before", but I think that isn't terribly helpful.

Our functional tests are running the unregister subcommand to disable
maintenance in order to run tests on the object store (such as running
maintenance commands in the foreground and checking the object store
afterwards). This is a form of automation using 'unregister' as a check that
maintenance will not run at the same time, and it doesn't care if
maintenance was already disabled. I can imagine other scripting scenarios
wanting that kind of guarantee.


Updates in v4
=============

 * The previous version would segfault if 'git maintenance unregister' was
   called with an empty 'maintenance.repo' config list. This scenario is
   fixed and tested.
 * Part of the issue is that for_each_string_list_item() cannot handle a
   NULL value. The macro can't be made smarter without failing
   -Werror=address issues, so for now I added a patch that adds a warning to
   its doc comment.


Updates in v3
=============

 * The --force option now uses OPT_FORCE and is hidden from autocomplete.
 * A new commit is added that removes the use of Git subprocesses in favor
   of git_config_set_multivar_in_file_gently().


Updates in v2
=============

 * This is now a two-patch series.
 * I rebased onto v2.38.0-rc1 for two reasons: Scalar is now merged, and the
   usage for 'git maintenance unregister' removed its translation markers.
 * Instead of making git maintenance unregister idempotent, add a --force
   option for those who do not want to require that the repository is
   already registered.
 * Make scalar unregister idempotent, with reasons argued in patch 2.

Thanks, -Stolee

Derrick Stolee (4):
  maintenance: add 'unregister --force'
  scalar: make 'unregister' idempotent
  gc: replace config subprocesses with API calls
  string-list: document iterator behavior on NULL input

 Documentation/git-maintenance.txt |  6 +-
 builtin/gc.c                      | 98 +++++++++++++++++++++----------
 scalar.c                          |  5 +-
 string-list.h                     |  7 ++-
 t/t7900-maintenance.sh            | 11 +++-
 t/t9210-scalar.sh                 |  5 +-
 6 files changed, 96 insertions(+), 36 deletions(-)


base-commit: 1b3d6e17fe83eb6f79ffbac2f2c61bbf1eaef5f8
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1358%2Fderrickstolee%2Fmaintenance-unregister-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1358/derrickstolee/maintenance-unregister-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1358

Range-diff vs v3:

 1:  8a8bffaec89 ! 1:  c3301e21109 maintenance: add 'unregister --force'
     @@ Commit message
          '--force' option that will siltently succeed if the repository is not
          already registered.
      
     +    Also add an extra test of 'git maintenance unregister' at a point where
     +    there are no registered repositories. This should fail without --force.
     +
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
       ## Documentation/git-maintenance.txt ##
     @@ builtin/gc.c: done:
       	char *maintpath = get_maintpath();
      +	int found = 0;
      +	struct string_list_item *item;
     -+	const struct string_list *list = git_config_get_value_multi(key);
     ++	const struct string_list *list;
       
       	argc = parse_options(argc, argv, prefix, options,
       			     builtin_maintenance_unregister_usage, 0);
     @@ builtin/gc.c: static int maintenance_unregister(int argc, const char **argv, con
      -	config_unset.git_cmd = 1;
      -	strvec_pushl(&config_unset.args, "config", "--global", "--unset",
      -		     "--fixed-value", "maintenance.repo", maintpath, NULL);
     -+	for_each_string_list_item(item, list) {
     -+		if (!strcmp(maintpath, item->string)) {
     -+			found = 1;
     -+			break;
     ++	list = git_config_get_value_multi(key);
     ++	if (list) {
     ++		for_each_string_list_item(item, list) {
     ++			if (!strcmp(maintpath, item->string)) {
     ++				found = 1;
     ++				break;
     ++			}
      +		}
      +	}
      +
     @@ builtin/gc.c: static int maintenance_unregister(int argc, const char **argv, con
       }
      
       ## t/t7900-maintenance.sh ##
     +@@ t/t7900-maintenance.sh: test_expect_success 'maintenance.strategy inheritance' '
     + 
     + test_expect_success 'register and unregister' '
     + 	test_when_finished git config --global --unset-all maintenance.repo &&
     ++
     ++	test_must_fail git maintenance unregister 2>err &&
     ++	grep "is not registered" err &&
     ++	git maintenance unregister --force &&
     ++
     + 	git config --global --add maintenance.repo /existing1 &&
     + 	git config --global --add maintenance.repo /existing2 &&
     + 	git config --global --get-all maintenance.repo >before &&
      @@ t/t7900-maintenance.sh: test_expect_success 'register and unregister' '
       
       	git maintenance unregister &&
 2:  06d5ef3fc57 = 2:  a768c326c0f scalar: make 'unregister' idempotent
 3:  260d7bee36e = 3:  5aa9cc1d6b9 gc: replace config subprocesses with API calls
 -:  ----------- > 4:  73a262cdca4 string-list: document iterator behavior on NULL input

-- 
gitgitgadget
