Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC267C00140
	for <git@archiver.kernel.org>; Fri, 12 Aug 2022 21:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbiHLVA5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Aug 2022 17:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234227AbiHLVA4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Aug 2022 17:00:56 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416BD99255
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 14:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660338045;
        bh=7MUV7qCU0hkj785QE8KIS6EIZZxZoA/qflsbwq6ONxs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=CR7Xdf+c0pEpCV5Zzc7C+zrUZ4nnVWoabjO91Hgy3Zugm2m6UeqMrLPWLM5am8UP1
         tXcAiC8FdsrbKhfL9eDgCbPIF50pysg8jJ6bVSSdPCrwIBz4eX1AMW4NrZRHcMRTBd
         de2A+q0apiWMgzRAiFACwFLgWTdXQRhyO78RPj6o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.191.7] ([89.1.214.151]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mf0BM-1nkUnH2j86-00gUaT; Fri, 12
 Aug 2022 23:00:45 +0200
Date:   Fri, 12 Aug 2022 23:00:55 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] tests: fix incorrect --write-junit-xml code
In-Reply-To: <xmqqpmh8kkfb.fsf@gitster.g>
Message-ID: <78npn9qp-2263-sosp-8901-4484s4499q99@tzk.qr>
References: <pull.1288.git.1657789234416.gitgitgadget@gmail.com> <xmqq35f38yeb.fsf@gitster.g> <s4s2qr56-2948-p025-rrq7-qq56p9oo844r@tzk.qr> <xmqqv8r2smvr.fsf@gitster.g> <3qn5r283-3232-4s58-8q9s-n67o407nr816@tzk.qr> <xmqqpmh8kkfb.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:MsQQ5B+fWCJ+P5xfrUoYFXzl9QTB2aPC9gRDWyLOV0wlSEfTzLA
 2xaj6CjUKPAiQk6lkibtsaW1Jn45rcoCDdkCcXlcn6Wcclp77g4/cx9+QbnwFuTbelFNmpt
 KyV0oxXx7jXwePdC2dD5ltifln9fD2CIc7wglkL6GAdaurDbavuzDaBWPO1y36lyh2tyEzs
 EVQPDBPfqETc638uAxbwQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:t42s6r3lQO0=:XtIHUsWyo8yPELiEA8j22r
 kMhEatYXs7whFSTUuCR0OykCDQYVAS807JG6iRZwPreHCDZMtLixk9/jucw9N3RRQvh/AOmmL
 4cTky9Xh8dUNY471lUY/GIeSkOs7dMDwIpffld9gTLI42oGNVL0knrfAep8exk6k3wDx6jyet
 Rmos7/b3UIi6fYjhRZlu6DUzI8x2PQnj2xuYR6Jdew/++BgLN/+7uO0ZNVxWVY16g2QWHewDt
 B8dcRarAbuQdU3wHG6e2qyErKToh+UOJiWoOirzUfhXpeFHYtKJgu6987yhPG/dNYt0VmKd6j
 t0Xum/eVUbEPMw0DkdWFjVYf5EsRmXpmAsMT/nZSX01myr+apcctK4u7TpdK7Buk8kqqtBUJI
 U3jKmQ0AhTeMEYDepQQI4O1rfWyckZC1XgsbE2FateJPQrUv7SPnZUft0E/ZoUmGx4HkVBMDI
 hkFmW/19Vte+Kxt6REA896E3nXAXChaDthB9xJ86WDq6Jv0GMhsAePvBHAu+9KaZk3zxabsXM
 R3Uk9HTL3fA9o2WpqUHg2bgZyP2PK60DhocKawEVv2p/9YyhQ6cWG0voOv6EScZPPoPQ4Z7Zi
 yBasDQKOJfWadKfeH0e+WLxA9PSFT23U1uDrFwaurTBSqFDj9E8tEPvtbW/xJ6zMeM1u6vB4c
 yJvxwPoHGBUW1A/3/EfpuMpeDMIA0+8dZddnwRxyfJqMUYQdtAfEtc1/FZWD3UPevSvtbSg+B
 aX3K37nz3mr075CNmU2wO+FrLHjX5Vz/m2i8Zca66V9OXpIIY48zL171S/cxi9kH1Ljmf6Pkp
 qcfqxAX4L0sD69f/wriw0Je96w2mYp9nUY4wzu0mlHRh6DOyidTlVvs66QtxZnnIlUnTTPYWb
 CduRIQk55jOSkToc0UGycgVua3bfZTiHHbTdY3tcb53kW4jvJUIf0/GIcUcHCSfOTjxVGmyqP
 vnQu9JIs7CFFK20aalv1niacGIV0yjYSeo6dBKtNVC6vvfQfqtBrHzFxKHX8/DJJYOl5YT5MO
 DvGJpcOpH8jx7/ywC/j/9HQmORrGkXy6gkhTAR+wBlUfPB+stIvbdXKoIPL6sKPmaAA9Eqp7W
 cYSe+Npy3mm0iRMe4TnJY18QIB3soLWSjaCxj/sQnW8HuVHBUeL1GenUw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 10 Aug 2022, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > The funny thing is that you're usually simply not picking up patches t=
hat
> > do not get any reviews, but for these refactorings it is somehow
> > different, and I do not understand why it needs to be different.
>
> Well, I am not sure if encouraging the maintainer to drop patches
> that are not reviewed is a good overall direction you would want to
> go in.

I am not encouraging you to drop high-quality patches that have a clear
benefit to the project and/or Git's users. You probably know me better
than to assume that I would ever do such a thing. You probably meant this
comment tongue-in-cheek, but I cannot really tell.

It's about these long patch series that touch everything and their dog and
the end result brings no clear benefit to users nor the Git project
itself. I can easily imagine how wonderful it would be not to see such
patch series ever again. ;-)

> But let's try that.  Less work for me, less disruption to our tree,
> and the world may be quieter and more pleasant ;-)

Amen!

Ciao,
Dscho
