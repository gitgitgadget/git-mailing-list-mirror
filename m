Return-Path: <SRS0=tECa=DD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A77C2D0A8
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 21:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FE22207F7
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 21:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="K6cHqJwD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgIZVAm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Sep 2020 17:00:42 -0400
Received: from mout.gmx.net ([212.227.15.15]:37011 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbgIZVAl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Sep 2020 17:00:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601154039;
        bh=4e+MDzJJSkmv5aRJvtyWfbaALxnth1MRBVKVmzohfLo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=K6cHqJwDbpludbvVdamgJ/4AGpqUoetQxz4AV6KTFXUb9VLyy4WNJSvj/uGAIjfUk
         uxHY3KnBkfDjC/INxvezvvtiOAB2QtXG10RLAJU4d+sNIKCRIDV44C5HXCf/M5NCTn
         pvvEn56qc0oh7K6qeEi9qgzDb/o/P7Yp1/3CV8E8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.113.174] ([89.1.213.116]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQe9s-1k7W6b31l8-00NjBP; Sat, 26
 Sep 2020 23:00:39 +0200
Date:   Sat, 26 Sep 2020 23:00:37 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 06/10] cmake (Windows): let the `.dll` files are found
 when running the tests
In-Reply-To: <CAPig+cTPi1yi7WQf_eWa+bFRJEdtULFO3yYqJh3nm=_CtEe6CQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2009262300060.50@tvgsbejvaqbjf.bet>
References: <pull.738.git.1601044118.gitgitgadget@gmail.com> <bb8f122cdec94e1ec77b37ed16a7151f5e35a93a.1601044118.git.gitgitgadget@gmail.com> <CAPig+cTPi1yi7WQf_eWa+bFRJEdtULFO3yYqJh3nm=_CtEe6CQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:VI/Raq8/Yu7fqF8lCPbaGzRtjLpMRj+V1Fp+uszQOwB4jRoGgR+
 Kvt+oEfl8MBwL0QNgB0b3ArOAgTuhxtFTgqagmYnjaPrO/itZToeaHivH1o2U/M7euB0lke
 amWGXgv9UnlXeHU2vjBeX12vJTplP4mYwTC2UVFIBJt7HN4k4vCXM0dZYcz+WGxzyV6QCen
 InFUEPD0LaRsS4b7X2eIg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yOLoLBNGcQQ=:rBoAuA4rjwMs7B7T3jXPBp
 rKmW0hoo2f9HzB2PYG3gpwftsRxLpl20FSZFSNZhX3Cd6dW4a2O8Bf7DLywy4ttn6CubsNxj+
 OnfGrsLueSQdtx2imTBrIVzVMQvus+2JjXc8/EBREDJbnTiouGYDL8yQDGoc1vXXHOIEKbki9
 tSsx+JB88tWtOutxryvw2MiJwPInhwuAXnTT1SPpYKcg4dEDUdXXMuX76QMCniI0FJCR33Vkc
 JlMdYGgGtFHYmsadUPb2xANCFRBKuzKM2n9Sy9Rp7uuiWJ7S427Q4bYPTYSZG9dhQF2D3H7oR
 /YCU277FMhOFjOQE+WM/uXdfS+jCm96JKUTxHMSvS6Fx0xtc2wFugeelUnVO3DIiOtkC9p2jD
 L7shhVYf7VYQPogIqKpB590q9OL94CyNhMXsKbTz03SLA6jhIvSCUaEDvuVFuV9CDVIfFgtUj
 65s8ekx8cRhG6JVD09sX5ZBXbwiEobFkvM5yDHJ4EdIjKf2L56iXbTKE0ettFbJuRW5ThYAx+
 Nu+siskECdOGl270ucazd4o5wamz2FrfEGtlDASSt+6eelpD1imer9bgVuCuBKTLtKdORuEIn
 Ede8PBQDTTuUioDcmsu0O8L2CWswYTJEKCk2UQ/ONzZi21nUyq26TyTqLt7Wpec2gMofLcitf
 9L9E9oQr49VNvPQ9/LX0DmMQIZ2l70mlINxB+WyA+qmeD+IQU6aUldeNK5Qo7z16W4Qh1OVlv
 wUvg1Ja6gsWs2cWLcbEMPDTkGD8V4pkrDnqJmo6QwMUEzlC5e2vyHLfSuQicNeBEURCjHHUj4
 NZXmZDb1avreJBmH+WZ+0vK3gW6nO8DrHmG5SUfgJ2lW9Jccn6UmW3HE/NHdqz7PkaAw8uUEd
 vgx31YK0uhnwVI7KE0kHNwowaT2EYyV1ebYiVraq5P5cBCIOPpORqnT/3csB5SaHNQMu8K9pz
 71r/5WzRZsua6ZEspkLtZyBS9XsXAYbyKVxZDPxDI6IbHmzE7Nz9+c3bA1cpwjiVHcrLmy16D
 sBVVHtYx/GFUdUbkQi20v3Xonx7IvuD07kKqaKFQHXcfOJ/TQ6u1EEy6s9kQ6aV8n+VzQnGfV
 2Wmr/oleFF253QWgmBXEZ/odrChJmMrjzoCTHvmLuSNp/vOBNQh2c110OIYC1NhDVHs4ZNm8a
 ecrZkcRc1eueRJzSHo9phZeEDiHQu1hTwYJojc8ZWFJUG1pN0y4PB/KVOqw5/kbjgiMjyOmPA
 4rcnb0gJ2DYWqYL0Lcfa3x+dwLg1SRZ5Si64JUg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Fri, 25 Sep 2020, Eric Sunshine wrote:

> On Fri, Sep 25, 2020 at 10:28 AM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > cmake (Windows): let the `.dll` files are found when running the tests
>
> I'm having trouble parsing this. Maybe you want s/let/ensure/ ?

Right, that does not parse at all. I did `s/are/be/` instead.

Thanks,
Dscho
