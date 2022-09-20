Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7F8C6FA82
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 00:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiITA5Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 20:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiITA5X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 20:57:23 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D9E4A11C
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 17:57:21 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id c7so951998pgt.11
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 17:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=ZwMu9BLtHqfs1W9ijQxE/1rjIyffGOkOteg67bJ/Jak=;
        b=dRiQL4s50o8LCuCTTRvlInCMTIDgOBfrIQ4/WPuhamAAYG3oM5HQ6Q9SH+exv3qEFi
         pxj9BnTke0fGU4Cd+C0rOA5rvSM+pmOY0Le26sMLaEylJLdvzfRm9c21CA7BBBUB+CfL
         EqS1HFQJ/8N++MNEvPETB955ATKH4/jV7xIFZ710vrMPVHBonViQLH43QV16GMFRyb90
         17w3NCoi+rn5ztOjcDrsBZu5Ufn/UELwPG1mjoJ7lMbwtNuV5Ao5DXhOuLiDMkrTtYK+
         sDA6ZCUySp57jm6vKKAnR/FpT446QO2T3dHPsgqbAA9nSMR7WyhtPnp4plzJwYsKZhQp
         gYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ZwMu9BLtHqfs1W9ijQxE/1rjIyffGOkOteg67bJ/Jak=;
        b=Yp44wSwZqvYQjdhOi5ZvRgq9arc0cEeCZPvy3dwTcS03jjwgg/kuHTyToLypr50e4/
         bXeTI1jkL15eZ3AT0jiqqaAxDCnCePVcVMX17Tm9765QJMWG0bGFxT7MXbJJowzevFb6
         7oqbguv/EGsPDzW47DnwrezmF9nO0Adqppazw9yDl1fpy4R/byZIh6FaBSpTkyXM0Trp
         uanalQq7Swi8zOyegT5a5xpFa9Tf3fb4PoBzAKQKRWMSwSxCbiWxOquJavO4EeEAOioH
         kEYgxd1hIKd61TRqiwBWZbnI6N4YX74IhpArQdc9gdh2qRStlk1uCWsiNVx4MVtvVfT4
         XAoA==
X-Gm-Message-State: ACrzQf1jQ+kbcr5tTsoSRpVWCiXuKRdttvSgR3m/pYutmoErxF04HeLD
        Ej7+794oz1Jftttb6Q9W2kKA
X-Google-Smtp-Source: AMsMyM7K2lSoQKTnBo9DELp7gg1V047n0VEZiTFSoQk059sCRh+B2mmB59di71+PHTgCPpDr3hqQfw==
X-Received: by 2002:a63:4f4f:0:b0:434:b9db:b9f with SMTP id p15-20020a634f4f000000b00434b9db0b9fmr18653940pgl.438.1663635440533;
        Mon, 19 Sep 2022 17:57:20 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id u82-20020a627955000000b00528bd940390sm3790pfc.153.2022.09.19.17.57.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 17:57:20 -0700 (PDT)
Message-ID: <07b35632-8e3c-fea1-0996-fb2e88ea6ba8@github.com>
Date:   Mon, 19 Sep 2022 17:57:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH 00/34] doc/UX: make txt & -h output more consistent
Content-Language: en-US
From:   Victoria Dye <vdye@github.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
 <af319ab4-2351-2d74-e0c7-6153f229d88c@github.com>
In-Reply-To: <af319ab4-2351-2d74-e0c7-6153f229d88c@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye wrote:
> If I could offer a suggestion, my preference would be that you split the
> series into three parts: one with the straightforward, easier-to-review
> changes, another with the more substantial updates to user-facing
> docs/information (which might warrant more discussion, i.e. which options we
> should be showing for a command in the SYNOPSIS/-h), and the last catching
> any new inconsistencies & adding the test. That way, more involved
> discussion on some patches doesn't prevent *all* of them from being merged.
> 
> I think the following patches would fit a "straightforward,
> easier-to-review" series:
> 
> * Patch 1 (CodingGuidelines: update and clarify command-line conventions)
> * Patch 2 (builtin/bundle.c: use \t, not fix indentation 2-SP indentation)
> * Patch 3 (bundle: define subcommand -h in terms of command -h)
> * Patch 5 (doc SYNOPSIS: don't use ' for subcommands)
> * Patch 6 (doc SYNOPSIS: consistently use ' for commands)
> * Patch 7 (doc SYNOPSIS & -h: fix incorrect alternates syntax)
> * Patch 8 (built-ins: consistently add "\n" between "usage" and options)
> * Patch 9 (doc txt & -h consistency: word-wrap)
> * Patch 10 (doc txt & -h consistency: fix incorrect alternates syntax)
> * Patch 12 (doc txt & -h consistency: add missing "]" to bugreport "-h")
> * Patch 13 (doc txt & -h consistency: correct padding around "[]()")
> * Patch 14 (stash doc SYNOPSIS & -h: correct padding around "[]()")
> * Patch 15 (doc txt & -h consistency: use "<options>", not "<options>...")
> * Patch 16 (t/helper/test-proc-receive.c: use "<options>", not
>   "<options>...")
> * Patch 17 (doc txt & -h consistency: fix mismatching labels)
> * Patch 18 (doc txt & -h consistency: add or fix optional "--" syntax)
> 
> (basically, 1-18, skipping patch 4 because it changes the content of an
> error message & patch 11 because it adds an option to the -h of 'cat-file')
> 
> In terms of review, my only comment on those patches is that 7 & 10 could
> probably benefit from being squashed together [1]. Otherwise, with the
> changes you mentioned in response to Junio's feedback [2], I think that
> subset of the series would be ready to merge.
> 

I forgot to mention this in the previous message, but it's probably worth
noting - regardless of whether or not you split the series, I am still
planning to review the remaining patches you've submitted here (that is,
everything *other than* what's in the list above, which I've already looked
over/commented on). I likely won't get the chance until later this week at
the earliest, though.

Thanks!
-Victoria
