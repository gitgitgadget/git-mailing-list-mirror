Return-Path: <SRS0=XQOF=2Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4483CC2D0C2
	for <git@archiver.kernel.org>; Fri,  3 Jan 2020 19:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FD26222C3
	for <git@archiver.kernel.org>; Fri,  3 Jan 2020 19:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ZsmHhw2n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbgACTjo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jan 2020 14:39:44 -0500
Received: from mout.gmx.net ([212.227.15.19]:47743 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728488AbgACTjn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jan 2020 14:39:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578080375;
        bh=GD0kgiFIU0BsuRb0CrS7EsdCNyqGvOFKaZgqOt/hGTA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ZsmHhw2nXBopjUd+LO/lz70NIJS4SGNP5NnxCpWjWfI58xJsghaPyQhUGifq0w7P4
         Ha1tPWFZnPH3+3sflWPMoXQRMBiSrTBv0uhMCj42zYejt7sMHOhBifD4rWFiYAKOug
         5BN6XMZMFb2U8dovrf9f1PCYvooKSugcPt2KuH8s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHG8g-1j0gC72x9c-00DJgd; Fri, 03
 Jan 2020 20:39:35 +0100
Date:   Fri, 3 Jan 2020 20:39:34 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Taylor Blau <me@ttaylorr.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.25.0-rc0
In-Reply-To: <20200102221921.GA81596@syl.local>
Message-ID: <nycvar.QRO.7.76.6.2001032036420.46@tvgsbejvaqbjf.bet>
References: <xmqqblrwm65l.fsf@gitster-ct.c.googlers.com> <20200102221921.GA81596@syl.local>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:NWtGJprA2gM0xDbdk8G+1BOB+cAuZhyd0Cy2vzbH+Xsina5p2G2
 PZlgoizB9AY8Lh4eq3XQpMZGgNJydb3KuBzf+Xh5FH1ZqqUWvaDgaewaM8neuOf2bM/zF8r
 0JWt0xWjWB153em3Wjmh1JaunWc3Y8vZko03HwFalGS/t4SkCXTq076VimiNKK9HsJRtO6Q
 +5EXZfgxbRcmKBAXLqsDA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Mu144KzpGvo=:nxuPQpSXT404yr58yB7apf
 QwehEBRRs8ErKRZtCmV12pZ829ZXmSk4WbL/x6GgRx126z2lxa4/NMInIHykyvhgUFoBubqw1
 mnE6PLGoCuvTwTyhz1dP0PG5U7RGyJO5VM0srfz/s98Q+2JXtP4xeqS/Mh4iAIcK3yhBlOikp
 5oat9NKN1TEjsu1Na+1xJslqeRhlgpROTiXCfAml8fk5a4WyADB5rzTI8Kxu593aYxRVkpKv/
 jpxviA53P5yFmaEObW5V6dt/dDIa2gx2ZAnhBRnRmTbeXe2Ebkn0Fnogcsw40Vcer6+XPk44D
 oNW3CG0wJmIRORC1cVDwS74483htunezW5XqWr+V8lQaC+NcoMaGGJW9HmGx1GLEXmddb1Zrq
 PnpeF7ukl4Kr7WdwKEIg4fAOttriR94VqnRmYsnLNUbGo9LrSjaHV5XcxTlisLIUaQiCvPDgf
 Yms3H4GqjV0+fjCS9ofcZ3aFnMcn0b2UG2aFR5zwcUUHXb20g1gqp2nSLF9hg0eb9WqX2FQnZ
 aVQBwDXNWfazSiegF3dQJ4r+sHRIxSjkcViwAWtO0QTCZt6TXPbkPIIi3u4LM/LpDKPpcnSwq
 x5STyRxv7sBcac+VuiV8NuYIrH0EQFwiOB32j0fgDGe0PSrAgRUGLacBS+lv3hke0iRg1JQV2
 oW1ulF129dG418TUiPmCe0zbPQHAXo8M3McdOLNXUvoPBqqQ9fN1K+VSdjnDq1xZIFZPKxnvR
 6ITQGoE69g7Qyp2NxPL9Ui/hY+8v0DohD03eGaCe4X6hN9gdonUX+jQzzrep+4a+VpNwilBU4
 bGbkgXmDSL2rOJbr8CHe+0xI+OX8ZNwI6YJ/zhGk714v1PIzjPjHEJN2Uf8y/UO8eTW7aaHtV
 KfBIDsoHvs3lbbD3oRdLygs2KmIGu2C/jeaNFHh2YG4J93dObAPmBlHGkCcEkzr7jpodjhRx8
 lVlDzEzh9XNnP2Cku17l6RPZ/pkcldcHs2e7/v/E5ZWqQ4+sVDCBU9tvl4vTtrRv/i2gjphqB
 BVVE5JRJ18FcGl8xhrGZ5A/eiAlrVse9au5SFKdtLNNra/mOab9vgd0YvPRz5DygPZbTP0/2P
 m1FDf5at0dW4pUcI2DgK1RnIbI8Bur5MgQeFdieLwkDCVqUjwg8+yzIp9F4Iaw4nRKKhE2g1b
 GWILcBOEesSYoezfLczpNKupEaoh2Vb7CDA4M4LDCvlbADW+SB08IVhzeH4ZsaStKU3/Rn3rf
 hF/rYDeTGeUtpUDmKYxjn1QSCoxar8+UZ5dpBM+qenFXqoZv26SIDWDOov7A=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor,

On Thu, 2 Jan 2020, Taylor Blau wrote:

> On Wed, Dec 25, 2019 at 01:44:54PM -0800, Junio C Hamano wrote:
>
> >  * The beginning of rewriting "git add -i" in C.
> >
> >  [snip]
> >
> >  * The effort to reimplement "git add -i" in C continues.
>
> I noticed while preparing GitHub's blog post for 2.25 that the work to
> rewrite "git add -i" in C was mentioned twice in the performance
> improvements section.
>
> I'm not sure if this is intentional, or if this was added twice during
> the merge(s) of and f7998d9793 (Merge branch 'js/builtin-add-i',
> 2019-12-05) and 3beff388b2 (Merge branch 'js/builtin-add-i-cmds',
> 2019-12-16).

If you mention this feature in the blog post, please note that the
built-in `git add -p` is not feature-complete until the
`js/add-p-leftover-bits` branch is merged.

And if you mention the built-in add -i/-p work, could I ask you to include
a note that it is based on one of the two Outreachy projects in winter
2018/2019?

Thanks,
Dscho
