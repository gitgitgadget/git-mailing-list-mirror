From: Greg Troxel <gdt@ir.bbn.com>
Subject: Re: Q: do people compile with NO_FNMATCH on OpenBSD 5.2?
Date: Thu, 20 Dec 2012 13:54:43 -0500
Message-ID: <rmi8v8sy2oc.fsf@fnord.ir.bbn.com>
References: <7va9tbf7vd.fsf@alter.siamese.dyndns.org>
	<rmisj732jop.fsf@fnord.ir.bbn.com>
	<7vzk1bdqy0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: git@vger.kernel.org, Arnout Engelen <arnouten@bzzt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 20 19:55:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TllGo-0007VG-Ak
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 19:55:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752081Ab2LTSyp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 13:54:45 -0500
Received: from fnord.ir.bbn.com ([192.1.100.210]:55926 "EHLO fnord.ir.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751582Ab2LTSyn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 13:54:43 -0500
Received: by fnord.ir.bbn.com (Postfix, from userid 10853)
	id 08A42BCF7; Thu, 20 Dec 2012 13:54:43 -0500 (EST)
OpenPGP: id=32611E25
X-Hashcash: 1:20:121220:git@vger.kernel.org::25KxM3BX6DNgkr9U:0000000000000000000000000000000000000000000iXr
X-Hashcash: 1:20:121220:gitster@pobox.com::25KxM3BX6DNgkr9U:0000000000000000000000000000000000000000000016JM
X-Hashcash: 1:20:121220:arnouten@bzzt.net::25KxM3BX6DNgkr9U:000000000000000000000000000000000000000000004s5i
In-Reply-To: <7vzk1bdqy0.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 18 Dec 2012 12:51:35 -0800")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/23.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211918>

--=-=-=
Content-Type: text/plain


  [mkstemp truncating output on error]

  diff --git c/wrapper.c w/wrapper.c
  index 68739aa..a066e2e 100644
  --- c/wrapper.c
  +++ w/wrapper.c
  @@ -229,7 +229,7 @@ int xmkstemp(char *template)
                  int saved_errno = errno;
                  const char *nonrelative_template;

  -		if (!template[0])
  +		if (strlen(template) != strlen(origtemplate))
                          template = origtemplate;

                  nonrelative_template = absolute_path(template);

Thanks for the quick fix.

I applied this patch to 1.8.0.1, and then the tests get all the way to
t1402 (separate msg when I figure out why).


--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iEYEARECAAYFAlDTXvMACgkQ+vesoDJhHiVgHQCgtc0QY8VLXTzMUb5409omAYEZ
b8sAn3a0nGlx5oI8617r/1gAhLAfp/Oo
=xCD7
-----END PGP SIGNATURE-----
--=-=-=--
