From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH 6/6] Teach core object handling functions about gitlinks
Date: Thu, 12 Apr 2007 00:19:30 +0200
Message-ID: <20070411221930.GN21701@admingilde.org>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org> <Pine.LNX.4.64.0704092115350.6730@woody.linux-foundation.org> <20070411080641.GF21701@admingilde.org> <81b0412b0704110129q56ee0628jafe8fca808ef9ef8@mail.gmail.com> <20070411083642.GH21701@admingilde.org> <7virc3p8zr.fsf@assigned-by-dhcp.cox.net> <20070411100328.GK21701@admingilde.org> <7vmz1eof3m.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOmey7/79ja+7F5w"
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Apr 12 00:19:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HblA8-0007zX-AE
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 00:19:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161280AbXDKWTd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 18:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030459AbXDKWTd
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 18:19:33 -0400
Received: from mail.admingilde.org ([213.95.32.147]:35264 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030342AbXDKWTc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 18:19:32 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HblA2-0000pl-TP; Thu, 12 Apr 2007 00:19:30 +0200
Content-Disposition: inline
In-Reply-To: <7vmz1eof3m.fsf@assigned-by-dhcp.cox.net>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44267>


--BOmey7/79ja+7F5w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Wed, Apr 11, 2007 at 01:01:17PM -0700, Junio C Hamano wrote:
> When you do a "checkout -f --recurse-into-subprojects" from the
> toplevel, I suspect that you would need to detach HEAD in the
> subproject repository grafted in your application tree to move
> it to the exact commit the toplevel project (i.e. your
> application) wants, and match the working tree to that commit.
> The toplevel simply should _not_ have to care what branch that
> commit comes from.

yes.

But why does everybody want to detach the submodule HEAD, instead
of creating one 'special' branch which holds the commit which is
used by the supermodule?

If you then want to switch to another submodule branch you loose
the reference that comes from the supermodule.

I want to create the extra branch exactly _because_ there is
independent work going on in the submodule (or the project it is
based on).  As you can switch between detached HEAD and an
independent branch you can also switch between the 'supermodule branch'
and independent branches -- only that you can easily switch back
if you have an branch of your own.

BTW: I also think that your --recurse-into-subprojects should
be implied.
If you check out one index entry, you should be able to read it
back afterwards.  That is a nice property everyone expects from
normal files and we should try to keep that for submodules.
When checkout_entry wants to touch a submodule we can simply rewrite
the 'supermodule branch' in the submodule.  If HEAD happens to point
to it we also read-tree the submodule.
This is easy to understand and implement and I have some good experience
with this model.

--=20
Martin Waitz

--BOmey7/79ja+7F5w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGHV7yj/Eaxd/oD7IRAkxGAJsGKNdQQuuRX/ijIpXzkSVe79NWRgCfTcFP
CuhAcvkT1Gev2ka+n2PeV0w=
=HbLp
-----END PGP SIGNATURE-----

--BOmey7/79ja+7F5w--
