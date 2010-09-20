From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [tig] Re: compilation error: undefined reference to `set_tabsize'
Date: Mon, 20 Sep 2010 22:43:44 +0200
Message-ID: <20100920204344.GB13017@vidovic>
References: <20100920174200.GA13017@vidovic>
 <loom.20100920T203217-346@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: Stefan =?iso-8859-1?Q?N=E4we?= <stefan.naewe@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Sep 20 22:44:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxnDy-0006Zm-Rt
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 22:44:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756387Ab0ITUoZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Sep 2010 16:44:25 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:45549 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753257Ab0ITUoY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 16:44:24 -0400
Received: by wwj40 with SMTP id 40so18349wwj.1
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 13:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=vLSjXt5uhZlYnHCpbYB7gpefcZ3NmaEqbA5w0DOHSE4=;
        b=Jc4xzFGkUO3bS6SGb6c6PSds3lI5Y/OdIX4ZxcM3M+rtw5OD4AxdmXXc5JEPRFASyA
         BYMOtx2eKnDCwvvGG1O+BeCpSQmXtnWRV3Y3/pUMLFpA4mJ8pAXS48cA2ArVylFJWg59
         zV4psjsAxHzipzVqZ8JTi0zLLpBBIGCnkPFP0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=pQg4b8B200BMy1aaG7HZl/M4GmRWdHyQlKpKt5VogStzNCzEVyUsu0Jr2mY9RTKCBY
         Xtu8Fj65D3LdTToFUMIIgbTxOowL9QQUtULYCWne1bIPnn58kBWLdNT3z9z+gzhW5CAg
         mFV1SE3dnQYmECuA2LzuAuKAB9ouVWniiAP54=
Received: by 10.227.133.18 with SMTP id d18mr2387580wbt.33.1285015427682;
        Mon, 20 Sep 2010 13:43:47 -0700 (PDT)
Received: from vidovic (aqu33-8-83-155-187-36.fbx.proxad.net [83.155.187.36])
        by mx.google.com with ESMTPS id bc3sm2180377wbb.20.2010.09.20.13.43.46
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 20 Sep 2010 13:43:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <loom.20100920T203217-346@post.gmane.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156667>

The 20/09/10, Stefan N=E4we wrote:
> Nicolas Sebrecht <nicolas.s.dev <at> gmx.fr> writes:
>=20
> >=20
> > Hi,
> >=20
> > tig don't compile anymore here:
> >=20
> >   % make
> >   gcc   tig.o  -lncursesw  -o tig
> >   tig.o: In function `init_display': tig.c:7113: undefined referenc=
e to=20
> `set_tabsize'
> >   collect2: ld returned 1 exit status
> >   make: *** [tig] Error 1
> >   %
> >=20
> > and bisected on
> >=20
> > commit f1fe753be71ef3ce5abcbb16c2a359f97e5c7e7d
> > Author: Stefan Naewe <>
> > Date:   Sun Sep 12 11:03:52 2010 +0200
> >=20
> >     Use function set_tabsize()
> >=20
> >     this fixes the following compile error on cygwin:
> >     tig.c: In function `init_display':
> >     tig.c:7112: error: invalid lvalue in assignment
>=20
> That change works for me on Cygwin, Ubuntu 10.04, Debian 5.0.6
>=20
> Maybe you should say something about your system/OS version ?

Naturally. I'm running on Gentoo.

  % gcc -v
  Using built-in specs.
  Target: x86_64-pc-linux-gnu
  Configured with:
  /var/tmp/portage/sys-devel/gcc-4.1.2/work/gcc-4.1.2/configure
  --prefix=3D/usr --bindir=3D/usr/x86_64-pc-linux-gnu/gcc-bin/4.1.2
  --includedir=3D/usr/lib/gcc/x86_64-pc-linux-gnu/4.1.2/include
  --datadir=3D/usr/share/gcc-data/x86_64-pc-linux-gnu/4.1.2
  --mandir=3D/usr/share/gcc-data/x86_64-pc-linux-gnu/4.1.2/man
  --infodir=3D/usr/share/gcc-data/x86_64-pc-linux-gnu/4.1.2/info
  --with-gxx-include-dir=3D/usr/lib/gcc/x86_64-pc-linux-gnu/4.1.2/inclu=
de/g++-v4
  --host=3Dx86_64-pc-linux-gnu --build=3Dx86_64-pc-linux-gnu --disable-=
altivec
  --enable-nls --without-included-gettext --with-system-zlib
  --disable-checking --disable-werror --enable-secureplt --enable-multi=
lib
  --enable-libmudflap --disable-libssp --enable-java-awt=3Dgtk
  --enable-languages=3Dc,c++,java,treelang,fortran --enable-shared
  --enable-threads=3Dposix --enable-__cxa_atexit --enable-clocale=3Dgnu
  Thread model: posix
  gcc version 4.1.2 (Gentoo 4.1.2 p1.3)
  %

--=20
Nicolas Sebrecht
