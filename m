From: Aidan Van Dyk <aidan@highrise.ca>
Subject: Re: [PATCH] Add NO_RSYNC to allow building without rsync
Date: Wed, 30 Jul 2008 15:49:05 -0400
Message-ID: <20080730194905.GI10399@yugib.highrise.ca>
References: <20080730185225.GG10399@yugib.highrise.ca> <alpine.LFD.1.10.0807301231050.3334@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="APlYHCtpeOhspHkB"
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jul 30 21:50:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOHgd-0007sT-Ft
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 21:50:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753390AbYG3TtJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 15:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753148AbYG3TtI
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 15:49:08 -0400
Received: from yugib.highrise.ca ([205.150.199.213]:40335 "EHLO
	yugib.highrise.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752097AbYG3TtH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 15:49:07 -0400
Received: from localhost (yugib.highrise.ca [205.150.199.213])
	by yugib.highrise.ca (Postfix) with ESMTP id A26CF111E39;
	Wed, 30 Jul 2008 15:49:05 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0807301231050.3334@nehalem.linux-foundation.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90843>


--APlYHCtpeOhspHkB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Linus Torvalds <torvalds@linux-foundation.org> [080730 15:42]:
 
> Hmm. Without mkdtemp(), maybe you could just do a trivial compat function 
> somethin glike
> 
> 	char *git_mkdtemp(char *template)
> 	{
> 		char *n = mktemp(template);
> 		if (mkdir(n))
> 			n = NULL;
> 		return n;
> 	}
> 
> instead?


And as I go to whip that up (ya, I'm lazy and just needed a prod), I see
it's already done:

# Define NO_MKDTEMP if you don't have mkdtemp in the C library.

But since rsync isn't available on this compile anyways, I still think
NO_RSYNC is worth having on it's own, just like NO_CURL or NO_TCLTK

a.

-- 
Aidan Van Dyk                                             Create like a god,
aidan@highrise.ca                                       command like a king,
http://www.highrise.ca/                                   work like a slave.

--APlYHCtpeOhspHkB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFIkMWxuVxNPsxNPScRArRAAKCX20S1yX72U/WAvPivFUQGUrlragCfVQm9
6xZ20/5uLiU1BVVWMnJLy4s=
=VyKa
-----END PGP SIGNATURE-----

--APlYHCtpeOhspHkB--
