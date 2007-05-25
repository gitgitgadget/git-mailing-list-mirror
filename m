From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH 2/3] entry.c: checkout available submodules
Date: Fri, 25 May 2007 23:31:03 +0200
Message-ID: <20070525213103.GA8361@admingilde.org>
References: <1180127233729-git-send-email-skimo@liacs.nl> <1180127233893-git-send-email-skimo@liacs.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Alex Riesen <raa.lkml@gmail.com>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Fri May 25 23:31:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrhNS-0004Sn-Lb
	for gcvg-git@gmane.org; Fri, 25 May 2007 23:31:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756746AbXEYVbG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 17:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756788AbXEYVbG
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 17:31:06 -0400
Received: from mail.admingilde.org ([213.95.32.147]:33525 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756746AbXEYVbF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 17:31:05 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HrhNH-0002Ts-MU; Fri, 25 May 2007 23:31:03 +0200
Content-Disposition: inline
In-Reply-To: <1180127233893-git-send-email-skimo@liacs.nl>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48420>


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Fri, May 25, 2007 at 11:07:12PM +0200, skimo@liacs.nl wrote:
>  create mode 100644 submodules.c
>  create mode 100644 submodules.h

I think the list tends to prefer subproject over submodule.

> @@ -193,9 +220,8 @@ int checkout_entry(struct cache_entry *ce, const stru=
ct checkout *state, char *t
>  		 */
>  		unlink(path);
>  		if (S_ISDIR(st.st_mode)) {
> -			/* If it is a gitlink, leave it alone! */
>  			if (S_ISGITLINK(ntohl(ce->ce_mode)))
> -				return 0;
> +				return checkout_submodule(ce, path, state);
>  			if (!state->force)
>  				return error("%s is a directory", path);
>  			remove_subtree(path);

I think the call to checkout_submodule should be moved to write_entry,
to keep it in line with the other mode types.

Aside from that I really like it :-)

--=20
Martin Waitz

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGV1WXj/Eaxd/oD7IRAjpKAJ95gSPzqijPff6uTgzLU4KXP8onWwCfUcEa
Vjtg2L9LGT/Uw86kLwQ66mk=
=70LI
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
