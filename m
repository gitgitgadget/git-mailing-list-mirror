From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] builtin-merge: missing structure bzero.
Date: Mon, 21 Jul 2008 19:21:19 +0200
Message-ID: <20080721172119.GE32057@genesis.frugalware.org>
References: <1216659830-22063-1-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fig2xvG2VGoz8o/s"
Cc: git@vger.kernel.org, gitster@pobox.com
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Jul 21 19:22:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKz5Z-0000Td-IC
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 19:22:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbYGURVW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 13:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbYGURVW
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 13:21:22 -0400
Received: from virgo.iok.hu ([193.202.89.103]:52279 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750967AbYGURVV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 13:21:21 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 78F851B2500;
	Mon, 21 Jul 2008 19:21:20 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 2A31B4465E;
	Mon, 21 Jul 2008 18:41:04 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id B1B9811901B3; Mon, 21 Jul 2008 19:21:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1216659830-22063-1-git-send-email-madcoder@debian.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89367>


--Fig2xvG2VGoz8o/s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 21, 2008 at 07:03:50PM +0200, Pierre Habouzit <madcoder@debian.org> wrote:
> This cause segfaults when replacing a directory with a submodule in a
> fast-forward.

Thanks.

> +test_expect_failure 'Replace a directory with a submodule, with a file conflict' '
> +	mkdir test &&
> +	cd test &&
> +	: create our repository with a sub/a file &&
> +	git init &&
> +	mkdir sub && echo a > sub/a &&
> +	git add sub && git commit -asm"initial repository" &&
> +	: save this state in a new branch &&
> +	git branch temp &&
> +	: then replace sub with it &&
> +	git rm -rf sub &&
> +        git submodule add -- "$(pwd)/../submodule/.git/" sub &&
> +	git commit -asm "replace sub/ with a submodule" &&
> +	: then try to update the "temp" branch &&
> +	git checkout temp &&

It seems this one fails. I guess this will be a problem in the low-level
merge code (read-tree -m) and not in builtin-merge.

> +	git merge master &&
> +	: and finally cleanse the mess &&
> +	cd .. &&
> +	rm -rf test
> +'
> +
> +test_done

--Fig2xvG2VGoz8o/s
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiExY8ACgkQe81tAgORUJZizQCgpJUSiA25w6FZ44FzxHEjaUZr
lKcAmgPfjlVuCeHmu3Y2C2R1SCtc4Onj
=rgzR
-----END PGP SIGNATURE-----

--Fig2xvG2VGoz8o/s--
