From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: Build issue for git 1.8.5.1 under Mac OS X 10.8 (Mountain Lion)
Date: Thu, 05 Dec 2013 08:07:21 +0100
Message-ID: <52A02629.7030906@web.de>
References: <6D4FDF40-DD9A-4875-9D8F-9678BE95FF73@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Marius Schamschula <mschamschula@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 05 08:07:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoT2E-0002le-2h
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 08:07:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698Ab3LEHHa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Dec 2013 02:07:30 -0500
Received: from mout.web.de ([212.227.15.4]:55282 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751453Ab3LEHH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 02:07:29 -0500
Received: from [192.168.1.103] ([194.47.242.237]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0MNcMo-1Vvdll16XC-007B5n for <git@vger.kernel.org>;
 Thu, 05 Dec 2013 08:07:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20131104 Icedove/17.0.10
In-Reply-To: <6D4FDF40-DD9A-4875-9D8F-9678BE95FF73@gmail.com>
X-Provags-ID: V03:K0:Ukq2xtLidRuxTz4cXs9gf1MAGwn8aXfWm7c0W9Y2ydyvXxd2LAl
 vw5V24DYeNr6oOqISogBdrb+9Y+VfHzwvjonFYsL9AJjUqL3MhboVHiFEv4BKFIX68trpyi
 +o1vMB8a/UDEajt/JFwiCvOAvAYg9059fShfFPh3W1aJMEw/CEzgEXVa84CIpD6WNNpfzGc
 mflPuKO4r40d8LdZL8eHg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238845>

On 12/04/2013 07:48 PM, Marius Schamschula wrote:
> Hi all,
>
> Over the years I have built many versions of git and released them on=
 hmug.org. git 1.8.5.1 builds just fine under OS 10.7 (Lion) and 10.9 (=
Mavericks), but the build fails (also for 1.8.5) on 10.8 (Mountain Lion=
):
>
> <snip>
> GIT_VERSION =3D 1.8.5.1
>      * new build flags
>      CC credential-store.o
> In file included from git-compat-util.h:330:0,
>                   from cache.h:4,
>                   from credential-store.c:1:
> compat/apple-common-crypto.h: In function 'git_CC_EVP_EncodeBlock':
> compat/apple-common-crypto.h:32:2: error: 'SecTransformRef' undeclare=
d (first use in this function)
> compat/apple-common-crypto.h:32:2: note: each undeclared identifier i=
s reported only once for each function it appears in
> compat/apple-common-crypto.h:32:18: error: expected ';' before 'encod=
er'
> compat/apple-common-crypto.h:36:2: error: 'encoder' undeclared (first=
 use in this function)
> compat/apple-common-crypto.h:36:2: warning: implicit declaration of f=
unction 'SecEncodeTransformCreate'
> compat/apple-common-crypto.h:36:37: error: 'kSecBase64Encoding' undec=
lared (first use in this function)
> compat/apple-common-crypto.h:40:2: warning: implicit declaration of f=
unction 'SecTransformSetAttribute'
> compat/apple-common-crypto.h:40:36: error: 'kSecTransformInputAttribu=
teName' undeclared (first use in this function)
> compat/apple-common-crypto.h:44:2: warning: implicit declaration of f=
unction 'SecTransformExecute'
> compat/apple-common-crypto.h: In function 'git_CC_EVP_DecodeBlock':
> compat/apple-common-crypto.h:62:2: error: 'SecTransformRef' undeclare=
d (first use in this function)
> compat/apple-common-crypto.h:62:18: error: expected ';' before 'decod=
er'
> compat/apple-common-crypto.h:66:2: error: 'decoder' undeclared (first=
 use in this function)
> compat/apple-common-crypto.h:66:2: warning: implicit declaration of f=
unction 'SecDecodeTransformCreate'
> compat/apple-common-crypto.h:66:37: error: 'kSecBase64Encoding' undec=
lared (first use in this function)
> compat/apple-common-crypto.h:70:36: error: 'kSecTransformInputAttribu=
teName' undeclared (first use in this function)
> Makefile:1975: recipe for target 'credential-store.o' failed
> make: *** [credential-store.o] Error 1
> </snip>
>
> Apparently a header issue: I tried force feeding the Security/SecEncr=
yptTransform.h file, and just got an other error=85
>
> Any help would be welcome!
>
> Thanks in advance.
>
> Marius
> --
> Marius Schamschula

I can't reproduce it here (in other words, it compiles)
What could help is to run the preprocessor, and see what the compiler s=
ee.

a) Patch the Makefile of git like this:

-- a/Makefile
+++ b/Makefile
@@ -349,7 +349,8 @@ GIT-VERSION-FILE: FORCE

  # CFLAGS and LDFLAGS are for the users to override from the command l=
ine.

-CFLAGS =3D -g -O2 -Wall
+#CFLAGS =3D -g -O2 -Wall
+CFLAGS=3D -E
b) Compile credential-store.o (Which is now an ASCII file)

credential-store.o ; make credential-store.o

c) Take an editor and have a look.
    On my system SecTransform.h is here:
-----------------
/System/Library/Frameworks/Security.framework/Headers/SecTransform.h"

d) And the file contains something like this:
---------------
typedef CFTypeRef SecTransformRef;
typedef CFTypeRef SecGroupTransformRef;


/Torsten
