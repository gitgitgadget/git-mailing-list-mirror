Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=0.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: (qmail 10144 invoked by uid 107); 10 Mar 2009 11:39:25 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.40) with ESMTP; Tue, 10 Mar 2009 07:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624AbZCJLjR (ORCPT <rfc822;peff@peff.net>);
	Tue, 10 Mar 2009 07:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbZCJLjR
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 07:39:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:35425 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751405AbZCJLjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 07:39:16 -0400
Received: (qmail invoked by alias); 10 Mar 2009 11:39:13 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp051) with SMTP; 10 Mar 2009 12:39:13 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18L5ScXdO0L5bVT7u/0FT3JaWmcpMzmh3uDm9XqIj
	9T5WJ/YoZcvmd/
Date:	Tue, 10 Mar 2009 12:39:12 +0100 (CET)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: schindel@intel-tinevez-2-302
To:	Johannes Sixt <j.sixt@viscovery.net>
cc:	git@vger.kernel.org, gitster@pobox.com,
	Peter Harris <git@peter.is-a-geek.org>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH/RFC] recv_sideband: Band #2 always goes to stderr
In-Reply-To: <49B64C3A.50909@viscovery.net>
Message-ID: <alpine.DEB.1.00.0903101236480.14295@intel-tinevez-2-302>
References: <cover.1236639280u.git.johannes.schindelin@gmx.de> <e2b19f6c7c50e5b0a652c40b0d8e4947134ed669.1236639280u.git.johannes.schindelin@gmx.de> <49B61377.90103@viscovery.net> <49B61703.8030602@viscovery.net> <alpine.DEB.1.00.0903101153250.14295@intel-tinevez-2-302>
 <49B64ADC.2090406@viscovery.net> <49B64C3A.50909@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

FWIW GitTorrent may be implemented as part of git-daemon, if Sam's ideas 
become reality.  And then, sideband transport is _the_ means to do 
asyncrounous communication while pushing bytes.

On Tue, 10 Mar 2009, Johannes Sixt wrote:

> Johannes Sixt schrieb:
> > All data producers and data consumers *in git* use band #2 to 
> > transport error messages and progress report. GitTorrent cannot not 
> > talk to upload-pack or upload-archive and expect to get arbitrary 
> > binary data over band #2.
> > 
> > For use-cases that you have in mind in GitTorrent, the *protocol* may 
> > be a good choice, but the current implementation is definitely a 
> > special case.
> 
> And it really is: Did you notice that stuff that recv_sideband sends over
> the channel named 'err' (before my patch) has "remote: " prepended on
> every line? That's certainly not an implementation that you want if you
> send binary data over that band!

Yes, that is unfortunate, but can be fixed easily.

However, I disagree to "fix" something that is working, even if it might 
be more complicated than currently necessary.

Ciao,
Dscho

