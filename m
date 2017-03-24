Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 989851FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 18:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966142AbdCXSyE (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 14:54:04 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34500 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965791AbdCXSyD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 14:54:03 -0400
Received: by mail-pg0-f67.google.com with SMTP id w20so1984135pgc.1
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 11:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=40GH2cfo+AD5bMhI0gge7Iwp0BxgfZuRvDmA0DTOMQE=;
        b=D4PY8+tPNntl4FaDKP/DyGFpTnLINsst1R9Ohc2RdGY1WzoZC/M51ztLAU9//1JMCN
         MTD743+J2j/Kp9QBQAEOmybjpwnThdCt3PUG6dqrA1G1SLZupKXdQ1a88+ffENo8yukw
         lUwL85yNqeYp6MshxVMtk1Sj/Ve6EOBAjIMAUE/7YV2Ggw159U0SV5uv/jW5qJZCYNkT
         h6V7U7Z8PISNqoRkEqYJ5r0yZNpWQDj3xj/3m9zr1xMhb+Hcp3hOtPnMMPXdYp2Cqyv9
         yVnj217fEA1vbHzMrjTJZ8vKDSIpSRQroDTVwmVz0Y+RX2oQYnlJ524/c8bMZHohpz6+
         iHTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=40GH2cfo+AD5bMhI0gge7Iwp0BxgfZuRvDmA0DTOMQE=;
        b=pTQt3Gw5Wunsk/Hk+eHn5jGryg+7Ra3cMch7cq67gH0WCQgCKxfEtdLrdn4EsJ+NBe
         gRNJHJ0Hbi8LqbJr04z8nNsqhI4XS8BFcwPphm088Cl2eqgdsu+oCz6EngMS681Duakc
         bliz2TWq6xep/zUdDOENIQ+3eGIrIDUna76d7Ixmkd7kUv0WZ7Z5hYdm0RQuRbFiiIMv
         pLPr11OtAeebhxSWTEcssFB/SbspNa9mLeVkSfbxqI0FDLHTcm4nSprJOMuXFSEo2Tt7
         QbkG3lHkmIDpwfMqCXFPHS7dHh7QHh/d1vKQ9Jb9wscRIPjuH7v0WYZdLO1jc4vYzhf2
         hW6w==
X-Gm-Message-State: AFeK/H2E3HWQX9EwvReag37aeoOVTppyx2/iCEePzHq+QOJW3qklkXK9VV1etljchd6T8w==
X-Received: by 10.99.56.17 with SMTP id f17mr7549344pga.228.1490381636701;
        Fri, 24 Mar 2017 11:53:56 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:8597:ae41:db75:6a97])
        by smtp.gmail.com with ESMTPSA id 79sm6110521pge.14.2017.03.24.11.53.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 24 Mar 2017 11:53:55 -0700 (PDT)
Date:   Fri, 24 Mar 2017 11:53:54 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Romuald Brunet <romuald@chivil.com>, git@vger.kernel.org,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: allow atomic flag via configuration
Message-ID: <20170324185354.GE31294@aiede.mtv.corp.google.com>
References: <1490375874.745.227.camel@locke.gandi.net>
 <20170324184550.3l6mw4ybynizblsm@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170324184550.3l6mw4ybynizblsm@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:
> On Fri, Mar 24, 2017 at 06:17:54PM +0100, Romuald Brunet wrote:

>> Added a "push.atomic" option to git-config to allow site-specific
>> configuration of the atomic flag of git push
>
> I don't really use --atomic myself, but this seems like a reasonable
> thing to want, and the implementation looks cleanly done.
>
> My one question would be whether people would want this to actually be
> specific to a particular remote, and not just on for a given repository
> (your "site-specific" in the description made me think of that). In that
> case it would be better as part of the remote.* config.

I didn't receive the original patch (maybe mailing delay?) so
commenting here.

I use --atomic sometimes, but it's tied to the specific context of
what I'm trying to push.

I'd be interested to hear more about the use case.  Do you want pushes
to be atomic opportunistically when the server supports that
(analogous to push.gpgSign=if-asked)?

This also seems likely to break scripts that rely on the current
non-atomic behavior, so without knowing more about the use case it's
hard to see how to proceed.

Thanks and hope that helps,
Jonathan
