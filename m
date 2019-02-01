Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7343E211B5
	for <e@80x24.org>; Fri,  1 Feb 2019 22:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfBAWsR (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 17:48:17 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45155 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbfBAWsR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 17:48:17 -0500
Received: by mail-ed1-f65.google.com with SMTP id d39so6735469edb.12
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 14:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/cfyTcuqvoo8YZVWyHU5TA/MwuHjksnN8ry721XByA0=;
        b=VAU7ZE8qk62d2Ui+Uanjiuc0tyME6sKyafB68WjgSViC8x91g/mZmeBolxP1d+vw1Q
         pvyrJjAIvww6G7/GaZ8t6FAA4aR5XI2W0CSnykmCjooNu3iLn8lmvKs8PSg8dw1kP54k
         wEMPVJ9F0Y0Hn9acDTJ02SXAFybV/w8LRkF91Y0bK9qOAw24tg8qlKg85u/jnwG+6RCG
         V6hMuKhp9n2OZwj1KXsEwuAWLhgRLINdM7VLfxj1XvL7zcj9fXPmN4c4S0OzGLhUgIph
         AThmgL3kNrWbN//Y/0RJ8IroGFV80ZJKioJ73h6GQdrdFEyWSatBlioJukQDCQnTLtwb
         GEgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/cfyTcuqvoo8YZVWyHU5TA/MwuHjksnN8ry721XByA0=;
        b=dlRoCxGVjt6SSojQil4WRkvnbArHkzYN08DCGMWs1KQxVmKrasRKcT2dX48LJMaGhv
         jtSNKHXNhkOIosbhB3XofKNEg17R2+7PserM0EUtSgE1zpxFUjI9mOiFi9M3QQTLW+Ov
         S1xyvk2qWqgnP1hJeGgjtT5+C3pbD1TMtu0fJNVqD9l4RsJWopYuVTUAquS/yWXz8l38
         HtehVh6mkybB5wCwDRz5riHxCIR0hEGWMv6sEuDZgncOMZ7NnMEG/sqosBsM0YliAqpU
         a5FjVilAK8nZoGPIWnvoLLKC6R4DjAoaS82ZKazZ6PPh9NSh6Fdt2bj5vf7ATITXV220
         MICA==
X-Gm-Message-State: AJcUuke0RR9B8mwMLEds2LwF2mPkPAy0BA39PcYAQA1PV6tgj/bpR0CC
        aW+lc77/mBZQj2VwUApRDWzkHnu/
X-Google-Smtp-Source: ALg8bN73rQHgVVxW5lXSY9BmkfK4tpdOFMaqzKtzsJfUSngtndLR6+3idAo0siI2qhKcBjrudErkgQ==
X-Received: by 2002:a50:86c2:: with SMTP id 2mr40611512edu.34.1549061295382;
        Fri, 01 Feb 2019 14:48:15 -0800 (PST)
Received: from ltop.local ([2a02:a03f:40eb:400:6cd3:4d33:1db0:edba])
        by smtp.gmail.com with ESMTPSA id j16sm1457120ejq.59.2019.02.01.14.48.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 14:48:14 -0800 (PST)
Date:   Fri, 1 Feb 2019 23:48:14 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH 1/1] Makefile: improve SPARSE_FLAGS customisation
Message-ID: <20190201224813.4vykjb4iud5j6xhz@ltop.local>
References: <3ccf0255-8a15-effc-ce6b-eabb61625f90@ramsayjones.plus.com>
 <xmqqmunfxjve.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmunfxjve.fsf@gitster-ct.c.googlers.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 01, 2019 at 01:46:13PM -0800, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
> > In order to enable greater user customisation of the SPARSE_FLAGS
> > variable, we introduce a new SP_EXTRA_FLAGS variable to use for
> > target specific settings. Without using the new variable, setting
> > the SPARSE_FLAGS on the 'make' command-line would also override the
> > value set by the target-specific rules in the Makefile (effectively
> > making them useless). In addition, we initialise the SPARSE_FLAGS
> > to the default (empty) value using a conditional assignment (?=).
> > This allows the SPARSE_FLAGS to be set from the environment as
> > well as from the command-line.
> 
> Thanks for a detailed and clear explanation here and in the cover
> letter.  I agree with the motivation and most of the things I see in
> this patch, but one thing that stands out at me is if we still want
> to += append to SP_EXTRA_FLAGS in target specific way.  Before this
> patch, because SPARSE_FLAGS was a dual use variable, it needed +=
> appending to it in these two places, but that rationale is gone with
> this patch.
> 
> Also, don't we want to clear SP_EXTRA_FLAGS at the beginning?
> 
> The reason I raise these is because I do not quite see a clear
> answer to "I want to set SP_EXTRA_FLAGS and not SPARSE_FLAGS,
> because ...".

I think the intent here is to *only* use SP_SPARSE_FLAGS as
the internal-only variable and to use SPARSE_FLAGS *only* 
as the additional user-controlable flags.
If it is indeed the case, then I think it looks good but maybe
it would be better to use another variable's name to make
this more explicit or add a small comment.

-- Luc
