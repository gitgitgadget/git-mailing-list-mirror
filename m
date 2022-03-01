Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82E6C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 17:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236695AbiCARyT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 12:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233793AbiCARyS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 12:54:18 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89ED3121B
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 09:53:36 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id q4so13504731qki.11
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 09:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SpFPMEOEfOqLd/d3YIr0VPfG41OKr5F7KadesMlBWuI=;
        b=ayP1BHdYq0I2wu6fHjxaABznN+FTiyvNaLLxd37OD9FqSu7Bia6+18hIhfqwS2ZvaU
         nEq0AS+z9hFY14bC7R7ijKJE3ZtOidt89s2rGETk/6GVexgX8LuX0auPjDd0fozOi/Hl
         bLxiSlZM/9M1YjVZAFXf+w5jaNBmNkIzQmljU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SpFPMEOEfOqLd/d3YIr0VPfG41OKr5F7KadesMlBWuI=;
        b=fGwq6XupixhbIdINm2xXSsdBs54ndsg21Ye0CnHNB4TBYI+vSAK/JuaxL+cpVmEetm
         CBwAgizBO4KIDMy6v90Io5ck6ChVJQrFPd9pbxW4QBCUpOKWVMmgf2gA/CiQMRAZM9EO
         ZlhqTcHJ2040Kl3jOjKMLko19mv9zkPbuFMilwm3/nSv7X/ykvtwciiDjzSQUZfA6UfB
         Rl7RhUNN6j3/Iy4jNoDpifcg6DhMthTUpZ7ptgf8USU0l7u7/BA4Y7Y3jVCvfafum7x2
         NBeQMI97HBssae/DqCGeFMhyNwKQkPS/GcdTGLeYwkF1ZjlVncr4ajj3cs/Qd3HNRt45
         uNnQ==
X-Gm-Message-State: AOAM533c1t7qegipO+OE264Ve0XaqUop80kSrrStbBfwQi2LKVXDwTJ4
        Sd4K/9u26d/GTBfaq5+7tDen/z3soqBHRg==
X-Google-Smtp-Source: ABdhPJwraIaLcmPtJsbktg0wWjtuWgpNMyL5ieDTQXfDI0H9xKLOF1vcNo+rjjU/r2I5Gqdcz0wssg==
X-Received: by 2002:a37:c0c:0:b0:5f1:7969:f152 with SMTP id 12-20020a370c0c000000b005f17969f152mr14457322qkm.97.1646157216007;
        Tue, 01 Mar 2022 09:53:36 -0800 (PST)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-32-216-209-220-127.dsl.bell.ca. [216.209.220.127])
        by smtp.gmail.com with ESMTPSA id f14-20020ac8068e000000b002dd1bc00eadsm8636348qth.93.2022.03.01.09.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 09:53:35 -0800 (PST)
Date:   Tue, 1 Mar 2022 12:53:34 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Ed Warnicke <hagbard@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: URI Scheme for git object ids?
Message-ID: <20220301175334.ctem25nxckynnvco@meerkat.local>
References: <CAFVSqg1arVNwWMANwR6CDP++5hXAEW1a_ajekNe+TXNpSSZFPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFVSqg1arVNwWMANwR6CDP++5hXAEW1a_ajekNe+TXNpSSZFPA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 01, 2022 at 11:35:52AM -0600, Ed Warnicke wrote:
> Has there been any discussion of how one might represent a git object
> id as a urn or uri?

This sounds similar to what git over ipfs folks wanted to do, but they ran
into obvious scaling problems. It works fine for small repositories with a few
dozen commits, but once we're talking millions, the process of doing anything
with such remote starts taking hours and days.

If you're interested in a decentralized forge solution, then Radicle has the
closest to something that is working. You just have to ignore all the crazy
cryptoblarf web3 stuff.

-K
