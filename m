From: "R. Tyler Ballance" <tyler@slide.com>
Subject: Re: Removing options from build
Date: Tue, 13 Jan 2009 14:00:45 -0800
Organization: Slide, Inc.
Message-ID: <1231884045.14181.36.camel@starfruit>
References: <1231883002.14181.27.camel@starfruit>
	 <200901132253.15370.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-iF7gHVD1QH5FIxe0M2zw"
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jan 13 23:02:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMrKx-0007WJ-7y
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 23:02:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754948AbZAMWAw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 17:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754929AbZAMWAv
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 17:00:51 -0500
Received: from mx0.slide.com ([208.76.68.7]:44775 "EHLO mx0.slide.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754851AbZAMWAv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 17:00:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=slide.com; s=slideinc; h=Subject:From:To:Date:Message-Id; bh=G
	0mA4o9+BFKYfhOOMM88HLabqx2hUGGl97aO4StN7KQ=; b=nDpMaXlafN9iiA708
	BLjRCRm3V4EJ8gXEzIUaPKVY1l+STD4r5yJHrqR1/ip3bk1HjibsFQa8LvYyrG4B
	gpLaWf8r9HQUc+rr5xj96imNuZACyi5U+RjdpreXPDN933mPXDAcKU12rFY10vF6
	zJYKqRoRBGdtvG4RsAYvKyw7Jo=
Received: from nat3.slide.com ([208.76.69.126]:37845 helo=calculon.corp.slide.com)
	by mx0.slide.com with esmtp (Exim 4.69 #1)
	id 1LMrJY-0002gg-BM; Tue, 13 Jan 2009 14:00:48 -0800
Received: from localhost (localhost.localdomain [127.0.0.1])
	by calculon.corp.slide.com (Postfix) with ESMTP id 4F4F7A700121;
	Tue, 13 Jan 2009 14:00:48 -0800 (PST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from calculon.corp.slide.com ([127.0.0.1])
	by localhost (calculon.corp.slide.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r7Ucuepqlqnp; Tue, 13 Jan 2009 14:00:48 -0800 (PST)
Received: from [10.10.8.190] (dhcp-10-10-8-190.corp.slide.com [10.10.8.190])
	by calculon.corp.slide.com (Postfix) with ESMTP id 1F5EE38990F9;
	Tue, 13 Jan 2009 14:00:48 -0800 (PST)
In-Reply-To: <200901132253.15370.trast@student.ethz.ch>
X-Mailer: Evolution 2.24.1.1 
X-Content-Bypass: Bypassed by sending host IP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105546>


--=-iF7gHVD1QH5FIxe0M2zw
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2009-01-13 at 22:53 +0100, Thomas Rast wrote:
> R. Tyler Ballance wrote:
> > Besides a vigorous flogging, we're looking at other ways to prevent thi=
s
> > sort of thing from happening again; the option we've settled on is to
> > remove the "--force" flag from our internal build of v1.6.1
> >
> > I'm wondering if somebody could point me in the right direction to
> > remove "--force" (safely) from the builtin-push.c and removing the
> > "rebase" command (we've got no use for it, and would prefer it gone).
>=20
> IMHO your update (or pre-receive) hook should just disallow
> non-fast-forward updates.

Don't merges count as non-fast-forward updates? We generate merge
commits with almost every merge, rarely do we actually have
fast-forwards anymore (highly active repository)

>=20
> This doesn't really address git-rebase, but it will disallow pushing a
> "harmfully" rebased branch since those are by definition non-ff.  Why
> take away the option to correct a mistake in the last commit with 'git
> rebase -i'?

I'm a strong proponent of revision history only moving forward, I would
much rather see a series of revert commits than having somebody who is
inexperienced with the tools they're using muck about an jeopardize the
stability of our central repository.=20


Used correctly, both --force and `rebase` have good reason to exist in
the Git codebase; they just haven't been used correctly, and proper
bamboo to flog developers with will take a couple days to ship from
Asia, so removing the options from our internal build is a lot easier
and faster ;)

Cheers :D
--=20
-R. Tyler Ballance
Slide, Inc.

--=-iF7gHVD1QH5FIxe0M2zw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkltDw0ACgkQFCbH3D9R4W/GEACdEEwS3be4xkCWsjar0oPiOTMC
F1oAoKTIdT2xO2AfFIG1pmMD0pzdw9wQ
=VXrY
-----END PGP SIGNATURE-----

--=-iF7gHVD1QH5FIxe0M2zw--
