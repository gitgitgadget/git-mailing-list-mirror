Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4A8C47254
	for <git@archiver.kernel.org>; Tue,  5 May 2020 15:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E5DC2073B
	for <git@archiver.kernel.org>; Tue,  5 May 2020 15:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="EfDm5UtK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729877AbgEEPDf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 11:03:35 -0400
Received: from mout.gmx.net ([212.227.15.19]:52507 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729654AbgEEPDe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 11:03:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588691007;
        bh=aoGom1H5XBrpToA+MetvRdQivzO+EIrgJDaxrLUmIEc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=EfDm5UtKf/QjoFdNcXfBsA5tA5D1Y6Bxxa3NfatjKglZIjI0K1CBHn7Y83JtCIoBk
         EvxXHroL7HWfSjohVxsRRdksQF70osyWxZwFmugOw1uH1nxRoDnk0OSIxDhROXYSHb
         FB/URQsHtHI0V2C4dX0HfmS+KS3NVbnR271eb8no=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.224.161] ([89.1.215.30]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MxDkw-1jC8xj2T60-00xZgA; Tue, 05
 May 2020 17:03:27 +0200
Date:   Tue, 5 May 2020 10:02:33 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 0/6] Minimal patch series to fix the CI runs of
 hn/reftable
In-Reply-To: <xmqq8si7ithq.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2005051000360.56@tvgsbejvaqbjf.bet>
References: <pull.623.git.1588599086.gitgitgadget@gmail.com> <xmqq8si7ithq.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:o3xn6DPpOFXtRBTRCnwUwFea0SCI6WzOsauZ7gFlCEZfX1rWjZt
 YxAPVmB+d7fZCYJrxArYRE+urUZHSTByiuiCqwJsm8DQuRuzrlEmSwIrJXeH4mXeCA0yQNL
 FM8HVmuNAZ09ZRHisrqXGokY4hlaAItiOfZKa+aqF3KEKueYfbV99lYrS0dN1Lolauf69i0
 vtxOJOIgxEOw94t/PG/KQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/40JI6PGcFo=:vpHwdWKLvm6KcncbEbt6QU
 hlk6llq/hSk1N/PJ3/EkhJF32b1OVHCzQFvJMP46/gBzcUAwUS8bUk732BoVxiTUpbBX9JMVq
 5ClFcyvkgm7m3CHJgJc9CbCk7l3V2/Fxv68XpGpTWirdgwNDuz6jbwpRvherdEmY5vIwu9A5J
 glXFifd2k6Kf3FeV5elXCPLb1SpoBxlA1e80Q2RQuTRKBFN/gocR72r+65jX1TfnrNE0rqbT3
 FGrvbkREWVqN2iGOMS4wSHHUgs39QRV6CaCZ238gXTaa2lvvB1hfPg46oQvb4j9n2OVPJ9pbx
 AZpHWlGol1NIx7qdHAz+YBbf3khcPPgN+Cb+csxP0TBsF+5I/3cygAkkb1vtRzdOH8irANflh
 do8BWe1ptkCbHOR+XD4vSf+ySHMWxdH6Wms6qR0AsQMlwZu9aiB/LPpdTIVN1Q3Vnuk+9e6LE
 8SjhK+AFY+Pt+PtpOW2F+93pbvftOMD+OLqgGc5wwzVsleF+vtYst3wLPNj2l2C9b5SbrdqY2
 FwjYSSh7Fpqg0Kra9W+W7W7fU4xB6xUWT/j1/ZmzAg7yGLgX0fcPqeg8OMFyFFK9CHHLBQwP7
 ufTh7puTKHVK4nCrjop6hIJX14t7wa0b0DGVFtAeKro2yRND5ng7yzuECbswVBDYnJ5odmkXp
 kqTPUS5xPA11tZnIgO8iuuRdU1AEyz2M/rwbh/R9tuqzO3OiJOIYZF6mj10GFycYAnhTH5pLs
 j3A9R8LbbNQ1Fgcu7FzffGEDCUGRz1lL3V7W7b4xOfNaNGiUOMaRe8yGj5uxrey6X7sJhvBCv
 +xkEBIJA6FtLRhz3qXhHtrSh48rNG+iFM9SMfu7+5RJ6Jn405WWQ6czhv2xWavVumwwCuiHlg
 e/YTsGLmq9dALjbvGZ6upZxAqZk7J43c/habckUBzM3JiJEi9h9lwsFJqazXolcHKtpISC1Q5
 j6EmmV+V7Q8+Lmy6byHf7QVkLi+BmHn0JXzaH60mLm9Lxd9yiy3DTxNiLoS7IKF4dLKHYhphr
 xkU95M9z+FTCID9Nllhi86bdMjo5DVN1eEGDh/GusNRNZuNghMlpVq730OjDAD7jtHKD0RWCU
 TPXGRGL+wapCYzFqsegX/nZi/aOSQ9MyC17lM+VA7KifV4idt0/uOkaXI/0fFMBUsLotA/UmB
 +Z9LCqjetPX3mW39jfw5cYU8s29oiMG5msN1axKqcm6310O87xuoI0eXOi0xt4qf8TRaa4EcD
 MtrSyj4RQlvTgt0wE
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 4 May 2020, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > These patches are not intended to be complete, not by any stretch of
> > imagination. They are just enough to get the CI run to pass, even in
> > the Windows-specific parts.
>
> Thanks.

You're welcome!

> Now I know at least somebody has been paying attention to call for help
> in the past few issues of the "What's cooking" report ;-)

Yes, I saw those requests for assistance, and I would have gladly jumped
in earlier, if my time had allowed.

Let's see whether my efforts bear fruit...

Ciao,
Dscho
