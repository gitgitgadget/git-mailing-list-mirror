From: Johan Herland <johan@herland.net>
Subject: Re: [RFC] Second parent for reverts
Date: Thu, 10 May 2007 20:06:05 +0200
Message-ID: <200705102006.08624.johan@herland.net>
References: <Pine.LNX.4.64.0705091406350.18541@iabervon.org>
 <alpine.LFD.0.98.0705091513050.4062@woody.linux-foundation.org>
 <alpine.LFD.0.98.0705100927340.3986@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=nextPart5733266.geFoFrrYEt;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu May 10 20:06:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmD1w-0003GI-Hs
	for gcvg-git@gmane.org; Thu, 10 May 2007 20:06:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755326AbXEJSGP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 14:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753023AbXEJSGP
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 14:06:15 -0400
Received: from smtp.getmail.no ([84.208.20.33]:35771 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752880AbXEJSGO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 14:06:14 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JHU0020H7MCIO00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Thu, 10 May 2007 20:06:12 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JHU007MU7M9T130@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Thu, 10 May 2007 20:06:09 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JHU004FK7M8TX50@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Thu, 10 May 2007 20:06:09 +0200 (CEST)
In-reply-to: <alpine.LFD.0.98.0705100927340.3986@woody.linux-foundation.org>
User-Agent: KMail/1.9.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46883>

--nextPart5733266.geFoFrrYEt
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 10 May 2007, Linus Torvalds wrote:
> On Wed, 9 May 2007, Linus Torvalds wrote:
> > If you want a "related to that commit" field, it should be a
> > separate field in the commit object. But since it doesn't really
> > have any real *semantic* meaning to git itself, it shouldn't be in
> > the header. We could, for example, make it be in the free-form
> > section, and teach our graphical visualization tools to
> > automatically turn it into a hyperlink.
> >
> > .. which we already do.
>
> Btw, sorry for harping on this issue, but one of the really *great*
> things about putting things in the free-form section is a somewhat
> unanticipated huge advantage:
>
>  - we've had much better integration with non-git users than any
> other SCM I've ever seen!
>
> [...]
>
> So in general, putting things into the headers and having git
> semantic meaning should be discouraged. The "parents" thing is
> special, because the whole "history" thing is very deeply integrated
> in git, and obviously has to be (any SCM that does _not_ have
> parenthood information is totally broken *cough*CVS/SVN*cough*), but
> other than that we should actually strive to _avoid_ anything with
> deep git semantics.

Ok. I'm sold. I will take my header fields and go away before y'all=20
replace me with a very small shell script. :)


BTW, I'm wondering whether anybody has ever thought about allowing=20
after-the-fact annotations on commits. Kinda like free-form=20
continuations on the commit message. It would allow people to make=20
notes on previous commits that were either forgotten at commit-time, or=20
only became apparent after the commit was done.

=46urthermore, if we make git-blame pay attention to hints in the commit=20
message (like Junio suggested somewhere else in this thread) -=20
including the annotations - we can then add annotations to guide=20
git-blame whenever it gets the blame wrong.

There's probably other things we could use this for.

Obviously we can't store the annotations in the commit object itself=20
(because commit objects are immutable). I'm thinking annotations could=20
be stored as simple (compressed) text files in .git/annotations/, under=20
the same sha1/filename as the corresponding commit object is stored=20
under .git/objects/. That would make them easy to retrieve from their=20
corresponding commit.


Anyway, it's just an idea that struck me. Feel free to tell me why this=20
is the worst idea since, oh, I don't know, say, my header fields=20
idea...


Have fun! :)

=2E..Johan

=2D-=20
Johan Herland, <johan@herland.net>
www.herland.net

--nextPart5733266.geFoFrrYEt
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6-ecc01.6 (GNU/Linux)

iD8DBQBGQ18QBHj4kl4fT1wRAj8VAJkBxv9/7P1/gY19wT/WUUOJTqasagCdGNrg
ltN09D9YHVn5Ox+uXH5M4qk=
=Bm4w
-----END PGP SIGNATURE-----

--nextPart5733266.geFoFrrYEt--
