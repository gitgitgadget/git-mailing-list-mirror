From: Jeff King <peff@peff.net>
Subject: Re: Minor bug report
Date: Thu, 4 Jun 2015 04:21:25 -0400
Message-ID: <20150604082125.GA5771@peff.net>
References: <CAMOUyJ_2snCaKcWNoOgH7aoHrdbUsCucqu_W_J3aH9_QQe1jEw@mail.gmail.com>
 <20150603062005.GA20580@peff.net>
 <CAPc5daU9VdndgkMFNmtiwhVdwyGQgDbFX3rrrsEEEUVewgs-dw@mail.gmail.com>
 <1433345954.21083.14.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Tummala Dhanvi <dhanvicse@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Thu Jun 04 10:21:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0QPE-00029c-Fx
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jun 2015 10:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752664AbbFDIVb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2015 04:21:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:40992 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751636AbbFDIV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2015 04:21:28 -0400
Received: (qmail 16340 invoked by uid 102); 4 Jun 2015 08:21:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Jun 2015 03:21:28 -0500
Received: (qmail 29884 invoked by uid 107); 4 Jun 2015 08:21:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Jun 2015 04:21:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Jun 2015 04:21:25 -0400
Content-Disposition: inline
In-Reply-To: <1433345954.21083.14.camel@kaarsemaker.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270758>

On Wed, Jun 03, 2015 at 05:39:14PM +0200, Dennis Kaarsemaker wrote:

> On di, 2015-06-02 at 23:48 -0700, Junio C Hamano wrote:
> > 
> > I am kind of surprised after reading these two threads that my
> > take on this issue has changed over time, as my knee-jerk
> > reaction before reading them was the opposite, something
> > along the lines of "This is only immediately after 'git init'; why
> > bother?". Or depending on my mood, that "How stupid do you
> > have to be..." sounds exactly like a message I may advocate
> > for us to send. Perhaps I grew more bitter with age.
> 
> The "fatal: Failed to resolve 'HEAD' as a valid ref." message, closely
> related to the "fatal: bad default revision 'HEAD'" message that started
> this thread just came by in #git with the following situation:
> 
> $ git init
> $ git add .
> # Oops, didn't want to add foo.xyz
> $ git reset foo.xyz
> fatal: Failed to resolve 'HEAD' as a valid ref.
> 
> The solution there is simple, git rm --cached, but I think git could
> produce more helpful messages when a repo is empty.

Yeah, I think there are a lot of places we could handle unborn branches
better. We've slowly been smoothing these rough edges over the years
(usually by using the empty tree when we wanted HEAD to be a tree-ish).

Patches welcome. :)

-Peff
