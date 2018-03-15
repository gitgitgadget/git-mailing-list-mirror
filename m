Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86FF71F404
	for <e@80x24.org>; Thu, 15 Mar 2018 17:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752158AbeCOR1r (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 13:27:47 -0400
Received: from mail-pl0-f53.google.com ([209.85.160.53]:46468 "EHLO
        mail-pl0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752164AbeCOR1q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 13:27:46 -0400
Received: by mail-pl0-f53.google.com with SMTP id f5-v6so4160902plj.13
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 10:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3ahZ/VcNEYtRdovcXTbDLMvPYP5fAi+nEXkOluTXf8k=;
        b=cLOiE55j03jUk58Ie7668RRmGa3Y7PjDrNVMk7r5IEjiZ2RS2CdY4LQnoZsWnCRb3R
         8Br9ZpNznR6HD20BVmBPbMvMyaqpFdJ1Twv6DRqkBva5qhxXAEI8EUBLMwtTUsF0tehH
         2R2P6WUXtYBR0RDYJyHM5OLQI2988ZLHZ6BoBHiLICdy+/AJfFPkq4O2eRwE1lyGEc/N
         QxJX1PL2hRQvumfrChbEweoLgVa7IyVY0BIymXkUguYTZyeE0TYTQ3Ok8ghh6RQzW2Tu
         07Sn81Kk9mfotk7K55efN6n3E+RVNjd11e32Laxwl0dqwVZeBf/kPJIkKt6lHy4sWtch
         ZKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3ahZ/VcNEYtRdovcXTbDLMvPYP5fAi+nEXkOluTXf8k=;
        b=mG3O0SzOqepduWmbhGqHZ7TsKpVK3F8nel1PsRAPt5D3iQKGLlOUlAne48EqaxckGi
         V9MV5wBwwXw/R+czEuPjT1YQ82LscFkfKsJxWKJo+W5LRkFDIUNTU2D2F8fSNVP5w1IP
         fihZ+I7zicehdubQBszyrfm90lV8AcJq9bU7woAHAsyS6/TGj3ZpWLNYa3TERw8pb4yS
         MSCvioT+kVyKG0cBIObHpFrAte49ikgeuyug3EHHatfINtA2uN7/Z82vJBNao/efu2U1
         Q5u7TvZYs8E46xG365UouPAVPZLPwrR6Hnps1QfGCbr+/uiUC4k//kOoU2RSWQNo1b7o
         C8uw==
X-Gm-Message-State: AElRT7GenggvRQxRh0Xd+aHpvxA71roUlPD8iZnsh1UOlukuxh34qkH/
        VuvM8ow9vNF2V2uvjeMpoRaUYH8dak0=
X-Google-Smtp-Source: AG47ELuR6At8KXoSN61WgHO4atb10J8A5boBO5HGqCShdEGWaJLJq43TZ9zVWoVog9d04I/T5n4UQQ==
X-Received: by 2002:a17:902:788e:: with SMTP id q14-v6mr9211014pll.396.1521134865774;
        Thu, 15 Mar 2018 10:27:45 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id h67sm11570551pfk.184.2018.03.15.10.27.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Mar 2018 10:27:44 -0700 (PDT)
Date:   Thu, 15 Mar 2018 10:27:43 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com, jonathantanmy@google.com
Subject: Re: [PATCH v5 12/35] serve: introduce git-serve
Message-ID: <20180315172743.GA174336@google.com>
References: <20180314183213.223440-1-bmwill@google.com>
 <20180314183213.223440-13-bmwill@google.com>
 <xmqqsh92xqnz.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqsh92xqnz.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/14, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > Introduce git-serve, the base server for protocol version 2.
> > ...
> >  Documentation/Makefile                  |   1 +
> >  Documentation/technical/protocol-v2.txt | 174 +++++++++++++++++
> 
> asciidoc: ERROR: protocol-v2.txt: line 20: only book doctypes can contain level 0 sections
> asciidoc: ERROR: protocol-v2.txt: line 374: [blockdef-listing] missing closing delimiter
> Makefile:368: recipe for target 'technical/protocol-v2.html' failed
> 
> I'll redo today's integration cycle to see if I can move this topic
> to a late part of 'pu', so that I can at least keep the part of 'pu'
> that is beyond what is in 'next' and still usable a bit larger.  The
> bw/protocol-v2 topic has been merged immediately above the topics
> that are already in 'next' for the past week or so, but I cannot
> afford to leave the build broken for majority of merges of 'pu'.
> 

Turns out I don't know how to write properly formed asciidocs, sorry
about that.  I fixed up the docs in my series locally and I'll send out
a v5 in just a bit.

-- 
Brandon Williams
