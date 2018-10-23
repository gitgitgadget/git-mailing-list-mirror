Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B07901F453
	for <e@80x24.org>; Tue, 23 Oct 2018 08:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbeJWRQG (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 13:16:06 -0400
Received: from mout.gmx.net ([212.227.15.19]:46857 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727632AbeJWRQG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 13:16:06 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M2cYX-1fN3IY1Rp7-00sRai; Tue, 23
 Oct 2018 10:53:27 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M2cYX-1fN3IY1Rp7-00sRai; Tue, 23
 Oct 2018 10:53:27 +0200
Date:   Tue, 23 Oct 2018 10:53:28 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Ben Peart <Ben.Peart@microsoft.com>
cc:     Ben Peart <peartben@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "peff@peff.net" <peff@peff.net>,
        "sunshine@sunshineco.com" <sunshine@sunshineco.com>
Subject: RE: [PATCH v3 1/3] reset: don't compute unstaged changes after reset
 when --quiet
In-Reply-To: <MW2PR2101MB0970EF1065717A38CF581C64F4F40@MW2PR2101MB0970.namprd21.prod.outlook.com>
Message-ID: <nycvar.QRO.7.76.6.1810231052410.4546@tvgsbejvaqbjf.bet>
References: <20181017164021.15204-1-peartben@gmail.com> <20181022131828.21348-1-peartben@gmail.com> <20181022131828.21348-2-peartben@gmail.com> <nycvar.QRO.7.76.6.1810222244150.4546@tvgsbejvaqbjf.bet>
 <MW2PR2101MB0970EF1065717A38CF581C64F4F40@MW2PR2101MB0970.namprd21.prod.outlook.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:unrGrFhAYKEbPZVNrv/u6wZuueUqgAPte1IXMFgq+2yWfAVLaGz
 GBZgItPSepF1tyGA1tpxF4mDF5gFA8ZrWQUeCwGdIeqJuAluq7Bt4+4QYcCjcjD/rEAgkC9
 sbS7kKM8Wt0+fja9UfmXnnkotaua00xKZ0C3Vm/8/kaBjh0x1cQYe44U0ZyVeLrsiXGsm4T
 eNcIVcG9vwRKa7RK8+ZIw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Qz0uC3jwmFQ=:DwQ/eXoXj/6NFsi0dxLDfK
 4e21VZbXf1cGSKex3UIpz7ED0nby7qAL/pOUz9xZjNB1VwvtZjcHGbIEfmU4mGrN7P2xN7S96
 BZDk0ToskzBsckZgHYm46eaNYjusimIodtViVIyk4yd2Vs3EC7UM3tcOOR/qjS9SDbJGYXEj6
 CZmCdRqYZbOyx8Oi4VRT7vB2/bXZndhjek7o+JVmtVRGK025Mpnen3W1149hqiFmiJlnTmWWQ
 CuuAO9wcBAmTVNoTYFpQ4pNX26KBwClnNG66Y3q7JyJWbQx2uwkg7ObjTdaV0DDxax1qWzl/B
 ixLOdbLyEneL3MjQ9bpZaWEnqXO6rsk0RI412aw2dzUfgvENqejrXJ0NmqLvDcK9INHGNDLW1
 +3o//KfRxxualtuvBGj43fa8OvJmg5M8kGor3dPCsJ9xzLRYNuDZ2C/yCpQsN0ffoVQ6vTl3l
 D7pjvcb/mHtDUeoFPLb4Cg4yOZMyQyYTdssnlNjGV3Y/qF+8roZFBaMh7JrUEj/HldFUOhY/L
 oeynVI3mrpyUJ80/0GoTrL7OI8DTb34y1guEzlq2PfKHCgNovmDaobuX612Prg/KQziI4s1pp
 jLLqcu7A9BOAhv82z5q2u7SVHDfy2kYugWerW315uzLtUOPTLJH/83uaX0Wt3zpWFwparBzGS
 j1vaqbpgqh+cVX7ZZRSz7RN/yHIvQ8lB7/9/AsABGh9PjVi+fUol+vE9TK/dbf6XY7a8JWQbS
 VERYAOsmok/7GGGDThCijFSfyLPdV00agOpzCNDs6ruaSZgAxq9TyAJAkPXsKEzAHwAhAGSzl
 FykNJ3DjkRidEB3RlH559qszRQJmOv2sckUVEW8g7w7JEDbVJo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ben,

On Mon, 22 Oct 2018, Ben Peart wrote:

> > From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > 
> > On Mon, 22 Oct 2018, Ben Peart wrote:
> > 
> > > When git reset is run with the --quiet flag, don't bother finding
> > > any additional unstaged changes as they won't be output anyway.
> > > This speeds up the git reset command by avoiding having to lstat()
> > > every file looking for changes that aren't going to be reported
> > > anyway.
> > >
> > > The savings can be significant.  In a repo with 200K files "git
> > > reset" drops from 7.16 seconds to 0.32 seconds for a savings of 96%.
> > 
> > That's very nice!
> > 
> > Those numbers, just out of curiosity, are they on Windows? Or on
> > Linux?
> > 
> 
> It's safe to assume all my numbers are on Windows. :-)

Excellent. These speed-ups will really help our users.

Thanks!
Dscho
