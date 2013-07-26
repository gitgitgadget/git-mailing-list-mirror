From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: git and cyrillic branches
Date: Fri, 26 Jul 2013 03:50:47 +0200
Message-ID: <51F1D5F7.5060101@web.de>
References: <922031374754788@web29h.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?0LjQstCw0L3QvtCyINC40LLQsNC9?= <xowirun@yandex.ru>
X-From: git-owner@vger.kernel.org Fri Jul 26 03:50:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2XBH-0000uE-SY
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jul 2013 03:50:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757384Ab3GZBuv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Jul 2013 21:50:51 -0400
Received: from mout.web.de ([212.227.17.12]:53464 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756392Ab3GZBuv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jul 2013 21:50:51 -0400
Received: from [172.20.7.197] ([69.193.69.194]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0M3Slc-1UBWx641Fw-00r1es for <git@vger.kernel.org>;
 Fri, 26 Jul 2013 03:50:49 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <922031374754788@web29h.yandex.ru>
X-Provags-ID: V03:K0:gWwEsU/v65tzbGuep0VswmfFeqg0esGF3spf5/MlNPcwxvk/Odt
 HLw+k6KHM6Hx19SX5wsBJ3vQSWFPmciQQosz2nT37NgPkQZvg/QeW3FM+mI34UUiS6o01eX
 AR0XETZW0/oT86qGvl+INj37btH+6YHfP5fIsRT4ZWrvZmOYTnsv+MAjge7h1h0ENCCJk39
 aDDxtvsDDRTfeM16XP1pQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231158>

On 2013-07-25 14.19, =D0=B8=D0=B2=D0=B0=D0=BD=D0=BE=D0=B2 =D0=B8=D0=B2=D0=
=B0=D0=BD wrote:
> hello! there is problem vith git and cyrillic (utf-8) names of branch=
es. branch creates perfectly, but when i clone this remote branch to lo=
cal host, there are 2 bugs:
> 1) "git branch" doesnt show checked branch with asterisk (while on re=
mote server it does)
> 2) "git push" gives 2 errors: "fatal: BRANCH_NAME cannot be resolved =
to branch." and "fatal: The remote end hung up unexpectedly"
> thanks.

It could be helpful if you could provide more information.
The best could be a step-by-step instruction using a some "mini repo",=20
so that we we can reproduce the problem.
I have done an illustrating example using UTF-8,=20
(not cyrillic, I don't have these letters on my keyboard ;-)

tb@linux:~$ mkdir cyrill
tb@linux:~$ cd cyrill/
tb@linux:~/cyrill$ git init
Initialized empty Git repository in /home/tb/cyrill/.git/
tb@linux:~/cyrill$ echo File>File
tb@linux:~/cyrill$ git checkout -b br=C3=A4nch
Switched to a new branch 'br=C3=A4nch'
tb@linux:~/cyrill$ git add File
tb@linux:~/cyrill$ git commit -m "Add File"
[br=C3=A4nch (root-commit) e39d84e] Add File
 1 file changed, 1 insertion(+)
 create mode 100644 "File"
tb@linux:~/cyrill$ git branch
* br=C3=A4nch
tb@linux:~/cyrill$=20



tb@macos:~> git clone tb@linux:~/cyrill
Cloning into 'cyrill'...
tb@linux's password:=20
remote: Counting objects: 3, done.
Receiving objects: 100% (3/3), done.
remote: Total 3 (delta 0), reused 0 (delta 0)
tb@macos:~> cd cyrill/
tb@macos:~/cyrill> git branch
* br=C3=A4nch
tb@macos:~/cyrill> ls -l
total 8
-rw-r--r--  1 tb  staff  6 Jul 26 03:39 File
tb@macos:~/cyrill>=20

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Other question:
what does (on Mac OS)
git config core.precomposeunicode
give you?
/Torsten
