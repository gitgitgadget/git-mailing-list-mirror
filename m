Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAF961F744
	for <e@80x24.org>; Thu,  7 Jul 2016 11:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756521AbcGGLQx (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 07:16:53 -0400
Received: from mout.gmx.net ([212.227.15.18]:49517 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752610AbcGGLQw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 07:16:52 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MhRI2-1aycMo2oAk-00MZXT; Thu, 07 Jul 2016 13:16:28
 +0200
Date:	Thu, 7 Jul 2016 13:16:25 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 00/17] Use merge_recursive() directly in the builtin
 am
In-Reply-To: <xmqqwpkyqwzh.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1607071313560.6426@virtualbox>
References: <cover.1467199553.git.johannes.schindelin@gmx.de> <cover.1467717729.git.johannes.schindelin@gmx.de> <xmqqwpkyqwzh.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Stx2t+iOsfVgHi7N3w9Hdxdz0y8v0r4WXoajtLUKBoAyf3OfMvv
 kesNbAPEXBYBVKkH1yAwOzLyuTTXEFS8C1+1tQ+MFFVHTRTMitGNrBk50hXI53emZ/nHQmt
 mYxst0FtSlZrZb6wtwJwWmdFZwHwDb1GA4zgLugTuBop8b9PLrCL84etia5WmSCEPd6MYBW
 sUxRLv88Ql9ACfaMLynbg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:waiDKh7Rnmk=:gWz9E45BKE1+HCrOrWRyKD
 u5frrMniD2KPLbpLDWrOhv46WlvzClHHWyOBm4BMVB+nE+GiYBXJy5H70MM1gYVuTwgq0lSkX
 3t1u/UilO8UiPbmvqEU6XzfIcxCHpE4j5HX4dMAvyJunf/SxZeLhSW/jnYXi8k/Hs8kqzE3Ys
 E7/+aHqJbuVBGsHtxnXRqgI3uc1sF8lEguxgL0og5xsdMuIp1Qgt4jPoKjXDX+1f96zcED4xI
 EaKyy3u0s5SFeGMKcDiMMfipFBpCyrccr9j4Urv01OFBDo2QzTim0/c9PYFP+7ZTtTHZ5DxJF
 38wgTxV05J70q9ykkceVERHF6b+iNCPXEXvf8wYhqkzJYjaPIZ+B2ZTUz8nj954CagOtHMCNz
 QvZSHto5Xq6hYIiklI88WmpoG0G/17OjryK/ocP0TK3Op/zBT3VRTzwjA401jzIK/Ro+f3Crf
 l2Dm5L8+U+1EWCCena3QS4h/2/ksC75fII4Oe9PIcgtT9FgzdR3Apy3mI3yeBNpU3gITH+nWW
 rWTZblGSDxZdJ4RdWmu857xgh9YWp8/c3BozDyUTtfU4tjyEIR/+WkgqYCUWu2f7882K8/Co3
 m/P9k7hJco1QkkqkfKRAXw2LiLg8NK3yao7NjqxGTMYsKsNB7+KNvdpiK0/t08s9erI4v7zvW
 Gxev1LyHL7yw5WSfqKUpwiL2RPzHPpFcn6Z85aywlcu5i6Ftb9delbTVPFiwVFx3P2L04G46T
 //FP3ZRnz3YtGq19XWiPJ1zcWpRvkOZ2VmRbgkcKVEBZJwsUq9wTYS8nO3VD71cvOhHwZryvd
 1ckT0lU
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Wed, 6 Jul 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > This is the second iteration of the long-awaited re-roll of the attempt to
> > avoid spawning merge-recursive from the builtin am and use merge_recursive()
> > directly instead.
> 
> I wanted to queue this in 'pu', but an unfortunate series that
> changes the convert_to_git() infrastructure has serious conflicts
> with the changes in this series.  I am still unsure if these
> changes cannot be done without butchering the calling convention
> of what leads to convert_to_git(), but in the meantime, this cannot
> yet be merged to 'pu'.

There is nothing butchered there. The secret to the merge conflicts is the
sha1 -> oid conversion paired with Vasco's untranslating of BUG: reports
without upcasing the "bug:" prefix.

I will rebase to `pu` and re-send.

Ciao,
Dscho
