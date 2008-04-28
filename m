From: Henrik Austad <henrikau@orakel.ntnu.no>
Subject: Re: About git and the use of SHA-1
Date: Mon, 28 Apr 2008 23:29:14 +0200
Message-ID: <200804282329.21336.henrikau@orakel.ntnu.no>
References: <200804281829.11866.henrikau@orakel.ntnu.no> <alpine.LNX.1.00.0804281515480.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1424096.qcIkuYNecW";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 23:30:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqavS-0001pk-R8
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 23:30:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937744AbYD1V3a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 17:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752038AbYD1V33
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 17:29:29 -0400
Received: from mail45.e.nsc.no ([193.213.115.45]:47174 "EHLO mail45.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937627AbYD1V3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 17:29:25 -0400
Received: from 062016203203.customer.alfanett.no (062016203203.customer.alfanett.no [62.16.203.203])
	by mail45.nsc.no (8.13.8/8.13.5) with ESMTP id m3SLTJNX014893;
	Mon, 28 Apr 2008 23:29:20 +0200 (MEST)
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.LNX.1.00.0804281515480.19665@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80621>

--nextPart1424096.qcIkuYNecW
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 28 April 2008 21:34:50 Daniel Barkalow wrote:
> On Mon, 28 Apr 2008, Henrik Austad wrote:
> > Hi list!
> >
> > As far as I have gathered, the SHA-1-sum is used as a identifier for
> > commits, and that is the primary reason for using sha1.  However, sever=
al
> > places (including the google tech-talk featuring Linus himself) states
> > that the id's are cryptographically secure.
> >
> > As discussed in [1], SHA-1 is not as secure as it once was (and this was
> > in 2005), and I'm wondering - are there any plans for migrating to
> > another hash-algorithm? I.e. SHA-2, whirlpool..
>
> No. The cryptographic security we care about is that it's impractical to
> come up with another set of content that hashes to the same value as a
> given set of content. The known attacks on SHA-1 (and more broken earlier
> hashes in the same general class) only allow the attacker to produce two
> files that will collide. Now, it's true that this would allow somebody to
> produce a commit where some people see the "good" blob and some people see
> the "evil" blob, but (a) the "good" blob contains some large chunk of
> random data, which is a major red flag by itself, and (b) all of these
> people have to be taking data from the attacker.

yes, I can see that point, but I was thinking more along the line of:

1) clone repo
2) add malicious code
3) add a huge block of comment, ifdef-block etc somewhere obscure in the co=
de=20
and keep adding random data untill hash matches a well-known release.
4) publish repo, or even worse, change central repo

Most users, and probably a lot of developers never browse through the *enti=
re*=20
archive looking for this, and as long as the hash checks out - why would yo=
u?=20
Yes, it would probably be discovered soon enough, but take the linux kernel=
=20
as an example - if you get, say 100 infected machines due to this, what wou=
ld=20
this do to the reputation of the kernel?


> If somebody gives you some source, and it's got some large random chunk in
> it, and the behavior of the object depends on the content of this chunk,
> and it's unspecified where this chunk comes from, you should be aware
> that they might be able to swap this chunk for a different chunk. But such
> a file is pretty blatantly malicious anyway.

True, but this actually means you have to verify *everything*, even though =
the=20
hash checks out.

but yes, I can see your point, and it would most likely be infeasible to=20
generate a collision using this approach, and changing to another=20
hashfunction would probably not add much. basically I was just curious and=
=20
played ahead with the idea.

Thanks for the answer though :)
=2D-=20
mvh Henrik Austad

--nextPart1424096.qcIkuYNecW
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIFkGx6k5VT6v45lkRAnVIAKDIkRYlHzURYAaMRQjY/EZqEh4mLQCfUwCF
Rul3eSsy0E/9YD6cQ1W5JFM=
=wZ0f
-----END PGP SIGNATURE-----

--nextPart1424096.qcIkuYNecW--
