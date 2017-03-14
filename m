Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F05A20951
	for <e@80x24.org>; Tue, 14 Mar 2017 22:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751342AbdCNWoM (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 18:44:12 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:32988 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750997AbdCNWoL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 18:44:11 -0400
Received: by mail-pf0-f179.google.com with SMTP id w189so193471pfb.0
        for <git@vger.kernel.org>; Tue, 14 Mar 2017 15:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UyZyHCHEwjjCYR47s1ZeBAxpwFYiYx0iCl6o3IsjsYo=;
        b=R+Dv3UztqNd5S7OM1/Yznpd6fxMkEmIyc48Jb0bb4R0yRtGlDj/R2h+G6u8ziUQRRZ
         EaEz/nHHZbnk6WhnQJdxHxHSBpx7eiJu4aOCtSCQ5+CiQai2qy4i/vB9Jkhp3vatmu3t
         00BemFPSac2a6JQ7lS6/3vrlxNB/yamuWWx/NBenq/sBeU4NsAulgkaIjawfRzICTbVM
         Su0sAd9o41dnIDuog7Tpv6YYE0AS/o/9sqIRm+GW3SCSqzvHdooe1buLC1eFPob4wZJy
         AGyZpBeqK55agztCvAq+iC/hDUGZ52zgPow+AfBg+23lB5jLT4B+fJEk4E9tgNWUaAG9
         N55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UyZyHCHEwjjCYR47s1ZeBAxpwFYiYx0iCl6o3IsjsYo=;
        b=eBhEBv+Nr6RU/S1DUiM54ReN1WhxlnW35q8n3D9NRg5W4XYEWXWHM8MbBZ8aDhlnzq
         fkag8FIC4+qyj9GG7MRo2bymOXZqvCJzk0mViBdZBiC5OLF6DhAAb2w5Edx1Ru2/Xi3J
         R+Yc/7plBURJQArCRorxyin5pP9LbFIpijxIwJeIYvycKJjQBtkDTQ+QqbQc8FzBYmnu
         ORmlZpWPxM0/h0ryXv9YIE+GgP53KcNK6tMinJ29+7F1NcitFL1t9ly5bMEa9lhtVsva
         91m4CFnVh2F5LSHsbsR+Gs/70lTHbi+toi5YWRWSn2uH7VKTUfr7VYLIT4Y/UBXAZPzy
         K8mQ==
X-Gm-Message-State: AFeK/H36W2JsGMeZe+v2A4wOtPrYZZanjf5ODh8a6FZZVH8DlBLahp/T+mLat7JjiT6ZRfPh
X-Received: by 10.98.141.82 with SMTP id z79mr121928pfd.20.1489531450088;
        Tue, 14 Mar 2017 15:44:10 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:491b:baa8:63f0:3cf1])
        by smtp.gmail.com with ESMTPSA id r71sm22342pfa.104.2017.03.14.15.44.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Mar 2017 15:44:08 -0700 (PDT)
Date:   Tue, 14 Mar 2017 15:44:07 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH v3 01/10] submodule--helper: add is_active command
Message-ID: <20170314224407.GC168037@google.com>
References: <20170309012345.180702-1-bmwill@google.com>
 <20170313214341.172676-1-bmwill@google.com>
 <20170313214341.172676-2-bmwill@google.com>
 <xmqqh92vkb8d.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh92vkb8d.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/14, Junio C Hamano wrote:
> Here is my attempt to rewrite the whole thing.
> 
>     The definition of which submodules are of interest by the user
>     is tied to the configuration submodule.<name>.url; when it is
>     set to a non-empty string, it is of interest.  We'd want to be
>     able to later change this definition, but there are many places
>     that explicitly check this condition in the scripted Porcelain.
> 
>     Introduce the "is-active" subcommand to "submodule--helper", so
>     that the exact definition of what submodule is of interest can
>     be centrally defined (and changed in later steps).  In a few
>     patches that follow, this helper is used to replace the explicit
>     checks of the configuration variable in scripts.
> 
> You are adding the "is-active" subcommand, and the implementation
> detail to do so is by using a new is_active() function, so the patch
> title needs a bit of tweaking, too.
> 
> 	Subject: submodule--helper: add is-active subcommand

Thanks for helping wordsmith this.  Since starting to contribute I've
realized that writing a good commit message is probably the hardest
part of the whole process.

-- 
Brandon Williams
