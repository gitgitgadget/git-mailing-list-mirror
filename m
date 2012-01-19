From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: Rebase and incrementing version numbers
Date: Thu, 19 Jan 2012 20:20:03 +0100
Message-ID: <1327000803.5947.59.camel@centaur.lab.cmartin.tk>
References: <CADo4Y9jGYJasDL9m7_50aOTrOyoezdyg=vcsZhQ87Qk-1XfTUQ@mail.gmail.com>
	 <CADo4Y9iKvoXhKg5pEAB+cbA7Rkfa=nF4TLu0xgcS3dnkNi_n4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-2D7JfvcUmRUxIoSIsx53"
Cc: git@vger.kernel.org
To: mike@nahas.com
X-From: git-owner@vger.kernel.org Thu Jan 19 20:20:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnxWs-0007UR-Ui
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 20:20:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932658Ab2ASTUG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jan 2012 14:20:06 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:50181 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932485Ab2ASTUF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2012 14:20:05 -0500
Received: from [192.168.1.17] (brln-4db9cba4.pool.mediaWays.net [77.185.203.164])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 134CF4610E;
	Thu, 19 Jan 2012 20:20:02 +0100 (CET)
In-Reply-To: <CADo4Y9iKvoXhKg5pEAB+cbA7Rkfa=nF4TLu0xgcS3dnkNi_n4g@mail.gmail.com>
X-Mailer: Evolution 3.2.2-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188826>


--=-2D7JfvcUmRUxIoSIsx53
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-01-19 at 12:20 -0500, Michael Nahas wrote:
> I'm at a new job and using Git-SVN at a place that is accustomed to SVN.
>=20
> The problem I'm running into is that whenever I change a file in a
> directory, I have to bump up the version number in the configuration
> file.  The larger version value in the config file causes my changes
> to be loaded over the old ones.

Is this a deployment script that does this? Why can't it look at whether
files have changed? If a feature isn't ready for production, why is it
in a branch that gets deployed?

>=20
> Most of my commits are edits to a file like "foo.js" and an increment
> to the version number in "config".  Ideally, each of my features
> should live in a single commit and I should be able to make a sequence
> of them, each time incrementing the version number in config.
>=20

So if you've changed the file but don't increase the config file's
version, it means that the change isn't ready for production? If that's
the case, you've just implemented branches, poorly.

Contrary to what apparently many people think, subversion does support
branches. Get your team to use them.

> The problem I'm running into starts with me editing version=3D100.  I
> create new commits where I set the version to 101, 102, 103, 104.
> When I go to push ("git svn dcommit"), my coworkers have incremented
> the version to 103.  So, I rebase my changes, and get conflicts every
> time because of the version number!

This sounds like a race condition that the svn users might be avoiding
by committing everything immediately. Sounds like a buggy development
process.

>=20
> Is there a good way to avoid these conflicts?  Is there a hook I can
> write?  Is there a change to this process that would work smoother
> with Git and its distributed development?  It's okay if the version
> number skips numbers (e.g., jumps from 100 to 104), as long as it
> increases.

You could write a merge driver that detects this situation and writes in
a higher number, but it's all working around the fact that it's a race
condition.

   cmn

--=-2D7JfvcUmRUxIoSIsx53
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJPGGzjAAoJEHKRP1jG7ZzTVpkIAJtthARLTHcZR6WxvjKx7UHY
CGZfC3v3WQD9JmBibWb3pISMcY/VT13sxSS75XspvaYrPJfHKwIMham4ILunqHX3
4HyDIwA8WrVkhq+gBTCngDC2IWmmmodFBJ9DZwKHnA8sYEXluIC0EwPw1SZZnp8q
axvUwCBg0/W1YVQnvjGmnFK8kI/KDQhegWLa6jj0ZJOEu48w/54eqAkiW/juPAxS
sV4b796bqRaS7lDsQhRebPKKPIW+lSa2qFzPtEqJNdKkWlsCXkJZABZ/TWlth6w6
eoumn4Qwfw5MZOzFv0uKZojE7fT62BRb7DWF4lg5bmVXHNUga897L2mfDwRYVhg=
=zn2K
-----END PGP SIGNATURE-----

--=-2D7JfvcUmRUxIoSIsx53--
