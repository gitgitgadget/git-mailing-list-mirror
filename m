From: Marius Schamschula <mschamschula@gmail.com>
Subject: Build issue for git 1.8.5.1 under Mac OS X 10.8 (Mountain Lion)
Date: Wed, 4 Dec 2013 12:48:21 -0600
Message-ID: <6D4FDF40-DD9A-4875-9D8F-9678BE95FF73@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 04 19:57:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoHd9-0004nN-LN
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 19:57:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933173Ab3LDS46 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Dec 2013 13:56:58 -0500
Received: from physics.aamu.edu ([198.180.133.30]:64727 "HELO physics.aamu.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933141Ab3LDS4z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Dec 2013 13:56:55 -0500
X-Greylist: delayed 498 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Dec 2013 13:56:45 EST
Received: from viz.physics.aamu.edu (viz.physics.aamu.edu [198.180.133.99])
	by physics.aamu.edu (Postfix) with ESMTPA id 4E5C58B3563B
	for <git@vger.kernel.org>; Wed,  4 Dec 2013 12:48:21 -0600 (CST)
X-Mailer: Apple Mail (2.1510)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238802>

Hi all,

Over the years I have built many versions of git and released them on h=
mug.org. git 1.8.5.1 builds just fine under OS 10.7 (Lion) and 10.9 (Ma=
vericks), but the build fails (also for 1.8.5) on 10.8 (Mountain Lion):

<snip>
GIT_VERSION =3D 1.8.5.1
    * new build flags
    CC credential-store.o
In file included from git-compat-util.h:330:0,
                 from cache.h:4,
                 from credential-store.c:1:
compat/apple-common-crypto.h: In function 'git_CC_EVP_EncodeBlock':
compat/apple-common-crypto.h:32:2: error: 'SecTransformRef' undeclared =
(first use in this function)
compat/apple-common-crypto.h:32:2: note: each undeclared identifier is =
reported only once for each function it appears in
compat/apple-common-crypto.h:32:18: error: expected ';' before 'encoder=
'
compat/apple-common-crypto.h:36:2: error: 'encoder' undeclared (first u=
se in this function)
compat/apple-common-crypto.h:36:2: warning: implicit declaration of fun=
ction 'SecEncodeTransformCreate'
compat/apple-common-crypto.h:36:37: error: 'kSecBase64Encoding' undecla=
red (first use in this function)
compat/apple-common-crypto.h:40:2: warning: implicit declaration of fun=
ction 'SecTransformSetAttribute'
compat/apple-common-crypto.h:40:36: error: 'kSecTransformInputAttribute=
Name' undeclared (first use in this function)
compat/apple-common-crypto.h:44:2: warning: implicit declaration of fun=
ction 'SecTransformExecute'
compat/apple-common-crypto.h: In function 'git_CC_EVP_DecodeBlock':
compat/apple-common-crypto.h:62:2: error: 'SecTransformRef' undeclared =
(first use in this function)
compat/apple-common-crypto.h:62:18: error: expected ';' before 'decoder=
'
compat/apple-common-crypto.h:66:2: error: 'decoder' undeclared (first u=
se in this function)
compat/apple-common-crypto.h:66:2: warning: implicit declaration of fun=
ction 'SecDecodeTransformCreate'
compat/apple-common-crypto.h:66:37: error: 'kSecBase64Encoding' undecla=
red (first use in this function)
compat/apple-common-crypto.h:70:36: error: 'kSecTransformInputAttribute=
Name' undeclared (first use in this function)
Makefile:1975: recipe for target 'credential-store.o' failed
make: *** [credential-store.o] Error 1
</snip>

Apparently a header issue: I tried force feeding the Security/SecEncryp=
tTransform.h file, and just got an other error=85

Any help would be welcome!

Thanks in advance.

Marius
--
Marius Schamschula
