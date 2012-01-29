From: Jeff King <peff@peff.net>
Subject: Re: BUG 1.7.9: git branch fails to create new branch when
 --edit-description is used
Date: Sat, 28 Jan 2012 22:18:44 -0500
Message-ID: <20120129031843.GA1347@sigill.intra.peff.net>
References: <2443.1327701165@plover.com>
 <7vr4ykybnl.fsf@alter.siamese.dyndns.org>
 <4F2399B6.8020507@alum.mit.edu>
 <7vbopoxp5q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Mark Jason Dominus <mjd@plover.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 29 04:18:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrLI3-0004Tk-CG
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jan 2012 04:18:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752212Ab2A2DSr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jan 2012 22:18:47 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47803
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752079Ab2A2DSq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jan 2012 22:18:46 -0500
Received: (qmail 7701 invoked by uid 107); 29 Jan 2012 03:25:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 28 Jan 2012 22:25:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Jan 2012 22:18:44 -0500
Content-Disposition: inline
In-Reply-To: <7vbopoxp5q.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189277>

On Fri, Jan 27, 2012 at 11:27:29PM -0800, Junio C Hamano wrote:

> > Given this design, shouldn't "git branch --edit-description" fail if the
> > branch doesn't already exist?
> 
> The only use scenario in the original design was to have a way to store
> the description given a branch name, and giving a description to a branch
> that does not yet exist is outside the scope of the design. So it all
> boils down to what is the most convenient and the simplest to explain.

How do we define "branch exists"? That the ref exists? What about a HEAD
that points to a branch-to-be-born?

Specifically, I am wondering whether this:

  $ git init
  $ git branch --edit-description

should work. Right now it edits the description for "master", even
though you haven't yet committed to it.

-Peff
