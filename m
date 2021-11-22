Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53249C433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 16:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbhKVQO4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 11:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbhKVQOz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 11:14:55 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8372C061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 08:11:48 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id l25so62538513eda.11
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 08:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=OiMr6Poq8cO58ylyabsZnxEW/yAqoyN4Moco91E91Do=;
        b=XGqK+M47DtO3VTXeRCt9JSh0J+WQP0ON4wn/gRi+UHf1eFeIwaJzlGk2W6CYjvjjhR
         zT4ByHlxSMQaz+tmtuQ7LyilXxeMbWQs5qBnkaU8DFg3A/paAuIEvtbRkc3xNjTK+0Nt
         LfUGBhwKJQL4YC9hBSEv7KKSimWpanaRKCGK/xz55t6v4gjANCogTeq4CmYv+qGwLnLV
         scpqlmojlCbotfGqMNPAwsxp1L7o2EAe+hjwLEk9hRx6F8tQT1wd8WLZJ4bRHOPmBO6m
         htw9eaCcymUpUIwpT+QuOh6RHyYWG+8UyOgh09X2MQXj6WXhLasFhGd32PbK90G+4NWS
         GZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=OiMr6Poq8cO58ylyabsZnxEW/yAqoyN4Moco91E91Do=;
        b=D2cPmbFzliBpXe+vXbDHAdkUmLKAqL9u2fjLm7H3Nsomciv4ILkxOKekspC9cxq9n3
         uYmRYv/L/5l9m2Xw6H8YJG0+0l1Q2IBp7XluDqManbqL8qBBet/xEdHa56/+Jc1cTB1b
         iC1BuM7LfVPWnX/9gKENz6RdsGjEqK/SzGaw655BVXwEhh58zMmzIc5n8zkmpZB26UIQ
         d+JO4KR1ex/k+P3pIN058GDTLsn4ka6xMg+CqBOZDizxkm20sdrzonAqpRXYvIega1qa
         BG1eYaYnpNAgHGj9eSwtPaR/lUbJY1amUOT3yK0M4kCOv7sIlyv3L+7IIQpG/9en1Nfo
         /5Jg==
X-Gm-Message-State: AOAM533ZB0IRmJFxeWuoMwhGhwvIJgi9rhlyN+XV6MfGM4qVRUG2DRCQ
        7UqKzXq9qUbHdHncVdcyNAU=
X-Google-Smtp-Source: ABdhPJx1QIKxcm3TK1CxCWFcRvCB8Bwef97FcXMMuNvilBDKu7yHSRFsPafq793P0IvESgekz/zD2A==
X-Received: by 2002:a17:906:2b12:: with SMTP id a18mr42039702ejg.254.1637597505296;
        Mon, 22 Nov 2021 08:11:45 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ji14sm4065972ejc.89.2021.11.22.08.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 08:11:44 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mpBux-0016UG-7a;
        Mon, 22 Nov 2021 17:11:43 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fixup??? Merge branch 'ab/ci-updates' into seen
Date:   Mon, 22 Nov 2021 16:57:39 +0100
References: <pull.1081.git.1637578930464.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <pull.1081.git.1637578930464.gitgitgadget@gmail.com>
Message-ID: <211122.86ee78yxts.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 22 2021, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The merge of the `ab/ci-updates` patches needs this fix-up to avoid
> breaking the Scalar tests.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     fixup??? Merge branch 'ab/ci-updates' into seen
>     
>     This fixes the CI breakage introduced with ab/ci-updates. It is based on
>     the current version of seen: 89513b853be (Merge branch 'en/keep-cwd'
>     into seen, 2021-11-21).
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1081%2Fdscho%2Ffix-ci-updates-merge-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1081/dscho/fix-ci-updates-merge-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1081
>
>  ci/run-build-and-tests.sh | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> index c0bae709b3b..c508c18ad44 100755
> --- a/ci/run-build-and-tests.sh
> +++ b/ci/run-build-and-tests.sh
> @@ -45,9 +45,8 @@ linux-gcc-4.8)
>  	export MAKE_TARGETS=all
>  	;;
>  esac
> -make -C contrib/scalar test
> -
>  make $MAKE_TARGETS
> +make -C contrib/scalar test
>  
>  check_unignored_build_artifacts

The CI breakage was introduced with the merger with ab/ci-updates, but
the combination of the two just reveals an existing breakage in
js/scalar.

Which is that on js/scalar this won't work:

    make clean
    make -C contrib/scalar test

Since its dependency graph is broken. It tries to run before "make all"
has been run, but fails.

It would be one thing if it just refused to run because the sources
haven't been compiled, but instead it tries in a way that suggests
that's meant to work, but it doesn't work.

I didn't spot this myself because I was testing on my locally patched
version of the scalar topic which doesn't have this breakage, which is a
patch you haven't reviwed/looked at/replied to yet, as noted in [1].

But there's also an existing breakage in js/scalar and this fix-up,
which is that yes, CI passes with this change. But what are meant to be
compile-only CI targets which don't run "make test" are now running no
tests ... except for this one scalar test.

Fixing that issue both in js/scalar & in this fix-up would be rather
easy, but it's all just a work-arond for the discrepancy that "make
test" isn't running the scalar tests by default.

If we fixed that more general problem this fix-up wouldn't be needed.

But at this point I'm just starting to repeat points I've made in
patches[2] I've sent you on top of js/scalar, and which you seem to be
ignoring.

1. https://lore.kernel.org/git/211118.86zgq14jp1.gmgdl@evledraar.gmail.com/
2. https://lore.kernel.org/git/patch-1.1-86fb8d56307-20211028T185016Z-avarab@gmail.com/
