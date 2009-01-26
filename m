From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 2/2] rebase -i --root: fix check for number of arguments
Date: Mon, 26 Jan 2009 01:07:55 +0100
Message-ID: <200901260108.07402.trast@student.ethz.ch>
References: <alpine.DEB.1.00.0901260029480.14855@racer> <alpine.DEB.1.00.0901260032000.14855@racer>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5257533.j2Olg6rC0s";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 26 01:10:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRF3l-0001TR-L0
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 01:10:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbZAZAIL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 19:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750862AbZAZAIL
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 19:08:11 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:30030 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750834AbZAZAIK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 19:08:10 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 26 Jan 2009 01:08:09 +0100
Received: from thomas.localnet ([77.56.223.244]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 26 Jan 2009 01:08:08 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.25.20-0.1-default; KDE/4.1.96; x86_64; ; )
In-Reply-To: <alpine.DEB.1.00.0901260032000.14855@racer>
X-OriginalArrivalTime: 26 Jan 2009 00:08:09.0036 (UTC) FILETIME=[2B77F8C0:01C97F4A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107144>

--nextPart5257533.j2Olg6rC0s
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Johannes Schindelin wrote:
>=20
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  git-rebase--interactive.sh |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>=20
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 6e2bf25..5df35b2 100755
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -571,7 +571,8 @@ first and then run 'git rebase --continue' again."
>  		;;
>  	--)
>  		shift
> -		test ! -z "$REBASE_ROOT" -o $# -eq 1 -o $# -eq 2 || usage
> +		test -z "$REBASE_ROOT" -a $# -ge 1 -a $# -le 2 ||
> +		test ! -z "$REBASE_ROOT" -a $# -le 1 || usage
>  		test -d "$DOTEST" &&
>  			die "Interactive rebase already started"

Acked-by: Thomas Rast <trast@student.ethz.ch>

I'll postpone 1/2 till I've had enough sleep to check whether
=2D-continue ever needed to know about --root, and either remove or fix
the remembering.  (Sorry for the noise.)

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart5257533.j2Olg6rC0s
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkl8/ucACgkQqUud07tmzP36qACeNFuMB1AeuPNNGtOgH1w8kYYm
ar8An3Tv42mRYS4j9m8VNnvJldCUdzBU
=liMb
-----END PGP SIGNATURE-----

--nextPart5257533.j2Olg6rC0s--
