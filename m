Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C375C433F5
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 05:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236171AbiBYFYJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 00:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235210AbiBYFYG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 00:24:06 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DFD2782AA
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 21:23:22 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d28so2765986wra.4
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 21:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=r/tMLbZ9yovOJVwhqzGiT5BLgacKhRgRYstvX9bfUic=;
        b=c9gmguiJgfoxT6md7tCkI+9DJMKMmMFZxcmwmnqe8HMeIm7HTzSyvcRlVu2w93b9vP
         TOPf5D5+8gZGU7WdKu4c5NtPqFSxifMX43qK5Pt7sx4en1S6ThAolhi8vhjwo/iqLjc8
         23k11NXYKg7SCM0WByV+SJMAzyHYX9hs7A7F24TBFbp4+I+bnCfyFH4kzYapRBu5B0tl
         V0zjD73X0cY/O6houaVsU72VD6/P1SKUv77oLirtUbo5Lco2LZVka9KfjJ/e/C6Jsco5
         qB79N63flSNeq0uVTTDuDyVJtD3KHHUNXXXNwuRAHE9cs81FLQVgjqGYSgtk3L67UhGP
         F13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=r/tMLbZ9yovOJVwhqzGiT5BLgacKhRgRYstvX9bfUic=;
        b=NEtKOF/BM5XoM9u/ZjtRVI/p4WimIshBAAT6KC29gFL+Ru4ptUVicou6JuUYZxhgEo
         bkJsBljRH7MnnFNkGkYuXjPw0rPh5A5tbEapZ7DSz/5HEw6kcdA5m/H0rR1vRpWSKOES
         nGZXymMSEw6pabLE/BrfdA/gk0W7GdilhZVBRYPnUUIIzNnagLlYzaVBuPvSQJP+1MNu
         cYkK69LA4dyRXXdHGE5IkDu9ClG+cAZxB3LP0+60l/cKQTtBj2ZvNMWGgIK8p2A3UjK7
         vLTWF2GR5gUnC8OZlcBqZc2Lpn62hH+w6qrJ3X61rlktn/H02i9RY85LWX3tn8ZgCd1q
         Nrfw==
X-Gm-Message-State: AOAM532Xka9/DUZFA1z9mvuX06AnV9/UtSJ6jMXjOMnpoOdImTNlNE3v
        /es5DUw2yjypRIeVdwMWFQCVWq6U3Aw=
X-Google-Smtp-Source: ABdhPJwWnw+BbWDjALBI4z3snh8SG4OGRn6i8haCEfNtxumIekJbAXEzLwZCK7SyN/SbHqeUer+5sQ==
X-Received: by 2002:adf:c04d:0:b0:1ed:c156:6651 with SMTP id c13-20020adfc04d000000b001edc1566651mr4842044wrf.558.1645766600789;
        Thu, 24 Feb 2022 21:23:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i22-20020a05600c355600b0037bee3a4e00sm4589715wmq.47.2022.02.24.21.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 21:23:20 -0800 (PST)
Message-Id: <pull.1147.v4.git.1645766599.gitgitgadget@gmail.com>
In-Reply-To: <pull.1147.v3.git.1645626455.gitgitgadget@gmail.com>
References: <pull.1147.v3.git.1645626455.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Feb 2022 05:23:17 +0000
Subject: [PATCH v4 0/2] add usage-strings ci check and amend remaining usage strings
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
        Junio C Hamano <gitster@pobox.com>,
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

In this version, comments added and the From field of the first commit
message is updated (i.e. "Abhradeep Chakraborty" instead of "Abhra303")

Changes since v2:

 1. split the single commit into two logically separated commits ( one
    addressing amending of usage strings and another is for adding the style
    checks to parse_options_check())
 2. the checks are simplified.

Changes since v1:

 1. remove check-usage-strings.sh
 2. remove CI check
 3. add checks to parse-options.c
 4. modify t/t1502-rev-parse-parseopt.sh to pass the test

Until v1:

A shell script check-usage-strings.sh was introduced to check the
usage-strings. CI check for the same was also introduced.

Abhradeep Chakraborty (2):
  amend remaining usage strings according to style guide
  parse-options.c: add style checks for usage-strings

 builtin/bisect--helper.c      |  2 +-
 builtin/reflog.c              |  6 +++---
 builtin/submodule--helper.c   |  2 +-
 diff.c                        |  2 +-
 parse-options.c               | 11 +++++++++++
 t/helper/test-run-command.c   |  6 +++---
 t/t1502-rev-parse-parseopt.sh |  4 ++--
 7 files changed, 22 insertions(+), 11 deletions(-)


base-commit: e6ebfd0e8cbbd10878070c8a356b5ad1b3ca464e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1147%2FAbhra303%2Fusage_command_amend-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1147/Abhra303/usage_command_amend-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1147

Range-diff vs v3:

 1:  f425e36b7ea ! 1:  dc200d098ae amend remaining usage strings according to style guide
     @@
       ## Metadata ##
     -Author: Abhra303 <chakrabortyabhradeep79@gmail.com>
     +Author: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
      
       ## Commit message ##
          amend remaining usage strings according to style guide
 2:  9d42bdbff6c ! 2:  e1c5a325826 parse-options.c: add style checks for usage-strings
     @@ parse-options.c: static void parse_options_check(const struct option *opts)
       		default:
       			; /* ok. (usually accepts an argument) */
       		}
     ++
     ++		// OPTION_GROUP should be ignored
     ++		// if the first two characters of the help string are uppercase, then assume it is an
     ++		// acronym (i.e. "GPG") or special name (i.e. "HEAD"), thus allowed.
     ++		// else assume the usage string is violating the style convention and throw error.
      +		if (opts->type != OPTION_GROUP && opts->help &&
      +			opts->help[0] && isupper(opts->help[0]) &&
      +			!(opts->help[1] && isupper(opts->help[1])))

-- 
gitgitgadget
