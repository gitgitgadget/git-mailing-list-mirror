From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Poor push performance with large number of refs
Date: Thu, 11 Dec 2014 03:09:49 +0000
Message-ID: <20141211030948.GA137226@vauxhall.crustytoothpaste.net>
References: <20141210003735.GA124293@vauxhall.crustytoothpaste.net>
 <CAJo=hJvKBvQvN=EV4y=ACz5pou9A0tD+txAn_8VR9L3KKtQSiA@mail.gmail.com>
 <20141210233443.GA130424@vauxhall.crustytoothpaste.net>
 <CACsJy8DxXdLsdgP7OKmv8bS1WVPSO_goBaNrttAqd0-ASBgbpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 11 04:10:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xyu8n-0007Q8-H1
	for gcvg-git-2@plane.gmane.org; Thu, 11 Dec 2014 04:10:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933596AbaLKDKD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 22:10:03 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:55239 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933176AbaLKDKB (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Dec 2014 22:10:01 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 9E79E2808F;
	Thu, 11 Dec 2014 03:09:52 +0000 (UTC)
Mail-Followup-To: Duy Nguyen <pclouds@gmail.com>,
	Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACsJy8DxXdLsdgP7OKmv8bS1WVPSO_goBaNrttAqd0-ASBgbpQ@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.17.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261269>


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2014 at 08:41:07AM +0700, Duy Nguyen wrote:
> It could be a regression by fbd4a70 (list-objects: mark more commits
> as edges in mark_edges_uninteresting - 2013-08-16). That commit makes
> --thin a lot more agressive (reading lots of trees). You can try to
> revert that commit (or use a git version without that commit) and see
> if it improves performance. If so, we probably want to enable that
> code for shallow repos only.

That's exactly it.  With Git 2.2.0, --no-thin was 2.295s, --thin was
8.769s, and --thin with the patch reverted was 3.645s.

I'll come up with a patch.  Thanks for the suggestion.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUiQr8AAoJEL9TXYEfUvaL3k8P/1R5eYHtseR6D/5uI74i/Y8x
lk5Aq8gcd0BxEQgSXygYflzPtzLMKtappOF0nePCPZ0qejK0e1n2xAU0Gzwr8f+f
iKFRtpUTH+KvGbLhBUf++PenoROjcpY3cnXD59NN4eTo5egqGmD4WhgaAH2uvaz3
JQJBxJqOYnn6JOlT/or/3JCoxpEmn+QdXrg2S/9d0Kjytd9ghiZ0VALKJWLl915r
GlumnYNZ+yX1yAo5e4q9fDPunnH3/Rv3SaIX0DVw4c8H5id2DOSYAaesEeyoCFeY
k6bDVuUDetRX86nPnswjACF1RevGBBQUrA+47W0Jh62Bn0H7d5TM9TXzxHa1l9CR
6JJgSVtS9V4I16rl1P7EFgWgXdpoWfxRqdavm3ZQBjXZxnmuAYu0keNTxjTB1wvW
QmoTR0ar5MSUINCJcfp9JBatK6pq7L5oyNmJSxGn00nzwVyXZurWv9yERXdtIm6J
Mu/LGuy+sPu4++RkI9IuDAZxVkhA8RV55xCCXAljEGcSv6IENqIkGvpCaf1PWcWX
l05d7w/Kumgl6v/zX5RO6CcyLZne5Zv1bNTaLCbg67MmwvCTjKD1SsBEOy8+2dnB
S+l/BLB3RVlGbSup4h+M4x3n36GVv1NGtbH8bLr4R7Jb1WbOh7xz6nkp3HSZAbCr
Y4uLiqds9GT0yvLfThHK
=YetB
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
