From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Installing on AIX fails
Date: Thu, 3 Jun 2010 15:41:04 +0000
Message-ID: <AANLkTilsQaMQyDP_od2NrfwIV7gvoD3R-yKNlMJjVKCA@mail.gmail.com>
References: <AANLkTinKjEBkn-9ajO4QXyHqY0EOQBGPRgNREaC_p_vQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Dario Rodriguez <soft.d4rio@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 03 17:41:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKCXi-0004AU-Te
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 17:41:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756452Ab0FCPlI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jun 2010 11:41:08 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50811 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756277Ab0FCPlG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jun 2010 11:41:06 -0400
Received: by iwn37 with SMTP id 37so96617iwn.19
        for <git@vger.kernel.org>; Thu, 03 Jun 2010 08:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=n9uxQhNkGx2zOpmhj0skmWjgr7tlDpKWH7qxdHl+2pc=;
        b=MhXF8+uhThEakAUQpBEJ27ZPh8tls7Iztt6fT60ULZ7D60kywpaXkkj/owTxQUI+Z9
         9nqgFvm+1zVitPdWxqvoBH9mGzrriSncbwF25qexlKXB2vG1uAocEtcEkjJ5ccWH7JLN
         RjERct83wehvyXVtEMfE1Blqjy2ZLY6H5j1ZY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=efgwAkFeCXGD91bKR16uOWgYe0Knn88rbHbK0fA6LmfeHOKNyVSwhk+UuWljfFiq/F
         xr9RQhDuchor+n06oSBSfxKIVdp8bPQYyRZnB6uEGXSQ58y/TvP9JjI0VpIb9ICbz7Dr
         wCOU9UgJacmgX4rKZsN4lxpNgqEl/8nd5W448=
Received: by 10.231.184.75 with SMTP id cj11mr12229344ibb.51.1275579664599; 
	Thu, 03 Jun 2010 08:41:04 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Thu, 3 Jun 2010 08:41:04 -0700 (PDT)
In-Reply-To: <AANLkTinKjEBkn-9ajO4QXyHqY0EOQBGPRgNREaC_p_vQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148336>

On Thu, Jun 3, 2010 at 15:32, Dario Rodriguez <soft.d4rio@gmail.com> wr=
ote:
> and it all works, with angels singing and everything... a testing rep=
o
> works fine for a test drive without installing, excepting 'git log'
> that just don't display anything.

How about PAGER=3D/bin/cat git log? If that works what's your pager, an=
d
do other git commands that use the pager (like git show) work or fail?

> $ /usr/linux/bin/make prefix=3D$HOME/apps/ NO_OPENSSL=3D1 NO_TCLTK=3D=
1
> NO_EXPAT=3D1 PYTHON_PATH=3D/usr/local/bin/python install
>
> [...]
> install -d -m 755 '/myhomedir/apps/bin'
> getopt: illegal option -- d
> Usage: install [-c dira] [-f dirb] [-i] [-m] [-M mode] [-O owner]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [-G group] [-S] [-n =
dirc] [-o] [-s] file [dirx ...]
> make: *** [install] Error 2
>
> Now the installing process fails because of the AIX 'install' tool an=
d
> I wonder, can I patch/configure the installing process for AIX? May b=
e
> a set of utils for building in such systems would help some people.

Does AIX's install have something equivalent to GNU install's -d? The
-c and -f options look likely from that synopsis.

> PD2: I don't know if AIX python path is always /usr/local/bin/python,
> but I've seen that git Makefiles set /usr/local/bin/python for FreeBS=
D
> only:
>
> git_remote_helpers/Makefile:
> ifndef PYTHON_PATH
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ifeq ($(uname_S),FreeBSD)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PYTHON_PATH =3D=
 /usr/local/bin/python
> =C2=A0 =C2=A0 =C2=A0 =C2=A0else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PYTHON_PATH =3D=
 /usr/bin/python
> =C2=A0 =C2=A0 =C2=A0 =C2=A0endif
> endif

That's presumably because Python is most likely installed via the
ports system on FreeBSD which drops it in /usr/local. How did you
install Python on AIX? Is it from some IBM package or another method
that's the most common & standard way to do it on AIX?.

If so the Makefile needs a test for AIX similar to the FreeBSD one.
