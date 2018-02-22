Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11B0E1F404
	for <e@80x24.org>; Thu, 22 Feb 2018 05:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752042AbeBVFh1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 00:37:27 -0500
Received: from mail-it0-f49.google.com ([209.85.214.49]:39758 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751444AbeBVFh0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 00:37:26 -0500
Received: by mail-it0-f49.google.com with SMTP id l187so5071411ith.4
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 21:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r0etWIm/y7YaQao5y3PPnt/GnrsWDWJ+nJPR57zXFKs=;
        b=K5u91+OHqHQSyYeeXcc5Z0zgmBsA9PDxpNIAq4wdgaR0uUPW7Js6fwQROk9uJ8i21u
         h+VFX9PRv5H3LYUqVwqN7Ka2rpfC/OjVllabEzbrpm/LxNPjqOsrmgCWCLpvv7txwfxg
         XMxAMgfD0pTezwg2Cob8hCzPp3IvyoI6/yxzbpWI3sySJMGIjBHkm1sjAFrELrZwTby0
         PkKy7hEqM8d9jVYu/4984I5IU/fV2gP0657lTWKV3EP3qwisZtEdbnhIiu25wEFQEs8c
         0lVUHCzSVnkeRjfyJMHya6Z5DTKApvBneFdN7q+to/CIcrXP4aiz3wx9rZz1gKcZQy9O
         17YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r0etWIm/y7YaQao5y3PPnt/GnrsWDWJ+nJPR57zXFKs=;
        b=UgiNz5OJvx+Ya4nFzvQV0obETaBFPOWGKavAv9HMQ9SskDrRLTyVpN1/HASd35S2Uu
         hJNNPTObS6YOtP6raTXc6k4ZTYauqdBhOlbKPPfiX2VZgC/1lJMrjckkyI+tJL9HWaZo
         C44B4H2j5yeK9gN+INSp+v27zRj1Ub50ug4kc0P/5t2/We5D6pdCmF7mgi5OTX1nArNk
         ZwnBtt9ptkFKuhdAzcHVu/7ydeLKTpunQrFV9MSfbirgADG/OhNGfLi1os7ytle4bjk3
         58KdSUwR7DzA+QOAq0eFepjhHTcrh6ljuBgk2usH8ufBZkT4koMZ45TYG1nrtqN0WauJ
         qHbg==
X-Gm-Message-State: APf1xPAy5pytg96CH+VDW+AftshXvek6R2Mr3y4GtqA27dnyZPeSBBMj
        1aptrA7EqyrCUw+30Iuo03U=
X-Google-Smtp-Source: AH8x224eNvfeAJbpqF5Jpp1Cc26F40gdsQBAQQcvUikRcuNcOu+5KYrrhvaGx/LECu8Xi51oe2EbpA==
X-Received: by 10.36.142.2 with SMTP id h2mr468231ite.5.1519277845610;
        Wed, 21 Feb 2018 21:37:25 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id o124sm1210944ith.12.2018.02.21.21.37.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Feb 2018 21:37:25 -0800 (PST)
Date:   Wed, 21 Feb 2018 21:37:22 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Dorian Taylor <dorian.taylor.lists@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Brandon Williams <bmwill@google.com>
Subject: Re: bug in HTTP protocol spec
Message-ID: <20180222053722.GB133592@aiede.svl.corp.google.com>
References: <4F85B1C3-9B5B-4D7C-8907-B728C18A70CD@gmail.com>
 <20180221221516.GA7944@sigill.intra.peff.net>
 <89E9DF80-F811-4F7A-AA35-0F52F1180BAF@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89E9DF80-F811-4F7A-AA35-0F52F1180BAF@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(+cc: bmwill@, who is working on protocol v2)
Hi,

Dorian Taylor wrote:
> On Feb 21, 2018, at 2:15 PM, Jeff King <peff@peff.net> wrote:

>> Thanks, I agree the document is buggy. Do you want to submit a patch?
>
> Will this do?

Thanks for writing it.

Do you mind if we forge your sign-off?  (See Documentation/SubmittingPatches
item '(5) Certify your work' for details about what this means.)

> Note I am not sure what the story is behind that `version 1`
> element, whether it's supposed to go before or after the null packet
> or if there should be another null packet or what. Perhaps somebody
> more fluent with the smart protocol can advise.

I believe the 'version 1' goes after the flush-packet.

Thanks,
Jonathan
