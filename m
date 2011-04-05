From: Jeff King <peff@peff.net>
Subject: Re: GSOC idea: build in scripts and cleanups
Date: Tue, 5 Apr 2011 12:52:12 -0400
Message-ID: <20110405165212.GB9965@sigill.intra.peff.net>
References: <201103260141.20798.robert.david.public@gmail.com>
 <20110328142121.GB14763@sigill.intra.peff.net>
 <201103301739.12691.trast@student.ethz.ch>
 <201104040943.10030.robert.david.public@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Robert David <robert.david.public@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 18:52:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q79UP-0004P4-Dt
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 18:52:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755138Ab1DEQwT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 12:52:19 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33807
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755028Ab1DEQwS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 12:52:18 -0400
Received: (qmail 25646 invoked by uid 107); 5 Apr 2011 16:53:01 -0000
Received: from 205.158.58.41.ptr.us.xo.net (HELO sigill.intra.peff.net) (205.158.58.41)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 05 Apr 2011 12:53:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Apr 2011 12:52:12 -0400
Content-Disposition: inline
In-Reply-To: <201104040943.10030.robert.david.public@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170887>

On Mon, Apr 04, 2011 at 09:43:09AM +0200, Robert David wrote:

> Today git code consists of the base written in C and many helper shell or PERL 
> scripts. While at a first time it is easier to write the script, final code is 
> supposed to be in C. One of these scripts is git-add--interactive.
> 
> Git-add--interactive is a helper script for git-add, which servers its options 
> -i and -p. It definitely need to be integrated in git-add.

Can you expand on "definitely" here? I.e., what are the motivations for
this change? I know what some of the arguments are, and I know how _I_
would answer the question, but I want to hear what _you_ think.

And I am not just trying to be pedantic. Understanding the motivations
for a change will help us figure out the right way to go about it, and
how to figure out if we are successful at making it.

> Interfaces
> As this is mainly part of git-add, that means that it will need to be changed 
> at the most.
> There are also another commands using this functionality now: git-am, git-
> checkout, git-rebase. 

I don't think this is right. "am" and "rebase" have interactive modes,
but the code and functionality are not shared at all with
add--interactive. But you are missing some other commands that do have
patch modes built on add--interactive.

-Peff
