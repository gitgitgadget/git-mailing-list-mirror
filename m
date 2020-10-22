Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6751BC388F7
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 12:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEB4521707
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 12:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Oa752Kme"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898169AbgJVM1e (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Oct 2020 08:27:34 -0400
Received: from mout.gmx.net ([212.227.17.22]:33273 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2898151AbgJVM1e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Oct 2020 08:27:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1603369650;
        bh=Vmh2jnvzAChQ2qkP15RSxph6OTDqS3XFPAn17pv0AXw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Oa752KmeAY/AM59aekwFuZqFMuT1WMEOl47EdTpkWwkxG8rRdgwf2O0GFCXR2ICmw
         MUl8e5myqKKANEIDEta+lzB5qMYJVjXYt11hHUJHrkH4QCjf7JuGaV0kWZ+2Da8xmc
         l/5QSnAzEu7BcfhDIg/DBqJIr3rT+OCtX6GWXyMo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.45]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEUz4-1kcf5U36DK-00G5Kg; Thu, 22
 Oct 2020 14:27:30 +0200
Date:   Thu, 22 Oct 2020 14:27:31 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 04/10] t4013: prepare for the new default branch name
 "main"
In-Reply-To: <xmqqtuun43ri.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2010221425380.56@tvgsbejvaqbjf.bet>
References: <pull.758.git.1603135902.gitgitgadget@gmail.com> <baeb01f70646ce0c7564f1a1f820fb011e124d97.1603135902.git.gitgitgadget@gmail.com> <xmqqtuun43ri.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:kdr1ymnmm9IjrZoZ0GyEni9e0U3aM8+dSAr5TQYaytp9PWdbqpR
 OtAsa2AQH2aGExh8s+dTuPoJf9AJITGDJRD6EuQO/Jdnzhc7bkeR0tnGqMDBAaKKaL9+i/r
 jsWvl5hTaW36ZOTFFUnGsslW+hjOMZmtg1LSlOa7EDl0uHLQvgsyMlvyo/NO9vXECHv2iID
 4oXreAeQj2LVl4lkpsjUQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tuTvJpSgh90=:qhRRSqCU2o1YHhE55vPCcU
 49yN/63XfspNsS1QchzUpqjzsAlAhHEI+8pkZNteZ9Bj9So9a1ic2T+9Gh2gT5EVsaeDNTeF8
 unvDS1CfrLu0DTymHiJaXcwNmVRs224SzFANvL9IF9EQx0YzgfewYrjqizkQAw8mItDIo8GwU
 D4wvSXwA/uRogVKzdBycmxVdGBiDzNcdue7QUS+VeA5jATl/pr6WQO5W41Yu1d2BxKRRfjMVY
 pFYWShorhWStqhmCrbuN/hSt3T63UZfaI0yLeHUsN/DoZZhpuWZ4LI5UBOv4kz520qvwNymcB
 dnWAPrtyc7pmMaKYHWdC+L+fPd2tAPlR59/BYfj7tIGAp3UlbcmgQ60RaTUp/IQxndE+tsrbd
 dkdUPylieRFdABqt63Bg8Z1hKHEgCBtmnpvwipgUbMTgWI4E8mpGLoybTgzgl3Ry3SRVatvdb
 44BNoC+As3eqIIH1bSnYnKROEmPrjL8V+R+rDPLMeAOpXNgzjyulLTQkHCMpkTLHFPYo2bdLE
 4FHK8RV1rQZ+ON+3jO6J5j/P/9EiK/BggxBUBxa8uCUtJmTYIkDUGRMeFYP04wWtbV+FZl4Kx
 SEVznsWHrGx4IeZe+v6NL9SrwrGE5MS4Ucizt11w77MADLpcdKUGEDzblKlPC3LPSWbOhE64Z
 JWuBfIESxIG791CCfKNhn1pFJrA/8IJqUgy0T589briTyEJHCQGhbZC5ulX0A5FCuaMz9PCYF
 5HIfpTTHTpetskKmHH8BqSANSG/4opdFdf2mkPqraz203yLyyRJOvVP6zw24oYoJ/SJtbq5q6
 s3ueE8aae7xy7XzQp9aeXLHWFJNBlCB/pPwmtx6QIriUbnNohcAZeh6JLRp8BduzdKrV0xrTo
 TUTPapiJZXPT8qO9pAytrLCRLzm+i7bzBzPvhJjLc=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 21 Oct 2020, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > This patch is a bit involved, mainly because the default branch name i=
s
> > not only hard-coded in the script `t4013-diff-various.sh` itself, and
> > not only in the support files in `t/t4013/`, but also in the _file
> > names_ in `t/t4013/`.
>
> There are some stuff in flight; let's hold this step before they
> graduate to avoid clashing.

Fair enough. I described the commands I ran to bring this patch about, and
I can just as easily run the same commands once the dust settled a bit.

Thanks,
Dscho
