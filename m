From: Jan Hudec <bulb@ucw.cz>
Subject: [Qgit RFC] commit --amend
Date: Sun, 10 Jun 2007 17:08:39 +0200
Message-ID: <20070610150839.GG4084@efreet.light.src>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kjpMrWxdCilgNbo1"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 10 17:08:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxP27-00078K-PY
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 17:08:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbXFJPIo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 11:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751510AbXFJPIo
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 11:08:44 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:55537 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751005AbXFJPIo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 11:08:44 -0400
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id EF27C5759E
	for <git@vger.kernel.org>; Sun, 10 Jun 2007 17:08:42 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1HxP1z-0001LK-Vt
	for git@vger.kernel.org; Sun, 10 Jun 2007 17:08:39 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49744>


--kjpMrWxdCilgNbo1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I am thinking about adding commit --amend support to Qgit.

However I see three ways to do it, so I'd like to ask whether anybody knows
some reason why any of them is better or worse, which I don't:

 - Add a button for "Amend". This would fit with what is there currently,
   because with stgit it has buttons "New patch" and "Add to top" (refresh),
   which correspond exactly to core git's "commit" and "commit --amend"
   respectively.

   Disadvantage (for current approach too) is, that when amending (resp.
   refreshing) the previous commit message is not there to be edited.

 - Add a radio button the way git-gui does. Switching the button to "amend"
   would load the previous commit message.

   This would be more invasive change, but it would allow editing the commit
   message when amending/refreshing. I fear it will be more user-error-prone
   too, though.

 - Add a separate action to the menu. This action would take over the refre=
sh
   (Add to top) operation when using stgit.
  =20
   I believe this has lower risk of user errors than the previous option. It
   also has the advantage, that I don't have to touch the disabling logic f=
or
   the commit action. Amending last commit is always possible, even if there
   are no changes, because you might want to edit the message (eg. if you
   forget to sign-off or forget to mention some change or something).

I'll try doing the first option now, unless somebody persuades me that it's
a nonsense.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--kjpMrWxdCilgNbo1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGbBP3Rel1vVwhjGURApBkAKDMDkLEvRDdNozelWHjOAyOVrZhuACfRRhu
GkWZfO+0N/POf4AgPJxXW20=
=UT8M
-----END PGP SIGNATURE-----

--kjpMrWxdCilgNbo1--
