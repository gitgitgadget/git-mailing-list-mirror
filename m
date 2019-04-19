Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCF8A20248
	for <e@80x24.org>; Fri, 19 Apr 2019 18:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfDSSuo (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Apr 2019 14:50:44 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35953 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfDSSuo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Apr 2019 14:50:44 -0400
Received: by mail-lf1-f65.google.com with SMTP id u17so4636558lfi.3
        for <git@vger.kernel.org>; Fri, 19 Apr 2019 11:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I490JTuNqtzqygPkiyNm6D/BzafMflyQwBngyyVQP3E=;
        b=lBS24raqIWU7+8PstkI8KQsy8kC0iUja9jEzlTaic0XNraNvhcSgEweSbgCNG6kwqr
         Co32MyenBeFvmdofdGAFoAXrFxX3DpISa1SXSU5YISGNuU0yDO9NixTi1Y0dsJ3v03eD
         tO8hRl9prFd1+7a7/ZJi1PKLYP8rH6aApaNWDLguVFQe87LnWHeu0w9Oah1ENk4Ysu/N
         w+8mV0QX641wfH3SlvM9osSJlzb0CB+i7W81w0XYNiphe/Wdt7p5fgTkH9Sm4CDdc16r
         BA6JdTHXbZMHkF2zCZoePtsRIHq2R7tZh7tz+6HfyLozSwX4t+HgHBGMgPMKiPOohttc
         i/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I490JTuNqtzqygPkiyNm6D/BzafMflyQwBngyyVQP3E=;
        b=LTTbhxU1ma7+1RFcZZ1n0WlVrGPIRgqg+TOVy1zy2G1wVipPR9VfFkabLE2QZWn91x
         xmfq3LEonumoLKmj4Mb6beld3mv5JriKFMrLWitdiTo8L2CuEv0BoYvv4oYdACDiJLe8
         edmEgrOBJ077PgDxhxnY4alzCyBTVo9Fof/MwYke2qWb7B84Aokk6tZ/xAmLQPZVHddZ
         N+SyCWhzKToMXMwLNjI1pdiT2/k0jwvmdKtDNlBW0jPo7w80BpZxtpLmr1dl4r+fw3Ps
         zjqazOz3trQcPQXQ4oWBaOJL3AgKA4pRg1xcCjxLlrZeVP3zRuIArOScnxe7JZk89FvG
         kYTg==
X-Gm-Message-State: APjAAAWrxD+kpEM9WlBcX8YBl5Rlh/WUryUdI+C3Hd+5OMw2o7JODvp0
        mKHPVCC7QbY7KDc9hNpVJOe6Z3dQ
X-Google-Smtp-Source: APXvYqwXE1zMv3tHi/91gAoBDrRK/jPk52uxeuqB9AnpKdH4E8I+hxoVSgtEoPFHHGROazcseMHr8g==
X-Received: by 2002:ac2:4186:: with SMTP id z6mr1025466lfh.50.1555650156784;
        Thu, 18 Apr 2019 22:02:36 -0700 (PDT)
Received: from vkochan-ThinkPad-T470p ([93.75.250.209])
        by smtp.gmail.com with ESMTPSA id c7sm845282lja.90.2019.04.18.22.02.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 22:02:36 -0700 (PDT)
Date:   Fri, 19 Apr 2019 08:12:49 +0300
From:   Vadim Kochan <vadim4j@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] configure.ac: Properly check for libintl
Message-ID: <20190419051249.oiypxcs6hexjdf2d@vkochan-ThinkPad-T470p>
References: <20190418050419.21114-1-vadim4j@gmail.com>
 <xmqqftqfhnmz.fsf@gitster-ct.c.googlers.com>
 <20190418082844.GA10068@lwo1-lhp-f71841>
 <xmqqmukmegof.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmukmegof.fsf@gitster-ct.c.googlers.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, Apr 19, 2019 at 01:56:48PM +0900, Junio C Hamano wrote:
> Vadym Kochan <vadim4j@gmail.com> writes:
> 
> >>     Some libc implementations have function called gettext() that
> >>     can be linked via -lc without -lintl, but these are mere stubs
> >>     and do not do useful i18n.  On these systems, if a program that
> >>     calls gettext() is built _with_ "#include <libintl.h>", the
> >>     linker calls for the real version (e.g. libintl_gettext()) and
> >>     that can be satisfied only by linking with -lintl.
> >> 
> >>     The current check to see if -lc provides with gettext() is
> >>     sufficient for libc implementations like GNU libc that actually
> >>     has full fledged gettext(); to detect libc with stub gettext()
> >>     and libintl with real gettext(), aliased via <libintl.h>, the
> >>     check to see if -lintl is necessary must be done with a sample
> >>     source that #include's the header file.
> >> 
> >> Is that what is going on and why this patch is needed?
> >> 
> > Yes you are correct. 'gettext' even might be defined as libintl_gettext.
> 
> With this exchange, I was aiming for extracting a more useful title
> for this patch out of you ;-), and I think I accomplished my goal.
> 
> "Properly" is fairly a useless adverb in the context of a patch
> title, as it does not tell us why we thought the way in which the
> updated code works is more "proper".  In addition, because no code
> is perfect, future developers are bound to find something inproperly
> done in checking for libintl after this patch gets applied.  It is
> better to say the most important thing the change does concisely and
> concretely.
> 
> I think
> 
> 	autoconf: #include <libintl.h> when checking for gettext()
> 
> is probably a better title.  
> 
> Together with your originally proposed log message, which we now
> know explains why this inclusion makes a difference sufficiently to
> be understandable by an average Git developer, the resulting commit
> will communicate to our future developers the reason why we thought
> this was a good change clearly.
> 
> Thanks.

Thanks! Should I re-submit patch with title updated v2 ?

Regards,
Vadim Kochan
