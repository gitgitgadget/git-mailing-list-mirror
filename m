Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 190251F404
	for <e@80x24.org>; Thu,  8 Feb 2018 18:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752100AbeBHSVy (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 13:21:54 -0500
Received: from mail-wr0-f180.google.com ([209.85.128.180]:41884 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751544AbeBHSVx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 13:21:53 -0500
Received: by mail-wr0-f180.google.com with SMTP id u60so2996397wrb.8
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 10:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=cNrU5PNXIo3DJGmdJvoPG4IeBngMhgOFwGD1DObw6oQ=;
        b=PXTsdZOICPYOpORAjtRsPlbx9BekIvErMJ/OVd2T++LmLoJwofwN4lA82wgD+5Iz2X
         uXw3kFv+xB/VMyOAdUMBPaDNDcN6ZdGVf/4Y9nUo37kKhkaJD7O0VWO6kJ/ByW0ev4eN
         dTkazZH1ITlGxs47oQB2R6K6Qi07/8NhQ323dwkdp8YJ4EpotjVqrbjm5SC6ZOcIdzpA
         oH50W7UEonQgnK1UHCwHodoRKQuyvtHv6lwQ9tPbMMrhd1J9cPs1yFtPsG+o+T7kS/Di
         SmRovapeerhSe/CDeVuxLw/GzjLqVONT4rH6h/DQxp0aUmRCp52km/Eq1gyQamErkOXI
         NN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=cNrU5PNXIo3DJGmdJvoPG4IeBngMhgOFwGD1DObw6oQ=;
        b=eyMho/fq55YuepwPVmPQiN+3ru3VAv+jnc7V2DRLSGrmGaA9B6nJcKuMlTSf4crLO5
         gAMsYyphQduHGH3RWcJ/2MgPCubAZ8wE1hhocIeKjPYfHf4GSZKTiZDpqjqOHgz2FFP8
         Mkj4H5g6o2VfJ9VJI9ItPVjWtZUdRZiqOnUD3DNFyHW8BMRa/e+LccdD7q5QDgGxSkS/
         1y1lMa5nJnhzRnSIRvOm+ZMdCuHCr3laLqoPhp4MJlZYYHX5N4k7J0fXsUNrJSE95ee2
         3oE1zZ5mPMAzRpNMGfDX0kUFuA9XWU4YwGaR0C/ER5q5U+yF8Bo3lntk47TLrUT2BSBl
         W6kg==
X-Gm-Message-State: APf1xPCxGU3E0MOUl4C2G7LwX4QYMpZirqFA9uxl1M8EeJDASPLWIv1y
        PsHtKdWY37QR6QrtiznsfeS2vQ1u
X-Google-Smtp-Source: AH8x227ub/opSptv2EOTWo8FKnfIqxuc+7qIIzvSUmDwjNouhmpu2q57LcJvE1P8NOSZ+I7ZCdAOMw==
X-Received: by 10.223.201.147 with SMTP id f19mr79094wrh.61.1518114112103;
        Thu, 08 Feb 2018 10:21:52 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id 123sm535528wmt.31.2018.02.08.10.21.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Feb 2018 10:21:51 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v2 00/17] document & test fetch pruning & add fetch.pruneTags
References: <20180123221326.28495-1-avarab@gmail.com> <20180208161936.8196-1-avarab@gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <20180208161936.8196-1-avarab@gmail.com>
Date:   Thu, 08 Feb 2018 19:21:48 +0100
Message-ID: <87d11fmjer.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 08 2018, Ævar Arnfjörð Bjarmason jotted:

> As noted in my 87h8quytmq.fsf@evledraar.gmail.com there was a bug I
> noticed in v3 where it would segfault on some git-fetch invocations,
> but there were not tests anywhere that caught that.

...and of course this whole submission this time around should be v4,
not v2, but I didn't notice that I didn't adjust the subject prefix
before sending. Junio: Hopefully you can pick it up anyway without too
much trouble, sorry.

FWIW I've deployed this to production @ work to some tens of k of
machines (low "k" of which have users using git) without any issues.
