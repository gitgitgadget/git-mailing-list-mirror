From: =?utf-8?b?VMO2csO2aw==?= Edwin <edwintorok@gmail.com>
Subject: Re: [BUG] git clean not working on FreeBSD/NFS
Date: Fri, 18 Jun 2010 11:03:05 +0000 (UTC)
Message-ID: <loom.20100618T122039-876@post.gmane.org>
References: <4C1A30A3.9080708@gmail.com> <loom.20100617T170956-287@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 18 13:05:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPZNq-0007wF-Hq
	for gcvg-git-2@lo.gmane.org; Fri, 18 Jun 2010 13:05:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760236Ab0FRLFH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jun 2010 07:05:07 -0400
Received: from lo.gmane.org ([80.91.229.12]:40319 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758468Ab0FRLFG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jun 2010 07:05:06 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OPZNg-0007q6-In
	for git@vger.kernel.org; Fri, 18 Jun 2010 13:05:04 +0200
Received: from 79-114-67-113.rdsnet.ro ([79-114-67-113.rdsnet.ro])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Jun 2010 13:05:04 +0200
Received: from edwintorok by 79-114-67-113.rdsnet.ro with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Jun 2010 13:05:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 79.114.67.113 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.4) Gecko/20100505 Iceweasel/3.6.4 (like Firefox/3.6.4))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149340>

Henrik Grubbstr=C3=B6m <grubba <at> grubba.org> writes:
>=20
> Sounds like the classic nfs problem with references to open deleted f=
iles.
> If you look closer at the failing directories, I bet that you'll find=
 files=20
> with names like ".nfsDEAD".

No, these are all the files that remain in libclamav/.deps (ls -al):
edwin@gcc101:~/buildbot/gcc4.2/build$ ls -al libclamav/.deps/
total 116
drwxr-xr-x  2 edwin  edwin  8192 Jun 18 03:24 .
drwx------  8 edwin  edwin  8192 Jun 18 03:24 ..
-rw-r--r--  1 edwin  edwin     8 Jun 18 03:23 libclamav_la-textnorm.Plo
-rw-r--r--  1 edwin  edwin     8 Jun 18 03:23 libclamav_la-tnef.Plo
-rw-r--r--  1 edwin  edwin     8 Jun 18 03:23 libclamav_la-unarj.Plo
-rw-r--r--  1 edwin  edwin     8 Jun 18 03:23 libclamav_la-uniq.Plo
-rw-r--r--  1 edwin  edwin     8 Jun 18 03:23 libclamav_la-unsp.Plo
-rw-r--r--  1 edwin  edwin     8 Jun 18 03:23 libclamav_la-untar.Plo
-rw-r--r--  1 edwin  edwin     8 Jun 18 03:23 libclamav_la-unzip.Plo
-rw-r--r--  1 edwin  edwin     8 Jun 18 03:23 libclamav_la-upack.Plo
-rw-r--r--  1 edwin  edwin     8 Jun 18 03:23 libclamav_la-upx.Plo
-rw-r--r--  1 edwin  edwin     8 Jun 18 03:23 libclamav_la-uuencode.Plo
-rw-r--r--  1 edwin  edwin     8 Jun 18 03:23 libclamav_la-vba_extract.=
Plo
-rw-r--r--  1 edwin  edwin     8 Jun 18 03:23 libclamav_la-version.Plo
-rw-r--r--  1 edwin  edwin     8 Jun 18 03:23 libclamav_la-wwunpack.Plo
-rw-r--r--  1 edwin  edwin     8 Jun 18 03:23 libclamav_la-yc.Plo
-rw-r--r--  1 edwin  edwin     8 Jun 18 03:23 unrar.Plo
-rw-r--r--  1 edwin  edwin     8 Jun 18 03:23 unrar15.Plo
-rw-r--r--  1 edwin  edwin     8 Jun 18 03:23 unrar20.Plo
-rw-r--r--  1 edwin  edwin     8 Jun 18 03:23 unrar_iface.Plo
-rw-r--r--  1 edwin  edwin     8 Jun 18 03:23 unrarcmd.Plo
-rw-r--r--  1 edwin  edwin     8 Jun 18 03:23 unrarfilter.Plo
-rw-r--r--  1 edwin  edwin     8 Jun 18 03:23 unrarhlp.Plo
-rw-r--r--  1 edwin  edwin     8 Jun 18 03:23 unrarppm.Plo
-rw-r--r--  1 edwin  edwin     8 Jun 18 03:23 unrarvm.Plo

If I run 'git clean -x -f -d -- libclamav' a few more times they are
eventually removed.

It is interesting that every time I repeat the config.status/git clean =
steps
I get the *same* files remaining in the directory.

There were 127 files initially, these 23 always remain behind on 1st ru=
n, a 2nd
git clean removes them (but some other .deps directories need even more=
 reruns
of git clean).

I added a printf in remove_dir_recursively, and those files are not eve=
n
printed.

Now I see the bug!
You do a single readdir() pass, and unlink() files. That is wrong for 2=
 reasons:
 - new files may be added in the meantime and you have a race condition
 - unlinking a file can cause order of files to be rearranged, moved. B=
ut your
readdir() cursors stays where it was before, hence you will miss enumer=
ating
some files that are there.

The fix is to rewinddir() if you unlinked anything (won't fix the race =
condition
but that can't be eliminated completely anyway).

I'm sending a patch as reply to this mail.
