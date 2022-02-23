Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9FBC433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 14:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241560AbiBWO2H (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 09:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241556AbiBWO2G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 09:28:06 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5BAAC07A
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 06:27:37 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id x15so5541254wrg.8
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 06:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=42x7JBXT0wOUXNQM6ZqV/sqN+Y18Awz/hHV6lJS5qEQ=;
        b=ngDTrJcuc2XdAVhhWJ6xlUfKPvUuCmIsmh73vORS4kXSaoLHaa9JDwwm7mlvMkusNC
         kou/2mYEEId8osdar0/zofnPy1y5ZBGvomAYnRorbBHtswlkRw6ji9l/q9BcuIgIHtY9
         +JlDDeb/8J//BjxGo2ORyOL/O5ivT2jwF9DyHl94vGiD8OHb+JGTv8CzBDSMaN8BbI03
         ybyg4bnOz5ECqe0X8mMQ+TIaKj037k4YbDQQldFqe7LaCFonY2CXkfeHn0in/z4KME63
         /GRXDxDXFvhH1jLgnBkJGOEnAOtSal93IPRy/Ra9+6m9emXhrq6r8iM+pPU6dSklrjSA
         52xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=42x7JBXT0wOUXNQM6ZqV/sqN+Y18Awz/hHV6lJS5qEQ=;
        b=HQ01IDHclC9kKE3X9TYL7rKSL3k5B2VFdm7958rBABh+eIZUIcya0mYUeIp2N1pKd3
         K5AUKkG/iVEBtxDXn2orckjoOeSQ6QCYHElSpR0RxUz8QIMxcS0kD84TijHMNhZTaBPO
         n3I3MML/BpgmVbHfBzpTCEf691MZQ3pK6v3i5hDdhzqc2B6ZlyaLyzNgrP2L6Qd+Y5mc
         FsBM6ailLcpraHCX74glOGHVN1V8L5kzVLfFYz2HBQCEy4weP6DH52dTWBzxNmfagx8V
         wYr7uG/43kFUqvPGCg8seaH4FSep5g8szYFl/yFT+AVYeFjZnNwgKFahIMHFJkpTF/j1
         vDtQ==
X-Gm-Message-State: AOAM533gw2+OfpERRL7xbra2pttZLOCMDXaTGmaSYNQw+4BR6IyKTpdg
        GDqqVULsR7R+3BLsfyT1qdEnZHMJtvY=
X-Google-Smtp-Source: ABdhPJy+c1u8bnnIRcoFeLncghOswwAUsJvE+wi49DfSmAC2kpKovvc7W/lqtyDoJwnBeA34gBsMoA==
X-Received: by 2002:a05:6000:18c3:b0:1e5:82d3:e4e2 with SMTP id w3-20020a05600018c300b001e582d3e4e2mr23781199wrq.575.1645626456219;
        Wed, 23 Feb 2022 06:27:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o3-20020a05600c4fc300b0037bea2f9775sm5888028wmq.25.2022.02.23.06.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 06:27:35 -0800 (PST)
Message-Id: <pull.1147.v3.git.1645626455.gitgitgadget@gmail.com>
In-Reply-To: <pull.1147.v2.git.1645545507689.gitgitgadget@gmail.com>
References: <pull.1147.v2.git.1645545507689.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 14:27:33 +0000
Subject: [PATCH v3 0/2] add usage-strings ci check and amend remaining usage strings
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Julia Lawall <julia.lawall@inria.fr>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series completely fixes #636.

The issue is about amending the usage-strings (for command flags such as -h,
-v etc.) which do not follow the style convention/guide. There was a PR
[https://github.com/gitgitgadget/git/pull/920] addressing this issue but as
Johannes [https://github.com/dscho] said in his comment
[https://github.com/gitgitgadget/git/issues/636#issuecomment-1018660439],
there are some files that still have those kind of usage strings. Johannes
also suggested to add a CI check under ci/test-documentation.sh to check the
usage strings.

In this version, the previously single commit is split into two commits (
one addressing amending of usage strings and another is for adding the style
checks to parse_options_check()) and the checks are simplified.

Changes since v1:

 1. remove check-usage-strings.sh
 2. remove CI check
 3. add checks to parse-options.c
 4. modify t/t1502-rev-parse-parseopt.sh to pass the test

Until v1:

A shell script check-usage-strings.sh was introduced to check the
usage-strings. CI check for the same was also introduced.

Abhra303 (1):
  amend remaining usage strings according to style guide

Abhradeep Chakraborty (1):
  parse-options.c: add style checks for usage-strings

 builtin/bisect--helper.c      | 2 +-
 builtin/reflog.c              | 6 +++---
 builtin/submodule--helper.c   | 2 +-
 diff.c                        | 2 +-
 parse-options.c               | 6 ++++++
 t/helper/test-run-command.c   | 6 +++---
 t/t1502-rev-parse-parseopt.sh | 4 ++--
 7 files changed, 17 insertions(+), 11 deletions(-)


base-commit: e6ebfd0e8cbbd10878070c8a356b5ad1b3ca464e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1147%2FAbhra303%2Fusage_command_amend-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1147/Abhra303/usage_command_amend-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1147

Range-diff vs v2:

 1:  902937e768d ! 1:  f425e36b7ea add usage-strings check  and amend remaining usage strings
     @@ Metadata
      Author: Abhra303 <chakrabortyabhradeep79@gmail.com>
      
       ## Commit message ##
     -    add usage-strings check  and amend remaining usage strings
     +    amend remaining usage strings according to style guide
      
          Usage strings for git (sub)command flags has a style guide that
     -    suggests - first letter should not capitalized (unless requied)
     +    suggests - first letter should not capitalized (unless required)
          and it should skip full-stop at the end of line. But there are
          some files where usage-strings do not follow the above mentioned
     -    guide. Moreover, there are no checks to verify if all usage strings
     -    are following the guide/convention or not.
     +    guide.
      
     -    Amend the usage strings that don't follow the convention/guide and
     -    add a check in the `parse_options_check()` function in `parse-options.c`
     -    to check the usage strings against the style guide.
     +    Amend the usage strings that don't follow the style convention/guide.
      
          Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
      
     @@ diff.c: static void prep_parse_options(struct diff_options *options)
       
       		OPT_END()
      
     - ## parse-options.c ##
     -@@ parse-options.c: static void parse_options_check(const struct option *opts)
     - 		default:
     - 			; /* ok. (usually accepts an argument) */
     - 		}
     -+		if (opts->type != OPTION_GROUP && opts->help &&
     -+			!(starts_with(opts->help, "HEAD") ||
     -+			  starts_with(opts->help, "GPG") ||
     -+			  starts_with(opts->help, "DEPRECATED") ||
     -+			  starts_with(opts->help, "SHA1")) &&
     -+			  (opts->help[0] >= 65 && opts->help[0] <= 90))
     -+			err |= optbug(opts, xstrfmt("help should not start with capital letter unless needed: %s", opts->help));
     -+		if (opts->help && !ends_with(opts->help, "...") && ends_with(opts->help, "."))
     -+			err |= optbug(opts, xstrfmt("help should not end with a dot: %s", opts->help));
     - 		if (opts->argh &&
     - 		    strcspn(opts->argh, " _") != strlen(opts->argh))
     - 			err |= optbug(opts, "multi-word argh should use dash to separate words");
     -
       ## t/helper/test-run-command.c ##
      @@ t/helper/test-run-command.c: static int quote_stress_test(int argc, const char **argv)
       	struct strbuf out = STRBUF_INIT;
     @@ t/helper/test-run-command.c: static int quote_stress_test(int argc, const char *
       		OPT_END()
       	};
       	const char * const usage[] = {
     -
     - ## t/t1502-rev-parse-parseopt.sh ##
     -@@ t/t1502-rev-parse-parseopt.sh: test_expect_success 'setup optionspec-only-hidden-switches' '
     - |
     - |some-command does foo and bar!
     - |--
     --|hidden1* A hidden switch
     -+|hidden1* a hidden switch
     - EOF
     - '
     - 
     -@@ t/t1502-rev-parse-parseopt.sh: test_expect_success 'test --parseopt help-all output hidden switches' '
     - |
     - |    some-command does foo and bar!
     - |
     --|    --hidden1             A hidden switch
     -+|    --hidden1             a hidden switch
     - |
     - |EOF
     - END_EXPECT
 -:  ----------- > 2:  9d42bdbff6c parse-options.c: add style checks for usage-strings

-- 
gitgitgadget
