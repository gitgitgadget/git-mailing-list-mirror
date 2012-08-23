From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: How to request a fast-forward pull
Date: Thu, 23 Aug 2012 01:31:07 +0100
Message-ID: <1345681867.15245.36.camel@deadeye.wl.decadent.org.uk>
References: <20120820202803.GA8378@windriver.com>
	 <20120820204033.GA636@mannheim-rule.local>
	 <20120821064138.GA3238@sigill.intra.peff.net>
	 <7vwr0sdute.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-8fH7DNl9dbF1qbuPdiuv"
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	git@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org, Bart Trojanowski <bart@jukie.ca>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 02:31:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4LKy-0007lW-DB
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 02:31:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758089Ab2HWAba (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 20:31:30 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:48143 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758016Ab2HWAb2 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Aug 2012 20:31:28 -0400
Received: from [2001:470:1f08:1539:21c:bfff:fe03:f805] (helo=deadeye.wl.decadent.org.uk)
	by shadbolt.decadent.org.uk with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <ben@decadent.org.uk>)
	id 1T4LKM-000127-4N; Thu, 23 Aug 2012 01:31:14 +0100
Received: from ben by deadeye.wl.decadent.org.uk with local (Exim 4.80)
	(envelope-from <ben@decadent.org.uk>)
	id 1T4LKK-0005Ci-9V; Thu, 23 Aug 2012 01:31:12 +0100
In-Reply-To: <7vwr0sdute.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 3.4.3-1 
X-SA-Exim-Connect-IP: 2001:470:1f08:1539:21c:bfff:fe03:f805
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204106>


--=-8fH7DNl9dbF1qbuPdiuv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-08-21 at 10:22 -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>=20
> > On Mon, Aug 20, 2012 at 01:40:33PM -0700, Jonathan Nieder wrote:
> >
> >> > When you have a moment, would you please migrate this
> >> > across to your main linux-stable repository?
> >> >
> >> > Both a branch and signed tag are present and pointing at
> >> > the same commit, but "git request-pull" does favour output
> >> > of the tag over the branch name.
> >> >
> >> > But merging the tag will want to create a merge commit.
> >> >
> >> > So, to avoid a merge commit in your repo, you can fetch
> >> > (fast fwd) into your (local) branch from my branch at:
> >> >
> >> >  git://git.kernel.org/pub/scm/linux/kernel/git/paulg/linux-stable.gi=
t linux-2.6.34.y
> >> >
> >> > and then fetch the signed tag listed below after that.
> >>=20
> >> Can this be made easier?  I could imagine request-pull learning
> >> --ff-only that generates a message like
> >>=20
> >> 	Greg,
> >>=20
> >> 	Please pull --ff-only
>=20
> Where did the "Greg,\n\n" come from?  Isn't it just the matter of
> adding the "--ff-only" when that string is added?
>=20
> >>=20
> >> 	 git://git.kernel.org/pub/scm/linux/kernel/git/paulg/linux-stable.git=
 linux-2.6.34.y
> >>=20
> >> 	to get the following changes [...]
> >>=20
> >> which could work ok if the recipient notices the --ff-only, but I
> >> wonder if there is a simpler way.
> >
> > If it is something important for the sender to communicate to the
> > recipient as part of the pull command-line, then I would think the
> > natural place is on the line with the rest of it, like:
> >
> >   Please pull:
> >
> >     --ff-only <remote> <ref>
> >
> > It's maximally noticeable to the recipient, then, and anybody
> > cutting-and-pasting the whole line would get it automagically. That is
> > as close to machine-readable as pull-request emails get.
> >
> > However, I have to wonder if that is a good idea in general. Isn't the
> > decision to --ff-only or not really the puller's business? In the
> > general case, I would not expect senders of pull request to have advice
> > in this area.
>=20
> Yes, absolutely.  The advice of the sender that would be more
> helpful is not "how", but "where"/"when".  Is the topic meant for
> the maintenance track?  Why is it appropriate to pull this series at
> this moment in the history of the overall project?
>=20
> > This particular case seems to be caused by a policy mismatch between th=
e
> > project and request-pull. The latter's behavior to favor a matching tag
> > is because tags carry more information. But in this case, it sounds lik=
e
> > the project would rather avoid the extra merge commits, even if it mean=
s
> > losing information.
>=20
> That's a project decision and can be done by whoever is pulling, as
> you mentioned earlier.
>=20
> In any case, why is this even become an issue in the context of
> linux-stable?  I thought people over there were working hard to
> *increase* verifiability of the history by using signed merges,
[...]

Each *stable update* series is a single branch made up almost entirely
of cherry-picked commits, possibly managed as a quilt series before
being reviewed and then committed.  Tags are signed, and each commit has
a reference to the original (though the format of that reference isn't
well standardised).

Although Greg owns the linux-stable.git repository, several stable
updates series and the corresponding branches are maintained by others,
such as Paul and myself.  When Greg pulls from them, he's mirroring the
other maintainer's branch and never merging with anyone else's work.  So
it should always be a fast-forward merge.  Further, the head of the
branch is always going to have a tag signed by the respective
maintainer.

Ben.

--=20
Ben Hutchings
Experience is what causes a person to make new mistakes instead of old ones=
.

--=-8fH7DNl9dbF1qbuPdiuv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIVAwUAUDV5y+e/yOyVhhEJAQpMIRAAiBXbH8j5GAa4yv1/SpdOYvjWpQG6TOf9
8yh1MDLFsN1sqE7SMpxOZpUMMLUWkL3OsUkHirIrdDAoCidY3SejDvP7Pzgq/+uA
S89jzL6Qgj5ECRP64KIsqgJVr61kabmOrxc/q+p2Zox0vpns6cONcuNuujn09T+3
2SX4rek1HHpYb0g9gZEa48LQHEkJYaaoN3K5yfUAXi/jPZZG3zl1ZgwHJZZHaTr+
o8uObrgQH4+abODJ5nDyOq9GjLu+okhcjMon+Z8hBg55pq0amGWj7RWizxKMifWk
jxEFhRiWfz0PuNlRPFFO17GpHovf5OKqUlVz1EP/rQGdnCkwyXc7CpR/MDvoQjBM
6wN13xPScWk/g/7jPOkHNfAERWtqBf5FRpvvK7fRYx4vUAhS3s6IA+035SsfUppS
7DKyLMvMjlPv8+Sf2R9dDavs25LhWzuEZA0gb9ghRuyrwC0K+6HcxT5yAX/XK0BV
zH3GQBETQFxYLSGPquOSbfvleaA/4+jzx9Z578Ty1lqRWYZCluDONc81w6ghyM7F
oa+0pfoKRg/QmypXybVEOXFN8L+v6I9ucbB2wKVPOkE5cxfxuPPVHE82LTYXD7pv
RrIoVYHor3IrPANa2i48k/AJ6GVYIAi1JRzRNvc7/q+ops1EAQ4hHrqvEv9XGMpP
m0uYG64DDnM=
=kS/l
-----END PGP SIGNATURE-----

--=-8fH7DNl9dbF1qbuPdiuv--
