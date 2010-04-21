From: Michael Olson <mwolson@member.fsf.org>
Subject: Re: git svn clone of subversion's own code failing
Date: Wed, 21 Apr 2010 14:18:46 -0700
Message-ID: <i2qc8b3bef91004211418x1496785dqce43607ad1a49e65@mail.gmail.com>
References: <B3F7BC3A-9606-48BF-A0C8-093CA42B3720@orcaware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Blair Zajac <Blair@orcaware.com>
X-From: git-owner@vger.kernel.org Wed Apr 21 23:19:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4hKT-0000z8-4S
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 23:19:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755213Ab0DUVTJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Apr 2010 17:19:09 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:65274 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754562Ab0DUVTG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Apr 2010 17:19:06 -0400
Received: by vws18 with SMTP id 18so356291vws.19
        for <git@vger.kernel.org>; Wed, 21 Apr 2010 14:19:06 -0700 (PDT)
Received: by 10.220.81.20 with HTTP; Wed, 21 Apr 2010 14:18:46 -0700 (PDT)
X-Originating-IP: [209.104.55.5]
In-Reply-To: <B3F7BC3A-9606-48BF-A0C8-093CA42B3720@orcaware.com>
X-Google-Sender-Auth: f4e4b2adee11d9a8
Received: by 10.220.47.219 with SMTP id o27mr6125658vcf.69.1271884746210; Wed, 
	21 Apr 2010 14:19:06 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145457>

On Wed, Apr 21, 2010 at 11:55 AM, Blair Zajac <Blair@orcaware.com> wrot=
e:
> Using MacPorts with git 1.7.0.4 and Subversion 1.6.11, ironically, cl=
oning Subversion's own source code is failing. =C2=A0I'm using a larger=
 log window size to make the scan to svn's first commit in the reposito=
ry much faster:
>
> $ git svn clone --log-window-size 5000 -s https://svn.apache.org/repo=
s/asf/subversion
>
> It ends up failing with:
>
> r855619 =3D c93a05b8f94c53b8748ffe9352445209fe648e87 (refs/remotes/tr=
unk)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0M =C2=A0 =C2=A0 =C2=A0 contrib/client-side=
/svn-clean
> r855620 =3D a6b138d3112b1ea0b51b112c6598aae5644369ae (refs/remotes/tr=
unk)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0M =C2=A0 =C2=A0 =C2=A0 subversion/bindings=
/swig/core.i
> =C2=A0 =C2=A0 =C2=A0 =C2=A0M =C2=A0 =C2=A0 =C2=A0 subversion/bindings=
/swig/python/libsvn_swig_py/swigutil_py.c
> =C2=A0 =C2=A0 =C2=A0 =C2=A0A =C2=A0 =C2=A0 =C2=A0 subversion/bindings=
/swig/python/libsvn_swig_py/svn_old_swig.h
> =C2=A0 =C2=A0 =C2=A0 =C2=A0M =C2=A0 =C2=A0 =C2=A0 subversion/bindings=
/swig/python/libsvn_swig_py/swigutil_py.h
> =C2=A0 =C2=A0 =C2=A0 =C2=A0M =C2=A0 =C2=A0 =C2=A0 subversion/bindings=
/swig/include/svn_global.swg
> =C2=A0 =C2=A0 =C2=A0 =C2=A0M =C2=A0 =C2=A0 =C2=A0 subversion/bindings=
/swig/include/svn_types.swg
> r855621 =3D 41bbc61c035218937f1032381f02c481c8653a22 (refs/remotes/py=
thon-bindings-improvements)
> W:svn cherry-pick ignored (subversion/trunk:855604) - missing 79 comm=
it(s) (eg 462871a2ededa70304eeb99affe550fd029557b5)
> r855622 =3D 2c62a0cca702ffe59dabee92220cf28aedfe1c84 (refs/remotes/py=
thon-bindings-improvements)
> fatal: ambiguous argument '3b290983fbd7b401e4d1d20256378ba3657cf7d6^.=
=2E862ea856c2acad5035ce14758fb928c07d7b7f6b': unknown revision or path =
not in the working tree.
> Use '--' to separate paths from revisions
> rev-list 3b290983fbd7b401e4d1d20256378ba3657cf7d6^..862ea856c2acad503=
5ce14758fb928c07d7b7f6b: command returned error: 128

I ran into the same issue.  A temporary hack can be found in the
thread "[PATCH/RFC 2/2] git-svn: Don't allow missing commit parent to
stop git-svn", but it is probably not a real solution to the problem.

--=20
Michael Olson  |  http://mwolson.org/
