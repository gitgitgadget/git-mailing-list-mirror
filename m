Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9CC71FEB3
	for <e@80x24.org>; Mon,  2 Jan 2017 10:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932793AbdABKkA (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 05:40:00 -0500
Received: from mout.gmx.net ([212.227.17.21]:60928 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932160AbdABKj7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 05:39:59 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MLelb-1cNj310AOB-000qdn; Mon, 02
 Jan 2017 11:39:48 +0100
Date:   Mon, 2 Jan 2017 11:39:46 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Johannes Sixt <j6t@kdbg.org>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mingw: add a regression test for pushing to UNC paths
In-Reply-To: <6d69b529-a42c-9f93-f342-7c6c19170285@kdbg.org>
Message-ID: <alpine.DEB.2.20.1701021121041.3469@virtualbox>
References: <9fb8a9f405b19db087379ea5bbad80c3fbac8e4e.1482513055.git.johannes.schindelin@gmx.de> <6d69b529-a42c-9f93-f342-7c6c19170285@kdbg.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:QIAyLxElMwoAhzEfJbFQHFFNUXqKQ980rR+jJO+YapRt6ueSffB
 ZsCbzi+73ELaREtERxIXOj/EwI+QkzG/cRnbsrduhckCXqERBK8mBrBykRQchx0w97k5RJJ
 wg9UupFQLio/BQ+ZWymS2SlTFUQvbAE/0RxjXntfXRAA0fTEnTLCY0RXuvypI5c6rz4yTxu
 zqMZV058AkfM+/kXPE8/g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zfzptUBQhUo=:kcDSa9mQDGwLyXXlz9zMAT
 iIT5TWJzFwlQ4Q1UOqzAmNPKXC1x6GD1HciPS/su7UpgXf1boj+2taZJYbb6G6mmgTX5cXS1f
 GNlLfHDZrDkJ5V37MOdMYcAHEhYBBNITNoOvoTHyXrTJ8F0LSD79rIIJiGlpDNFtXnOJbTchE
 gxfvE64q3SsOwJq/osejevtBiqNNperNfM3Y09jSvgOKw72SPKMz3GpWG86kV7A9TQJZPis3d
 sBtl2a87wLVR3neaQXFqFYmxI2EZzpmqdjVkXD5FMYkcZDmM428V/YFTwtEKUIpVc7pJv0acC
 OIeDyUOohkD0ewXxc4x/kjQ528qlfpY70fmyEM4usru8vohphrENM2ZRpQLOwqZRvJqDFeIAI
 tt9r4Ps1Hb5rYUarSiuNJyez9+IAPYSohDk36u7F0Q4Nk57HIIqvWGsrRyVrJlYQDADVAWZ6y
 Vx8WejB0mzBt8gU4YL5NTawrHMMyIyrZqevCU0i90gVaSb1tH/+v8JfQialCF7XCKBZ2IMgUN
 zwTMA348WVO/4rsTS09jO9s9Q9F3Vh60SWwRbmDq+HCCaZ6SXceCw9UzshGuVkaF0MuzsPT0j
 rMqcjhZFQuWSpgPcTSCH82Mtz35prSXTDnjBVuIXI+W+5CrAIb5pr1tGEYWvQCRHdTqR8JEZw
 ZlyENgM5DgBHkC9qtfL3G34Ffz37Eg/oJJ9H7azs2d0R8TqqiTnmMNzCfFJNgspXCplMsBRFW
 FYF67eWBDG//pk3fr7fvbLeCQOgTppS1cnVmtvsdiYzO4Ke0urUlsZOl3G4l6UPCu695DGicu
 nbogCiE3S5Q1vPz0JAXcWStrqQ/tw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Fri, 23 Dec 2016, Johannes Sixt wrote:

> Am 23.12.2016 um 18:11 schrieb Johannes Schindelin:
> 
> > +test_expect_success setup '
> > +	test_commit initial
> > +'
> > +
> > +test_expect_success clone '
> > +	git clone "file://$UNCPATH" clone
> > +'
> > +
> > +test_expect_success push '
> > +	(
> > +		cd clone &&
> > +		git checkout -b to-push &&
> > +		test_commit to-push &&
> > +		git push origin HEAD
> > +	)
> > +'
> > +
> > +test_done
> 
> Wouldn't at a minimum
> 
> test_expect_success 'check push result' '
> 	git rev-parse to-push
> '
> 
> be a good idea to make sure that the pushed commit actually arrived?

Sure.

Ciao,
Dscho
