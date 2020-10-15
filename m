Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECCEC433E7
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 19:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 149CD206E5
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 19:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="fE+qkZ+H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391804AbgJOTkJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 15:40:09 -0400
Received: from mout.gmx.net ([212.227.17.22]:35693 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391799AbgJOTkI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 15:40:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602790799;
        bh=Aw2crRGPuhiv3rvsNWD+2f4i7gfeXvTDSZnFQEQZ6Ho=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=fE+qkZ+HjHNmS+4cotKRuv4uTzCalWg3VSf9enSbuCgh7roFDdbRJ9+PR7T63Em9s
         u6nPJZe7O7e+Ek981E3AuWYdphOCUPB2JpIM5/4OCwc9ZOnErx/QrU81z17/ZdszSM
         hJfeaKm+rBCvo1v8+rkVRnZ9g6jqnIo+pu/1Q4lk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([89.1.212.47]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MOA3F-1knJUE0oZN-00OUv3; Thu, 15
 Oct 2020 21:39:59 +0200
Date:   Thu, 15 Oct 2020 21:39:57 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Patrick Steinhardt <ps@pks.im>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 05/13] reftable: utility functions
In-Reply-To: <xmqqwnzrh30f.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2010152139390.56@tvgsbejvaqbjf.bet>
References: <pull.847.git.git.1600283416.gitgitgadget@gmail.com> <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com> <4190da597e65bce072fa3c37c9410a56def4b489.1601568663.git.gitgitgadget@gmail.com> <20201002041214.GE3252492@google.com>
 <CAFQ2z_NL1UrmonMH3qLKrEkjsPjm9qTbtoeY0OHQZzkVW2t3-w@mail.gmail.com> <20201012152505.GB3740546@google.com> <20201012170527.GA21606@xps> <nycvar.QRO.7.76.6.2010131405380.50@tvgsbejvaqbjf.bet> <xmqqo8l6ku0y.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2010151346060.56@tvgsbejvaqbjf.bet> <xmqqwnzrh30f.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:zQSm+naOUqWAow0pN06SCT3qzIpUwpDpXvpy0k5TX/bIZ/CNjOC
 nx/r2bqE2KmSk5lXuWvN3zadcotnVjkUInMjZg3TAQNX2nbiF7y3XsbN2EJd3J05SV9yIEJ
 JcHJyXoN20zA6ScYs7WevMzeqQKtrDyIm5ZsxpIG/riHidl9cPcyl5mdDuBZJiUGvdw9+pg
 CL8eQLuHVF/Tjpatkeq+A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vc/HMaK6FS8=:XPmbEZFL75ICycN3gb6HnG
 z+dst89Rs9HugyDVz01Vt6cerDDSt0YFVbNc5+EHSuR2I1WZdwYClIPZHZ0t10wl0C4UYK0iT
 QNtGbVUIUlW9WXm+eFfX6qM0LCkUFoOJxSDdUydWkHgFnxX9le5bueKXOZECr3Mu8tvKwBkiR
 Vw1hg0AKhGF0v33uPTf1LRY2sQype95In39l/as6Nr7Xnfe2SXVuPubaebeX5hv4TyUHh1b2O
 fiH8twfKpaK98UDFQsV6QAEkHGIv1YVSNcEn+ywDJhixoc1QMRO0CH+uDz99A/tJNclghPr4E
 Egu1jGtDahFzGk2UxqYssmwCO3Y7wXUuwJvBM18l0A0lCuUwvhfoKwwcc6azFjsLAIHaEn6mr
 nlzkDAnApNj6pVcXeUchoETSpjCCWKeHVlAw7KiMM+X6gpYEHm4lqsPgpGKIeUASdlVnQXbBp
 CobA0u8xpboFYcZYJkBLMn7D73lrWWIcNe/XEyCCMSKswDbi5IHGIzHLhIGA71WV4jLs0Eh90
 SQd6ktdcIFvQCRhbdU+4s4O0B5fUCxgRw2cPIttMgSmMkBw7HEKq+afHZc6/Speo0nChkj616
 qVp627Vo2qMytHrowT4yKP8/w1nKWzHl8knc+LllcYK+mPdhyoACNRFPIWx8ZInodOI7jO4+u
 6yujcFt3UNqyx5xiFlRu+l+PKJ340qatQfGHV9a5tPTRSiHqfuE0CbCXtkh2Jr9oSwSRKBau9
 C2tgoVfv8yddneBAhb73Hn6o8ulFAb1oqZzexmb+qTAXF0b+MvUrcfqau+k/O4POeAVNP1QUw
 Lz+N3ZYaZrmpOve4XYnRut8i4hpsp6/p7s8MJGIv+7doCFXfO0ubCT2nI9m8Nti9AsvvzqWXQ
 TtHF2vQyOWm9mtrYXXNABnBHyFAPWfqB5yjrfsWZ4=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 15 Oct 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > Hi Junio,
> >
> > On Tue, 13 Oct 2020, Junio C Hamano wrote:
> >
> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >>
> >> > Somewhat related: I was wondering whether it would make sense for g=
it.git
> >> > to rename `strbuf` to `git_buf`? Would that make it easier to excha=
nge
> >> > code between the two projects? Or would it just be unnecessary chur=
n?
> >>
> >> To us, "git_buf" is just as descriptive as "buf" and does not say
> >> anything about the nature of 'buf' (other than apparently it was
> >> invented and widely used here).  "git_strbuf" I can understand, but
> >> why should we?
> >
> > If it makes code sharing between git.git and libgit2 easier, why shoul=
dn't
> > we ;-)
>
> I see no reasonably explanation why libgit2 is not the one who uses
> "#define strbuf git_buf" to make "sharing easier", though.

That's a fair point, thanks for bringing it up!

Ciao,
Dscho
