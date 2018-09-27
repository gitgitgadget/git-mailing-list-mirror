Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6C6D1F453
	for <e@80x24.org>; Thu, 27 Sep 2018 21:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbeI1Dze (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 23:55:34 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54606 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbeI1Dze (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 23:55:34 -0400
Received: by mail-wm1-f67.google.com with SMTP id c14-v6so259209wmb.4
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 14:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=m3/6emYKWRknLiK3IAHwl29z4mblk4/jxf1Jtrj6bVo=;
        b=oWUvuCww3Exk7Q7pxpRqjvAxuh2hMTznNjdb74xlKydSSricCPlIuIUiElCfLERp/j
         iN90l6dL1VqQrXvDgvp8sPk99rHXTt5tUacpEs6wywvON4Y3MGTyTkDD3oR1LhS16qy7
         AyNNbwghB6W4yeYDeMElV7P1unSpvq3lChT7fkPTMnp0Jc7uK7ptmyx3oxsk3rkLZ8c5
         JdFxgaxr7nX2SuZp3kcFTF3l87LFzmaKdx4pH3nsnC07SfsdkgvnhbH33oMm336hUDPI
         WU59bkMCM8G4bxEw9KAK9BMctA0UDFYoVLuwJvV6rTsxltTUnJUCp3nlID4JCBbBuSa2
         58og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=m3/6emYKWRknLiK3IAHwl29z4mblk4/jxf1Jtrj6bVo=;
        b=shg7vJfPUy9wbKRs/IHWFALL7F6x7KEr6YtA58WUdJYEuQelrr2Z2NBv14Z3+6SRE1
         fOPGmK4Wm6/jOPT7rIA/Q/lu/+MlGhqc5+Rh3pEjMCDM3ETj8JblEXoF1zY+whM4UqIS
         w6fol4icn0Smntt/WpS6eESiUWS3ZzUjfqQ9CL3EuO/UnfIPTmhFOnKKdUYGesi+5XSz
         1slqo41GZGqHOo3Wz8rDSmUoAzrmPjpOY0vY/AxsUJinaGmLsOPHsZ+CNPMvfHYdSy0B
         siIDdUWOTMTXgMPF061loONwyf1x3ieBdCRrZ82rhoxBIzqBQhab84JuVswHuVQNLSh3
         N5Og==
X-Gm-Message-State: ABuFfogX69fiUaa/Y6h0VulnKG5hTzeKbZMaZUIMYrTyVv44Ma6RBXCb
        UE1Gh2U4g7aSzUNC7TR8NkE=
X-Google-Smtp-Source: ACcGV61izGndV9Ihv5Ijg6ygseGuLMSBYRMgZbjwPsUisZux+ICBNBjcHU82pEUYZ79Ni+/w/r3GrQ==
X-Received: by 2002:a1c:2dc5:: with SMTP id t188-v6mr270629wmt.94.1538084115296;
        Thu, 27 Sep 2018 14:35:15 -0700 (PDT)
Received: from rigel (236.209.54.77.rev.vodafone.pt. [77.54.209.236])
        by smtp.gmail.com with ESMTPSA id g8-v6sm150173wmf.10.2018.09.27.14.35.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 14:35:14 -0700 (PDT)
Date:   Thu, 27 Sep 2018 22:35:11 +0100
From:   Rafael =?iso-8859-1?Q?Ascens=E3o?= <rafa.almas@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Nickolai Belakovski <nbelakovski@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] branch: colorize branches checked out in a linked
 working tree the same way as the current branch is colorized
Message-ID: <20180927213511.GB2628@rigel>
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
 <20180927181708.GA2468@sigill.intra.peff.net>
 <20180927192804.GA27163@rigel>
 <20180927193559.GB6950@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180927193559.GB6950@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 27, 2018 at 03:35:59PM -0400, Jeff King wrote:
> On Thu, Sep 27, 2018 at 08:28:04PM +0100, Rafael Ascensão wrote:
> > But if we're open to change how branches are displayed maybe a config
> > option like branch.format (probably not the best name choice) that can
> > be set to the 'for-each-ref --format' syntax would be way more flexible.
> 
> We have that already, don't we?
>

git branch has --format, but there's no way (at least to my knowledge)
to define a value in gitconfig to be used by $git branch.

Having branch --format available, making an alias is a possible route.
(Either by wrapping branch --format or for-each-ref itself). But I was
referring to changing the output of the default $git branch;

