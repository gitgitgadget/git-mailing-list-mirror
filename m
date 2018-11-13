Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7576B1F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 01:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbeKMLHv (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 06:07:51 -0500
Received: from mail-pg1-f175.google.com ([209.85.215.175]:42675 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbeKMLHv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 06:07:51 -0500
Received: by mail-pg1-f175.google.com with SMTP id d72so1410185pga.9
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 17:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AptoZlOWhed9SLv7Q3c/r/p3JSS6KElgh6AdI98ypnE=;
        b=sDgPjs/3kqbirjztBndqpjhgzNdjsOnDjbeKNDgIvfYQFPReibQlJS+WCbexG9ie3o
         gP3d04S+wXyLidq+P3TrYpIVRMGz9o4Xf27x3dnguIIy9PwdTvMqZzwX/QcNV/E3HPQ/
         rd65aqGN1Z+85R+6hNCZ2koVCvN0oimD47iTaCSAzlc8UKBaiuwL79CKauC6kLwbf3mO
         aQ0jyAu2mf5yCQLhWA9cnGdnbAx06twNcOix+TSlIP4SLjzA2GzNyEJvHAJCJ+hKjCtX
         0OBO2wzyrw+e1vPw184bzxTYXhiEy/3shVZpN2QCXVBSoBno/5TqqFiCr+fYWvPlrT6I
         Olbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AptoZlOWhed9SLv7Q3c/r/p3JSS6KElgh6AdI98ypnE=;
        b=ifblruIAf3iBu0yO5CTdGBHZQXAjUHRbk9jvK6jmPqPqSihNh2q18WibLuiZiYuWdV
         1csOnAS0NX2XVcmk+DwOkCGKFF+ght7j5xotYeNtvEvhCGOC9sSZR4Ln8mJpmNr5BaHO
         PCV4tkrAgWgHHv1aKzvmCOnVafob0g9/+zH+nldvMp20UobU1b9tileNPHPEPG+0dhX7
         GKe8bpiZLBB6141u2gb4/0xmFSkumLy/UnGfDz3yezLB/0hcABxAAwOVkL1llqDkreZ+
         fZhNYMp03lKpBrQSI9DzFR0TcnVEFkyIyVfzezFtY3vpzL87iGnPq8lXPocx7fuoZZ9S
         HABQ==
X-Gm-Message-State: AGRZ1gJ0uxrZNK9XxsSl9uHgpZnaCySyqlvyUjc+eQViXtSOP+uQ3cHR
        f0lFjhPBNsfUMQ0PV8wDMO/JCzhQ
X-Google-Smtp-Source: AJdET5eL4x/ee83gH1JcPhR1vV2uYA9MRVIMfOGzLv8BAdYA0RAdKgF4u5j4Q6w9U2pKUeJisHteug==
X-Received: by 2002:a63:594d:: with SMTP id j13mr2868207pgm.210.1542071529580;
        Mon, 12 Nov 2018 17:12:09 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id p15-v6sm35152066pfj.72.2018.11.12.17.12.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 17:12:09 -0800 (PST)
Date:   Mon, 12 Nov 2018 17:12:07 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ben Peart <peartben@gmail.com>, git@vger.kernel.org,
        pclouds@gmail.com, Ben Peart <benpeart@microsoft.com>
Subject: Re: [PATCH 2/3] ieot: default to not writing IEOT section
Message-ID: <20181113011207.GE170017@google.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20181010155938.20996-1-peartben@gmail.com>
 <20181113003817.GA170017@google.com>
 <20181113003938.GC170017@google.com>
 <xmqqpnv9zsu6.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpnv9zsu6.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

> How about
>
> 	hint: ignoring an optional IEOT extension
>
> to make it clear that it is totally harmless?
>
> With that, we can add advise.unknownIndexExtension=false to turn all
> of them off with a single switch.

I like it.  Expect a patch soon (tonight or tomorrow) that does that.

We'll have to find some appropriate place in the documentation to
explain what the message is about, still.

Thanks,
Jonathan
