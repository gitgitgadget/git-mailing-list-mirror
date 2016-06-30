Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C83D71F744
	for <e@80x24.org>; Thu, 30 Jun 2016 08:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbcF3Iqj (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 04:46:39 -0400
Received: from mout.gmx.net ([212.227.17.20]:57223 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751860AbcF3IqN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2016 04:46:13 -0400
Received: from virtualbox ([37.24.143.100]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Lurin-1bRRVk39SD-0108Tw; Thu, 30 Jun 2016 10:38:45
 +0200
Date:	Thu, 30 Jun 2016 10:38:44 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org
Subject: Re: [PATCH 9/9] am: make a direct call to merge_recursive
In-Reply-To: <xmqqpoqz51o8.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1606301026360.12947@virtualbox>
References: <cover.1467199553.git.johannes.schindelin@gmx.de> <dc58115e23c8d942b3ff6270b43719bc841becbb.1467199553.git.johannes.schindelin@gmx.de> <xmqqpoqz51o8.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:DhNvSj2tp6jmPvCIhJuxEtD0twZX9w/aDbpAuThOFFsYLGMEa6I
 q2rrNLngqtn2qR34qnKfV1y9nK75dS6EEwY1AT7K8E09hIO2Q6zgDyBUSe8P8dQ/yLpKHW2
 nbopb1pAgvDolTVumyEuBj4gE0PB2j9r9FuB3P9aOfBX5Mn/mUxxLPRY6D949BC+HgDPD+8
 t4gtgkGADxK9U3DtYT5Ug==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:ycq6qTWOefg=:spbjcY0pFlTLrKsG2xfms3
 TZ6QKAEdW0HbzlD2PouaQI4YjqfviAArx8mCPpel1GiwFT6y3wCftTMbKzsrWNjm1IDbRKQBe
 D9daqDJTH1KKs/TWMjxuOP7P1lwg7zYIBnvYVT/23u/YTCNO41bo2zw5sKL76NstWhlltASjA
 615eQSnrvAFIWu2RsMLMkcwkE7QUACUVl242M5m46pjV4B7AG3MGetubTh70TWIVMddWBf/b3
 3NvbA2Qnb1nvDBUvyjf1wmDsB8wLaW5AfFYPxoBLz7SSrq3MXZjrUsseIp+UnkeVp3aGp193O
 3NigGOejz2OOjafyHMCgYYCU+pfucRbeVV/uJ+EcAYU+Gmb0ZLkqk7DR7Rx6baGrxPgRLUw0C
 FXr+fVkMXsD8k3R0slTE3A8ZDsw9aptqNojw75XrbjRFm5SIinJtuBvGalRk/5T4Wq7klcLuj
 cb99C32dtRouRVg4G3fSrvqnbFNecNHqnrmMRJDVhXs1uqPOoSzGPdAU8qD6LcR51AJ20St5k
 641IcTxlbw2NUd3/zHCc5uIA/H5dDuyD43AzcEepCuRMOtDuOsmQr4o57IcLYhk5Twc1whIQ0
 bD+y0MsySLLORmScB5vHrfl0E6GG3MFbjDUhRa0uKH0uMOSyka33gqWJ/l4Z6ulEvfYicZV9Z
 CInVdNx5KhD13Wy6Tsbh1EfVYdSQsebYYvx40RAqAQWKYJWyVz/eJ6C1gaOM04GOzlTEmkaxd
 uxzyPjuBtPnbStsUy2RX/SHFFdfYlY/465eV5hhBX62TA9QyW8B5Acqal/rCbOi/OsDhhE2df
 XdOblSE
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Wed, 29 Jun 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > From: Junio C Hamano <gitster@pobox.com>
> 
> Did I write this thing?

Yes, you did. It was db05d6194d3f9ea9e64163944961d5f6e85302be as part of
pu@{2016-06-15}.

> Having two sets of numbers that illustrated that this is not really
> a useful optimization in the bigger picture looks vaguely familiar
> (e.g. $gmane/279417), but the numbers are different.

I beg to differ. While the performance improvement is not huge, even your
toy experiment shows it is significant, i.e. noticeable.

> > 	It feels *slightly* wrong to submit your own patch to review,
> > 	however, please keep in mind that
> >
> > 	1) I changed the patch (o.gently does not exist anymore, so I do
> > 	   not set it), and
> >
> > 	2) I added my own timings performed on Windows.
> 
> It probably is much less confusing if you take the authorship,
> possibly with a passing reference to whatever I wrote as the source
> of inspiration in the log message, or something.  I do not think I
> deserve a credit in this 9-patch series.

The patch is an almost verbatim copy of db05d6194, I only removed the
now-obsolete "gently" setting, is all.

That means that I feel really, really uneasy about claiming authorship
because I did not write it.

If you really want me to, I will take custody of this patch and rewrite
the commit message as well using --reset--author, of course.

Ciao,
Dscho
