Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96A541F45F
	for <e@80x24.org>; Thu,  9 May 2019 18:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbfEISw2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 14:52:28 -0400
Received: from mout.gmx.net ([212.227.17.20]:39273 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727718AbfEISw1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 14:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1557427939;
        bh=x0W+2qk39w43Q+2rwdAy2rriIsS7s2Yn2DOi6iHCq10=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=bzJKwsT6iigclX/YN4iOpiCTBk54dlZM/cyRfOBNKwkz/KsdlHSUnHRCcs4KiIq3V
         cLMM8OYpaYONgcCcTCnscYIT5hsNlRQNve8u2hq/FA3FWHz9IRkrjF5E+nfB1n9rtU
         o6qhSmSEXgEADHPQ+O4KPNV2kuHkiljmGIajdDxo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MV67y-1hFLfh1J8o-00S5M0; Thu, 09
 May 2019 20:52:19 +0200
Date:   Thu, 9 May 2019 20:52:03 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Git Gadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
        chris <chris@webstech.net>
Subject: Re: Fwd: [PATCH v2 1/1] diff-highlight: Use correct /dev/null for
 UNIX and Windows
In-Reply-To: <xmqqh8a4fh68.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1905092048130.44@tvgsbejvaqbjf.bet>
References: <pull.59.git.gitgitgadget@gmail.com>        <pull.59.v2.git.gitgitgadget@gmail.com>        <bcbffa141116f869db40e4572f9824a3d090c20c.1541026721.git.gitgitgadget@gmail.com>        <CANg4QoEPWcnPpbUYcgR4PmECzjCOmroAmH2fMoX-vhw+W_dVnQ@mail.gmail.com>
 <xmqqh8a4fh68.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ncNbvsMUhnZHOTSRzzyNjOJUDT8H1KnC1dWgittoXe7LHhhpt4Z
 8B9hPKoyDX6iHErfL8Tr0xLdQaqrReoJE/jxLKqBqM+ne2VqlbeiRZgeliBcGHwp5VCKm0s
 8ziEFiaREP+nHUZMWHdvijhaBKWAoupOOvT3rg2xcM3krpDu7QArjm3Jo9rjzuJ9T+VffWe
 8AYCB9IM1ZfYqs7iL+h1A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TdRxF/vzgJg=:3zBT3KkMAhVT8HW/Wb5pbV
 4LYJAhHch2ahI1w5M2TYYnHObIdCEk+mrHVB3E3wLrHttpeWuZXiTGNWRwwHfz9gPcCY1G7xT
 Gtmvjug5NwxWhj7LTx0XYVMWyzxhAxGb3+al5GhmBftcDIZyGFC81w3E18trsl6asSfEpyzIY
 YudTMzCp/CX00/7Zlxy6MO3fmoo9rQZStxNdsyPo45k1Uso5YjgczWzlGcnca/Wo627QYUm50
 NquxmuyRDpPCf6+ugk8ZHnEqAcYk2a+/zqGOBy/8zHE/tyOvohp5MhanPyTN004ui6LcWI4Ya
 VP/negvBdDzCf6yVkTsl+yawXCxnXAn+iJ4aW33WfFV/g+M1TYAIBgxVrdkEYnovJ0XphL/gj
 F+yHiIwnB9K4KyEoE/qN293afGxjzQij7ZzHYOvmVv1sGbK7l5bS/V2WHKTBif3wapcnI/+SE
 BxCFfQJhQ5wbBFyrKBRiPAwIwZvsluAObqgZ3LAxPzh+I/nsiA87+rsXgScqXzeQ+kaDLI13v
 D/y+jzzi68o/QModX+5hKK/SXCORCNk5azT8wY3hgJCypWS8cnVrHLyf2AZc1Gr7RGBTNcuLO
 mgmFxTIIKtfEavzOj33FmifhM/iD44KqnJxpfUDVTO6C+ZwWk+4YcfiaedUruE9whYbjorXhA
 NgHuvmwL5UndpPv7+CraPG3067VYgISMm6Myrv414ChTsbFqhF6dfSGU/oCDyj3Ru2uvmJwEl
 3L6Fyt4d5DCF+wAGKdgx2dwvJrlX+w4PUPHVOUe7ZFl/kL967MYmXF0Gut4oFJIOX5LEb0qUS
 HX2tcsFhjMNTazw/d3UKucPuF6t8TtbdHLyXgqpwCgGptdw00d3ModiLFsCkuIbG2Prdp13Ee
 K6dT8dlqRb2ME+6Ry5Sjc7d6uApoXPmAz1TBLcl5NEyutjp39YhrTFh2Hu2HV5WnlifxKCv+2
 qh5IeotMkgQ==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 9 May 2019, Junio C Hamano wrote:

> Git Gadget <gitgitgadget@gmail.com> writes:
>
> > Forwarding this mail to the Git mailing list, as the original did not
> > make it there (for reasons unknown).
>
> It seems that the forwarding mechansim (if this weren't manual---I
> cannot tell) mangles whitespaces?  No need to resend, as the
> receiving end manually fixed them up.

I did send it manually, via the GMail interface (which I seem to be unable
to use effectively).

Sorry for the trouble, and thanks for fixing it up.

For the record, you could also always just fetch from the tag. The mails
GitGitGadget sends (unless I manually forward mails) are generated from
those tags, so (modulo bugs) the sent patch and the commit(s) reachable
from the published tag are identical.

In this instance, it would have been:

	git fetch https://github.com/gitgitgadget/git \
		pr-59/webstech/master-v2

Thank you,
Dscho
