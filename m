From: Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>
Subject: Re: git log --pretty=format joins lines in the subject of commit message
Date: Fri, 17 Sep 2010 15:56:53 +0400
Message-ID: <4D8D88A4-FEBF-4FA9-A39F-410D76289E4B@jetbrains.com>
References: <DDB24DEE-934B-4C8D-8DAA-595905035AC4@jetbrains.com> <AANLkTikXwKBUKvrNs3ezKWjBh35Y87q6gZKSyZ=1cZyG@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 17 13:57:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwZYr-00084d-TN
	for gcvg-git-2@lo.gmane.org; Fri, 17 Sep 2010 13:57:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753063Ab0IQL44 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Sep 2010 07:56:56 -0400
Received: from mail.intellij.net ([213.182.181.98]:49120 "EHLO
	mail.intellij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752332Ab0IQL4z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Sep 2010 07:56:55 -0400
Received: (qmail 3679 invoked by uid 89); 17 Sep 2010 11:56:54 -0000
Received: by simscan 1.1.0 ppid: 3634, pid: 3669, t: 0.0712s
         scanners: regex: 1.1.0 clamav: 0.96
/m: 52
Received: from unknown (HELO loki-mac-pro.labs.intellij.net) (Kirill.Likhodedov@jetbrains.com@172.26.240.110)
  by mail.intellij.net with ESMTPA; 17 Sep 2010 11:56:54 -0000
In-Reply-To: <AANLkTikXwKBUKvrNs3ezKWjBh35Y87q6gZKSyZ=1cZyG@mail.gmail.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156378>

I think that if it is a feature, it should be reflected in the document=
ation for custom pretty formats.

Anyway, that doesn't seem consistent enough: Git knows that the subject=
 is "first line\nsecond line\nthird line" (because it shows it correctl=
y in full or raw formats). Why does it join the lines in the custom for=
mat's %s?=20

I know I can just use raw format, I'm just concerned about git log beha=
vior consistency.


15.09.2010, =D0=B2 17:01, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =D0=BD=
=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB(=D0=B0):

> On Wed, Sep 15, 2010 at 12:55, Kirill Likhodedov
> <Kirill.Likhodedov@jetbrains.com> wrote:
>> Commit something to a git repository with a commit message with seve=
ral newlines like this:
>>=20
>> =3D=3D=3D=3D commit message starts below =3D=3D=3D
>> first line
>> second line
>> third line
>>=20
>> fifth line
>> =3D=3D=3D commit message ends above =3D=3D=3D
>>=20
>> Git treats the first 3 lines as commit message subject and the last =
line as its body.
>>=20
>> 'git log' shows the commit message correctly - exactly like I've ent=
ered. So does 'git log --pretty=3Draw'
>>=20
>> But 'git log --pretty=3Dformat:%s#%b' joins the first three lines:
>> first line second line third line#fifth line
>>=20
>> Is it a bug or a feature?
>=20
> It's probably a feature. We delimit the subject by "\n\n", not
> "\n". And IIRC subjects in E-Mail can contain \n.
>=20
>> If it is a feature how can I acquire the original subject of the com=
mit message by using custom format?
>=20
> Use a log format that gives you the complete message, then pipe it
> through perl or something to parse it?

----------------------------------
Kirill Likhodedov
JetBrains, Inc
http://www.jetbrains.com
"Develop with pleasure!"
