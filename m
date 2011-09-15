From: Alexey Shumkin <zapped@mail.ru>
Subject: Re: Problems with format-patch UTF-8 and a missing second empty
 line
Date: Fri, 16 Sep 2011 00:05:15 +0400
Message-ID: <20110916000515.1dfc5665@zappedws>
References: <CAHz1FYgPuMHLC+f2mFqD73=NGXQSStRPDOsiCy-HtaWKbHu7NQ@mail.gmail.com>
	<20110915151734.GA18305@sigill.intra.peff.net>
	<20110915224456.14410ed8@zappedws>
	<20110915185033.GA17016@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ingo Ruhnke <grumbel@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 15 22:05:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4IBg-00023a-5m
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 22:05:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934711Ab1IOUFY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Sep 2011 16:05:24 -0400
Received: from smtp18.mail.ru ([94.100.176.155]:33989 "EHLO smtp18.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934706Ab1IOUFV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Sep 2011 16:05:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail;
	h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date; bh=EuF7peFs0r4Xuzmn/BEAT1519uoZKjhCKEDeDUNWKrA=;
	b=LYY3dZCUv9To071xmjQK5WKQonf1wIOleahEHYf8VWZB45CO2m6yiadhNel8U4ElL8Fx+hjsXlbzkgTQlYvPY4CdVgII+E0hV7FJpuZD8j0aW/4+Bofs+JB/wXNUjip/;
Received: from [91.77.41.177] (port=53788 helo=zappedws)
	by smtp18.mail.ru with psmtp 
	id 1R4IBS-0000Lu-00; Fri, 16 Sep 2011 00:05:19 +0400
In-Reply-To: <20110915185033.GA17016@sigill.intra.peff.net>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.22.0; i386-redhat-linux-gnu)
X-Spam: Not detected
X-Mras: Ok
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181489>

> >=20
> > I reproduced this bug with the latest git (v1.7.6.3)
> > It seems to me this is not the "git format-patch" bug
> > but "git am"'s one. (But it is only the supposition)
>=20
> Can you be more specific about what you tested? Running Ingo's snippe=
t
> with a more recent git produces:
>=20
>   Subject: [PATCH] =3D?UTF-8?q?=3DC3=3D84=3DC3=3D96=3DC3=3D9C=3D20=3D=
C3=3D84=3DC3=3D96=3DC3=3D9C?=3D
>=20
> which is right (and "git am", new or old, will apply it just fine).
>=20
> But there may be a different, related bug lurking somewhere.
>=20
> -Peff
>=20
this is my steps (log from terminal)

$ mkdir git-format-patch
Initialized empty Git repository
in /home/Alex/tmp/git-format-patch/.git/

$ cd git-format-patch

$ echo file content > file

$ git add -vf file
add 'file'

$ git commit -a -m '=D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=82: =D1=81=D1=82=D1=
=80=D0=BE=D0=BA=D0=B0-1
> =D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=82: =D1=81=D1=82=D1=80=D0=BE=D0=BA=D0=
=B0-2'

[master (root-commit) 7ede929] =D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=82: =D1=
=81=D1=82=D1=80=D0=BE=D0=BA=D0=B0-1 =D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=82=
: =D1=81=D1=82=D1=80=D0=BE=D0=BA=D0=B0-2
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 file

$ git log
commit 7ede9291cf2d160721bcd8362d8d0f6c6e28cf29
Author: Alexey Shumkin <zapped@mail.ru>
Date:   Thu Sep 15 23:18:26 2011 +0400

    =D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=82: =D1=81=D1=82=D1=80=D0=BE=D0=BA=
=D0=B0-1
    =D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=82: =D1=81=D1=82=D1=80=D0=BE=D0=BA=
=D0=B0-2

$ git format-patch --root HEAD
0001-1.patch

$ cat 0001-1.patch=20
=46rom 7ede9291cf2d160721bcd8362d8d0f6c6e28cf29 Mon Sep 17 00:00:00 200=
1
=46rom: Alexey Shumkin <zapped@mail.ru>
Date: Thu, 15 Sep 2011 23:18:26 +0400
Subject: [PATCH]
=3D?UTF-8?q?=3DD0=3DBA=3DD0=3DBE=3DD0=3DBC=3DD0=3DBC=3DD0=3DB8=3DD1=3D8=
2:=3D20=3DD1=3D81=3DD1?=3D
=3D?UTF-8?q?=3D82=3DD1=3D80=3DD0=3DBE=3DD0=3DBA=3DD0=3DB0-1=3D20=3DD0=3D=
BA=3DD0=3DBE=3DD0=3DBC=3DD0=3DBC=3DD0=3DB8=3DD1?=3D
=3D?UTF-8?q?=3D82:=3D20=3DD1=3D81=3DD1=3D82=3DD1=3D80=3DD0=3DBE=3DD0=3D=
BA=3DD0=3DB0-2?=3D
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

---
 file |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 file

diff --git a/file b/file
new file mode 100644
index 0000000..dd59d09
--- /dev/null
+++ b/file
@@ -0,0 +1 @@
+file content
--=20
1.7.6.3.4.gf71f

$ git init ../git-format-patch-am
Initialized empty Git repository
in /home/Alex/tmp/git-format-patch-am/.git/

$ cd ../git-format-patch-am

$ git am < ../git-format-patch/0001-1.patch
Applying: =D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=82: =D1=81=D1=82=D1=80=D0=BE=
=D0=BA=D0=B0-1 =D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=82: =D1=81=D1=82=D1=80=
=D0=BE=D0=BA=D0=B0-2
applying to an empty history

$ git log
commit 9856238e06d4ca8faeefc48e5c80e8ef7bd34195
Author: Alexey Shumkin <zapped@mail.ru>
Date:   Thu Sep 15 23:18:26 2011 +0400

    =D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=82: =D1=81=D1=82=D1=80=D0=BE=D0=BA=
=D0=B0-1 =D0=BA=D0=BE=D0=BC=D0=BC=D0=B8=D1=82: =D1=81=D1=82=D1=80=D0=BE=
=D0=BA=D0=B0-2

$ git --version
git version 1.7.6.3.4.gf71f



But as you said
>>This is by design. Git commit messages are intended to have a
>>single-line subject, followed by a blank line, followed by more
>>elaboration

and solved with "-k" for both "format-patch" and "am" commands
