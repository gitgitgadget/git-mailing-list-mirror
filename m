Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FF351FA7B
	for <e@80x24.org>; Sun, 18 Jun 2017 07:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751088AbdFRHf5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Jun 2017 03:35:57 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35414 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751082AbdFRHf4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Jun 2017 03:35:56 -0400
Received: by mail-pf0-f194.google.com with SMTP id s66so12419879pfs.2
        for <git@vger.kernel.org>; Sun, 18 Jun 2017 00:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=9KFL5vHhcQJrmMyz1sEyu/9EF1ogoyfFA9ETeDY1tjs=;
        b=XgHIiOnSIYpuJERds/nmbyH4L6EUXUsMfMOWlz3dNdN1j9j2p5FoWEU8TecCPf/9Qb
         vkBfzv1sx7HAXfFyyATB1YGTS55Uj9vqA7nFOchcHhZz3guwzz/3/8DVoTN2Lt+QnWUb
         bfkRLc/7YgSRwRWiiZQPd2dzGKBKwby4I3W4HJCR8edhYuAAbcR/GpHjNrntiHew8w0J
         uliDHjVSm2ky7ZutkOsFuLhIfZL+I9RA9Sucxo26kbYDFrtvHhrb1hlX0Jw/uqoQ1Qzu
         u0A5bOfBehiJqTnPHYlEI+gJFHhrZ6F/QbyOiIxVJ4ummkCZxot8jA8fbPFZbIaQ556Y
         +AnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=9KFL5vHhcQJrmMyz1sEyu/9EF1ogoyfFA9ETeDY1tjs=;
        b=DQJzjQg1tFZ7MUYyT1lD1b69AcQXno7Uq+qg+6cACI4jcz+JLeTNGL8E3raFonxhVZ
         se+/KE/UwHrDZTNBwmRN3FqYcOQlDRDVgomJBlr+ikAzTkmYGm4zQzhrafCda7ZWkn8H
         cwQ/JwRHm7n8nI5+gfPrdupcdzGWFA0Q38M4G+23fCtXTg/hn7/ojr6G9u7HJvYm5aJd
         GCohv610+6SCNxysL2y9BZPDW97DHjdCRV3jAHkcOLdhCQsBbckxM0TlAZSV1Y9Qo7zI
         Iy5+G85lIQJN7en/1TZDzbYYceuCgZUnWDBexgZjzcuKoxInBYH+goi9sIGIh9VzvVoP
         uuqA==
X-Gm-Message-State: AKS2vOwFmNMnESDNPrYjqTzAU9kyQWg6jSjbSSvxz/0SGbO+YzS9+1kC
        x2ck932mHpujxw==
X-Received: by 10.84.173.67 with SMTP id o61mr13957949plb.236.1497771355964;
        Sun, 18 Jun 2017 00:35:55 -0700 (PDT)
Received: from unique-pc ([2405:204:7208:1ff:86ae:df58:5f4e:dbf8])
        by smtp.googlemail.com with ESMTPSA id 189sm13790375pgj.67.2017.06.18.00.35.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 18 Jun 2017 00:35:55 -0700 (PDT)
Message-ID: <1497771338.1689.4.camel@gmail.com>
Subject: Re: [PATCH/Almost final] wt-status.c: Modified status message shown
 for a parent-less branch
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Samuel Lijin <sxlijin@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Date:   Sun, 18 Jun 2017 13:05:38 +0530
In-Reply-To: <20170616105032.rjmmql56ifol34mk@sigill.intra.peff.net>
References: <1497255003.1718.1.camel@gmail.com>
         <xmqqa85dnjpz.fsf@gitster.mtv.corp.google.com>
         <20170612212025.ytyukvmmthfcsejh@sigill.intra.peff.net>
         <xmqqshj4nb9u.fsf@gitster.mtv.corp.google.com>
         <20170612213759.f2scl3r46vboolna@sigill.intra.peff.net>
         <1497514760.2394.6.camel@gmail.com>
         <20170615084248.elfsh4of5qdsk3pa@sigill.intra.peff.net>
         <CAJZjrdXXGb-QrvJW9JusPT597QDnQD_shzVJq-5GN=hZCBJYeA@mail.gmail.com>
         <20170615131245.zh5nuipmaadcfpdx@sigill.intra.peff.net>
         <1497609408.2517.4.camel@gmail.com>
         <20170616105032.rjmmql56ifol34mk@sigill.intra.peff.net>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2017-06-16 at 06:50 -0400, Jeff King wrote:
> Wouldn't you want this in cmd_commit(), not cmd_status()?
> 
That's right. I made a little mistake while trying to replicate a
change specified by Mr. Junio C. Hamano in a previous mail in this
thread. 

Seems there aren't any other changes required as far as I could see,
hence this mail will follow with an "almost final" patch.

--
Regards,
Kaartic
