From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: O(#haves*...) behaviour in "have <sha>" processing in upload-pack
Date: Sat, 13 Sep 2008 14:18:43 +0200
Message-ID: <200809131418.48637.trast@student.ethz.ch>
References: <200809130211.14091.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1539352.cQM8uiMAJP";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 13 14:26:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeUCm-0007G0-Hz
	for gcvg-git-2@gmane.org; Sat, 13 Sep 2008 14:26:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752269AbYIMMSx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Sep 2008 08:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751516AbYIMMSx
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Sep 2008 08:18:53 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:18919 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752667AbYIMMSx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Sep 2008 08:18:53 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 13 Sep 2008 14:18:51 +0200
Received: from [192.168.0.8] ([77.56.223.244]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 13 Sep 2008 14:18:51 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <200809130211.14091.trast@student.ethz.ch>
X-OriginalArrivalTime: 13 Sep 2008 12:18:51.0833 (UTC) FILETIME=[E20BA290:01C9159A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95800>

--nextPart1539352.cQM8uiMAJP
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I wrote:
> * Isn't this ok_to_give_up() test moot?  If H is not in our object
>   store, it cannot be of any use in the transfer (of our history to
>   the client).  So if we are going to fake an ACK to stop the client
>   digging on this side of his history, we might as well send it right
>   away.

Never mind this part, it's wrong:

Let B=3D$(merge-base H W).  Suppose H is unknown to the server, but B is
known.  Then sending a fake ACK as a reply to H will cause

* the client to believe we have everything reachable from H, including
  B, and cease sending any history reachable from H; and thus

* the server to believe that the client does not have B, since it did
  not list this commit in a "have" line.

Sorry for the noise.

=2D Thomas

=2D-=20
Thomas Rast
trast@student.ethz.ch


--nextPart1539352.cQM8uiMAJP
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkjLr6gACgkQqUud07tmzP3jbQCfX6s42FJWB2oRnvLL23G7v8Vv
YCgAn1vTCoZvD1qslEZ9Iqkc5XETnCvh
=wWfS
-----END PGP SIGNATURE-----

--nextPart1539352.cQM8uiMAJP--
