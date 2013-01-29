From: Matthew Johnson <mejohnsn@gmail.com>
Subject: Why Same Files show up with different Statuses in Git?
Date: Mon, 28 Jan 2013 23:38:31 -0800
Message-ID: <CANL2M4sapzGtB1L4=OY5aa-gcnUtM-u96EhP_vGxRRxpwWJ2_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 29 08:46:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U05tB-0001oY-HS
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 08:45:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751763Ab3A2Hpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 02:45:32 -0500
Received: from mail-vc0-f173.google.com ([209.85.220.173]:63428 "EHLO
	mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086Ab3A2Hpb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 02:45:31 -0500
Received: by mail-vc0-f173.google.com with SMTP id fy7so86252vcb.4
        for <git@vger.kernel.org>; Mon, 28 Jan 2013 23:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=unh4TMHLXw6B7IHoDFED9o+d7IVUzNPzShqo8U+ioA0=;
        b=iu6YYkoaKDhiqSHIHsX07HDrEtpAqUdoQtvDpD0Rb24sjdQ7qaI8KUp1eBRYZsdDad
         sPp3+OYXzZF0Z4PTAUW4v++ibumV9CkElyDxlN0tyxcd/H2hC//CeLU2WRwBTC0QlyeN
         vdPL80Xp+fxQjP4/faTbaovyCxON7RFrGlZZjqwfFZiYu4s7xcAMr6sQqTynLf/Y3zKV
         NUAKqSdBMwN0Tgqi6aw0ftM+MKUe/FDfuarbxSxW03bt/9yh6B7Q7yndQYtQMfO6UTbT
         utLVG4BXnYP8hJVqnJbue+RzW86faVBIJtkMG0LvI3/ptoLWwYoMdEIhBKEn2CPodbmf
         m5gA==
X-Received: by 10.220.151.141 with SMTP id c13mr471212vcw.64.1359445111899;
 Mon, 28 Jan 2013 23:38:31 -0800 (PST)
Received: by 10.58.24.200 with HTTP; Mon, 28 Jan 2013 23:38:31 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214909>

First, some background. I have one hard disk separated into two
partitions: one for the version of Windows 7 that shipped on this
rather new Thinkpad (Windows 7 Professional SP1), the other for Fedora
17 (which I installed and keep up-to-date). Of course, it is rather
easy to access the Windows partition from the F17 partition, which I
have been doing with no noticeable problems: the File Explorer
equivalent, Dolphin (the KDE equivalent) will automount the Windows
partition as a filesystem under /media, I only have to enter the
password for 'su'.

I don't think it makes a difference, but for completeness I provide
the options with which I find it mounted:

/dev/sda2 on /media/Windows7_OS type fuseblk
(rw,nosuid,nodev,relatime,user_id=0,group_id=0,default_permissions,allow_other,blksize=4096).

Anyway, the problem is this: the very same files, e.g.
/media/Windows7_OS/cygwin/home/Matthew
Johnson/MrEd/mr.ed/lesson1/images/home-icon.jpg show up as 'modified'
when I type "git status" (in the mr.ed/ dir) using the F17 git client,
but do not show up at all when I type "git status" under the Cygwin
client. This problem is not on all files, only a few, predominantly in
two directories.

Under Windows (cygwin) "git status" shows nothing to commit, only
untracked files, which is what I expect; only under F17 do I get
several modified files -- and these have old dates (e.g. Nov 27).

Yes, that is another important note: I am running Cygwin on the
Windows partition.

The versions of things under the F17 partition are:

  Linux 3.7.3-101.fc17.x86_64 x86_64
  System:  Fedora release 17 (Beefy Miracle)
  KDE:  4.9.5

git --version
git version 1.7.11.7

Under Cygwin, the git version is 1.7.9.

Finally, I did check the git configuration to make sure the same
user.name and user.email are set in both. And in both cases, I made
mr.ed the current directory before executing "git status". Shouldn't
that be enough? Is there anything else that must match in the git
config?
