Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 393BC20C11
	for <e@80x24.org>; Mon, 27 Nov 2017 20:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753148AbdK0Uti (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 15:49:38 -0500
Received: from mail-io0-f182.google.com ([209.85.223.182]:36188 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752945AbdK0Uth (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 15:49:37 -0500
Received: by mail-io0-f182.google.com with SMTP id 79so30267818ioi.3
        for <git@vger.kernel.org>; Mon, 27 Nov 2017 12:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M59sipfM0XPf5PjJiozrT8PK7R/ov426YJqrBZD0G+Y=;
        b=BqxiDyNq4913kNiMj8lSi1OJsbLe68QQboqmC2H4vMJ4m/ZtkqTFtd/mgnvvi1Z2ni
         Ymkfq/U9gD1y5D4vhk4K+3Ksuv7CGLM9Cnsq13rFJ8GNQ3F9pY1EjomW/Vz13qtOycXQ
         apwEPp+kW1ksVkrZFqgM0sY4qYY/p8c0feRi7un/huupLCAQUkmCgSM2XffABDEELM+q
         BZu6dkIXFRo1NAZE3ikhjMjPBEPqsF+8n1misoE7peRNBJRfHFBD2H7hcYqtX7cbt2n5
         EmMFYfO8rFm0D/d/5sDHbH0Oow+xF2k8HMqbFiJH5bC1N0NUanA9Hr8y6s4dLYeT3i1P
         jvtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M59sipfM0XPf5PjJiozrT8PK7R/ov426YJqrBZD0G+Y=;
        b=fl23FB4QPJu0DboHSHuwuJg3KjY5PV2zuqc7DccIyMaBl6mm9RLU8OVLvFUwILbutL
         vRuFueDsDy/OJMc329nQQkg7LMn6uRDiQbqs1wAomeXq0hLi8YyLTibfdAzkZyUI1kZq
         5ZPT4USKHgAVQn0M8Drmk9cwOlJC5eSVIsr2Oc1uF1UC5knbJET4yy25U5v+6FfJXrqv
         6vPULmkwPHEJUpWbPOxCE2HpihqEytusXxy9pPqN3qZturNJuzOW0uvoYxEwR1OyX+nm
         MRgYmu2RgNVCPJf2EVZAe38H1J58E5pka3dC58uYohNeTRQowjR6JqLk5BwMH2VijH5z
         9z1w==
X-Gm-Message-State: AJaThX5kN5PvDiZV9/+XUzaWU0/OWpmde7klDXvBnM3XFNJyDG9cqQQb
        nGldKiHmc2vMcj7Ipn5aVaA=
X-Google-Smtp-Source: AGs4zMaZT2HVE5pnzK1vb+RujeXMUEZRCxdS6ifmq3B7TYemeDeqPoqm6fcjRmOp9WYkkNmhNQ7efQ==
X-Received: by 10.107.70.15 with SMTP id t15mr2086572ioa.24.1511815776502;
        Mon, 27 Nov 2017 12:49:36 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id k9sm7833713ith.25.2017.11.27.12.49.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Nov 2017 12:49:35 -0800 (PST)
Date:   Mon, 27 Nov 2017 12:49:09 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, Nathan Neulinger <nneul@neulinger.org>,
        Santiago Torres <santiago@nyu.edu>, git@vger.kernel.org
Subject: Re: git status always modifies index?
Message-ID: <20171127204909.GA27469@aiede.mtv.corp.google.com>
References: <dfbf4af3-e87c-bdcb-7544-685572925a50@neulinger.org>
 <20171122202720.GD11671@aiede.mtv.corp.google.com>
 <20171122211729.GA2854@sigill>
 <20171122215635.GE11671@aiede.mtv.corp.google.com>
 <20171122220627.GE2854@sigill>
 <alpine.DEB.2.21.1.1711252240300.6482@virtualbox>
 <20171126192508.GB1501@sigill>
 <alpine.DEB.2.21.1.1711262231250.6482@virtualbox>
 <20171127052443.GB5946@sigill>
 <alpine.DEB.2.21.1.1711272142120.6482@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1711272142120.6482@virtualbox>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Johannes Schindelin wrote:
> On Mon, 27 Nov 2017, Jeff King wrote:

>> [...] IMHO it argues for GfW trying to land patches upstream first, and
>> then having them trickle in as you merge upstream releases.
>
> You know that I tried that, and you know why I do not do that anymore: it
> simply takes too long, and the review on the list focuses on things I
> cannot focus on as much, I need to make sure that the patches *work*
> first, whereas the patch review on the Git mailing list tends to ensure
> that they have the proper form first.
>
> I upstream patches when I have time.

You have been developing in the open, so no complaints from me, just a
second point of reference:

For Google's internal use we sometimes have needed a patch faster than
upstream can review it.  Our approach in those cases has been to send
a patch to the mailing list and then apply it internally immediately.
If upstream is stalled for months on review, so be it --- we already
have the patch.  But this tends to help ensure that we are moving in
the same direction.

That said, I don't think that was the main issue with
--no-optional-locks.  I'll comment more on that in another subthread.

Thanks,
Jonathan
