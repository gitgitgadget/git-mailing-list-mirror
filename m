From: Georg Lohrer <pacco@tropezien.de>
Subject: Re: How to use git-svnimport without trunk, tags and branches?
Date: Sun, 11 Mar 2007 17:57:13 +0100
Message-ID: <45F434E9.7040003@tropezien.de>
References: <45F3EA37.2080502@tropezien.de> <20070311143638.GA7822@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sun Mar 11 17:57:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQRML-00072W-Pn
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 17:57:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933839AbXCKQ5W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 11 Mar 2007 12:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933844AbXCKQ5W
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 12:57:22 -0400
Received: from www18.your-server.de ([213.133.104.18]:4397 "EHLO
	www18.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933839AbXCKQ5V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 12:57:21 -0400
Received: from [91.23.156.88] (helo=[192.168.100.70])
	by www18.your-server.de with esmtpsa (TLSv1:RC4-MD5:128)
	(Exim 4.50)
	id 1HQRMG-0002zU-47; Sun, 11 Mar 2007 17:57:20 +0100
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
In-Reply-To: <20070311143638.GA7822@diana.vm.bytemark.co.uk>
X-Authenticated-Sender: pacco@tropezien.de
X-Virus-Scanned: Clear (ClamAV 0.88.4/2690/Thu Mar  1 12:11:27 2007)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41943>

Hi Karl,

Karl Hasselstr=F6m schrieb:
  > You could try something like this:
>=20
>   trunk: svnrepos/projectA
>   tags: svnrepos/dummytags
>   branches: svnrepos/dummybranches
>=20
> I haven't tested, but I think that kind of maneouver should work.

yes, that does the trick. I use:

$ cd ~/tmp/git-test
$ tar xvfj fooRepos.tar.bz2
$ mv fooRepos foorRepos.svnrepos
$ svn mkdir file:///home/georg/tmp/git-test/fooRepos.svnrepos/dummytags
$ svn mkdir file:///home/georg/tmp/git-test/foorRepos.svnrepos/dummybra=
nches
$ mkdir fooRepos.git; cd fooRepos.git
$ git-svnimport -b dummybranches -t dummytags -T projectA=20
file:///home/georg/tmp/git-test/fooRepos.svnrepos

Unfortunately there was a bunch of directories  instead of a single=20
projectA-directory. Do I have to repeat the above mentioned sequence fo=
r=20
every directory (projectA, projectB, ...) or is there a simple way of=20
git-svnimport'ing into an existing git-repository?

Nevertheless, if that is not possible, I could extract with your way=20
the desired directories separately and keep the histories intact.

Regards, Georg
