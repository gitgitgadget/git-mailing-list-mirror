Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CB8D2098B
	for <e@80x24.org>; Tue, 18 Oct 2016 11:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755967AbcJRLxz (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Oct 2016 07:53:55 -0400
Received: from mout.gmx.net ([212.227.17.20]:50313 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752128AbcJRLxx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2016 07:53:53 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LlGoc-1cU9Lf1BYc-00b1pi; Tue, 18 Oct 2016 13:53:25
 +0200
Date:   Tue, 18 Oct 2016 13:53:10 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 16/25] sequencer: support amending commits
In-Reply-To: <xmqqinsqx54y.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1610181352010.197091@virtualbox>
References: <cover.1473590966.git.johannes.schindelin@gmx.de> <cover.1476120229.git.johannes.schindelin@gmx.de> <ec146dc2f3a3698bd433bbec4d7ecbab762c1bfb.1476120229.git.johannes.schindelin@gmx.de> <xmqqinsqx54y.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:dlGKZ5tCbXCr7A7Ttw9mGCY7EWNEDmVNiPoztkeWxhVBxC932dQ
 efJNpXTq0GCYKgt//viCRITE6CJobV+UurZ/X8EiQ/+mEOMO72nQmBXI/M2C9usHf813U0x
 bzCGyKIi0vPg3fq5bfSoGI/ZmgFxS5eTmfok9NyU8OzNC2uLeQ/N+ETw3ALReuDU4GMSfgw
 ZLXl4HRwoG2IARgILcmmg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eES3dMS5VHg=:FSQoYpHRxgGfcOujI9tKUN
 lj8oX3LOTpKsHhXjoSotGh2ZhYT78VQ2vOqq6owX7JyumZqu215Xb2HSTDiTCc7c7e+j5DeGy
 JIn4Do4+OGSkxNM5hxfZQTARzmzSpU+PKsXeO98y/qEE8Z5RuGw92H5RLrHx4ZSmT2P+QEX87
 uTeEyipZSXOttvhHhTAmPMUHm+LIJ7HA6+4ba28LqJHKS1OXLjJbe5csFmR1LZPHNP5fxO+Sq
 tThAto93o8bf1jZXNZ6bU9mLmwm4PkAOj5e5aaPOENX30kYQU2cIs/eyQ+kRrh243bAH8RANb
 VIONxhJVvArtSjoYt0cs3p4XcK6/+2tDjsaIIVfwHYX9yhRxlCy26dHjC2NrlB8FY3NKtktYE
 eaZ2sG30WQvK/HB0HDr9GG+luy+mrK1gRL4Fp6uF8cZcqt6C+62xf4iIR01byd2JC8Z2f9xAh
 ntVyopW4TLJyvilPhtv4MMW5UipN50OFOD5/dmX7UH0dsDVbm8YqQ00ZWGXFF7S1iKWJjR1ut
 nkKOdRHjaRPXmHW5SLf+t6mmEpZJa/08h+2UpG7ITVGev7rtdTYNC0Qo5i+79CiuX+4VIfwPV
 P0SYR+RrcoWyfsYyp6sp9dBcOJp51wDaJpI/UBRSNj5f0ir8vKulCIBtTrL/Inj1+ZEdRNrmR
 vVlGbWE1BTUGE07yGtjHEZ1l/F+TQXryV3I9o7obhzSNwRba55NuvIPbxb57LZ3JPkLwFgJnY
 9aJ+vNP9ZWHWA0uQJTEbWzWnMFOyNPJD7EiPFoefEJtK3EHX/LD4q2h2dYz82h+hY+Zz1bBow
 cCnGeB/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 17 Oct 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > This teaches the run_git_commit() function to take an argument that will
> > allow us to implement "todo" commands that need to amend the commit
> > messages ("fixup", "squash" and "reword").
> 
> Likewise to 15/25, i.e. Good, though the growth by these two steps
> starts to make me wonder if these three options should be crammed
> into an unsigned "flags" bitword.

After looking at the diff with the added complications of ORing and ANDing
the flags, I'd much rather prefer to stay with the three flags being kept
separately. It's not like we need to save bits, but we need to preserve
readability as much as possible, I'd wager.

> I see you have v4, so I'll ignore the remainder of this stale round
> and start reading that updated one instead.

Thanks,
Dscho
