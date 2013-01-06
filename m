From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: Version 1.8.1 does not compile on Cygwin 1.7.14
Date: Sun, 06 Jan 2013 10:42:03 +0100
Message-ID: <50E946EB.1000709@web.de>
References: <2491041.bQ51Qu8HcA@thunderbird> <1890551.8jTmplCF6O@thunderbird> <BB541ECCD3F04E479F06CA491DDB598D@black> <50E92675.4010907@web.de> <20130106093211.GB10956@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Stephen & Linda Smith <ischis2@cox.net>,
	Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org,
	Mark Levedahl <mlevedahl@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 10:42:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrmkR-0003j3-67
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 10:42:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752660Ab3AFJmL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Jan 2013 04:42:11 -0500
Received: from mout.web.de ([212.227.15.4]:51270 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752189Ab3AFJmK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 04:42:10 -0500
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0LfAbI-1TCBWN32z2-00oe4f; Sun, 06 Jan 2013 10:42:03
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <20130106093211.GB10956@elie.Belkin>
X-Provags-ID: V02:K0:RBsPhlXShQWWe8kf2/v2InS/6x1TXJlJUuk4WbRXmG7
 WSmu8uLdCAy+bmk/wQbfBgIfWqiBB+dUspkPhBwDOdO4DeHKTw
 Ihh3HjIlR+DZ+Kfy3+/IsfmFsbcY8cSr/EUS7PkjcNyLOBkiSi
 Pd+1nAGZ+LURx3AbWtxUCrMRvslIurDXh5sZ7SgxHCHkBrpfwC
 RaSYAkAseQZNvqunM+SuQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212789>

On 06.01.13 10:32, Jonathan Nieder wrote:
> Hi,
>=20
> Torsten B=C3=B6gershausen wrote:
>>> Stephen & Linda Smith wrote:
>=20
>>>> git co 9fca6c && make all
>>>> ...   The make errored out as before
> [...]
>>>> git co 9fca6c^  && make all
>>>> ... and this compiles to completion
>>>>
>>>> CYGWIN_NT-5.1 WINXPMACHINE 1.7.14(0.260/5/3) 2012-04-24 17:22=20
>>>> i686 Cygwin
> [...]
>> You can either upgrade to cygwin 1.17 or higher.
>> Or, if that is really not possible (because you are sitting on a pro=
duction machine,
>> where no changes are allowed),
>>
>> You can enable this in Makefile:=20
>> CYGWIN_V15_WIN32API =3D YesPlease
>=20
> What I don't understand is why commit 9fca6c would have had any
> effect at all.  Since 1.7.14 doesn't match /^1\.[1-6]\./, wouldn't
> the setting to avoid including <sys/stat.h> and <sys/errno.h> be
> unset both before and after that commit?
>=20
> Stephen, what is the content of your config.mak?
>=20
> Curious,
> Jonathan
The short version:
Cygwin versions  1.7.1 up to 1.7.16 use the same header files as cygwin=
 1.5

The change in cygwin came in in 1.7.17,=20
(and from that version of cygwin we need commit 9fca6c to compile git)

Currently we can not compile git under cygwin 1.7.1 .. 1.7.16 :-(
As "everybody" running cygwin 1.7 seems to update to the latest,

I don't know if we want to improve the Makefile to enable=20
CYGWIN_V15_WIN32API =3D YesPlease=20
for cygwin versions 1.7.1 .. 1.7.16 (which are outdated)

/Torsten




=20


http://git.661346.n2.nabble.com/PATCH-Rename-V15-MINGW-HEADERS-into-CYG=
WIN-OLD-WINSOCK-HEADERS-td7571449.html
