Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3409E20705
	for <e@80x24.org>; Sat,  9 Jul 2016 07:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751596AbcGIH06 (ORCPT <rfc822;e@80x24.org>);
	Sat, 9 Jul 2016 03:26:58 -0400
Received: from mout.gmx.net ([212.227.17.20]:65073 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750845AbcGIH05 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jul 2016 03:26:57 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MJFBe-1bOXY22ogc-002mQB; Sat, 09 Jul 2016 09:26:48
 +0200
Date:	Sat, 9 Jul 2016 09:26:47 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Naja Melan <najamelan@autistici.org>
cc:	git@vger.kernel.org
Subject: Re: Git 2.8.1 - bug in patience diff algorithm when used with
 --ignore-space-at-eol?
In-Reply-To: <alpine.DEB.2.20.1607090823270.6426@virtualbox>
Message-ID: <alpine.DEB.2.20.1607090924490.6426@virtualbox>
References: <3153d359-2b82-d5e2-9e92-7a28bcd8bc48@autistici.org> <alpine.DEB.2.20.1607090823270.6426@virtualbox>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ici7QWtkAHOym1FW0G4F29/P0WntJxtQzN7Ykyd9DcgzwSfvT5g
 fatcDEWMiMZPiKoTusPAmm3fCHdBUuXI23H+nKpDIdGVAkHSDs9RkGubVIsNFf8XQ48BysO
 qjV65f3caMpbiEyyGyyoW7INGD9wciOzo5DEwhbVhArZW52/ntN8pIyAJbH1NSmZ8glXixV
 f8RFfJNCVBFZbdujcpjrw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:MMBCxPdQNNE=:xFUKE5IMbnf4lZfRcW8gDr
 21Vo9xILinkLaiHzyP73KvH77pZPcSB0X3Kk0VLUAKETr+GcvzvRvjCd/YoycEdhnqbjyKbFe
 Azc7EKJFzJVOLkk5lqnf9rxTjBOZY7J1vgUvpGpYepnR+9uYrGELTTgtJjYRoJUCtCUNIuSQ/
 mz4sLJqApyN0DJjYYyrmoBNfGyDNeAumSTouqkoG9FBsPtXDGqwISlOn0GpiiuIiQ55lbQSc6
 RR8bZTI+DKGfzTFenwGU8jrzUO0lJ/WDNNtF1D+ycEydpCMDnf6uR2Lz68wVG09HAAGmB/F/q
 120hiMWOXs56T/Drv03yrMCCrACPIQQ4HyJmZIeeq8BoV3Xr6BQxEBJBFkgXkhBm65ynafhuD
 KcwpE818N+PW8pJlsN9Q8OTr9lojgZSHN5mf9kf0ugbi9kMc6v0eMfdaiiS5EiUxNnWjCWQwW
 svSgkgWHKdPb11FTvrTcjasV889p/245Em19Y6IKWSNdR2TvUcBT96z7GJUScgyZEqt823OAx
 NoJND2IbSInrsgoStAVX63U3fxE+0W+E4SaaBgkbk21Z4vw6rHzO67ktf1EvOLXYaCbBY1vsi
 DWUCDroOjPhY8Mhy0/a5DdAquul0S669CV7OEisw0+hvPwaffElUiDBPneaXCpOY8b4O5jzfk
 RrT+vhs/h8TyglpXK8JKrspWxN6VrgCF0QEelJ3ojqCO6VBGDWBwdEYMyaeR1a4UNcNNCcGQm
 KFmMzTXgx8uNwj0SMsLGFcll/tK6G25ZheF3pMXVu6XQCOghmZMLmqSKyNXANj9+IbEA93UGv
 4hUgHcz
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

On Sat, 9 Jul 2016, Johannes Schindelin wrote:

> On Fri, 8 Jul 2016, Naja Melan wrote:
> 
> > When diffing with --patience and --ignore-space-at-eol, a change that
> > adds or removes just one character a the end of a line isn't picked up.
> 
> Confirmed with the current 'master'. I am on it [...]

And I fixed it:

http://thread.gmane.org/gmane.comp.version-control.git/299176/focus=299178

Ciao,
Johannes
