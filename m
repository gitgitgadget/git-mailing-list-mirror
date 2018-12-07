Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41A5A20A1E
	for <e@80x24.org>; Fri,  7 Dec 2018 22:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbeLGWVv (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Dec 2018 17:21:51 -0500
Received: from mail-qk1-f176.google.com ([209.85.222.176]:37752 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbeLGWVv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Dec 2018 17:21:51 -0500
Received: by mail-qk1-f176.google.com with SMTP id 131so3357997qkd.4
        for <git@vger.kernel.org>; Fri, 07 Dec 2018 14:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/u10gNYd7F990jpsgm2favpcNGApv43gbPoVPkuqaY8=;
        b=GMn6voo50A8mjWNypUPgCepYg3dUYv7z3LYPf12zKjPMqiu9cBwhoH/77xc3UDUOGJ
         2uihRRbJy2adbSmkLKJ6XU/IE/CagIQw08ezfPUtsGKB9R0lVXJN/0hDGJyb/zZcG5xT
         bXms5xLH8L1MajvdZZxSsU2mDIVcKmfD7nhZsmYvoPjGmWHyF0O06gQz+YjrCs8FzhMj
         qq++ZwJYhlKyZ3MF2OMj4pdDx7LOJvHiM2aFjDVrTmgdnLNSpdnxOQQeQSRZQTkOMoB9
         n2FumXypUoQXJZ7wvFaN9ax9ob3VTaqa4AuIJu0IWf6EkBdCVGVHg6qN9+PWl67fHycl
         3S7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=/u10gNYd7F990jpsgm2favpcNGApv43gbPoVPkuqaY8=;
        b=Qd7nBfYVXVtVBl3rcukphOLhoQ+1243pVLWhMQIx8c8ug5iyZGt6ToDWvWSkYuYcuo
         zbZ4nrhvtIt1Y9oRVaKdGjEBfNuNTXjAY1ACCiRrRTylt1rPz64qcxYWsV6ECzKdsADa
         b+eErH7WRRyRAaUyGFXnWUz+Livolno1lalUMzbyW6sg9DLdoZ4xdwO8BIU+ldtMTpBr
         tV56RKp/Cd7rIwpFK9EcMlVh4J/kXnopAZutkwsAFkQyuyqhtOGrDHIg9t51ZN8ATtNz
         88mj2cBX43BGTVMLhiI9Z1nHaxUjPNGuJ0z1urOwZPXFXknZSVmF0KIKtuPqH7xOSnPi
         7dmA==
X-Gm-Message-State: AA+aEWbbIOVuuz+fK7CBLqwnWm6RiWpxVcpbik7UpgohTTzku6HxXJzA
        oOU0+66ND8tJxR8xRwvp4jY=
X-Google-Smtp-Source: AFSGD/XRXXf5ZMbHnAnTmTAw2qlQqqCo87HjdgdEIw9PzWRekFt1+ZU/Yj0XKs/7pZu2lBFOm/4fFA==
X-Received: by 2002:a37:3c06:: with SMTP id j6mr3404687qka.298.1544221310573;
        Fri, 07 Dec 2018 14:21:50 -0800 (PST)
Received: from whubbs1.gaikai.biz ([100.42.103.5])
        by smtp.gmail.com with ESMTPSA id d193sm3733591qka.91.2018.12.07.14.21.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 14:21:49 -0800 (PST)
Received: (nullmailer pid 22818 invoked by uid 1000);
        Fri, 07 Dec 2018 22:21:47 -0000
Date:   Fri, 7 Dec 2018 16:21:47 -0600
From:   William Hubbs <williamh@gentoo.org>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, chutzpah@gentoo.org
Subject: Re: enhancement: support for author.email and author.name in "git
 config"
Message-ID: <20181207222147.GA22590@whubbs1.gaikai.biz>
References: <20181206181739.GB30045@whubbs1.gaikai.biz>
 <CAN0heSp2g0A82YYvMw-RaERESXFtj3TgPKA3RysC07Lf=tHBcg@mail.gmail.com>
 <20181206191737.GA31091@whubbs1.gaikai.biz>
 <nycvar.QRO.7.76.6.1812062318570.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <nycvar.QRO.7.76.6.1812062318570.41@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On Thu, Dec 06, 2018 at 11:20:07PM +0100, Johannes Schindelin wrote:
> Hi William,
>=20
>[...]
>=20
> There *is* a way to get what you want that is super easy and will
> definitely work: if you sit down and do it ;-)
>=20
> Please let us know if you need any additional information before you can
> start.

Which branch should I work off of in the repo?

William
