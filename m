From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: Re: Git does not handle changing inode numbers well
Date: Wed, 8 Aug 2012 20:34:11 +0200
Message-ID: <20120808183411.GT21274@login.drsnuggles.stderr.nl>
References: <20120808152230.GQ21274@login.drsnuggles.stderr.nl> <7vboiltglr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HqPpMaT+a6TeY/Q4"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 20:34:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzB5K-0000rW-Fo
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 20:34:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758373Ab2HHSeS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 14:34:18 -0400
Received: from drsnuggles.stderr.nl ([94.142.244.14]:42625 "EHLO
	drsnuggles.stderr.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752693Ab2HHSeR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 14:34:17 -0400
Received: from login.drsnuggles.stderr.nl ([10.42.0.9] ident=mail)
	by mail.drsnuggles.stderr.nl with smtp (Exim 4.69)
	(envelope-from <matthijs@stdin.nl>)
	id 1SzB59-0004dB-DI; Wed, 08 Aug 2012 20:34:12 +0200
Received: (nullmailer pid 17802 invoked by uid 1000);
	Wed, 08 Aug 2012 18:34:11 -0000
Mail-Followup-To: Matthijs Kooijman <matthijs@stdin.nl>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vboiltglr.fsf@alter.siamese.dyndns.org>
X-PGP-Fingerprint: 7F6A 9F44 2820 18E2 18DE  24AA CF49 D0E6 8A2F AFBC
X-PGP-Key: http://www.stderr.nl/static/files/gpg_pubkey.asc
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Score: -2.6 (--)
X-Spam-Report: Spamchecked on "mail.drsnuggles.stderr.nl"
	pts  rule name              description
	---- ---------------------- -------------------------------------------
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203110>


--HqPpMaT+a6TeY/Q4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Junio,

> -	if (ce->ce_ino != (unsigned int) st->st_ino)
> +	if (trust_inum && ce->ce_ino != (unsigned int) st->st_ino)
>  		changed |= INODE_CHANGED;

I just tried this with 1.7.10 (that is, I deleted these two lines to
mimic trust_inum being false) and it indeed fixes my problem.

(I'll probably won't be implementing the full patch, though, I've
already figured out how to fix my filesystem instead)

Gr.

Matthijs

--HqPpMaT+a6TeY/Q4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAlAisSMACgkQz0nQ5oovr7xfyACgkEMYoJ0oNCLPMKqe2lTPT36L
hQ0AoJx8JFvQbP3XWFDXoYR1J3hfeWGb
=fD1i
-----END PGP SIGNATURE-----

--HqPpMaT+a6TeY/Q4--
