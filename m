From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH 1/2] daemon: add tests
Date: Fri, 6 Jan 2012 20:48:00 +0100
Message-ID: <20120106194800.GA9301@ecki.lan>
References: <7v8vlovavj.fsf@alter.siamese.dyndns.org>
 <1325692539-26748-1-git-send-email-drizzd@aon.at>
 <7vy5tnpcuw.fsf@alter.siamese.dyndns.org>
 <20120104204017.GC27567@ecki.lan>
 <7vaa63p11t.fsf@alter.siamese.dyndns.org>
 <20120104222649.GA14727@sigill.intra.peff.net>
 <20120105000713.GA24220@ecki.lan>
 <20120105025559.GB7326@sigill.intra.peff.net>
 <20120105160612.GA27251@ecki.lan>
 <20120106155204.GA17355@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 06 20:56:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjFtp-0003K8-TQ
	for gcvg-git-2@lo.gmane.org; Fri, 06 Jan 2012 20:56:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758857Ab2AFT4V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jan 2012 14:56:21 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:25305 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756423Ab2AFT4U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jan 2012 14:56:20 -0500
X-Greylist: delayed 99707 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Jan 2012 14:56:20 EST
Received: from localhost (unknown [80.123.242.182])
	by bsmtp.bon.at (Postfix) with ESMTP id F372810012;
	Fri,  6 Jan 2012 20:54:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20120106155204.GA17355@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188044>

On Fri, Jan 06, 2012 at 10:52:04AM -0500, Jeff King wrote:
> > > 
> > >   run-command: optionally kill children on exit
> > >   https://github.com/peff/git/commit/5523d7ebf2a0386c9c61d7bfbc21375041df4989
> > 
> > Thanks, looks great. But if I add this on top (to enable this for
> > "git daemon"), then t0001 kills my entire X session. Not sure yet
> > what's going.
> 
> The fix is to move the recording of the PID up to a spot where we are
> certain that it's a real PID. Fixup patch is below, and I'll push a new
> version out to my github repo.

I have rebased Junio's cb/git-daemon-tests onto your
jk/child-cleanup and replaced the call to pkill with a regular kill
command.

On top of that, I have added two commits to fix the discussed race
condition. I also verified that the race condition actually happens
by adding an artificial delay in the daemon (this change is
obviously not included).

I pushed the new cb/git-daemon-tests to
https://github.com/drizzd/git . If you have no objections I will
post the entire series including your run-command and send-pack
patches to the list.

Clemens
