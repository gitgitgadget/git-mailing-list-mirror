From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] remote-hg: add missing config for basic tests
Date: Tue, 13 Nov 2012 00:48:26 -0500
Message-ID: <20121113054826.GC10995@sigill.intra.peff.net>
References: <1352742068-15346-1-git-send-email-felipe.contreras@gmail.com>
 <1352742068-15346-2-git-send-email-felipe.contreras@gmail.com>
 <20121112203207.GF4623@sigill.intra.peff.net>
 <CAMP44s2GzX_+6+eNU5n6kGue_-MWvU9qNXAr3Caw3A7nWhkawA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 06:48:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TY9Mb-0000Ca-L8
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 06:48:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753312Ab2KMFsb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 00:48:31 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45589 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752725Ab2KMFsb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 00:48:31 -0500
Received: (qmail 19880 invoked by uid 107); 13 Nov 2012 05:49:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 13 Nov 2012 00:49:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Nov 2012 00:48:26 -0500
Content-Disposition: inline
In-Reply-To: <CAMP44s2GzX_+6+eNU5n6kGue_-MWvU9qNXAr3Caw3A7nWhkawA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209578>

On Tue, Nov 13, 2012 at 04:46:36AM +0100, Felipe Contreras wrote:

> >> +setup () {
> >> +     (
> >> +     echo "[ui]"
> >> +     echo "username = A U Thor <author@example.com>"
> >> +     ) >> "$HOME"/.hgrc
> >> +}
> >
> > This makes sense, but I wonder if we should use something different from
> > the git author ident set up by the test scripts, just to double check
> > that we do not have any bugs in confusing the two during the import.
> 
> I don't know, but these tests would not check for any of those issues.
> When such tests are added I would prefer the author to use to be
> explicitly defined, but lets see.

It's OK if we do not add more explicit tests at this point. I'd just
rather set a safer precedent on the off chance that it might catch
something in a later test, just as we use separate GIT_AUTHOR_* and
GIT_COMMITTER_* in the rest of the test suite. If the choice were not
completely arbitrary and had some maintenance cost, I might be more
concerned, but as far as I can tell, one name is as good as another at
this point.

Any objection to me marking it up as I apply?

-Peff
