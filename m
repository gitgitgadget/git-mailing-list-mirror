From: Jeff King <peff@peff.net>
Subject: Re: valgrind patches, was Re: What's cooking in git.git (Jan 2009,
	#04; Mon, 19)
Date: Tue, 20 Jan 2009 09:19:32 -0500
Message-ID: <20090120141932.GB10688@sigill.intra.peff.net>
References: <7vbpu3r745.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901191407470.3586@pacific.mpi-cbg.de> <20090120044447.GF30714@sigill.intra.peff.net> <alpine.DEB.1.00.0901201447290.5159@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 20 15:22:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPHTn-0007C2-Oy
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 15:21:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756599AbZATOTj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 09:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756304AbZATOTi
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 09:19:38 -0500
Received: from peff.net ([208.65.91.99]:60247 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755772AbZATOTi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 09:19:38 -0500
Received: (qmail 1862 invoked by uid 107); 20 Jan 2009 14:19:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 20 Jan 2009 09:19:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Jan 2009 09:19:32 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901201447290.5159@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106475>

On Tue, Jan 20, 2009 at 02:51:49PM +0100, Johannes Schindelin wrote:

> > I think creating it inside the trash directory for each test run that 
> > wants to use valgrind makes more sense (probably as .git/valgrind, which 
> > is unlikely to hurt anything but will stay out of the way of most of the 
> > tests).
> 
> Here I disagree.  But I think that test-lib.sh should create it on-demand, 
> and it should traverse all executables in all paths listed in $PATH, 
> replacing the ones that start with "git-" ("git" itself should be the 
> first one) that are no scripts by symlinks to the valgrind script (which 
> should therefore live in t/), and those that _are_ scripts by symlinks to 
> $GIT_ROOT/$NAME.

How will you deal with race conditions between two simultaneously
running scripts? I.e., where are you going to put it?

> I'll work on it.

Great.

-Peff
