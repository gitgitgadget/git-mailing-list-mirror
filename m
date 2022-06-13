Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F176EC43334
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 15:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243054AbiFMPjj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 11:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349078AbiFMPiw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 11:38:52 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E164674C7
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 06:13:13 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id c130-20020a1c3588000000b0039c6fd897b4so1513222wma.4
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 06:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uKDA6wya3ia5Po17rW30aZgU49Lt1E0VSzRb5f8FthA=;
        b=lpBTqMAoE8u5Y8MANBTlXoVP40UmwI4NjgKBIlWo2zIePsOKhsefyuT/GCZ5LqYakk
         4l1xxuAWoPTXVEmPkaTJK2mXHqeUmul16OLFMP7S+ZcfbpfV7k2tqaWvKOMOsNvnJbrV
         WA4zIEvfU7jzz0AMVqZPQYVqths79ihOaVGGBJEQnin81s6LpYoVxXemGeGV0bUuBUo4
         NbVEobfbD+LZSHYuUb4p5NSROG4G/iZa+FHDjjFy2A7seqdvOCOcOT9Kl6mzEvXPVLWt
         37hsZqNfNKVu4oAbcefHGET8tEtZLRlr+ElAr3t64T0Wa5aavX4d021qX5f//ttmt4XI
         Vjow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uKDA6wya3ia5Po17rW30aZgU49Lt1E0VSzRb5f8FthA=;
        b=gYeE0mLDr3zN01rN7iTdjHvuvRnjxcswr/BU5ASefdldjEX2wHpkULspcwD9LVJCEP
         KnO9RP8ikHV6htEaJS2r/ibEVQ6+W1x5gW7sgvhPukvpyBQcXanqkQ96YNcwYj9DqEeD
         H/CkX0LOza548HYe+lqnbOI21Din7eWPKYz/+3Sn0uZDxkWMOKH3KFMrNAb9TEnqnOzh
         2zmgyFa+aRYOoDclY3kdZPk+hh8RV+a1U3EfctghxmxJI/mvCr0vLEinIiRaqtxkKxnV
         grJ8Iv9rB0emwahaQ7nPJE6wPrP5TWwEw0K75+6CbXehbxJ3HMQbKOFMX2A8Py5tYZg3
         ePWA==
X-Gm-Message-State: AOAM532kOULir4JumZthpMAi2QMkjhb3sLfwSj+a0Zog3/APiMWV544n
        7W3BBWia291WTzCcTDi/F8CbyyH3FoTKXQ==
X-Google-Smtp-Source: ABdhPJwlI1hpCjOc+RRmz6VbmCO7C1hmWjm7uiMdlqIFv8u7x/2Ecs7h2a2ynbCVMUgLqDO9KRd3lA==
X-Received: by 2002:a7b:c758:0:b0:39c:44ce:f00f with SMTP id w24-20020a7bc758000000b0039c44cef00fmr14841334wmk.167.1655125989842;
        Mon, 13 Jun 2022 06:13:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d14-20020a05600c34ce00b003975c7058bfsm9304713wmq.12.2022.06.13.06.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 06:13:09 -0700 (PDT)
Message-Id: <pull.1253.v2.git.1655125988.gitgitgadget@gmail.com>
In-Reply-To: <pull.1253.git.1654774347.gitgitgadget@gmail.com>
References: <pull.1253.git.1654774347.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 13 Jun 2022 13:13:06 +0000
Subject: [PATCH v2 0/2] ci(GitHub): mark up compile errors, too
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just like we mark up test failures, it makes sense to mark up compile
errors, too.

In a sense, it makes even more sense with compile errors than with test
failures because we can link directly to the corresponding source code in
the former case (if said code has been touched by the Pull Request, that
is). The only downside is that this link currently is kind of misleading if
the Pull Request did not even touch the offending source code (such as was
the case when a GCC upgrade in Git for Windows' SDK all of a sudden pointed
out problems in the source code that had existed for a long time already).
We will see how the GitHub Actions engineers will develop this feature
further.

This patch series is based on js/ci-github-workflow-markup. Which also
serves as an example how this looks like if the offending source code was
not touched by the Pull Request:
https://github.com/dscho/git/actions/runs/2477526645 because it still
triggers the above-referenced GCC build failure.

Changes since v1:

 * Using a comma in the workflow command now, as described in the official
   documentation ;-) (Thank you, Ævar)
 * The curly bracket construct was replaced by a proper subshell, to avoid
   jumbled output and a race where the exit.status file could be read before
   it was written.

Johannes Schindelin (2):
  ci(github): use grouping also in the `win-build` job
  ci(github): also mark up compile errors

 ci/lib.sh                 | 10 ++++++++--
 ci/make-test-artifacts.sh |  2 +-
 2 files changed, 9 insertions(+), 3 deletions(-)


base-commit: 3069f2a6f4c38e7e599067d2e4a8e31b4f53e2d3
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1253%2Fdscho%2Fci-mark-up-compile-failures-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1253/dscho/ci-mark-up-compile-failures-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1253

Range-diff vs v1:

 1:  5212c5ec474 = 1:  5212c5ec474 ci(github): use grouping also in the `win-build` job
 2:  19d6e34f038 ! 2:  34daf06bb71 ci(github): also mark up compile errors
     @@ ci/lib.sh: else
      -		"$@"
      -		res=$?
      +		# work around `dash` not supporting `set -o pipefail`
     -+		{
     ++		(
      +			"$@" 2>&1
      +			echo $? >exit.status
     -+		} |
     -+		sed 's/^\(\([^ ]*\):\([0-9]*\):\([0-9]*:\) \)\(error\|warning\): /::\5 file=\2 line=\3::\1/'
     ++		) |
     ++		sed 's/^\(\([^ ]*\):\([0-9]*\):\([0-9]*:\) \)\(error\|warning\): /::\5 file=\2,line=\3::\1/'
      +		res=$(cat exit.status)
      +		rm exit.status
       		end_group

-- 
gitgitgadget
