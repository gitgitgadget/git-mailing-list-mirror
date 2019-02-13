Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90FBB1F453
	for <e@80x24.org>; Wed, 13 Feb 2019 16:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404451AbfBMQn0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 11:43:26 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40350 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403764AbfBMQn0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 11:43:26 -0500
Received: by mail-qt1-f194.google.com with SMTP id j36so3297754qta.7
        for <git@vger.kernel.org>; Wed, 13 Feb 2019 08:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Lt0I5Yut0McVGFzBkyMC+hlxXJ4BGrNjKgGHPUrexmo=;
        b=sbM72QnlaX3f9BBi0nsYmGNqaZfldGvZnM0sBWomxVeXeaiEKLNJSmaaLa4UhRaqEN
         TwHW34oNq7f7cyST65GgD0fGqNPdvE+/9KBV9SuOlNzpb9t0dKwTBqAT+rGDHyagNDVS
         NdLMPUGqh0e1VLR4S3ztAJUCdCX25ZFeME1sJoLjKOoFdBr/Oy/IIKaWLHRqF2xiGhAc
         rvIMrhv4zPaVVzxSpyi3AlcEGa4wro4Sz0itZu6Y/WIrqJQQBNDsBgSW0Ywjmvi5Ityn
         fgOc3rw86RDIkAsT6okEvO02maKh8IETU1Ife/5Y1cwooaF2jXtT5ngVYYKEGD5UGS8B
         52Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Lt0I5Yut0McVGFzBkyMC+hlxXJ4BGrNjKgGHPUrexmo=;
        b=tr/NRAU8SqzFrbUgU2HQ3kjoEKPR5J36CzzMxHOcDXa9bRiTb6bsmG2wRRkqmhuOF+
         wposoj6LOfUpo3sT1zzi7GIBZ4spXAPk3FBZFBjWGvkVjc5jLqai90wfAmY006QnnSz/
         AcVmqKbLGIxB8x6U5tiCRErpN1mbSKSuPEHLuJ2wxMym92rJdvhv+DDZAdOBBCUBaipw
         qkU2jvVd+wCrnHafUKl0lH8TK7jJoey0PHAGbpa6hjvbt4j8ARIxoHermMUy3QPKReKy
         SNJL8a1UTTJVYxEizmmX3oNFagaxkFUWPlqmZdZimCXVIZUSOUbNkfnJ/tsyVOSYnaDK
         EbJQ==
X-Gm-Message-State: AHQUAubLk6vB4IdcJA0P07C3p1MaEJFqgxoEKlrZsdBdwc3ej/ATO8Wb
        mkfeZqNKyhbWAvqsYcSoKiL2OmiZ
X-Google-Smtp-Source: AHgI3IbYLcidYuc8aI8N9wFgo9oBw1XjiZXZRy/fFdZqHhp7U0Vd73X5D+KJwt5QzxCMOhh7rWpVig==
X-Received: by 2002:aed:2151:: with SMTP id 75mr1214940qtc.24.1550076205485;
        Wed, 13 Feb 2019 08:43:25 -0800 (PST)
Received: from whubbs1.gaikai.biz ([100.42.103.5])
        by smtp.gmail.com with ESMTPSA id z17sm19895402qth.79.2019.02.13.08.43.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 08:43:24 -0800 (PST)
Received: (nullmailer pid 3666 invoked by uid 1000);
        Wed, 13 Feb 2019 16:43:22 -0000
Date:   Wed, 13 Feb 2019 10:43:22 -0600
From:   William Hubbs <williamh@gentoo.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, chutzpah@gentoo.org, williamh@gentoo.org
Subject: Re: [PATCH v6 2/2] config: allow giving separate author and
 committer idents
Message-ID: <20190213164322.GA3625@whubbs1.dev.av1.gaikai.org>
References: <20190204184850.10040-1-williamh@gentoo.org>
 <20190205195212.25550-3-avarab@gmail.com>
 <xmqqef8mrnnj.fsf@gitster-ct.c.googlers.com>
 <87k1iekkea.fsf@evledraar.gmail.com>
 <20190206000413.GA734@whubbs1.gaikai.biz>
 <xmqqwomdqzik.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwomdqzik.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

I am writing back onn this thread because I'm not quite sure of the
status. v5 of the patch seemed ok, but there were some changes discussed
that would have created a v6. The v6 changes though were never really
clear. I'm not sure whether I am supposed to be doing something more or
whether I'm waiting for you. ;-)

Can you write back and let me know?

Thanks,

William

