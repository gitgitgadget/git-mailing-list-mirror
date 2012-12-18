From: Jeff King <peff@peff.net>
Subject: Re: Feature suggestion: new 'git add -i' command to discard working
 copy changes
Date: Tue, 18 Dec 2012 17:20:23 -0500
Message-ID: <20121218222023.GA3685@sigill.intra.peff.net>
References: <50D0DA19.5030606@cs.wisc.edu>
 <7vvcbzdoy9.fsf@alter.siamese.dyndns.org>
 <20121218215914.GB1806@sigill.intra.peff.net>
 <50D0E9DA.1020408@cs.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Evan Driscoll <driscoll@cs.wisc.edu>
X-From: git-owner@vger.kernel.org Tue Dec 18 23:20:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tl5Wn-000699-0Z
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 23:20:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755402Ab2LRWU0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2012 17:20:26 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:58008 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754071Ab2LRWU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 17:20:26 -0500
Received: (qmail 23794 invoked by uid 107); 18 Dec 2012 22:21:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 18 Dec 2012 17:21:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Dec 2012 17:20:23 -0500
Content-Disposition: inline
In-Reply-To: <50D0E9DA.1020408@cs.wisc.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211793>

On Tue, Dec 18, 2012 at 04:10:34PM -0600, Evan Driscoll wrote:

> I have two use cases of 'add -i'. The more common one is if I kind of
> want -p but don't want to do it for every file. (I guess in part this is
> my way of substituting for not knowing all the actions during -p as
> well.) But I sometimes use it if I want to stage several but not all
> files, as it's often faster for me to just choose the files I want from
> the interactive add's list than it is for me to type each of the files
> that I want (even with tab completion) -- I'm often working in a project
> with unfortunately-deep paths.
> 
> What I want for my 'discard' action is more like the latter: I'd like a
> fast way to choose a file(s) to discard without having to type the path(s).

That makes sense.

> Maybe I should just investigate tig or another front end; that might
> satisfy my desire.

Yes, "tig status" will do this (use "!" to revert changes to the path).

Another trick is to stage what you want and throw away the rest, like:

  $ hack hack hack
  $ git add -i ;# now everything unstaged is garbage
  $ git checkout .
  $ test test test
  $ git commit

Of course that implies that you can separate the wheat from the chaff at
that exact moment. Sometimes you are just discarding known junk to make
further work or "add -i" easier.

-Peff
