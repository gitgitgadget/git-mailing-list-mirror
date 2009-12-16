From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: How do I show only log messages for commits on a specific
 branch?
Date: Thu, 17 Dec 2009 00:26:42 +0100
Message-ID: <20091216232641.GK25474@genesis.frugalware.org>
References: <20091216101647.GB27373@bc-bd.org>
 <51419b2c0912161005n1596d4a1n92ed555c98aee4c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dMdWWqg3F2Dv/qfw"
Cc: bd@bc-bd.org, git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 17 00:27:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NL3Gr-0002qN-C2
	for gcvg-git-2@lo.gmane.org; Thu, 17 Dec 2009 00:27:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935924AbZLPX0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2009 18:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935923AbZLPX0q
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Dec 2009 18:26:46 -0500
Received: from virgo.iok.hu ([212.40.97.103]:38804 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935919AbZLPX0o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2009 18:26:44 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id A2E7D58055;
	Thu, 17 Dec 2009 00:26:42 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 6E2C344965;
	Thu, 17 Dec 2009 00:26:42 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 113D01240014; Thu, 17 Dec 2009 00:26:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <51419b2c0912161005n1596d4a1n92ed555c98aee4c6@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135344>


--dMdWWqg3F2Dv/qfw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 16, 2009 at 11:05:52AM -0700, Elijah Newren <newren@gmail.com> wrote:
>   git log new@{30.years.ago}..new
> (You'll get a warning that 'new' hasn't existed for 30 years but it
> doesn't hurt anything)

That's the same as "git log new", if I'm not mistaken.

What Stefan wants to do is to let git log show the commits which are
only in the "new" branch, but I don't think there is an out-of-the-box
solution for that.

One solution I can think of is to iterate over each ref using "git
for-each-ref --format='%(refname)' 'refs/heads/*'", then run "git
merge-base $i new", run git rev-list $mb..new|wc -l and then you could
decide what is the first commit that does not belong to any other
branch. But that's just an idea, I don't have the motivation to script
it properly.

--dMdWWqg3F2Dv/qfw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkspbLEACgkQe81tAgORUJacnACfW8sL7lW+c784cpXOj5IVzTUZ
njEAnioaBu6uisPuCZuscn9G6oOcZU+J
=L7RW
-----END PGP SIGNATURE-----

--dMdWWqg3F2Dv/qfw--
