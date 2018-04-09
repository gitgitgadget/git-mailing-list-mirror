Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD9D41F424
	for <e@80x24.org>; Mon,  9 Apr 2018 07:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751886AbeDIHgy (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 03:36:54 -0400
Received: from mout.gmx.net ([212.227.15.18]:37645 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751416AbeDIHgx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 03:36:53 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LrNE4-1eMa2f0eHk-0136Wy; Mon, 09
 Apr 2018 09:36:41 +0200
Date:   Mon, 9 Apr 2018 09:36:41 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>, Phil Haack <haacked@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH v2 09/15] config: avoid using the global variable
 `store`
In-Reply-To: <20180406212351.GB7870@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1804090936260.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1522336130.git.johannes.schindelin@gmx.de> <cover.1522772789.git.johannes.schindelin@gmx.de> <a9689c880f9226c236aec58f8036740ff39efbb8.1522772789.git.johannes.schindelin@gmx.de> <20180406212351.GB7870@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:lnigv5ZlCB+N03TSXSSrc1+h7nO/A+6DJXfShaACRbz5+quxGdT
 HBC2UaRfKbpYZJn13cEBAmgWpkqtLy5QSaiQYdxNxKcAi6cLcrqkQM7sXQHbK2JVjiGvLn5
 bRFYl0Nz8xJoiQtk7E6u7iJq57CymLiwss78kmfFz7gGAfvaqx9c48xObneAmanM+pMEubu
 m/LqlPobeKCh4E416HhXg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NmzPKOmLJZI=:PLgXsgLZ1QDoeul5Dkr2Sa
 FkPCf533KoyaY8n80NzULhr90wwjQdXaohw3vGYw/VfClTAfhZgQaIMjx8WS2HNK1oJi1iDFr
 gH09gUe6x85y/AkLRpU8WLJfHhUr5ZLo/ig6MP4kwXTM1fn6Y3pHZbl1gAD/Zm/q4OUdvGcnl
 jdXDO+MMjTojlrfqHs2ZhRs8W49mqzUkoPv8aVjTp1FSKX9fCRGNzgqYaSjibAhXniOqFmIU8
 +1l9ET8x6Z2JbJSTLx9TxHhybVQoNlMNmoW0k0/NFo8/nnw8pwnmrT+0q/wb4Q01woCpBg71c
 I1tRBjXsyzKrcPcfw1gI8afWOBRUv7zajssacsFazeolS6gehBR5ygE7Hd29MaU72c9E9VNxU
 kg3iHwTO1y+beAAb//mTII2YzOWD8+uIoyKL3GuvXALyK1MyNHYxbTCF7Gq1HrEHzW6Gd3cRa
 FXYOI62joTvsLMdjtC6goKLCMg0wo/z3G+9Y37km0dldSPpd5BCQ6TGVbfiojlOkqEu2goenW
 +bhQNdY5sLbbQJTdXlOkPk3Yg6+0syJKURcbUEdpHx7YTlecqEfWqRlXYJ6GLJPF8nTDr6UPq
 jpwTAdGPfaKdT80GbnkS0Es7J3YmJoRxKKaSj/lKx6iMyPGfQrYWLZv2coPgOet6jac4qU4xr
 d7v6kL12s74YmiPpc5K6q/5qwwYmfTquvgIOF//IahSnwfVTjTM/e49WRte0ozKSRsPXcL0Ib
 swe0lOrv1SDDTHA7rHjAvFdlCPDjcyJL1UcJejEMhXYaOEBtkvzMDIK2nIl4bG9WRfzyWFfij
 R3kTnbnWEQsE2QjjIekxgQuO8a7nXBYuu3xRie1jmIKyJ/7HB0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 6 Apr 2018, Jeff King wrote:

> On Tue, Apr 03, 2018 at 06:28:34PM +0200, Johannes Schindelin wrote:
> 
> > -static struct {
> > +struct config_set_store {
> 
> This made me think of the existing "configset", which is quite a
> different thing. Maybe just "config_store_data" or something would clash
> less.

Sure,
Dscho
