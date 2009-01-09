From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: Curious about details of optimization of object database...
Date: Fri, 9 Jan 2009 13:07:21 -0600
Message-ID: <200901091307.33483.bss@iguanasuicide.net>
References: <20090109174623.GC12552@seberino.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4057758.qaVKTBKHfy";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: chris@seberino.org
X-From: git-owner@vger.kernel.org Fri Jan 09 20:08:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLMiX-0001tF-MP
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 20:08:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753952AbZAITHA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 14:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753908AbZAITG7
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 14:06:59 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:58987 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753897AbZAITG6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 14:06:58 -0500
Received: from ip72-204-50-125.fv.ks.cox.net ([72.204.50.125] helo=[10.0.0.124])
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LLMh7-0002l2-Tp; Fri, 09 Jan 2009 19:06:58 +0000
User-Agent: KMail/1.9.10
In-Reply-To: <20090109174623.GC12552@seberino.org>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105031>

--nextPart4057758.qaVKTBKHfy
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 2009 January 09 11:46:23 chris@seberino.org wrote:
>I'm told a commit is *not* a patch (diff), but, rather a copy of the entire
>tree.

It's even more than that.  A commit object contains its message, the SHA of=
=20
the tree, and zero or more SHAs for its parents.

>Can anyone say, in a few sentences, how git avoids needing to keep multiple
>slightly different copies of entire files without just storing lots of
>patches/diffs?

Loose objects can have large swaths of duplicated data.  However, git also=
=20
supports storing objects in a packed format, which uses delta compression t=
o=20
reduce the duplication to close to nothing.

Some examples:
Sizes are from "du -sh .git ."; The .git directory stores all the objects a=
s=20
well as the repository configuration, refs, reflogs, etc.  The . directory=
=20
has .git and a clean checkout of master.

The LinuxPMI (http://linuxpmi.org/) tree:
41M     .git
83M     .
(So, the storage is actually a bit smaller than the checkout; 984 objects; =
140=20
commits)

A small project between me an my flatmates:
309K    .git
3.6M    .
(Here, the storage is significantly smaller than the checkout; 786 objects;=
=20
155 commits)

My repository that tracks my dotfiles:
124K    .git
176K    .
(113 objects; 28 commits)
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart4057758.qaVKTBKHfy
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklnoHUACgkQdNbfk+86fC3FCwCdGoXXdt8FbJG2ZlHmBGPf1BIb
ijgAnjY4s4/GbJjtgfljH7uNNpiPmiet
=8YMO
-----END PGP SIGNATURE-----

--nextPart4057758.qaVKTBKHfy--
