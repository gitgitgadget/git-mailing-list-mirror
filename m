From: Jeff King <peff@peff.net>
Subject: Re: Bug: "git checkout -b" should be allowed in empty repo
Date: Mon, 6 Feb 2012 03:57:07 -0500
Message-ID: <20120206085707.GA24149@sigill.intra.peff.net>
References: <7vwr8bvvxj.fsf@alter.siamese.dyndns.org>
 <4F263AEE.4080409@alum.mit.edu>
 <7v39axc9gp.fsf@alter.siamese.dyndns.org>
 <7vaa55ar4v.fsf@alter.siamese.dyndns.org>
 <20120130215043.GB16149@sigill.intra.peff.net>
 <7vobtcbtqa.fsf@alter.siamese.dyndns.org>
 <20120206043012.GD29365@sigill.intra.peff.net>
 <CAH5451ndjozo8-Cx3+Vc84TCjKJvCnSuOUsQS5cnqXsdc=8fMQ@mail.gmail.com>
 <20120206050637.GA4263@sigill.intra.peff.net>
 <4F2F94AC.6010800@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andrew Ardill <andrew.ardill@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Feb 06 09:57:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuKNv-0001cY-Ib
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 09:57:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753967Ab2BFI5K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 03:57:10 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58713
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751087Ab2BFI5J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 03:57:09 -0500
Received: (qmail 25763 invoked by uid 107); 6 Feb 2012 09:04:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 Feb 2012 04:04:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Feb 2012 03:57:07 -0500
Content-Disposition: inline
In-Reply-To: <4F2F94AC.6010800@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190052>

On Mon, Feb 06, 2012 at 09:51:56AM +0100, Michael Haggerty wrote:

> On 02/06/2012 06:06 AM, Jeff King wrote:
> >I don't recall seeing anybody complain seriously about it in the past
> >six years of git's existence.
> 
> In the real-world situation when I noticed this bug, I wasn't trying to
> use a nonstandard name for "master".  What I was doing is importing a
> snapshot of some code from another non-git project onto a "vendor
> branch", which I knew I would later want to merge into my own work
> (which I planned to do on master).

Thanks, that sounds like a very reasonable use case. I stand corrected.

(For some reason I thought you ran across it accidentally while mucking
with "--edit-description", since were talking about that an unborn
branches in a nearby thread).

-Peff

PS I probably would have done it as:

     git init vendor
     cd vendor
     import import import
     cd ..

     git init project
     cd project
     git fetch ../vendor master:vendor

   but I don't think there's anything wrong with your approach (in fact,
   it's slightly more efficient).
