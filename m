Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0641C64E7B
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 14:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2842220758
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 14:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="WRd+AzzY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730590AbgLAOZm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 09:25:42 -0500
Received: from mout.gmx.net ([212.227.17.21]:60281 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729248AbgLAOZl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 09:25:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606832643;
        bh=/kMTEoes8amlCstjPLXFKNjNgk38wIjPhI3UGR2d6rE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=WRd+AzzYHpDCBTJ5hKQMc8Sq1qKNC0IbzLaXigWQGFtUTUU3tgxAt/8IN5WyaCOGp
         uJyNOfdbff9/Ya1avNCtUWHKlJ+FMNnopcRNbWE1XziirUTHjtgSe3R+f4wcxJavi1
         x5weJQm19CIJ31iUrJJhUNzhrn2ps2i8kHeYR/+k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.88.62] ([213.196.213.207]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4hzj-1k0q9c1qjv-011hKa; Tue, 01
 Dec 2020 15:24:03 +0100
Date:   Tue, 1 Dec 2020 15:24:01 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 6/6] fixup! reftable: rest of library
In-Reply-To: <X8Ya24TJd87hRq7H@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2012011519340.54@tvgsbejvaqbjf.bet>
References: <pull.801.git.1606545878.gitgitgadget@gmail.com> <ded8d502d97d3d48dc0e4397b6153f4b06fa319b.1606545878.git.gitgitgadget@gmail.com> <X8Ya24TJd87hRq7H@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:2cjCEtGfkBdsE1EyzrNXueudvrFWFvLIrj7rICXb0FKUNHAWQbs
 8xIG9ZAzl/+Wkegrd7tJCu1LUQtUNQEePirFawNEnOlyUC3IGvSLLcZBaWXw0wZUUKKjce1
 oq+xsVt6ztamUhBfMobZQR1iOylI9fyQrRw1UFDzEhKuJD68aTFrkOQF1k6cAglhzYlRONa
 4qwleWAzJ16mEA/iYIsRw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/fCpQZd2JDk=:bop7TGXw54a/SeshfZbbTC
 PBMyGLxif8AKULr2Dct0ZMbsco6c5AHfwbla5UWVUyCfeaeMgqIEpF01gmoyQsYgxZEwiHu5v
 s9ns3YXa6rezVxeky55/+KcSEQAOqVBpkaaYz+jh5Io1jRCPQvdtFplGC13Ep7cUlYiqFFNiU
 OVDvseeWpIWH0N23QOhWqF6iMRiGoZfifo4YfiRvSSg9oDjyyBG7/wNf6mdpwVrtZaAT08Y4H
 nzjjZvsAMCrapPX4FzpqR/uQXaVQGrzdSM3uI3tO2BEjDDLI/bncOpOFee3Uu2AmYwgHIVNzO
 Dp3A3exvWEf3hPKjpmiZnpBZv1jC6WA6dXDsdHzTEMlEfXfC05KV6XQqn6ADOHvYHFaAuNebb
 n1G1nxjHq2lpt0rsQpXOEMvEVBce0ERxkPjCzp0thhJ1+9qXcm8Ujxyu8+zds4bPOlU67zoB6
 aqMhchVV2s9VL73JvlUiSlZAsySGI7DWSa+UkKc2CZSzCKzjvL2m5N2gZfuobGiPM7NA3x3Y/
 qxVmAokPvkU9Q5V1xJ5Tx0E9lU/8LuFFSJEbFSK+ed3Ge4V6UpKH/L2FTfewyKfcK2wrNqG3+
 ErWjuz1W21TVvAMlbt12ZSPwGsz18lPWQIOkJNTpTRacKpeG61bzAF54KBzDv9qnk1DZV/xwe
 j+frFxbnNqztBbVGtIaNZ8EHBTI6y0pHsSakaWQzt4fNV4aai4+L2MU0cDZI8FuhZJhy2Icrj
 oO+7MggLs9nrDlBsT3MDHjAifB7XlILA0YLnvVy1yQLgv/akZ3Vpbw+o48OoN3mXUxY3h6MNy
 Jxqn1pagIR2BUqAA/lTJ5WqafteJDFghgG8lMwwySpYTbvDqmzZ2vl7y0V6bZfpsg674SKsko
 GJqbMOKokhrYHv3C6byh4RpTMQEe64LUhgQY1c0lo=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 1 Dec 2020, Jeff King wrote:

> On Sat, Nov 28, 2020 at 06:44:38AM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > The stack_test hard-codes `/tmp/`. That is a particular problem on
> > Windows where the temp directory is never at that location.
> >
> > Let's not do that, but instead use `TMPDIR` as we do in similar
> > scenarios in the rest of Git's source code.
>
> Yeah, I noticed this, as well. This seems like a good band-aid, but it
> would probably be nice if the test tool was able to write into a
> specified directory (or even just the current directory).

You can force it to do that by setting `TMPDIR` to the path of the current
directory...

> I don't see it being invoked anywhere,

It is invoked in `t/t0032-reftable-unittest.sh`:
https://github.com/dscho/git/blob/reftable-on-windows/t/t0032-reftable-uni=
ttest.sh

> but presumably if we were to add support to our test suite, we'd have a
> script which invokes it within a scratch directory.

I agree that it would make most sense for t0032 to prefix the call to
`test-tool` with `TMPDIR=3D$PWD`.

Ciao,
Dscho
