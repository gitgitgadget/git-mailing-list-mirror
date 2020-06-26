Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB4CC433DF
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 16:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 862F82075D
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 16:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ZLCzeAgZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgFZQFj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 12:05:39 -0400
Received: from sonic306-20.consmr.mail.ir2.yahoo.com ([77.238.176.206]:35294
        "EHLO sonic306-20.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725807AbgFZQFj (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 26 Jun 2020 12:05:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1593187537; bh=IvBw+JfYFHhkZcOjWbi4KH6NnzqqPc/63wdjPBSnWsI=; h=Date:From:Reply-To:To:Cc:Subject:References:From:Subject; b=ZLCzeAgZ1ZP2yzzO5T1eIEc81viWGgt/+PR5lw+zfb/O8vA5OiH+r2iRb7Y/cMHETA61M5M1SuThI04V3o04jyX63yyEngKDwBfBnsmT764Xtm+qV926jIgM82pTMKtYSCWwNzSK7vh7sXcJDrDi+4nZNgaG8vIsZCZbHgpvgrcXydJwEvvWFAHt/gWiZrSLEhonxK9x8nZVpAbvcKeFcWIVh8xtWfhjwoLrqH0kaT1k2LGbVB7/zjHEmW5TUjCnMV+ifqinbCRR+1TODQiQRFU/8mrkmWo4awfvswv8kcM0yif8mP0tzj5/bIBEYqSKmNN7NRAUt39h9v7btRX/iQ==
X-YMail-OSG: QvdHcg8VM1n6GXLoBBR4QKF84UScZIonsJ02p.w4caeiFeDujQVKHRYrnrfql2Y
 w.ad2nPr3fJEgQC96zSzK0NK1CSPgrcUOE_.RUTcASM0ZAW_hfylYLy7QV8mQ8lphejF35_PJjJe
 cp.HjteFndN_3lqBWbozTQG9VXM3u8U9GlRy6_BNRMVuKxS22Dg04M8vhhBX94OnXKEbMKKApqNI
 E1zHJEU1mq3m3I3Y58k0ynxlxRF4jjvaIylFUdPDQeIK11pggeIUVbNwkhjPdmfSpxPKmys25rBV
 oszhS_aoJvz3AvagvWYQlCNddg4kWDfRg7b3SDr73CVum4Lj7wmUqfnoXU1EQZqPS6Xx_NaDlvuE
 d3bhJ6dtHQMRBRwaXT9XG6neDUrcmN_83ofAskny3lw_BtJbEl8qj1TPzA0kGiqJ1Z4ZdixC0SD0
 sSe5rpMQbb9_3_7OzLDiIViLxfF6IWSh0HticDwNC8R3ajN1lWemRdviY1xKnsyTe5hlNZzdGyPm
 JX3GpJyn5OrfbqOBXYS1CRfuNcE6Jh0Im_2i4_3WU6ipeNvGPvcs0yrW5utQ13UjPhhl_0gw2ckH
 VFsXiJFDahjb6HoAuh1D6vdbW9fneTUdAQznnCabfeIsKD7WdOczrFiNnfQ19SFLdviv4Tu5tebT
 RdZ2mTMZdZsN0_bDXw0rcf9p6.AFkW8DYJpl9Ym.d.WMFCXNEO9aHmLRVH9oKraVDQAsgyw66Yvm
 Nfwaj4Mxdk8H0lLqcxbwwValgOC1iHu30teCAmjkGztq17otmIfZxiZNB0uwURd9BXjXB8FA5IF7
 rBeP589Ms2t0W5MNVYQWCHcQtdSrMMA1kF9xwE47CPuUCFL6jSAuu6MkAZvJCV6nADKWVsA_VrqT
 SyoDcb9Yb0oSaOT8MTXg1yP4IUvaa31ZWgvaC75euD34y0LNwpP9HLchLG3n46BY6NzOQIJDDwAj
 Sc_ZcJEPE_Z4Cr6JHQPa1bEmQsq_IohJtxhWazeHIGU1za5bjs4RSliC_4x2HwgapvLTgo0W4ovT
 bv0f_RDgQSgtC9CHznrVgfRAkY8j01MAHxNUmHrUDxt7rKYTblBqnd_yMPMIETTDHT2XYxHmlgQW
 3cFj4w.ycssLGRs9dcYR9gETAfd5mMEuuQhft_FtvULyviNw5JvIrdPeipPb42nPrxi__2U84oKq
 mCkEYvv4ZEywySyJxwx.3j4DVxfHmiOcS29WZeTo6GLRWlhR7dfCjJPp2b75GFD3O_Ahmtj_gAbK
 rLNGL3tQ1qGhZZZIuj_dJO80CML6kZFMvI8iShAvIGGudtv9CkZ6xqJCBPdLidg3wAcTxWE3vlrE
 N5YVHNOgCN57rCv_SDKO3DcOmMeXaUeZD_Esy_AKI_EDkA7_qWffT6RMnzV4KrSEkQT5bsHGKmhx
 GmvLsNsXyPm2NOAOo_tw-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ir2.yahoo.com with HTTP; Fri, 26 Jun 2020 16:05:37 +0000
Date:   Fri, 26 Jun 2020 16:05:34 +0000 (UTC)
From:   Hin-Tak Leung <htl10@users.sourceforge.net>
Reply-To: htl10@users.sourceforge.net
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     git@vger.kernel.org
Message-ID: <1406746652.7528852.1593187534410@mail.yahoo.com>
Subject: Re: git doing large refetches
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1406746652.7528852.1593187534410.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16138 YMailNodin Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0 Safari/605.1.15
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thursday, 25 June 2020, 19:06:16 BST, Pratyush Yadav <me@yadavpratyush.com> wrote:

> Hi,

> On 25/06/20 05:46PM, Hin-Tak Leung wrote:
> > Hi,
> > 
> > Lately I noticed that git occasionally do very large re-fetches, despite the difference between local and remote being not large. For example, here are two aborted fetches (see how small the emumerating / counting /compressing are, compared to the receiving object number):
> > 
> > $ git fetch torvalds
> > remote: Enumerating objects: 19374, done.
> > remote: Counting objects: 100% (19374/19374), done.
> > remote: Compressing objects: 100% (4016/4016), done.
> > ^Cceiving objects:  2% (161673/7478285), 80.54 MiB | 2.78 MiB/s
> > 
> > $ git fetch sound
> > remote: Enumerating objects: 52009, done.
> > remote: Counting objects: 100% (52009/52009), done.
> > remote: Compressing objects: 100% (5480/5480), done.
> > ^Cceiving objects:  1% (74819/7481898), 37.92 MiB | 1.98 MiB/s
> > 
> > I don't see any real pattern, as the last few times I fetch from either of those two are also quite small ( a few days ago).
> > 
> > $ git --version
> > git version 2.26.2

> See https://lore.kernel.org/git/20200422155047.GB91734@google.com/

> This problem shouldn't be present in v2.27.*

Thanks a lot! Glad to know it is already fixed!

Cheers,

Hin-Tak
