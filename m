Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 307511F404
	for <e@80x24.org>; Mon, 10 Sep 2018 17:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbeIJWaZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 18:30:25 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:43952 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbeIJWaZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 18:30:25 -0400
Received: by mail-wr1-f41.google.com with SMTP id k5-v6so22816917wre.10
        for <git@vger.kernel.org>; Mon, 10 Sep 2018 10:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/A8l1Eh96Ozxt6a71+GTiozI/UlvEp1cKpecUAnCj+c=;
        b=SGqH+b2tmrWXjsOtESRv/ae2kZ46XcC46JuAyw8Lowm+YglME6IkBaQeKNdTY+wm1d
         0xjArI4Ib4+5N2Fp0De2UV1M3VU9ZGscE0ZpsdCeMa39ftfbvGRtgBNbWFY7JoZKfsoD
         8k4a9IU8QP636qSPpmlldh8FMkz88TKs/mcERXDyTHQbzfqqQRP9NKI7QdvLb/3F6z7R
         EopMn42lruChm2Ig4ZbmPn6D2G1afqFAZeWUdrwLGKtE1xLE/c6UiNX0AdupBl7zbfq+
         /zBzpPHb7t7g480y2UXz8ya07Jjbko0ERqCS0/yksbVpvfamb7ARd1sxlth6RwAwQ8l7
         gd1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/A8l1Eh96Ozxt6a71+GTiozI/UlvEp1cKpecUAnCj+c=;
        b=IaTDr44K+8Vj9aC0Azvz8JWeWMxw34ZiHO/pScetj/oXaiDrfX3/hNYIJnb3bLyjel
         ZywmfT28EGZ1f4lKR4eVKZHKlYDK0yBciZ8jbXHOwogPSNOXl/AWw/VCBkuW70emhNaj
         mpoW8caxU64uY0z1WaU/QHSKqw+x4X4yIUMvxuZZOp5qRfqL6r0A3ZL3G7DjwK+1TS/2
         meYIwT9yQTYzszkj/LiTbDgnrlut0vkFbH1Q/G6gxFV4TYcQI4tRLwz2x7aooTGg97VB
         T1q0IPyNnfMmAF+DjpxKA39kwqjvJZrgCofHn9c4YLrx9xTxyzIy0fTN83hyhBOsqgOb
         MvOw==
X-Gm-Message-State: APzg51D6ajO1gV6SG7qU25geejVNT23OgGcCz+wXdeeT1ADrhmHKMD/m
        s4lDNYju7AVUVrxlMgPYF5U=
X-Google-Smtp-Source: ANB0Vdag+D5BePr/h3i4zG/bKqsrj1htvIx7XGNM36HCmFj6i1omqkCP3C1xSaMK/bJ+Aagt/kobGg==
X-Received: by 2002:adf:d4c6:: with SMTP id w6-v6mr15551535wrk.185.1536600914903;
        Mon, 10 Sep 2018 10:35:14 -0700 (PDT)
Received: from esm (ipbcc18976.dynamic.kabel-deutschland.de. [188.193.137.118])
        by smtp.gmail.com with ESMTPSA id j44-v6sm24290752wre.40.2018.09.10.10.35.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 10:35:13 -0700 (PDT)
From:   "Eckhard =?iso-8859-1?Q?Maa=DF?=" <eckhard.s.maass@googlemail.com>
X-Google-Original-From: Eckhard =?iso-8859-1?Q?Maa=DF?= <eckhard.s.maass@gmail.com>
Date:   Mon, 10 Sep 2018 19:35:12 +0200
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Bryan Turner <bturner@atlassian.com>,
        dylanyoungmeijer@gmail.com, Git Users <git@vger.kernel.org>
Subject: Re: [Possible GIT Bug]
Message-ID: <20180910173512.GA22152@esm>
References: <CAPGJNu5RPXjeib-vayVzmFkU9cZ=h5o5VDoM1vQqv2+HgtNXLw@mail.gmail.com>
 <CAPGJNu5=GkiALR1=RYgHLv3NDrycqv13jpU5_=SOW-yWtRXduw@mail.gmail.com>
 <CAGyf7-EFiZ7ouUPDMtv3eb57QEiM2pkavyKQe7iNO7+eBeuZ9w@mail.gmail.com>
 <20180910132452.GB5233@sigill.intra.peff.net>
 <xmqqin3duypt.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqin3duypt.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 10, 2018 at 09:03:10AM -0700, Junio C Hamano wrote:
> It is neither but if I have to pick one between the two, it is much
> closer to the former than the latter.  The primary source of this is
> that we have only *one* pathspec given to the diff machinery, but in
> order to implement your ideal "find harder", you'd need *two*.  That
> is, one set of paths for which you are interested in their origin,
> and the other set that you allow the machinery to consider as possible
> origins.  Since we can only give one pathspec machinery, that one
> pathspec is used to specify both of these sets.

How does tihs compare to `--follow`? With that knob active the machinery
indeed uses the whole repository for finding renames and/or copies. Is
this the only exception then?

Take care,
Eckhard
