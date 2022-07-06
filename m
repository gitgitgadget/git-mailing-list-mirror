Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CD5C43334
	for <git@archiver.kernel.org>; Wed,  6 Jul 2022 13:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbiGFNXy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jul 2022 09:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbiGFNXx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jul 2022 09:23:53 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12602633F
        for <git@vger.kernel.org>; Wed,  6 Jul 2022 06:23:51 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id o4so22076009wrh.3
        for <git@vger.kernel.org>; Wed, 06 Jul 2022 06:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/T5XJHonOUd0x2S/X8qgbP2fTz7/qFx5vA3r6TNb3iI=;
        b=SEF2uK7ocYm2aBSQpmtFaPPbTPIVJ0IzG7e2axXAZEuTeT747+b9MYRlhGIZRP+K7y
         Lw8K/92yvyxuQwoPl1KUGlBn4D7mPXdpKRjq8zBlp6tWf9I6ddgdjCj6qBn7UNkj6xmw
         06rhlMy6340v+NQglbVLmADw9HdrHcaltIojTwjqfRZ7zfc7gctEtjlFSD1XtIKlOsgh
         hCrUWW2SErtO+i95Ltni2jAMO6c/Z3jSyxbK1yk1nL962JjTEm7cKKnn10Pes2IpSf5i
         oA6kuaPr+q9OSoHeCLUifm9BV0QuMU8twjwJW5C6TF02nMcPp8AQCQJ3QcRPQOuI0eAB
         uz0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/T5XJHonOUd0x2S/X8qgbP2fTz7/qFx5vA3r6TNb3iI=;
        b=LAIzZbv5PYFHpTYgBnKjMx2QvgVVcL7KBEn+MVRs8lG+dKJZoF9RCmzbaZyYBz+kTM
         HVv3hWB9wuGEmoJKCNba283nlh0GZopRsQk1lQiUT/7rXWsihwt0AiZnkfOvJSjR/cWd
         IqfdEZy7siL2FmZIPAE2LCg7jIX/3MGVdaYGiVfXQHpBPRxiz9e9Q4lpjIGROUWMso0i
         Y79KIhPRAMymYUcGhVvDpyXdR6VICFOoT/l5cpiRdBFjJJ8XAwqr8iJ9O0jq4HrpS/vJ
         yq8bv2+L9sH1qaBxfe8Z/O7l7UxDPyi4SjXIlUrleqJ1OKxNdS4SObaq27xP8MwBZCnl
         aCFQ==
X-Gm-Message-State: AJIora/tzUQyPMajrx8m7ueViA+SVlncd0DaUbhrjcKFEPaDt3RpN6h5
        /ri/JmnhmuGN3jA4Q9HOfdtVxMpRYMw=
X-Google-Smtp-Source: AGRyM1vr5k/wwJSJICQbJeJKZk+FzWQOckg6Di8UHFjSuGo+OVo7i7G5Q3/XG90GFZtKN/EJn1+a0w==
X-Received: by 2002:a5d:664d:0:b0:21a:3b82:6bb2 with SMTP id f13-20020a5d664d000000b0021a3b826bb2mr37627820wrw.534.1657113829639;
        Wed, 06 Jul 2022 06:23:49 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.gmail.com with ESMTPSA id g20-20020a7bc4d4000000b0039c798b2dc5sm21947435wmk.8.2022.07.06.06.23.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 06:23:49 -0700 (PDT)
Message-ID: <fa543f66-6e86-9f95-f164-20a68705cecd@gmail.com>
Date:   Wed, 6 Jul 2022 14:23:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/3] xdiff: introduce XDL_ALLOC_GROW()
Content-Language: en-GB-large
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     phillip.wood@dunelm.org.uk,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1272.git.1656516334.gitgitgadget@gmail.com>
 <da996677f0730ec7a50d399524fb58c44dad468a.1656516334.git.gitgitgadget@gmail.com>
 <220630.86czeqe74c.gmgdl@evledraar.gmail.com>
 <5734b393-57c8-dc63-282e-221ee1937351@gmail.com>
 <0a1650bf-a7f5-0cc5-e6c9-0e02d1f542bf@gmail.com>
 <220630.86zghuclzq.gmgdl@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <220630.86zghuclzq.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 30/06/2022 14:25, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Jun 30 2022, Phillip Wood wrote:
> 
>> On 30/06/2022 13:03, Phillip Wood wrote:
>>> On 30/06/2022 11:54, Ævar Arnfjörð Bjarmason wrote:
>>>>
>>>> On Wed, Jun 29 2022, Phillip Wood via GitGitGadget wrote:
>>>>
>>>>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>>>>
>>>>> Add a helper to grow an array. This is analogous to ALLOC_GROW() in
>>>>> the rest of the codebase but returns −1 on allocation failure to
>>>>> accommodate other users of libxdiff such as libgit2.
>>>>
>>>> Urm, does it? I just skimmed this, so maybe I missed something, but I
>>>> don't see where you changed the definition of xdl_malloc(),
>>>> xdl_realloc() etc.
>>
>> Oh I think I might have misunderstood your question. For git.git it
>> will still die() but for other users that arrange for xdl_realloc() to
>> return NULL on failure it will return -1. The same applies to the
>> comments in the previous two patches about XDL_[CM]ALLOC_ARRAY()
>> returning NULL on allocation failure.
> 
> Yes, I meant that the "but returns −1 on allocation failure to
> accommodate other users of libxdiff such as libgit2" is really more of
> a:
> 
> 	...but *allows for* dropping in another xmalloc(), xrealloc()
> 	etc. implementation that doesn't die on failure.
> 
> So I think the rest of my upthread question still stands, i.e.:
> 
> 	"So if that's the plan why would we need an XDL_ALLOC_ARRAY(),
> 	can't you just check that it [I mean ALLOC_ARRAY()] returns
> 	non-NULL?"
> 
> I.e. if the plan is to replace the underlying x*() functions with
> non-fatal variants can't you use ALLOC_ARRAY() instead? I haven't tried
> that, but I don't see a reason we couldn't do that in principle...

As the cover letter says, the aim of this series is not to replace 
xmalloc() etc with non-fatal variants, it is just to make the xdiff code 
more readable. (One can already use a non-fatal allocation function for 
xdl_malloc()) I don't think that using ALLOC_ARRAY() in xdiff is helpful 
for other users as they would have to define their own array allocation 
macros, rather than just providing their own allocation functions. I 
would like to reduce the friction others have upstreaming xdiff patches 
to us, not increase it.

Best Wishes

Phillip

> Anyway, I'm all for the end goal here, but the way to get there seems to
> be a bit of an exercise in running with scissors the more I think about
> it.
> 
> I.e. the reason we're using these x*alloc() wrappers at all is because
> we're lazy and want to write stuff like:
> 
> 	struct stuff *foo = xmalloc(...);
> 	foo->bar = "baz";
> 
> Which the compiler is helpfully not yelling at us about, as opposed to
> doing the same with "malloc()", where it would spot the potential null
> pointer dereference.
> 
> (I'm using "compiler" here to be inclusive of extended gcc/clang options
> to detect this sort of thing, & other similar analyzers).
> 
> But re "scissors": if we're doing to be maintaining the xdiff code
> in-tree to be defined as our usual x*alloc() functions we're going to be
> carrying code that can't have test or analysis coverage.
> 
> Which I think brings me back to my suggestion of whether we can't just
> have non-fatal versions of these helper macros, define our own currently
> fatal versions in terms of those, and use the non-fatal versions in the
> xdiff/ code.
> 
> 
