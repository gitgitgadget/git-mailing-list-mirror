From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Installing on AIX fails
Date: Mon, 7 Jun 2010 00:26:19 +0200
Message-ID: <201006070026.20363.jnareb@gmail.com>
References: <AANLkTinKjEBkn-9ajO4QXyHqY0EOQBGPRgNREaC_p_vQ@mail.gmail.com> <m3631xr9bm.fsf@localhost.localdomain> <AANLkTikbAShMuOvFra8bLT2PmU7s_iUQhr4RY7oD3LLa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tor Arntsen <tor@spacetec.no>, git@vger.kernel.org
To: Dario Rodriguez <soft.d4rio@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 07 00:26:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLOIe-0002DT-6B
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 00:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867Ab0FFW0b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Jun 2010 18:26:31 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48435 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732Ab0FFW0a (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jun 2010 18:26:30 -0400
Received: by wyi11 with SMTP id 11so1991240wyi.19
        for <git@vger.kernel.org>; Sun, 06 Jun 2010 15:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=na8h42n/K4KYp3hV0/PeNNIaR3SYYTJIXdDrL+CXRaE=;
        b=dYwgkjPFzYUojFSOZQfwYfgBsQo609WS70vFPGm6QNsPJtT+D9YMLC7i3mlsRKlyud
         JDXML81cAxFB3KEN9g6vesj5NyOiPxnuohxFi9/VjnTs7NkFGbflmMO/ugMgAjGANMfA
         mA3nf8XJLnu+3RZGfkbiSKzCRhX+py792tl8k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=An1M/A0+MztLBgIKN+B9xigyB5MMJT8mc3/2ROXCGZkG7AAlxXuUw0hGl9M9nP+UFZ
         BrrYs8PyzmdIdu0soPAdFHHncmR59lABJAbWDV0TftPcnxvXRf9Thy6e/khnSKKFh6EY
         nqk9xNuOMJAU2BRR/UFooFmO854u5c4lflN0s=
Received: by 10.227.152.204 with SMTP id h12mr13152358wbw.108.1275863187203;
        Sun, 06 Jun 2010 15:26:27 -0700 (PDT)
Received: from [192.168.1.15] (abwd128.neoplus.adsl.tpnet.pl [83.8.227.128])
        by mx.google.com with ESMTPS id u36sm32228554wbv.0.2010.06.06.15.26.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Jun 2010 15:26:26 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTikbAShMuOvFra8bLT2PmU7s_iUQhr4RY7oD3LLa@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148557>

On Sat, 5 Jun 2010, Dario Rodriguez wrote:
> On Sat, Jun 5, 2010 at 8:44 AM, Jakub Narebski <jnareb@gmail.com> wro=
te:
>> Tor Arntsen <tor@spacetec.no> writes:
>>>
>>> Maybe you could get away with just using the script-version of inst=
all
>>> which comes with coreutils itself (because it'll need an install to=
ol
>>> to use before 'install' itself is installed..).
>>>
>>> I'm attaching a copy. To use it it should be sufficient to use
>>> INSTALL=3Dpath-to/install-sh make install
>>> or something like that.
>>
>> I wonder if it would be better to simply include fallback portable
>> install-sh in git sources.
>>
>> BTW. shouldn't we define and use INSTALL_D in Makefile?
>=20
> I think so about the install-sh, but about the Makefiles I wonder if
> it's not better to reuse current INSTALL, maybe if install-sh is used=
,
> then there is no need for using other 'install' program, excepting th=
e
> case in wich the user sets INSTALL commandline.

Well, if there were install-sh script in git sources, we could uncommen=
t

  #AC_PROG_INSTALL          # needs install-sh or install.sh in sources

line in configure.ac, then ./configure would automatically detect and
select 'install' program or script to use.  The autoconf documentation
(autoconf.info) says:

  This macro screens out various instances of `install' known not to
  work.  It prefers to find a C program rather than a shell script,
  for speed. [...]

  Autoconf comes with a copy of `install-sh' that you can use.  If
  you use `AC_PROG_INSTALL', you must include either `install-sh' or
  `install.sh' in your distribution, or `configure' will produce an
  error message saying it can't find them--even if the system you're
  on has a good `install' program.  This check is a safety measure
  to prevent you from accidentally leaving that file out, which
  would prevent your package from installing on systems that don't
  have a BSD-compatible `install' program.

So I guess we should also prefer install program for speed, even if we
do not use ./configure script.

--=20
Jakub Nar=C4=99bski
Poland
