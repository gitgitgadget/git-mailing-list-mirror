X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: SEGV when lookup_* returns NULL
Date: Mon, 27 Nov 2006 22:13:15 +0100
Message-ID: <20061127211315.GC18810@admingilde.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DKU6Jbt7q3WqK7+M"
NNTP-Posting-Date: Mon, 27 Nov 2006 21:13:26 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32450>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gonmy-0007I1-Lw for gcvg-git@gmane.org; Mon, 27 Nov
 2006 22:13:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758583AbWK0VNR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 16:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758584AbWK0VNR
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 16:13:17 -0500
Received: from agent.admingilde.org ([213.95.21.5]:459 "EHLO
 mail.admingilde.org") by vger.kernel.org with ESMTP id S1758583AbWK0VNQ
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 16:13:16 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1Gonmt-0001F7-AO for git@vger.kernel.org; Mon, 27 Nov 2006 22:13:15 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org


--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

When trying to an unmodified GIT on a repository with submodules
it segfaults a lot.

All the lookup_{blob,tree,commit} functions check that the object
really is of the requested type and return NULL otherwise.
However this NULL pointer is not checked in the calling functions.

Should we make lookup_* to just die when invoked on another object-type?
Or modify all the callers?
Is there a sane error-handling strategy besides dying in this case?
Really checking all the return values in the whole chain would be
a lot of work.

--=20
Martin Waitz

--DKU6Jbt7q3WqK7+M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFa1Tqj/Eaxd/oD7IRAjNtAJ940+c/Z5AvGk/gx2lTCXd5oFYNmgCfccvQ
ph2T49HvIMnLfao8Hx7HfAk=
=OUCc
-----END PGP SIGNATURE-----

