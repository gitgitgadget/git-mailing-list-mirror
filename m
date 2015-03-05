From: Aschemann Gerd <gerd@aschemann.net>
Subject: Bug? git submodule add SSL certificate problem: unable to get local issuer certificate
Date: Thu, 5 Mar 2015 16:20:10 +0100
Message-ID: <27F61CEE-F1D3-4B7F-B394-8D06A4AD8976@aschemann.net>
References: <F24DBF8D-40EE-4C8D-AE9C-463E59C4AAD7@aschemann.net>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: multipart/signed; boundary="Apple-Mail=_1017851C-DF7F-4DA0-AAAA-50C174D4E8D0"; protocol="application/pgp-signature"; micalg=pgp-sha1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 05 16:20:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTXZU-0000MD-H6
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 16:20:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756344AbbCEPUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2015 10:20:13 -0500
Received: from mail.our-isp.org ([148.251.114.20]:56693 "EHLO mail.our-isp.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751824AbbCEPUN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2015 10:20:13 -0500
Received: from [IPv6:::1] (localhost [127.0.0.1])
	by mail.our-isp.org (Postfix) with ESMTPSA id 06862E02AD;
	Thu,  5 Mar 2015 16:20:11 +0100 (CET)
In-Reply-To: <F24DBF8D-40EE-4C8D-AE9C-463E59C4AAD7@aschemann.net>
X-Mailer: Apple Mail (2.1510)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264840>


--Apple-Mail=_1017851C-DF7F-4DA0-AAAA-50C174D4E8D0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=iso-8859-1

Hi,

seems to be a bug: If adding a submodule from an https URL with a =
certificate issued by StartSSL (or even a private/self-signed one?) =
leads to the following error:

  $ git -c http.sslverify=3Dfalse submodule add =
https://example.com/git/xxx.git
  Cloning into 'xxx'...
  fatal: unable to access 'https://example.com/git/xxx.git/': server =
certificate verification failed. CAfile: =
/etc/ssl/certs/ca-certificates.crt CRLfile: none
  Clone of 'https://example.com/git/xxx.git' into submodule path 'xxx' =
failed

Performing a simple clone works well:

  $ git -c http.sslverify=3Dfalse clone https://example.com/git/xxx.git
  Cloning into 'xxx'...
  Password for 'https://example.com':

Cheers,
  Gerd

--
Gerd Aschemann --- Ver=F6ffentlichen hei=DFt Ver=E4ndern (Carmen Thomas)
+49/173/3264070 -- gerd@aschemann.net -- http://www.aschemann.net


--Apple-Mail=_1017851C-DF7F-4DA0-AAAA-50C174D4E8D0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iEYEARECAAYFAlT4dCoACgkQzwFxgv4fp7tS2wCeKtNXAd++3rBEZXas6qB0NXrp
WOYAn1go7T/xkdQ/3ssOx+Cx8uHsGn/5
=ZHq3
-----END PGP SIGNATURE-----

--Apple-Mail=_1017851C-DF7F-4DA0-AAAA-50C174D4E8D0--
