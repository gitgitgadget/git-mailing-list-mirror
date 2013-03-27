From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 10/9] clone: leave repo in place after checkout errors
Date: Tue, 26 Mar 2013 21:03:48 -0400
Message-ID: <20130327010348.GA18405@sigill.intra.peff.net>
References: <20130325201427.GA15798@sigill.intra.peff.net>
 <20130325202359.GH16019@sigill.intra.peff.net>
 <7vtxnxsuty.fsf@alter.siamese.dyndns.org>
 <20130326222209.GA16457@sigill.intra.peff.net>
 <20130326223259.GA28148@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 27 02:04:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKems-0002Hn-I1
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 02:04:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752772Ab3C0BDx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 21:03:53 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40918 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751951Ab3C0BDw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 21:03:52 -0400
Received: (qmail 9990 invoked by uid 107); 27 Mar 2013 01:05:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Mar 2013 21:05:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Mar 2013 21:03:48 -0400
Content-Disposition: inline
In-Reply-To: <20130326223259.GA28148@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219229>

On Tue, Mar 26, 2013 at 03:32:59PM -0700, Jonathan Nieder wrote:

> > +static const char junk_leave_repo_msg[] =
> > +N_("The remote repository was cloned successfully, but there was\n"
> > +   "an error checking out the HEAD branch. The repository has been left in\n"
> > +   "place but the working tree may be in an inconsistent state. You can\n"
> > +   "can inspect the contents with:\n"
> > +   "\n"
> > +   "    git status\n"
> > +   "\n"
> > +   "and retry the checkout with\n"
> > +   "\n"
> > +   "    git checkout -f HEAD\n"
> > +   "\n");
> 
> Can this be made more precise?  I don't know what it means for the
> working tree to be in an inconsistent state: do you mean that some files
> might be partially checked out or not have been checked out at all yet?

It means that we died during the checkout procedure, and we don't have
any idea what was left. Maybe something, maybe nothing. Maybe an index,
maybe not.

> 	error: Clone succeeded, but checkout failed.
> 	hint: You can inspect what was checked out with "git status".
> 	hint: To retry the checkout, run "git checkout -f HEAD".

That is certainly more succint, if not more precise. I'd be fine with
it.

-Peff
