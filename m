Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC9CECAAD3
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 08:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbiHaILu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 04:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbiHaILt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 04:11:49 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF35B8F1D
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 01:11:47 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id u6so17278478eda.12
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 01:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=or3nBaHnFvhOMzFmDl2Dbfhtx/B3d2ZgdNIC9GKZnTk=;
        b=LIIl4iW8NimYyjEjrE3xYFpzPzO7fQddgg7n9mZt2GkQDqN1HGTwvxq22+BzRim1wz
         FNgPaUDQ16rKwic984ZtR91HJ6kaRnAwPxJayrvSdkEXt1X0yYoz2kWZY8PqglakVyf2
         yaLJDpfL9DxPS7d+jlK1pa95ql5cy4LCqlqFEkN+dpoO3/O12C+n2MM/p1cnIOB++127
         0ks9bAutlVezXfc7+iJ3juc7cmC5n2pYUdkNemYHKC8mYo1ehqOW5umDyp2vWwW0iNB6
         rjk/tE3+f8NLnAfRS2edcO4H+NvCQ34/zomwhVhzeSsRVielB61dD4bEfgy2xzRWOVnA
         d5Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=or3nBaHnFvhOMzFmDl2Dbfhtx/B3d2ZgdNIC9GKZnTk=;
        b=F2sufCI5HHghx4FalJ9ZUbOu0fnlObpLdl6aaRJ7hmDMTfmrooly2RshTGPQR3cUYb
         /F/6d/u3oCqVap74sPfy8wuS0VLbUSN+ZFX05kMl2S1Oiykwl2CLtMl/JZInNne03t7p
         cIWPB0oKN7b3zCXbussu6CABKvjNfisznMSGiSHw6wnWDv0f3dU6CullphnqwnN7huPb
         2F00uTelK/Ct6lQ2YDYb53zF5Hb96kbrDFxeyFwnSepRY0lufsc9omgo/4ShoEnPJbR9
         ltEqpifMxlJsvTk2ErPy0C1fpiQqUZp9UzD1fMF3tbqbfJagd2HkUXiRRfe7a2DDdSNt
         eHAA==
X-Gm-Message-State: ACgBeo2kc2WsmhQKCHBsmrZfu4cnt67f92XfGK5fSVfdjYLzFXplbHVA
        oQA9gOQo863C96wQH8X9Gm8=
X-Google-Smtp-Source: AA6agR6OB0I7nvqvLqyShEPlhgTqpOUWLRbUjU9wXj5ysWxku3yxninCujIEzlDj2ncWRd6tEfiPag==
X-Received: by 2002:a05:6402:156:b0:440:b458:93df with SMTP id s22-20020a056402015600b00440b45893dfmr24565371edu.337.1661933506432;
        Wed, 31 Aug 2022 01:11:46 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id 3-20020a170906300300b0073100dfa7b0sm6823014ejz.8.2022.08.31.01.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 01:11:45 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oTIp7-0005Tl-0Y;
        Wed, 31 Aug 2022 10:11:45 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: jk/unused-annotation + ab/unused-annotation (was: What's cooking in
 git.git (Aug 2022, #10; Tue, 30))
Date:   Wed, 31 Aug 2022 10:00:50 +0200
References: <xmqqilm9k0bc.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqilm9k0bc.fsf@gitster.g>
Message-ID: <220831.86fshcal32.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Aug 30 2022, Junio C Hamano wrote:

> * jk/unused-annotation (2022-08-19) 11 commits
>   (merged to 'next' on 2022-08-24 at 2174b8c75d)
>  + is_path_owned_by_current_uid(): mark "report" parameter as unused
>  + run-command: mark unused async callback parameters
>  + mark unused read_tree_recursive() callback parameters
>  + hashmap: mark unused callback parameters
>  + config: mark unused callback parameters
>  + streaming: mark unused virtual method parameters
>  + transport: mark bundle transport_options as unused
>  + refs: mark unused virtual method parameters
>  + refs: mark unused reflog callback parameters
>  + refs: mark unused each_ref_fn parameters
>  + git-compat-util: add UNUSED macro
>
>  Annotate function parameters that are not used (but cannot be
>  removed for structural reasons), to prepare us to later compile
>  with -Wunused warning turned on.
>
>  Will revert; coccinelle cannot even parse the annotation correctly.
>  cf. <Ywh7ppVFk6VK1Ybs@coredump.intra.peff.net>
>  cf. <xmqqy1v7r3so.fsf@gitster.g>
>  source: <Yv9gxqH6nK2KYnNj@coredump.intra.peff.net>

I see you did this already in 4f464a7b54a (Revert "Merge branch
'jk/unused-annotation' into next", 2022-08-30), per [1] and [2] you &
Jeff seemed to agree on my approach in [3] as a way forward.

The ab/unused-annotation in "seen" (not in this WC E-Mail) is a rebased
version of 1/2 of that series. Without the 2/2 [4] it won't catch the
accidental use of parameters.

Were you planning on picking that up, or would you like it submitted
separately? I know there were reservations about (ab)using "deprecated"
for this, but per the rationale in [4] and Jeff's [2] it seemed like
there was consensus to go that route.

1. https://lore.kernel.org/git/xmqqy1v7r3so.fsf@gitster.g/
2. https://lore.kernel.org/git/Ywh7ppVFk6VK1Ybs@coredump.intra.peff.net/
3. https://lore.kernel.org/git/cover-0.2-00000000000-20220825T170709Z-avarab@gmail.com/
4. https://lore.kernel.org/git/patch-2.2-0f603594e5e-20220825T170709Z-avarab@gmail.com/
