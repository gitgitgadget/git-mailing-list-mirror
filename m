From: Sung Pae <sung@metablu.com>
Subject: [PATCH] Wrap completions in `type git' conditional statement.
Date: Thu, 12 Nov 2009 03:56:38 -0600
Message-ID: <44A6FDEB-71B6-42E1-99E3-D6A595FF1B58@metablu.com>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: multipart/mixed; boundary=Apple-Mail-14-539724112
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Nov 12 10:59:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8WQt-0003BS-QO
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 10:57:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751736AbZKLJ53 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2009 04:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbZKLJ53
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 04:57:29 -0500
Received: from mail-gx0-f226.google.com ([209.85.217.226]:38220 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902AbZKLJ52 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2009 04:57:28 -0500
Received: by gxk26 with SMTP id 26so1864549gxk.1
        for <git@vger.kernel.org>; Thu, 12 Nov 2009 01:57:34 -0800 (PST)
Received: by 10.150.101.11 with SMTP id y11mr4791059ybb.326.1258019853957;
        Thu, 12 Nov 2009 01:57:33 -0800 (PST)
Received: from ?10.0.1.103? (75-149-214-69-Illinois.hfc.comcastbusiness.net [75.149.214.69])
        by mx.google.com with ESMTPS id 5sm983914ywd.53.2009.11.12.01.57.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 12 Nov 2009 01:57:33 -0800 (PST)
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132759>


--Apple-Mail-14-539724112
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hello,

I don't know if this has come up before (I didn't notice in a casual =
grep of git log), but attached is a little patch to wrap the bash =
completion script in a `type git' check.

=46rom the patch header:
--
The onus for checking if a command exists before loading its completions
properly falls on individual completion files since they are normally
sourced from a completions directory (e.g. source =
/etc/bash_completion.d/*),
or perhaps from a single file concatenated from other completion files.

Also, this is standard practice with other bash-completion scripts.
--


Cheers,
Sung Pae

--Apple-Mail-14-539724112
Content-Disposition: attachment;
	filename=0001-completion-Wrap-completions-in-type-git-conditional-.patch
Content-Type: application/octet-stream;
	name="0001-completion-Wrap-completions-in-type-git-conditional-.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=205e9d29fa1938554903631a4b560e08211b8efab3=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20Sung=20Pae=20<sung@metablu.com>=0ADate:=20Thu,=20=
12=20Nov=202009=2002:55:28=20-0600=0ASubject:=20[PATCH]=20completion:=20=
Wrap=20completions=20in=20`type=20git'=20conditional=20statement=0A=0A=
The=20onus=20for=20checking=20if=20a=20command=20exists=20before=20=
loading=20its=20completions=0Aproperly=20falls=20on=20the=20individual=20=
completion=20files=20since=20they=20are=20normally=0Asourced=20from=20a=20=
completions=20directory=20(e.g.=20source=20/etc/bash_completion.d/*),=20=
or=0Aperhaps=20from=20a=20single=20file=20concatenated=20from=20other=20=
completion=20files.=0A=0AAlso,=20this=20is=20standard=20practice=20with=20=
other=20bash-completion=20scripts.=0A---=0A=20=
contrib/completion/git-completion.bash=20|=20=20=2015=20++++++++-------=0A=
=201=20files=20changed,=208=20insertions(+),=207=20deletions(-)=0A=0A=
diff=20--git=20a/contrib/completion/git-completion.bash=20=
b/contrib/completion/git-completion.bash=0Aindex=20e3ddecc..f1f9fb8=20=
100755=0A---=20a/contrib/completion/git-completion.bash=0A+++=20=
b/contrib/completion/git-completion.bash=0A@@=20-18,16=20+18,13=20@@=0A=20=
#=20To=20use=20these=20routines:=0A=20#=0A=20#=20=20=20=201)=20Copy=20=
this=20file=20to=20somewhere=20(e.g.=20~/.git-completion.sh).=0A-#=20=20=20=
=202)=20Added=20the=20following=20line=20to=20your=20.bashrc:=0A+#=20=20=20=
=202)=20Add=20the=20following=20line=20to=20your=20.bashrc:=0A=20#=20=20=20=
=20=20=20=20=20source=20~/.git-completion.sh=0A=20#=0A-#=20=20=20=203)=20=
You=20may=20want=20to=20make=20sure=20the=20git=20executable=20is=20=
available=0A-#=20=20=20=20=20=20=20in=20your=20PATH=20before=20this=20=
script=20is=20sourced,=20as=20some=20caching=0A-#=20=20=20=20=20=20=20is=20=
performed=20while=20the=20script=20loads.=20=20If=20git=20isn't=20found=0A=
-#=20=20=20=20=20=20=20at=20source=20time=20then=20all=20lookups=20will=20=
be=20done=20on=20demand,=0A-#=20=20=20=20=20=20=20which=20may=20be=20=
slightly=20slower.=0A+#=20=20=20=20=20=20=20Note=20that=20git=20must=20=
be=20available=20in=20your=20PATH=20or=20as=20an=20alias=20at=20the=0A+#=20=
=20=20=20=20=20=20time=20of=20sourcing.=0A=20#=0A-#=20=20=20=204)=20=
Consider=20changing=20your=20PS1=20to=20also=20show=20the=20current=20=
branch:=0A+#=20=20=20=203)=20Consider=20changing=20your=20PS1=20to=20=
also=20show=20the=20current=20branch:=0A=20#=20=20=20=20=20=20=20=20=
PS1=3D'[\u@\h=20\W$(__git_ps1=20"=20(%s)")]\$=20'=0A=20#=0A=20#=20=20=20=20=
=20=20=20The=20argument=20to=20__git_ps1=20will=20be=20displayed=20only=20=
if=20you=0A@@=20-60,6=20+57,8=20@@=0A=20#=20=20=20=20=20=20=20=
git@vger.kernel.org=0A=20#=0A=20=0A+{=20type=20git=20||=20type=20=
git.exe;=20}=20&>/dev/null=20&&=20{=0A+=0A=20case=20"$COMP_WORDBREAKS"=20=
in=0A=20*:*)=20:=20great=20;;=0A=20*)=20=20=20=
COMP_WORDBREAKS=3D"$COMP_WORDBREAKS:"=0A@@=20-2242,3=20+2241,5=20@@=20if=20=
[=20Cygwin=20=3D=20"$(uname=20-o=202>/dev/null)"=20];=20then=0A=20=
complete=20-o=20bashdefault=20-o=20default=20-o=20nospace=20-F=20_git=20=
git.exe=202>/dev/null=20\=0A=20=09||=20complete=20-o=20default=20-o=20=
nospace=20-F=20_git=20git.exe=0A=20fi=0A+=0A+}=20#=20type=20git=0A--=20=0A=
1.6.5=0A=0A=

--Apple-Mail-14-539724112--
