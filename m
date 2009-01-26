From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] contrib git-resurrect: find traces of a branch name and resurrect it
Date: Mon, 26 Jan 2009 12:54:17 +0100
Message-ID: <200901261254.39360.trast@student.ethz.ch>
References: <200901201450.53450.bss@iguanasuicide.net> <1232740985-4551-1-git-send-email-trast@student.ethz.ch> <200901231500.23182.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3680585.IyljjPciPQ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <junio@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Mon Jan 26 13:42:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRQnG-0008LE-Fm
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 13:42:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbZAZMky (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 07:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbZAZMkx
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 07:40:53 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:12572 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751017AbZAZMkx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 07:40:53 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 26 Jan 2009 13:40:51 +0100
Received: from thomas.localnet ([129.132.153.233]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 26 Jan 2009 13:40:50 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.25.20-0.1-default; KDE/4.1.96; x86_64; ; )
In-Reply-To: <200901231500.23182.bss@iguanasuicide.net>
X-OriginalArrivalTime: 26 Jan 2009 12:40:50.0954 (UTC) FILETIME=[5211C6A0:01C97FB3]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107206>

--nextPart3680585.IyljjPciPQ
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Stephen,

Sorry for the long delay.  I'm going to roll a v2 with two small
fixes.  After that it's all yours ;-)

Boyd Stephen Smith Jr. wrote:
[...]
> 6. Try to resurrect branch from origin/pu, get local version I just delet=
ed.
> 7. delete reflog for that branch
> 8. Try to resurrect branch from origin/pu, get local version I merged int=
o=20
> master at some point.
> 9. Add new option.
>=20
> So, I added a couple of options locally: --only-merges, so it would only =
look=20
> at the first line of commit logs, ignoring my local reflogs entirely;=20
> and --revisions, to specify arguments to pass to rev-list so it wouldn't =
even=20
> see my local merges (I passed 'origin/pu origin/next').
>=20
> Yeah, my usage might be abusage, but it worked for me. :)

I'm fine with adding such an option, but I still wonder what was wrong
with the original scheme of asking 'git rev-list -1' for the newest
commit.  I thought rev-list always listed by date, so that command
should always pick the newest candidate commit from all candidates
selected.  Do you have an example where that breaks?  Or did you just
have a use-case in which you wanted something other than the newest
candidate?

> In my local version, which I was going to try and clean up over the weeke=
nd, I=20
> was going to support both, by borrowing refspec syntax from fetch/push. =
=20
> Specifically.  Resurrecting 'js/notes' as 'pu/js/notes' would look like:
> git-resurrect -H js/notes:pu/js/notes
>=20
> Would you object to a patch that dropped -b in favor of the refspec synta=
x?

No, that would be fine by me.

> There seems to be some needless redundancy between USAGE and OPTIONS_SPEC.
>=20
> Would you object to a patch that used $USAGE inside OPTIONS_SPEC?

Also a good idea.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart3680585.IyljjPciPQ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkl9pH8ACgkQqUud07tmzP3KwwCePeioeJoJXkD7vmptJarNEQG/
+TEAniDUm5yc9V2emD8/6NZwDK1I7sPQ
=LBzj
-----END PGP SIGNATURE-----

--nextPart3680585.IyljjPciPQ--
