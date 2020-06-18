Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EB9C433E0
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 13:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A71592073E
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 13:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="dDx3XGOh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbgFRNPu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 09:15:50 -0400
Received: from mout.gmx.net ([212.227.15.15]:35785 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728632AbgFRNPs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 09:15:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592486135;
        bh=2qS4lNSdUn4pBfFp2yt8+F6VJF3RlpOu4zwDMHd7AMo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=dDx3XGOh6c9QArDyHzNyWcXrjNQ7VozD96q2vGtEa4HzitaJXNCxueQtC8SHtKbB0
         yMCqpBrij/jrW86kIMs8+viid5FbT1NiKXcHrM7R0mWLqGf1RcHRSdvCevzp0QxCzL
         tJwLFCah3t8s96eokysQIAAK73sGcCWGX57x9iIY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.227.237] ([89.1.212.49]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2wL0-1jknvf2XyG-003Q48; Thu, 18
 Jun 2020 15:15:35 +0200
Date:   Thu, 18 Jun 2020 15:15:34 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        sandals@crustytoothpaste.net, Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 02/12] fmt-merge-msg: introduce a way to override the
 main branch name
In-Reply-To: <xmqqeeqdv9e8.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2006181514430.54@tvgsbejvaqbjf.bet>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com> <pull.656.v2.git.1592225416.gitgitgadget@gmail.com> <f4d547391537e5c3b0b4a07adb41b6aa56541fc3.1592225416.git.gitgitgadget@gmail.com> <20200616130456.GF666057@coredump.intra.peff.net>
 <xmqqeeqdv9e8.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:b2IQ7S8JGmv+8bNcnBlXe27htQ8d+YzC/mVaMisKE13Y7lSVD5d
 kB/aIuXP5wfhvGSGjY64V1RDEauE9X03rpHT/0ZuiY5XSHmEujYzqgKPPStxogTmJ84la1v
 3bMeFCGS0t227wPBJXpF//scYnaZ33XphYZDQlRdX4hfojyoa3WS4ujfhAZPUmenwMns+87
 ktOkMIIAmbksxENvdBWiA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2yQnuRFMDSk=:YgXtPz2e9jtCIEQ0CQb+G8
 jS7tG6kRksqSdaGAqkeciQR8X2hYr1y8/hyYBgj5bkJPVCebbsRU4xXjTI8SsCK/97Jjp4svK
 icCnVLiVDYj5fBAgdfy7ZN04IjtoqdYKwi/lHmxMvIR+PIMwcF32U4clWbMRdORQ1UObrMGjt
 XxHHAAMBcn2D9RNIg9R0ZhQyZHDP0ReX2bMmPwzmJu+P60KvfJFk/h5FTXVzWeBDKmcu1ez2b
 f2agjwVrBsffUotMog1kyz9N/JvAODGj9TEqwiCyrbj9Qp1MDUW1gkKseCflSBa6RfchuMLhI
 Q09nAqAFzkcV9zYBRIICJnc5DB5R0ed7jgty43/UoIlhtbOWQx7NOfZU4Rky2emmc0MmQkkP8
 N8UB+kr7lvPLlYzvLJtAZGCEskPd+kHBg8bcHFw54NL2ryRHAD6tc5IFQT3onr/swa/jp79L2
 Kf6RM75YlY6vEgylBaLb3Eg9mkJjdrBdmcVwJDMx4HoPGQBjSSEilHyTGknAkzoO1vPRnM0ud
 jwZ0EbO7XKpjagbnHqCeCfZQBywphbEOoeNEvy/xN8BGDW7aPZrD6zHYvPu35d6i5g2pOKpAP
 Xoav45BfBFoH5eDD7qFBNTFK/0eUFREQp1fCUZRrB2gCgLdmanUfyaEQWGQuQeglgHRh0FW7a
 XjB2zjiS2lIePX6YYxbyra8TxKAdOmHy8oTvBJEHIi8jIKu6cZ1sN5kmyKF1ZxVYC33vMYlUN
 dA8oad3cYn0mvSkLcUId5MUUP8KjKISqTBERqOVkSp/kcZbIKdo4Uz39+ytfS0gJLMZ5kDG9f
 kUm4EGBM+hNgNeGxNFjSjUrVcjxuuwz3jSiwnw65pxcXuCLOQDJU0JxtwXvi4oVmOzm+RXM50
 FWEU3wBQjOHpXhRiPQYctq7SaQZU4eRXMWel3pGP/1pFMactUGaF41ra6kILEPZjcoddHKi3o
 8qfhIzRonLXiKbZ+dSnZ1acyZw/3wieZLgFGz5fNtgqWtm7VjMxuk3C6fLWBThdSr70c5gXUZ
 V/57ys5r+ekR9W193QjO9GQsTbXIsKAd/h/Jw6haeTrVlP4111XoYnGRt9r9/EfPicUpoC7kW
 Xs+jY2Mnevmw1x7Zz8sDO7M81u2AJAozdzDFNWmJPJe3lgEvKAhD0L0a2E8YfPT8ADJV9uHNB
 36Q7wZ4gkO8lHRjOPXEhri8M+F50W4Ab7c5Iy7LMogstQk6i381L+jiA95IIvdnK1hczKhby0
 +1mG0eFrFFg557jgI
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 17 Jun 2020, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>
> > I'm not sure if this check_refname_format() is valid, though. IIRC we'=
ve
> > had issues where "ONELEVEL" was used to check a branch name, but misse=
s
> > some cases. The more full check done by strbuf_check_branch_ref()
> > actually creates the full refname and checks that. It also catches stu=
ff
> > like refs/heads/HEAD.
>
> Yup.
>
> I actually am in favor of removing special casing of a single branch
> done by fmt-merge-msg and fast-export --anonymize, so this may not
> matter.
>
> We still need a mechanism to allow users specify the default name to
> be given to the first branch "git init" creates and used by "git clone"
> as a fallback name when it cannot infer what the other side uses, though=
.

All right, `core.mainBranch` will go, then, and `init.defaultBranch` will
stay and I will check the full ref.

Thank you for your help improving the patch series,
Dscho
