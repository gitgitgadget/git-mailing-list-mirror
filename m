Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 479EC1F404
	for <e@80x24.org>; Sun, 18 Mar 2018 14:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754466AbeCROvF (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Mar 2018 10:51:05 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37354 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754212AbeCROvE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Mar 2018 10:51:04 -0400
Received: by mail-wm0-f51.google.com with SMTP id 139so11027467wmn.2
        for <git@vger.kernel.org>; Sun, 18 Mar 2018 07:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=e4EJhKxBRa0eZej/Uax+4KPFNrUEJeilJkcXKHi17g8=;
        b=KjeoJeYfLSfTCdpS59jdutm6GCxPXCDuqr3wb5o/A2ODOOrea3JUYpwsB6OBBezTMv
         3gNWP1XClywSHi6n83SEHbJx7IIRr1nW78sYDzx7pltjw1/oumRfftLs3Eo2KDXAoxJc
         uuE1v5xGsbbuShr3zfcwW5AsOurpmS+lOwr9LtF4n/kbwaKWSOYa98SkMl+7UUhpIydl
         B2tVfPLdAoKurxkd2OkyK/2mciUIIqw71zq5jXe323I4wopbXuM8iRv8YWIg6rsKb2xP
         4f2dszLrFe4UQ8LcjyiUCd5bw+oMSQ4eG8cBWpymPNBc3EklZMBesNpUEjV47+f7WKjN
         OTZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=e4EJhKxBRa0eZej/Uax+4KPFNrUEJeilJkcXKHi17g8=;
        b=i44gp0WEyShczxIJCUqb6f9R9uGCppa8A7aA0nZw7r86tsrlJI84FF3ZAdjOqClxXV
         S+vEsiJvlVRIKomtkoaKvsRAIRCKipEkhlklSirszZoJQkvkuCHPVnLBln0tWh0nGlMQ
         oWLUKfKgb33qdxJWzC8bgWboekaV/w1bjzrr6l21OfwISc0co9ftpc0QzKloMJ6nN99t
         1buqMwaLk8gM9hN0NmtpeBv4i7i7lAib6O2nqTU0ARTNH02fQZ8CBNBRwucKH35tuihh
         jv4tUw06rHN52tO013YBgRVVV0FRp/CAUKKCZm8vjFPLxL2lYPr5I44xwtfi7r2FrQwr
         mGgw==
X-Gm-Message-State: AElRT7EpFUHUT2akv1NFvsY6LLlbkMRphVkl+1yPfNWlBpDNf6YPWze6
        FFRuffZRwml5ZXWi22IRBkI=
X-Google-Smtp-Source: AG47ELtGhwuyWWbW8cKA3PTP9RuDJpZ3+9R4XS0uCdgHCVv59dY2lRNP2mSIs0wB/VNSFwuurmf28g==
X-Received: by 10.80.170.156 with SMTP id q28mr10250178edc.43.1521384663280;
        Sun, 18 Mar 2018 07:51:03 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id x6sm1390157edb.56.2018.03.18.07.51.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 18 Mar 2018 07:51:02 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     e@80x24.org, git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH v6 00/11] nd/pack-objects-pack-struct updates
References: <20180317141033.21545-1-pclouds@gmail.com> <20180318142526.9378-1-pclouds@gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180318142526.9378-1-pclouds@gmail.com>
Date:   Sun, 18 Mar 2018 15:51:01 +0100
Message-ID: <877eq9cu96.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Mar 18 2018, Nguyễn Thái Ngọc Duy jotted:

> v6 fixes the one optimization that I just couldn't get right, fixes
> two off-by-one error messages and a couple commit message update
> (biggest change is in 11/11 to record some numbers from AEvar)

Thanks, aside from the minor typo I just noted in
https://public-inbox.org/git/878tapcucc.fsf@evledraar.gmail.com/ (which
I trust Junio can fix up) this all looks good to me.
