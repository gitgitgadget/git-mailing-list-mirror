Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 042AE1F453
	for <e@80x24.org>; Wed, 23 Jan 2019 23:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfAWXjS (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 18:39:18 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35506 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfAWXjO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 18:39:14 -0500
Received: by mail-wr1-f66.google.com with SMTP id 96so4532305wrb.2
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 15:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:references:message-id:user-agent
         :mime-version;
        bh=FYd8+oIsrpTJfQldMaBlXHKaMBTC5yoDWcdYF9cB21Y=;
        b=lc9dxQjRCUl2Jnd664Q7b8NeBPUQShaL+WzrzpXsAF2u5/cejEaxSBvvCbhMoXsCOV
         zWZBCTtjd1yBVdPauiv6q5d+xVyEh5Gy36LD0blkllnyGdaZxW/mKzL6C9tryeVtu0+A
         kp5+b5NS9p8kSIcjMtxCqY3e8Hr8NkmEpW0xXhykI38C4IT4T7CwK+85mtJkzj1pUHBa
         3KfP6MW2JsDehboFFkM5b848b1f/3q03As8g01CXpPNMvAqt04268yKPrUW/Q5YFmRqm
         ggioF8UkUVvOKtjBAYYvizK7gb6gn7FOw+blmX8Jq91f+4VRimxp9UOUHNeyo0GG/Z2g
         a77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:references
         :message-id:user-agent:mime-version;
        bh=FYd8+oIsrpTJfQldMaBlXHKaMBTC5yoDWcdYF9cB21Y=;
        b=cYjbW2Jp1XAnrIU9/Z/GORk/K1zNfQtdwJH6AVqlLFBN1mz9ort19d9u1ojc9HXT1z
         5lFe+L+hrWIc46Xb5WyHGDc5mRQoVH4G00+Aby8uGzNuCNiuUExcYYFgF9EtqOWNxwX/
         2ufVVvr64NsHGgXGBS5KyWMKSbuWLBGQzARHr34u1btGei8SkZWPSrv9pf77ZuRXgIu2
         MbEn7JC72GjKzsIsW2LwFa5PqjpWE3r5Kl35BK9HTNC2p1oEm3KS2a/48HcUkDtsGO3i
         C8tQkqASXdlFSOLkCgMipkpbTp+IHBtXPSBYM20uwK9QaD9abDeDjSiaKGXNvBwibO/5
         4nag==
X-Gm-Message-State: AJcUukccE0z38Xweo5eZM4ViI5of1Uf4SI3ksFuw4uAvPdqpIpwDi8ee
        tPcOxiYZPP6PIjNg3Jj04tE=
X-Google-Smtp-Source: ALg8bN6E+yjGEWBEL6UJPExQIGF3PzkCWjZ/XAWrxmmeL0DNg+gXWXQrgoNEdzn7T/Cv48tV+UhSyw==
X-Received: by 2002:a5d:6684:: with SMTP id l4mr5078406wru.154.1548286752307;
        Wed, 23 Jan 2019 15:39:12 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j8sm151388608wmd.0.2019.01.23.15.39.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 15:39:11 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 09/21] Add a build definition for Azure DevOps
Date:   Wed, 23 Jan 2019 14:44:14 -0800
References: <pull.31.v3.git.gitgitgadget@gmail.com>
        <pull.31.v4.git.gitgitgadget@gmail.com>
        <eaba471b89976b51ea19fc6772890304135ab539.1548254412.git.gitgitgadget@gmail.com>
Message-ID: <xmqqd0on54gw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> This commit adds an azure-pipelines.yml file which is Azure DevOps'
> equivalent to Travis CI's .travis.yml.
>
> To make things a bit easier to understand, we refrain from using the
> `matrix` feature here because (while it is powerful) it can be a bit
> confusing to users who are not familiar with CI setups. Therefore, we
> use a separate phase even for similar configurations (such as GCC vs
> Clang on Linux, GCC vs Clang on macOS).
>
> Also, we make use of the shiny new feature we just introduced where the
> test suite can output JUnit-style .xml files. This information is made
> available in a nice UI that allows the viewer to filter by phase and/or
> test number, and to see trends such as: number of (failing) tests, time
> spent running the test suite, etc.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  azure-pipelines.yml   | 306 ++++++++++++++++++++++++++++++++++++++++++

Way-overlong line in this file bothers me somewhat, but let's say
these are not for human consumption and it is OK ;-)

> diff --git a/ci/lib.sh b/ci/lib.sh
> index a9eb4f4eae..91cf1402bf 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -42,7 +42,7 @@ then
>  
>  	BREW_INSTALL_PACKAGES=
>  	export GIT_PROVE_OPTS="--timer --jobs 10 --state=failed,slow,save"
> -	export GIT_TEST_OPTS="--quiet --write-junit-xml"
> +	export GIT_TEST_OPTS="--verbose-log -x --write-junit-xml"
>  fi

Interesting to see this change here, not in the previous step.  If
we stopped at 08/21, did we even have a chance to enter this elif
block?  If not, it probably is sane to squash this hunk to the
previous one that introduced the elif block.

