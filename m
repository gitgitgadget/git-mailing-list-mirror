From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: git checkout no longer warning about uncommitted/untracked files!
Date: Mon, 23 May 2011 22:37:17 +0200
Message-ID: <4DDAC57D.9020809@lsrfire.ath.cx>
References: <1306171797211-6395441.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: funeeldy <Marlene_Cote@affirmednetworks.com>
X-From: git-owner@vger.kernel.org Mon May 23 22:37:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QObsZ-0002XB-DE
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 22:37:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753303Ab1EWUh0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 May 2011 16:37:26 -0400
Received: from india601.server4you.de ([85.25.151.105]:38085 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753052Ab1EWUhZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 16:37:25 -0400
Received: from [192.168.2.106] (p579BE3CF.dip.t-dialin.net [87.155.227.207])
	by india601.server4you.de (Postfix) with ESMTPSA id ACC932F8061;
	Mon, 23 May 2011 22:37:23 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <1306171797211-6395441.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174272>

Am 23.05.2011 19:29, schrieb funeeldy:
> I found some other posts that seem to indicate that this is the right=
 place
> to file bug reports for git.  If this is wrong, please let me know th=
e
> proper method.
> We are using git version 1.7.3.  We just noticed that git checkout no=
 longer
> warns about uncommitted/untracked files and just deletes them!!!

I can't reproduce this behaviour based on this description alone:

	$ git --version
	git version 1.7.3
	$ uname -a
	Linux ubuntu 2.6.38-8-generic #42-Ubuntu SMP Mon Apr 11 03:31:50 UTC 2=
011 i686 i686 i386 GNU/Linux

	$ mkdir /tmp/repo && cd /tmp/repo
	$ git init
	Initialized empty Git repository in /tmp/repo/.git/
	$ git config -l
	color.ui=3Dauto
	user.name=3DRen=E9 Scharfe
	user.email=3Drene.scharfe@lsrfire.ath.cx
	core.repositoryformatversion=3D0
	core.filemode=3Dtrue
	core.bare=3Dfalse
	core.logallrefupdates=3Dtrue

	$ echo 1 >a
	$ git add a
	$ git commit -m.
	[master (root-commit) b0e60d3] .
	 1 files changed, 1 insertions(+), 0 deletions(-)
	 create mode 100644 a

	$ git branch x
	$ echo uncommitted >a
	$ echo untracked >b

	$ git checkout x
	M	a
	Switched to branch 'x'

	$ cat a
	uncommitted
	$ cat b
	untracked

Can you reconstruct what your colleague did, perhaps using his or
her shell's command history file (e.g. ~/.bash_history)?
