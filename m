From: XANi <xani666@gmail.com>
Subject: [BUG] Veryfing signatures in git log fails when language is not
 english
Date: Thu, 14 Feb 2013 01:18:37 +0100
Message-ID: <20130214011837.04880b3e@hydra.devrandom.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/IafX5ms1Wl3YfNANkX/YIu/"; protocol="application/pgp-signature"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 14 01:19:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5mXy-0002An-5D
	for gcvg-git-2@plane.gmane.org; Thu, 14 Feb 2013 01:19:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761306Ab3BNATA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2013 19:19:00 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:46175 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752887Ab3BNAS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2013 19:18:59 -0500
Received: by mail-ee0-f46.google.com with SMTP id e49so968675eek.19
        for <git@vger.kernel.org>; Wed, 13 Feb 2013 16:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:subject:message-id:x-mailer:mime-version
         :content-type;
        bh=dzwcUAVWgC90i8D6hyBTFpKrOpvtuIZRowX1jxrTfio=;
        b=lIzfQqJ8ORzGZeBFwAApdPmHj1RE4GVXI5IuzhLTP/DLeiPa6Br0D+f/V2HYw06P4K
         Kk9XajZqFLIWyzlOwpjUYnk98YpMLMEfY7piDRvOX9GI1EiQ6HbKuDLAGE12aH1qaCOl
         4mOLR4AyCQ8qOolNqjKSXWtPaU/n98Fc/Tr9Iw5M82TC04kjiKG8PE7wQ4jxeFeFjqVA
         y6sdmOkR/mL8GZRO3t8fw2EufDgopQecmlLPFMwk8B6jGlVDihj7gEfleCvsREZ67OKi
         Xy0qLEZRhtwi2PLjE1m+h+cMOFAI0n0HUAsdXiakQQYXro0919aMLWVAb+IiOMMLl+nJ
         BurQ==
X-Received: by 10.14.179.5 with SMTP id g5mr80602351eem.41.1360801137738;
        Wed, 13 Feb 2013 16:18:57 -0800 (PST)
Received: from hydra.devrandom.pl (aeqx143.neoplus.adsl.tpnet.pl. [79.191.179.143])
        by mx.google.com with ESMTPS id q5sm75869670eep.11.2013.02.13.16.18.56
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 13 Feb 2013 16:18:57 -0800 (PST)
X-Mailer: Claws Mail 3.8.1 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216294>

--Sig_/IafX5ms1Wl3YfNANkX/YIu/
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

any functionality that depends on exact exit msg of program
 can potentially fail because of that
=E1=9B=AF export |grep LANG
declare -x LANG=3D"pl_PL.UTF-8"

=E1=9B=AF ~/src/os/git/git log --format=3D"%G? %h" |head -2=20
 0d19377
 5b9d7f8

=E1=9B=AF unset LANG
=E1=9B=AF ~/src/os/git/git log --format=3D"%G? %h" |head -2
G 0d19377
G 5b9d7f8

tested against maint (d32805d) and master (5bf72ed)

maybe git should set up some output-changing variables before calling
external programs? I think setting LC_ALL=3DC should be enougth.

--=20
Mariusz Gronczewski (XANi) <xani666@gmail.com>
GnuPG: 0xEA8ACE64



--Sig_/IafX5ms1Wl3YfNANkX/YIu/
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRHC1eAAoJEK6jAYnqis5kursQAJRQp82aPiSSwdz9PMtS+Ffi
B9YWcVaFuRagK1QvKfItNDBIRFLcy4nksD6CZdabzeIWPcIbg7WCm1SKCWtwsCLC
TikZqshWIj55Ow3cDAKy3oeNlEeTTHR8RJZsZO/cfD880eqXsHD34tTtotGL4HQ3
lXQ1eyrC8m4S+cuQotPeNdB1Fgx+PRgnYJ4mJ3iVfa/WIqfHuzGHXS1vOVHIQGQw
i/S/ziCDVm3mlWg1M0cTSqP3fJDwCqp9eRMMWAb1+jrmzhBIaHUvOpDxG8b3JoL3
dDD2VwSHm4rOhYcBSW3DnqXjyiu7EOCHMnKn3u0E+ISRdF2EdtWwXwrB0ynpQytD
s8iYLVQ4RUFfRJEwM7t8efgMCZy3pTPw0Q/ssF7yxEINwIR5AUQeX9Q0Jk/56FyA
ADS7uN+aEU7gZmDs0lfJEeFgknysz2sNc83VF3CrS4YwNg1qQMbNX0e298D2XhqM
yQNs/tWbK0J1bsmSSh7s6JCDNIuWfMZeaPqFgjgJTnBF49Y24ex79p7sNaCTZ6O3
0PW3LdwtI0chS8yg++BoPp+4OWcfdeDHdJLi4Ry4RkmlaAQF7Arer93fCv7Abf5u
YAJsN6Q129FRfPmAVPS5yQm0gIlOZ3b1zsm90aFa2YdwR/StSBtASKOPpm8SxSLq
LJzusLaRUdhAPQch8sGY
=vGhM
-----END PGP SIGNATURE-----

--Sig_/IafX5ms1Wl3YfNANkX/YIu/--
