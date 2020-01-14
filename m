Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACF9C33C9E
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 21:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B3724658
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 21:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="enFRXQdJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbgANV7E (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 16:59:04 -0500
Received: from mout.gmx.net ([212.227.15.18]:43503 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728791AbgANV7E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jan 2020 16:59:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579039138;
        bh=QtVcbNPN0g3by7g9S3kIqwV0VjhQtwHBHkAF+jvFCLA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=enFRXQdJmreaOKrcn+QPNm618uelSlm0TSleE1JsFJogD3Z6az0pFpxgsztA9OOHp
         9wKBZqDxVK/XuUQfxJcO1uT6TPVeLEZYhGunVgQ6KPOngcj2cLg7iyzv5hypCxcRfJ
         Gh4VDaX+kiwKSzq5MFm1EpvppdH6YF8Idh5TLcnY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5wPh-1ikaSn32HD-007RXB; Tue, 14
 Jan 2020 22:58:58 +0100
Date:   Tue, 14 Jan 2020 22:58:58 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Denton Liu <liu.denton@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.25.0
In-Reply-To: <20200114024938.GA17003@generichostname>
Message-ID: <nycvar.QRO.7.76.6.2001142258130.46@tvgsbejvaqbjf.bet>
References: <xmqqtv4zjgv5.fsf@gitster-ct.c.googlers.com> <20200114024938.GA17003@generichostname>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:BdCmcsF3GDNfUddt/u8EVluJszvLegvCw86yttiArrK9DTI/LqX
 rG+X5F2il1kHrwMVyKv7DWijevQfenXn7gZYz/LCrC+eRwqD7x3qebc4iJAbWBbfPa3QrOz
 EIWv/D4ylbcS4z50vobwYU+dVkalo6mdN1Ixl924dTw9SRqHHqCknE6OFY4zzWzWZ4IDES1
 lEC/P84UNMZ3pWKM0hKkQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uHo8Ov6ODOE=:8p5x6amKdtLAKSVSsBumcV
 eCTFbeLuv61tgbqgO3q62wu9T9A8VTXcQF765/rV4kQFv5i2FaLy9Kvz00l3lSw4QEeO3ZMdD
 Vw0NpMpzQP8YULyV+px1WSh4QY5AQA67ZVSFrcHT7oKdmRzi+nqIXerJ78QPSNrRgmfKq/aN1
 bp+97YzONp2l1p3qcmIvWMSM+4khIYFp9qnfvLKAPs7oDk8NArM4gzWYlHcsHmIhRzIezE2pj
 NGJpGgOtrj1ezDuWuiFNPzKfe+DYaMkj2iDZRz5im2gl8D/kTn+cJEiYqTrKgjgZC3zokJtuv
 4gVmmw2+Kq88TiZNOp/hbqhRsgYP9/8SQ/joyOkdGoHq6495i5PP992q6YZNKnd+SjDbJiDyo
 ofAcdkhgb4AqUyHsDSiFNWC10ELofAqqvrwXZk88B9JwvFIraVmvKqILpdSl6v1XEtrsj/1vd
 8CM0IpGSiZqS2yS6sjCB6GelIoCtEzMPU59OiX3iQmcvRKfXrRcmfUKNAepDJ+VEPfKjqLvj8
 o3uoB6Z4Yaa9jUNzIB1jcSOLYsKw4WadX54HYhhdzchmbRJP2R5QIm9Gvx1FdYjktdou+QbB7
 2MQRFlTiXfJXPQgULxxqxTOyKTtG31ylLI3Tb/3OLvDICeyD/i1ipPqSOIcgIOl+ibkeGyn9Z
 VFdeoSvd5SCx62ZrmZkDNaJaZ6wwAwDdixt1zZPpK+oQqYLf1+H3gqU6n13TJZHMdBSJJBlNL
 id/PRijARHWtUk+dKT6G/NOszl660C0aVO9+wYMg+E0QKPHhNWy1yr3bKUcdf0fzaQbVRPoaJ
 /Sp0GBlhSfeuE0LV6Chzg0Cxv6KqPcOeOgiVo5Rr9pHWBH5T8HSKjvMHcsXyn97XUjWxk8HNa
 0LTxmVeWZ8zVMPTpHgdpcxEoYyFcoK0EFJDdsfREbV6qoQTTtfTTKUtWc3V0j+NvYMgC6MXWt
 fr05os5aI57lMuodLqawA4f7mqS/F3IQLLCF9M+6pjhor7nVPVj4csYGBpjmlB3oqdSAD1x0t
 7B1xM6Z1+HB8eTY8F39GgqExENizd7uJxjjrOqk3Ap/RkkK6KoOb2FXu+Y7XgehPfBZKC7QWd
 B8sWt4P/uGjT9JSmnIuBt2FFZ72g3RiU+/iU7LfSL8cDxbij7JgOwltHbFjdMeG3z1C8EgibO
 1gusA6QSPpzoaz8ipDMoUiT7Ul3S7lUassP9h5ERuJ/gBtQtGJ9TrlmHnj67h1nWiEDAYjT8i
 1H4l2VU34Jj30T4+KQF5WhEsHr7CHIoepwCK0dnsMliXfn1II9ZF7Q4acCDk=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 13 Jan 2020, Denton Liu wrote:

> Subject: [PATCH] .mailmap: fix erroneous authorship for Johannes Schinde=
lin
>
> In 49e268e23e (mingw: safeguard better against backslashes in file
> names, 2020-01-09), the commit author is listed as
> "Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>", which
> is erroneous. Fix the authorship by mapping the erroneous authorship to
> his canonical authorship information.

Please note that 4c6c7971e0e42f0f1ce7e9472bc3aec8e0c96650 unfortunately
has the same problem (albeit with Stolee as author), and it already made
it into `next`.

Ciao,
Dscho
