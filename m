From: "Matthew D. Fuller" <fullermd@over-yonder.net>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 05:32:21 -0500
Message-ID: <20061018103220.GS75501@over-yonder.net>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <Pine.LNX.4.64.0610171605440.3962@g5.osdl.org> <45357411.20500@utoronto.ca> <200610180246.18758.jnareb@gmail.com> <45357CC3.4040507@utoronto.ca> <871wp6e7o9.wl%cworth@cworth.org> <45359B2A.1070102@utoronto.ca> <4535E844.8010604@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Aaron Bentley <aaron.bentley@utoronto.ca>,
	Linus Torvalds <torvalds@osdl.org>,
	Carl Worth <cworth@cworth.org>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 18 12:32:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ga8iy-0004vY-Ot
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 12:32:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030188AbWJRKcZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 06:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbWJRKcY
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 06:32:24 -0400
Received: from ns.centralmiss.com ([206.156.254.79]:65488 "EHLO
	optimus.centralmiss.com") by vger.kernel.org with ESMTP
	id S1751463AbWJRKcX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 06:32:23 -0400
Received: from draco.over-yonder.net (adsl-072-148-013-213.sip.jan.bellsouth.net [72.148.13.213])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by optimus.centralmiss.com (Postfix) with ESMTP id B38EA2842A;
	Wed, 18 Oct 2006 05:32:21 -0500 (CDT)
Received: by draco.over-yonder.net (Postfix, from userid 100)
	id 2C30961C52; Wed, 18 Oct 2006 05:32:21 -0500 (CDT)
To: Andreas Ericsson <ae@op5.se>
Content-Disposition: inline
In-Reply-To: <4535E844.8010604@op5.se>
X-Editor: vi
X-OS: FreeBSD <http://www.freebsd.org/>
User-Agent: Mutt/1.5.11-fullermd.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29220>

On Wed, Oct 18, 2006 at 10:39:32AM +0200 I heard the voice of
Andreas Ericsson, and lo! it spake thus:
>
> So in essence, the revnos work wonderfully so long as there is a
> central server to make them immutable?

It seems from my somewhat detached perspective that there's a lot of
conflation of 'conventions' with 'capabilities' around this thread...


With a single linear branch, revnos work wonderfully, and are probably
much more useful than any sort of UUID.  It would be silly in this day
and age to design a VCS aimed specifically for this use case, of
course.  That doesn't mean a VCS shouldn't make it easy, though.


With a star config, revnos are useful locally and with reference to
the "main" branch[es].  And, most of the world is star configs of one
sort or another.  Actually, one might say that practically ALL the
world outside of linux-kernel is star-configs   ;)

In many cases in the star setup, a revno (particularly along the
'trunk') is more directly useful than a UUID; consider particularly
the case of somebody who's just mirroring/following, not actively
developing.  In some cases, the UUID is more useful.  Certainly, using
a revno in a case where the UUID is more appropriate is Bad, but
that's just a matter of using the right tool.


With a uber-distributed full-mesh setup, revnos may be basically
useless for anything except local lookups (which boils down to
"useless for most anything you'd identify a revision for").  For that
case, you'd practically always use the UUID, and pretend revnos don't
exist.


The merge revno forms (123.5.2.17 and the like), I'm somewhat
ambivalent about in many ways.  But, you don't have to use them any
more than you have to use "top-level" revnos.  If either form of revno
is Wrong for your case (whether it be because "I hate numbers
wholesale", or because "Numbers don't cover this case usefully"), then
you just use the UUID and pretend the number isn't there.  If you
wanted them completely out of sight, I wouldn't expect it to be very
hard to talk bzr into never showing the revnos and just showing the
UUID ("revid").



[ I don't speak for bzr, despite the fact that I'm about to appear to ]

>From where I sit, revnos are quite useful in the first 1.5 or 2 cases.
Some would argue that they're not useless in the third case as well,
but that's no necessary point to hash out; it certainly does no
technical harm to have them there, since you can just ignore them if
they don't help you.  I think a good case could be made that the vast
majority of VCS use in the world is a form of case 2.

Git comes out of a world where case 3 is All, and the other cases are,
if not actively ignored, at least far secondary considerations, so it
can hardly be surprising that it doesn't have or want something that
adds practically nothing to its case.

bzr, both in its own development schema, and in the expected audience,
is overwhelmingly case 2 (of which case 1 is really just a degenerate
version), but that doesn't mean case 3 is ignored or impossible.  The
UUID's are there for when you need them, and can be used anywhere you
might use a number, and just as easily.  It's a community convention
to organize development in such a way that the number is "usually"
useful, and when it is, it's certainly easier.  That doesn't mean you
HAVE to use it in cases where it doesn't fit, though.  "bzr people
like to avoid using UUID's" doesn't lead to "bzr can't handle the
cases where UUID's are necessary".


> Doesn't this mean that one of your key features doesn't actually
> work in a completely distributed setup

That's one way of phrasing it, I guess.  I'd say rather "a particular
feature isn't applicable to a completely distributed setup".  I'm sure
git has a lot of features that are key for somebody that "don't work"
for someone else, just because they're doing something that person
doesn't want done.  Just because somebody else thinks their toaster
oven is a great way to solder, doesn't mean you have to sell yours.
You can just leave it in the cupboard and use an iron instead.



-- 
Matthew Fuller     (MF4839)   |  fullermd@over-yonder.net
Systems/Network Administrator |  http://www.over-yonder.net/~fullermd/
           On the Internet, nobody can hear you scream.
