From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] remote-curl: don't fall back to Basic auth if we haven't
 tried Negotiate
Date: Fri, 5 Feb 2016 20:46:48 +0000
Message-ID: <20160205204648.GA7403@vauxhall.crustytoothpaste.net>
References: <1454404284-2197-1-git-send-email-dmitry.a.vilkov@gmail.com>
 <xmqqegcusvb4.fsf@gitster.mtv.corp.google.com>
 <20160202232952.GA6503@vauxhall.crustytoothpaste.net>
 <CAHdYDCqtNQMoU3Gu2AcSEWM5wA0SbaMrivu3WV_-N+B-F67v1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Dmitry Vilkov <dmitry.a.vilkov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 21:47:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRnHP-0007z4-OF
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 21:47:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756985AbcBEUq4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 15:46:56 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:54554 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754386AbcBEUqx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Feb 2016 15:46:53 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:f2de:f1ff:feb8:36fd])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 79E9A282CA;
	Fri,  5 Feb 2016 20:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1454705210;
	bh=r6mO0t6NrwPMFHYUSrvf4+cYUvxn5nC5pGPTrbSbLy4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J3lQRHRQBaVXz/ZfdbKdsamE7ZUZwqy6soVqh12UPiHGxZlhcz5jjRvruk1x+YTQ/
	 pPmGCmB95R+UQR5/lHDw+gE85GLgBjwSOT4PDc0V9TLhhCQjEVo08iGVbnpuFwtmNp
	 XWcW3QVShxyMCd4GihvaQC93xI1zdq0KuaiPgjKiYm8bZOAL3eDekAoHa/AkaKCN5R
	 4ix192JSIp/DYcyC9bY7ImkTKZdHi9Hj8NKDW+yMy6xoTQvm/zAIRQ6sfD3xiZQNGk
	 KvWlL1cWbsGXhZIgdAmLuUNtWv9hEicTC5hSl5Z9Q+bB4EB2R8J6hDNDo3+yvBiHRn
	 uWxrkOJIlxsh/iA0ui3bbAPlLA3R+1VIcTG5KBf9jNpoOzyuUZUTa9kLQ7R0THASEH
	 /LFgVY+69CqSOXPYGqU4yObDmmovxpqTfJCDIZVcN/7mqM/Qq0AIYV/GO/aoJj8Ezj
	 ZAARc8Tfbe+9a9feen4lOgL/0OonPWJo8uYR6dwreL2SzPzFXbk
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Dmitry Vilkov <dmitry.a.vilkov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <CAHdYDCqtNQMoU3Gu2AcSEWM5wA0SbaMrivu3WV_-N+B-F67v1Q@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.3.0-1-amd64)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285628>


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 05, 2016 at 12:18:22PM +0300, Dmitry Vilkov wrote:
> You are right, we are using a bare URL (without a username component).
> With username encoded in URL everything works just fine. But it's
> generally wrong to pass creds in URL (in my opinion) and security
> policy of my employer prohibits doing such thing.
> Anyway, as you said libcurl needs valid (not NULL) username/password
> to do GSS-Negotiate, so there is nothing wrong if I set empty
> username/password combination when git prompts for creds. Even more,
> there is no other way to let libcurl to use GSS-Negotiate without
> username in URL.

You can literally do https://:@git.crustytoothpaste.net/git/repo.git as
the URL, and that will work.  GSS-Negotiate using Kerberos passes the
ticket, which contains the principal name in it, so an actual username
and password is not needed at all.  libcurl just needs something to tell
it to do authentication.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.11 (GNU/Linux)

iQIcBAEBCgAGBQJWtQo3AAoJEL9TXYEfUvaL91IQAKmmLnaLCuxHyZFAIhgf/oKH
+EGQW/8ViRDLDIVtpG1zA3rKDcxrmf8yLkEJnK447vssyeSlwGISlkMlBBMil+SD
JqMKBDIT8Ycr7CqX4r/XeEEqNGNWShkgTV+dfAgHTFyKFeBtEOfzLqEP0HQMs9Zm
ckIYDMJDHJ+1JnwpX3aWeCj5ZX2stLi5u6UBliJaApeQIm11erWaG0c2OjpDgFdA
Jpquf/0TOQNvzLmiRNfmNImSOj+/e1Zn0iF/CgkfHFUz0nKiyvR0HL351T3+J1Ch
BE89FgdoYtTF18uRyIwy0mv4ITMqcYEcluCbhKte/TXnqSc2i0sffUfF/UOVuzxy
HZGJbBsuHpoEpXJ0/DR/aJMkq+0gKIgqEJtCzvuzULNRaUO1ANWvoQqB8EP/iCl4
1Fi8+lxF0BF0ZBYyOCEg/cjCw/M+g9d0BA3ttJ/LO/QvfTL+z+PJ5tf1LWzRJW57
L3d5vnup/3ADH+b+VK782jQqS/OglFI6dLbg2sYqk6+maeGeKldUrTaa7M6NJQct
MS9aUiXtwd9Gr00DJqBVaFXkJ5Tgh9LFKXVLUkO2iEoUaDUE99bqa94ZHBqQxFu+
Vd7IvUf71FaJ7MUboQCOmKWBPa+q/KSsvC4SXgSLAFPGZxwq4HfaIKBnZID9UnnB
ZynQ86Vrixl7u8LuCHed
=hzET
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
