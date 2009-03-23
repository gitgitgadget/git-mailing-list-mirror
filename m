From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: git rebase + fuzz = possible bad merge
Date: Mon, 23 Mar 2009 14:54:43 +0100
Message-ID: <200903231454.48600.trast@student.ethz.ch>
References: <49C7675E.9000309@panasas.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3789119.u2Lek9ZNTh";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Benny Halevy <bhalevy@panasas.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 14:57:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Llkee-0002Ir-Bw
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 14:57:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753610AbZCWNz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 09:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751779AbZCWNz1
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 09:55:27 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:32436 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756781AbZCWNzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 09:55:25 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 23 Mar 2009 14:55:21 +0100
Received: from thomas.localnet ([129.132.153.233]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 23 Mar 2009 14:55:21 +0100
User-Agent: KMail/1.11.1 (Linux/2.6.27.19-3.2-default; KDE/4.2.1; x86_64; ; )
In-Reply-To: <49C7675E.9000309@panasas.com>
X-OriginalArrivalTime: 23 Mar 2009 13:55:21.0625 (UTC) FILETIME=[01EE0890:01C9ABBF]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114303>

--nextPart3789119.u2Lek9ZNTh
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Benny Halevy wrote:
> I'm hitting bad merges with (non interactive) git rebase
> when a hunk is merged pre-maturely into an inexact match
> when there's fuzz.
[...]
> { for i in {1..10}; do echo fuzz $i; done; echo; cat test_file; } > fuzz_=
file
[...]
> git rebase --onto test_branch master^ master

git-am, and by extension rebase, by default doesn't take history into
account.  It just applies the patches "blindly".  Thus, there's no way
to know which series of 'line N' you really wanted it to go onto.

To avoid this issue, use the -m option to git-rebase so that it uses a
"real" merge.  (You can achieve similar effects for git-am with the -3
option.)

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart3789119.u2Lek9ZNTh
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAknHlKgACgkQqUud07tmzP33PwCfcVxUcR4oG2OORulKVbjrdcT5
+nQAn2XkCBuABIJvpXyoKFjZJvVc0f4p
=/WgE
-----END PGP SIGNATURE-----

--nextPart3789119.u2Lek9ZNTh--
