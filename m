From: Jeff King <peff@peff.net>
Subject: Re: GSOC idea: build in scripts and cleanups
Date: Sat, 26 Mar 2011 09:39:39 -0400
Message-ID: <20110326133939.GB2859@sigill.intra.peff.net>
References: <201103260141.20798.robert.david.public@gmail.com>
 <20110326021435.GA2352@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Robert David <robert.david.public@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 26 14:39:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3Tia-0003tw-E3
	for gcvg-git-2@lo.gmane.org; Sat, 26 Mar 2011 14:39:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751965Ab1CZNjq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Mar 2011 09:39:46 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53307
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751963Ab1CZNjq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Mar 2011 09:39:46 -0400
Received: (qmail 24002 invoked by uid 107); 26 Mar 2011 13:40:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 26 Mar 2011 09:40:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 26 Mar 2011 09:39:39 -0400
Content-Disposition: inline
In-Reply-To: <20110326021435.GA2352@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170053>

On Fri, Mar 25, 2011 at 09:14:35PM -0500, Jonathan Nieder wrote:

> > I was also thinking if there isn't PERL a better choice in rewriting shell 
> > scripts, due to planed porting (android, etc). Better than C. But I don't know 
> > android and other platform so much, so thats why I'm asking.
> 
> So far (on Windows and various Unixen) it seems that C is much easier
> to work with as far as porting goes.[2]

If I were considering cleaning up and porting add--interactive to C, I
think I would probably start with just porting the "-p" patch loop
first. I think it's the part that most people use, and most callers
don't support a generic "-i" but just the "-p" interface (e.g., you can
do "git add -i" or "git add -p", but only "git checkout -p"). And that
cuts down the size of the task somewhat.

As far as cleanup versus features, I think Thomas would have to comment
on that. He is the one who did the most work on patch-mode, and
therefore the one who most thinks it needs cleaned up. :)

> [1] Android is an odd example because the platform uses Java heavily
> (so JGit might be a better fit for it).  Perhaps the wish for android
> support should have been put on the Eclipse ideas page[2] and a link
> added to git's; I dunno.

Yeah, I'm not sure what an Android port would quite look like. In theory
I could probably build stock git for my rooted N1 using a
cross-compiler. But I can't imagine what I would use it for. A native
app seems like it would be more useful, and that pretty much requires
Java.

-Peff
