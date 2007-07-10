From: martin f krafft <madduck@madduck.net>
Subject: Re: how to combine two clones in a collection
Date: Tue, 10 Jul 2007 08:21:04 +0200
Message-ID: <20070710062104.GA22603@piper.oerlikon.madduck.net>
References: <20070709222250.GA8007@piper.oerlikon.madduck.net> <alpine.LFD.0.999.0707091923300.3412@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 10 08:21:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8962-0002Ek-4q
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 08:21:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752044AbXGJGVK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 02:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751769AbXGJGVJ
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 02:21:09 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:34575 "EHLO
	albatross.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752004AbXGJGVI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 02:21:08 -0400
Received: from localhost (albatross.madduck.net [127.0.0.1])
	by albatross.madduck.net (postfix) with ESMTP id 67EB2895D78
	for <git@vger.kernel.org>; Tue, 10 Jul 2007 08:21:06 +0200 (CEST)
Received: from albatross.madduck.net ([127.0.0.1])
	by localhost (albatross.madduck.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 03708-06 for <git@vger.kernel.org>;
	Tue, 10 Jul 2007 08:21:06 +0200 (CEST)
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by albatross.madduck.net (postfix) with ESMTP id 10339895D7C
	for <git@vger.kernel.org>; Tue, 10 Jul 2007 08:21:05 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 2B42F9F121
	for <git@vger.kernel.org>; Tue, 10 Jul 2007 08:21:05 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id F227343FC; Tue, 10 Jul 2007 08:21:04 +0200 (CEST)
Mail-Followup-To: git discussion list <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0707091923300.3412@woody.linux-foundation.org>
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.21-2-amd64 x86_64
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
X-Spamtrap: madduck.bogus@madduck.net
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at madduck.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52047>


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thanks, Linus, for your time in answering my questions. I have some
more comments and questions in reply. I hope I am coherent enough,
this subject matter doesn't exactly flow off my tongue with ease
yet...

also sprach Linus Torvalds <torvalds@linux-foundation.org> [2007.07.10.0435=
 +0200]:
> I really _think_ that what you want is to just use separate
> branches, if I understand correctly. That makes it really easy to
> just have both lines of development (both the "trunk" and your
> "debian" one) in one git repository.

It does mean, however, that I duplicate the upstream into my repo,
and thus into the published repo at git.debian.org, because I cannot
just publish a single branch ('debian') in such a way that people
could clone it and still be able to build the package against
upstream (which they'd have to obtain for themselves), right?

> Of course, especially if you want to continue to work the way you
> probably worked with SVN (ie you are used to seeing those two
> branches as two separate directories), that means that while you
> can (and should) see it as a single git project, you'd normally
> end up just having two copies of that project: they'd _both_ have
> two branches, but they'd just en dup having different branches
> checked out.

The way I tend to think about a pair of branches is that one depends
on the other, or rather, one stems from the other. Thus, I'd
probably branch the 'debian' branch off 'upstream', and add the
=2E/debian directory, and then either rebase the debian branch onto
new upstream heads, or merge upstream into the debian branch on new
versions.

This makes perfect sense and I have been experimenting with such
a workflow before:
http://albatross.madduck.net/pipermail/vcs-pkg/2007-June/000001.html

So if I made changes to the debian branch, I'd check it out first,
then return to the upstream branch when done.

Your suggestion to checkout the same repo twice with different
branches does sound a lot like the way I used to do things in SVN.
However, I guess what I am trying to prevent is having to manually
set up this hierarchy on each machine I choose to work on. Instead,
I'd rather be able to clone a repository and be ready to work.

In your scenario, would I make two branches and then import upstream
into one, the ./debian directory into the other, and never ever
merge back and forth again, thus treating them as separate
directories?

> Of course, after you get comfy enough with the setup, you might
> end up just deciding that you might as well just switch branches
> around in a single repository (which is what a lot of git users
> end up doing), but at least initially, it's probably easier from
> a conceptual standpoint to just have the two branches checked out
> in separate copies of the repos.

Okay, this is beginning to make sense. However, the debian branch
tracks changes mostly to ./debian/*. To check it out separately,
I need a directory. If usptream is checked out to ., then if I'd
check out the debian branch do ./debian, I'd end up with
=2E/debian/debian. Do you suggest the use of a symlink then?

> > How can I do this with git? I am aware that maybe the best way
> > would be to use git-svn to track the upstream branch remotely
> > and to add ./debian in a separate git branch (and to stop using
> > SVN and switch to git for ./debian)
>=20
> I don't think you'd have to stop using SVN.

I think I would want to. :)

> (And no, I don't know what the standard debian package management
> setup looks like, but I would hope that your extra stuff would be
> just a few files and package descriptions, and obviously any of
> the local debian changes to the project).

Your hopes seem to be quite close to reality. :)

Thanks,

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
spamtraps: madduck.bogus@madduck.net
=20
http://www.vcnet.com/bms/

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature (GPG/PGP)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGkyVQIgvIgzMMSnURAljaAJ4qyrAwDbfnH+/5ZLNPoOd3dNXD5ACgvZLB
mqp2Vdtzbvu+meWZLuuhfa8=
=2lzk
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
