From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Lets avoid the SHA-1 term (was [doc] User Manual Suggestion)
Date: Sat, 2 May 2009 17:37:34 +0200
Message-ID: <20090502153734.GA6135@atjola.homenet>
References: <94a0d4530904261638o6cbda368p4f3aa641505a6768@mail.gmail.com> <20090427002838.GF12338@atjola.homenet> <b4087cc50904270602q17fba432ka219180d358fae47@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	David Abrahams <dave@boostpro.com>, Jeff King <peff@peff.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	"J. Bruce Fields" <bfields@fieldses.org>
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 02 17:37:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0HHg-00036S-Ba
	for gcvg-git-2@gmane.org; Sat, 02 May 2009 17:37:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755272AbZEBPhj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 May 2009 11:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754995AbZEBPhj
	(ORCPT <rfc822;git-outgoing>); Sat, 2 May 2009 11:37:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:51819 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754798AbZEBPhi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2009 11:37:38 -0400
Received: (qmail invoked by alias); 02 May 2009 15:37:37 -0000
Received: from i59F56FEA.versanet.de (EHLO atjola.local) [89.245.111.234]
  by mail.gmx.net (mp003) with SMTP; 02 May 2009 17:37:37 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+kJZ5qVPSk+T/L485pTJPQxqqzkPew5e4iCbpBEQ
	7t4AjiUUnIy6DW
Content-Disposition: inline
In-Reply-To: <b4087cc50904270602q17fba432ka219180d358fae47@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118138>

On 2009.04.27 08:02:02 -0500, Michael Witten wrote:
> 2009/4/26 Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>:
> >
> >> Do you agree that either 'id' or 'hash' would work fine?
> >
> > "object id" would work for me, but I'm fine with the existing "obje=
ct
> > name" as well. I don't like "object hash" (or "object hash id"), be=
cause
> > it IMHO doesn't express that well that it's used to identify an obj=
ect.
>=20
> However, the SHA-1 hash is not actually essential to git. In the git
> world, there is only content and every object is identified by its
> content. Now, to identify an object, it would be pretty cumbersome to
> have to write out the contents, so we abbreviate the contents with a
> hash.
>=20
> So, the hash or object name or object id or whatever you want to call
> it isn't even an essential part to git. It is a convenience.
>=20
> In that sense, I think that '[cryptographic] hash' is the right term,
> because the others ("object name" and "object id") seem special. A
> hash is not special. In fact, the documentation should read "For
> convenience, the git tools refer to objects using the hash value of
> their contents". You see? It's not essential.

"For convenience" means "To make it suck less for the user" to me. And
that's why you can use an abbreviated object name as long as its unique=
=2E

That a hash is used isn't essential for the basic data model, where
commits reference trees which in turn reference other trees and blobs.
To understand that model, it's not essential to know that hashes are
used.  But it is essential that some kind of identifier other than the
whole content is used. Otherwise, the whole data model would make no
sense at all. If you use the whole content to identify an object, that
means that commits contain the whole trees which in turn contain the
whole other trees and the whole blobs. So you could as well just have
only commit objects, they contain everything anyway.

So that we have the object name instead of the whole content _is_
essential.

Bj=F6rn
