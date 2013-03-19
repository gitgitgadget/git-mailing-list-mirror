From: Jeff King <peff@peff.net>
Subject: Re: [ITCH] Specify refspec without remote
Date: Tue, 19 Mar 2013 06:02:32 -0400
Message-ID: <20130319100232.GA6120@sigill.intra.peff.net>
References: <CALkWK0nYECHZaxit9jR-tS=7fXyOP5dy6mqUz0DKmbTRU-xRNw@mail.gmail.com>
 <20130318170804.GA15924@sigill.intra.peff.net>
 <CALkWK0=WCsXErHft9RbDOeehon7E2oCj5-YT6Ph+8bLFW-5JaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 19 11:03:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHtNo-0004JV-C9
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 11:03:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496Ab3CSKCh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 06:02:37 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:58138 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751256Ab3CSKCh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 06:02:37 -0400
Received: (qmail 26989 invoked by uid 107); 19 Mar 2013 10:04:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 19 Mar 2013 06:04:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Mar 2013 06:02:32 -0400
Content-Disposition: inline
In-Reply-To: <CALkWK0=WCsXErHft9RbDOeehon7E2oCj5-YT6Ph+8bLFW-5JaQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218493>

On Tue, Mar 19, 2013 at 03:28:12PM +0530, Ramkumar Ramachandra wrote:

> > I think the ambiguity is a little more complex than that, because we
> > cannot enumerate the universe of all remotes. Keep in mind that we can
> > take either a configured remote or a URL (or ssh host). So what does:
> >
> >   git push foo:bar
> >
> > mean? Is it pushing "refs/heads/foo" to "refs/heads/bar" on "origin"? Or
> > is it using the default refspecs to push to the "bar" repo on the host
> > "foo" over ssh?
> 
> Wait, why does git-push support pushing to a URL directly?  Shouldn't
> the user be required to create a new remote out of the URL and push to
> that?  What happens to upstream branches if we directly push to a URL?

I do not recall the exact history, but I would not be surprised if git
first learned to push to a URL, and later learned about configured
remotes.  I do not use it that often myself these days, but I find it
occasionally useful for one-off pushes (e.g., pushing a normally private
repo to a temporary publishing point to share with somebody else).

In that case, upstream branches are not touched at all (because we do
not have a configured remote whose fetch refspec we can examine).

-Peff
