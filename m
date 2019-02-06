Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76C321F453
	for <e@80x24.org>; Wed,  6 Feb 2019 18:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfBFSeN (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 13:34:13 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41638 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfBFSeM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 13:34:12 -0500
Received: by mail-qt1-f195.google.com with SMTP id b15so8990207qto.8
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 10:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Zogkj9K1hFOutNS5XH4UDHwsnhbZs4W9nEQxM+hKMrk=;
        b=lcUUL9nj6IgJSe+hDA/qsoTgdjHrHPScrcxaC/EVErTaMwNU/hhAF3ZGZ41LgWzagP
         K2GE3qUf+dL85CsLk8DCskaLBlTvrcH9wytOF6FxQkVGlnMToUYBW2dywM8rRPJXT0tX
         oXRe3H0OnOb7JuWex3w0GNNCr23NTKx7jaqHFWSb1ilCFaewgE8BAlaYVIJp5RHza24j
         MTBjpeNantN5Bb5T2kuTdVo27lC1L3sFw2fnz8lmxM0B8dY4NMzo7q3eOUer8M5bpobc
         5pjWr47ACXyPrrFTR9sr4GPU3ZaO1HAUSaTq9Kmle/MqZEd/CPrlR6UNFVcGVssd/nbq
         +gTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Zogkj9K1hFOutNS5XH4UDHwsnhbZs4W9nEQxM+hKMrk=;
        b=AQWKGw/AQBP2zwGEAT0XCAvnsqD5DPtLg938mLS3ByEtW9ws1Q9NS72XmCL0TCkoG5
         ymrBEtMordAiJ7UC+Xx+h3wUWd2I2Gv55Mo7Lm6L6hePQ3DCzACtSR9iRULh1QWF0tF2
         s+lx+jrsFDgvt8dmMgrufgLWrGPOop0UA/SalRAujj0LYotDEDyZ1gFZOm7RATodKYtA
         VSFlnN/pANoHOG1qRHGlr7hPSsun/P2N0lTiRLjHfmksZTlSui2GBnzIX6rhRgf7mEwH
         hgB0vXWC1S4fsCeNy5g8eTo+CLqFrapeN0+uPq8ECfRsTg0zfXxf+CtTNPdQ1ssNCQU2
         CVHw==
X-Gm-Message-State: AHQUAuY3u8tdIUMTGT8NZUUVysM9Yp9ye5VeWLrCBPfopF9c9gjU0QLG
        rj/8ZIbZPgT1VJ2kOoXIiPU=
X-Google-Smtp-Source: AHgI3IaWw99a0soPb77U9orZSEePKpx4tCND9ChdW2c4an9/B/PaTnZ6RqeLj6YI+xWFcPiw5ugirQ==
X-Received: by 2002:a0c:8b64:: with SMTP id d36mr8624206qvc.233.1549478051323;
        Wed, 06 Feb 2019 10:34:11 -0800 (PST)
Received: from whubbs1.gaikai.biz ([100.42.103.5])
        by smtp.gmail.com with ESMTPSA id z207sm18632803qka.57.2019.02.06.10.34.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 10:34:10 -0800 (PST)
Received: (nullmailer pid 10916 invoked by uid 1000);
        Wed, 06 Feb 2019 18:34:08 -0000
Date:   Wed, 6 Feb 2019 12:34:08 -0600
From:   William Hubbs <williamh@gentoo.org>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        chutzpah@gentoo.org, Jeff King <peff@peff.net>, williamh@gentoo.org
Subject: Re: [PATCH v6 2/2] config: allow giving separate author and
 committer idents
Message-ID: <20190206183408.GA10832@whubbs1.gaikai.biz>
References: <20190204184850.10040-1-williamh@gentoo.org>
 <20190205195212.25550-3-avarab@gmail.com>
 <xmqqef8mrnnj.fsf@gitster-ct.c.googlers.com>
 <87k1iekkea.fsf@evledraar.gmail.com>
 <87h8dhl0zh.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87h8dhl0zh.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 06, 2019 at 10:28:34AM +0100, =C6var Arnfj=F6r=F0 Bjarmason wro=
te:
>=20
> William, is that something you're intererested in carrying forward? I
> can also help if you want. Sorry your first contribution to git has
> turned into this mess of re-rolls, as often happens we find that when
> trying to tweak something that the existing behavior doesn't have any
> tests.
=20
 I'm open to it, but since we aren't sure about reverting the patch I
 guess we should wait for Jeff to reply?

> I think it's worth spending a bit more time here to prove to ourselves
> that the changes aren't e.g. spamming users with the ident advice in
> cases where we don't want that, but maybe everyone else is tired of this
> and we should just take your v5 and fix the other stuff later. I'll
> leave that up to you / Junio to decide.

Junio,

I guess it's up to you, should we take my v5 patch then do the other
fixes later?

William

