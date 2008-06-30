From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH 13/13] Build in merge
Date: Tue, 1 Jul 2008 00:58:27 +0200
Message-ID: <20080630225827.GR4729@genesis.frugalware.org>
References: <e8d1385cc49a06ca3fae28231ebc66a333ce4ffb.1214789764.git.vmiklos@frugalware.org> <486961C7.2090603@free.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TYjWXklH5JTzT8n9"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Olivier Marin <dkr+ml.git@free.fr>
X-From: git-owner@vger.kernel.org Tue Jul 01 00:59:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDSLG-0000JQ-SA
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 00:59:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763071AbYF3W6a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 18:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763875AbYF3W6a
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 18:58:30 -0400
Received: from virgo.iok.hu ([193.202.89.103]:44915 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763071AbYF3W63 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 18:58:29 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 0451F1B2540;
	Tue,  1 Jul 2008 00:58:27 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id D487E4465E;
	Tue,  1 Jul 2008 00:29:57 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id C893F11901EE; Tue,  1 Jul 2008 00:58:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <486961C7.2090603@free.fr>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86961>


--TYjWXklH5JTzT8n9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 01, 2008 at 12:44:23AM +0200, Olivier Marin <dkr+ml.git@free.fr=
> wrote:
> > +	if (new_head && show_diffstat) {
> > +		struct diff_options opts;
> > +		diff_setup(&opts);
> > +		opts.output_format |=3D
> > +			DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT;
> > +		opts.detect_rename =3D DIFF_DETECT_RENAME;
> > +		if (diff_use_color_default > 0)
> > +			DIFF_OPT_SET(&opts, COLOR_DIFF);
>=20
> Ah, I missed that. You should call diff_setup_done(), to finish diff_setu=
p()
> and have a recursive diffstat.
>=20
> For example:
>=20
> $ git checkout -b test c0f5c69
> $ git merge 2dce956
> Updating c0f5c69..2dce956
> Fast forward
>  help.c |   22 ++++++++++++++--------
>  1 files changed, 14 insertions(+), 8 deletions(-)
>=20
> is wrong. Correct diffstat is:
>=20
> $ git diff --stat c0f5c69..2dce956
>  Documentation/gitcli.txt        |   37 +++++++++++++++++++++++++++++++++=
----
>  Documentation/gittutorial-2.txt |   10 +++++-----
>  help.c                          |   22 ++++++++++++++--------
>  t/test-lib.sh                   |    2 +-
>  4 files changed, 53 insertions(+), 18 deletions(-)

Fixed in my working branch.

> > +	git_config(git_merge_config, NULL);
> > +
> > +	/* for color.diff and diff.color */
> > +	git_config(git_diff_ui_config, NULL);
>=20
> Also, what about doing "return git_diff_ui_config(k, v, cb)" at the end of
> git_merge_config() instead, to avoid parsing config files twice.

Sure, changed.

Thanks! :)

--TYjWXklH5JTzT8n9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhpZRMACgkQe81tAgORUJYMEQCbBHoex84sjGGQa/iXZ3AaDrQ8
vmQAnA8EI+Nn+0z8OL6r3OmoPuVOMSWn
=hjGr
-----END PGP SIGNATURE-----

--TYjWXklH5JTzT8n9--
