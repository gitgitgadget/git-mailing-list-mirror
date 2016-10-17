Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97A041F4F8
	for <e@80x24.org>; Mon, 17 Oct 2016 15:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757005AbcJQPLV convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 17 Oct 2016 11:11:21 -0400
Received: from mxo1.dft.dmz.twosigma.com ([208.77.212.183]:59560 "EHLO
        mxo1.dft.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755177AbcJQPLT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 11:11:19 -0400
Received: from localhost (localhost [127.0.0.1])
        by mxo1.dft.dmz.twosigma.com (Postfix) with ESMTP id F0700100034;
        Mon, 17 Oct 2016 15:11:17 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo1.dft.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo1.dft.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tNMhwUKQ2rpL; Mon, 17 Oct 2016 15:11:17 +0000 (GMT)
Received: from exmbdft6.ad.twosigma.com (exmbdft6.ad.twosigma.com [172.22.1.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo1.dft.dmz.twosigma.com (Postfix) with ESMTPS id E06D380035;
        Mon, 17 Oct 2016 15:11:17 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft6.ad.twosigma.com (172.22.1.5) with Microsoft SMTP Server (TLS) id
 15.0.1156.6; Mon, 17 Oct 2016 15:11:17 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::9966:e831:c693:7cef]) by
 exmbdft7.ad.twosigma.com ([fe80::9966:e831:c693:7cef%17]) with mapi id
 15.00.1156.000; Mon, 17 Oct 2016 15:11:17 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     'Heiko Voigt' <hvoigt@hvoigt.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Uninitialized submodules as symlinks
Thread-Topic: Uninitialized submodules as symlinks
Thread-Index: AdIgxgX2aZUXw1O6SWms0VMYgKmgtQEpkO2AAMbM/NA=
Date:   Mon, 17 Oct 2016 15:11:17 +0000
Message-ID: <a50ecef48329481b8c2aa7c0c7d78946@exmbdft7.ad.twosigma.com>
References: <fd5bcf57f92944c0b7f6f2f8342c342c@exmbdft7.ad.twosigma.com>
 <20161013161017.GC29710@book.hvoigt.net>
In-Reply-To: <20161013161017.GC29710@book.hvoigt.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.60.10]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> -----Original Message-----
> From: Heiko Voigt [mailto:hvoigt@hvoigt.net]
> Sent: Thursday, October 13, 2016 12:10 PM
> To: David Turner
> Cc: git@vger.kernel.org
> Subject: Re: Uninitialized submodules as symlinks
> 
> On Fri, Oct 07, 2016 at 06:17:05PM +0000, David Turner wrote:
> > Presently, uninitialized submodules are materialized in the working
> > tree as empty directories.  We would like to consider having them be
> > symlinks.  Specifically, we'd like them to be symlinks into a FUSE
> > filesystem which retrieves files on demand.
> 
> How about portability? This feature would only work on Unix like operating
> systems. You have to be careful to not break Windows since they do not
> have symlinks.

Windows doesn't support FUSE either IIRC.  Since this would be an alternate mode of operation, Windows would still work fine on the old model.
