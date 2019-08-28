Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F35F41F461
	for <e@80x24.org>; Wed, 28 Aug 2019 16:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfH1QP6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 12:15:58 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40239 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbfH1QP5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 12:15:57 -0400
Received: by mail-wm1-f65.google.com with SMTP id t9so660650wmi.5
        for <git@vger.kernel.org>; Wed, 28 Aug 2019 09:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+HYuO+R7Hb7cKTCmj1oZuAmeO2zIbTfnHq3x88VBc5k=;
        b=GEEEcqHIQjVRdiBAb1/06ZjZVYOOuqY6syqoI6KF2DEp9HMhaR0G7S9fTE1vDL3K+j
         DQcEsfyFYNkYS7vMfjmoK0M5Fm5kcqAJxNjm0Hzg9rV0qgRbSQKYwwjjwa5MxLkVkDVR
         6xglVQ6zHNryovRb1gmJPwkXj+WJbQACO5cS5Rr+xWCwD0eH/ucQ1UHnbEgfSxBLHKjF
         mnbX/LJP3EbUZ/j4Y/mxywNNjGgQLtHRBxXLx9KnSMmfwB45kg6v/3K4GDOJW5p62paH
         FseuQe2fLeNJHUQgbuvPDhPfoy6lBKw5u9hFikHXEJL7KUNr57lZeTryRRDvZGKrxjqU
         w57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+HYuO+R7Hb7cKTCmj1oZuAmeO2zIbTfnHq3x88VBc5k=;
        b=BZwQWCp5ODISmMSSiW/ee+sRLy69mZWGMdh2X2k5RVEuKWp1/Fwj2lSoV8/kdWbV32
         +MO+b6YYHTfyBkxec477Z4/DONYuvVJ6onOXtHt0RWVCDmAKln2r28AHx5Nre8/SxrP+
         Bqg8lH0PzU3BtCmySxppibBeXnZU59okvPBp5Qk8WcLavCo26bCczirgpQYEIP36/Pqi
         muE7cuUKiLkvi62B6dV6UgBp/bJwAxcXTZT/dIODGKc33kjSmI4s6nSz6Si321seCV4+
         7dHrkkM21FP3WXhg8xCFpIo7da6fthFdzV3d+Da4SLGYxlgjkXKxPVL67R84lSYTaDO1
         noSA==
X-Gm-Message-State: APjAAAWnIT9fasFiM2g1tMbQr4DyOtcofM0uImmEq/ipoZYB/0fokuFS
        YZKfkIkfB7THi1rVMF4plgM=
X-Google-Smtp-Source: APXvYqwjElqPMoUJa2JjfMgJjpeCeNCGGI3r471q8YiLCPDLvVpF7hRlIhSYUeE29NThXOFOPnSNrg==
X-Received: by 2002:a7b:cbd3:: with SMTP id n19mr6143128wmi.112.1567008955881;
        Wed, 28 Aug 2019 09:15:55 -0700 (PDT)
Received: from szeder.dev (x4db66bea.dyn.telefonica.de. [77.182.107.234])
        by smtp.gmail.com with ESMTPSA id k6sm8048544wrg.0.2019.08.28.09.15.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2019 09:15:55 -0700 (PDT)
Date:   Wed, 28 Aug 2019 18:15:52 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] upload-pack: fix race condition in error messages
Message-ID: <20190828161552.GE8571@szeder.dev>
References: <pull.324.git.gitgitgadget@gmail.com>
 <5c313aba7e97cb93e7d07f6d5dfaf0febe8a2f8b.1566956608.git.gitgitgadget@gmail.com>
 <20190828093408.GD8571@szeder.dev>
 <20190828145412.GB14432@sigill.intra.peff.net>
 <20190828153944.GA29715@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190828153944.GA29715@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 28, 2019 at 11:39:44AM -0400, Jeff King wrote:
> On Wed, Aug 28, 2019 at 10:54:12AM -0400, Jeff King wrote:
> 
> > > Unfortunately, however, while running './t5516-fetch-push.sh -r 1,79
> > > --stress' to try to reproduce a failure caused by those mingled
> > > messages, the same check only failed for a different reason so far
> > > (both on Linux and macOS (on Travis CI)):
> > 
> > There's some hand-waving argument that this should be race-free in
> > 014ade7484 (upload-pack: send ERR packet for non-tip objects,
> > 2019-04-13), but I am not too surprised if there is a flaw in that
> > logic.
> 
> By the way, I've not been able to reproduce this locally after ~10
> minutes of running "./t5516-fetch-push.sh -r 1,79 --stress" on my Linux
> box. I wonder what's different.
> 
> Are you running the tip of master?

Yeah, but this seems to be one of those "you have to be really lucky,
even with --stress" cases.

So...  I was away for keyboard for over an hour and let it run on
'master', but it didn't fail.  Then I figured that I give it a try
with Derrick's patch, because, well, why not, and then I got this
broken pipe error in ~150 repetitions.  Run it again, same error after
~200 reps.  However, I didn't understand how that patch could lead to
broken pipe, so went back to stressing master...  nothing.  So I
started writing the reply to that patch saying that it seems to cause
some racy failures on Linux, and was already proofreading before
sending when the damn thing finally did fail.  Oh, well.

Then tried it on macOS, and it failed fairly quickly.  For lack of
better options I used Travis CI's debug shell to access a mac VM, and
could reproduce the failure both with and without the patch before it
timeouted.

