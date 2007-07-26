From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: Windows support
Date: Thu, 26 Jul 2007 08:25:51 +0200
Message-ID: <08588116-8E66-4F40-BC77-E0B272BE7776@zib.de>
References: <a1bbc6950707250335m3d37d4farceffc50945e31f6c@mail.gmail.com> <46A73015.7020306@midwinter.com> <a1bbc6950707251956h3db847c9v8db438f4c665b2cf@mail.gmail.com> <20070726031546.GN32566@spearce.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jul 26 08:25:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDwme-0003M5-CE
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 08:25:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753313AbXGZGZG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 02:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753768AbXGZGZG
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 02:25:06 -0400
Received: from mailer.zib.de ([130.73.108.11]:48057 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753487AbXGZGZE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 02:25:04 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l6Q6OvEa009288;
	Thu, 26 Jul 2007 08:24:57 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db1a95f.pool.einsundeins.de [77.177.169.95])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l6Q6Otgb023154
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 26 Jul 2007 08:24:56 +0200 (MEST)
In-Reply-To: <20070726031546.GN32566@spearce.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53778>


On Jul 26, 2007, at 5:15 AM, Shawn O. Pearce wrote:

> Why Cygwin?  Because I have to use Windows, but I'd rather use Linux.
> No, Linux isn't permitted.  And Solaris/x86 is only allowed on
> "servers".  I have yet to find a way to classify my desktop as
> a server.  :-|
>
> git-gui is fairly well supported under Cygwin, as I use it a lot
> in my day-job.  As do a lot of my coworkers.  Which actually gives
> me a pretty good testing ground; ~20 people all beating on git-gui
> all day long is a pretty sizable testing group.  I actually wonder
> some days if git-gui is better tested on Cygwin than it is on Linux.
>
> But as has been stated on this thread, Cygwin isn't native Windows.

So apparently you're working in a reasonably sized group of people all
testing git on cygwin. I'd be completely satisfied if git ran rock solid
on cygwin.

I found the following list of warnings about cygwin in the wiki
entry WindowsInstall [1]. Some points look quite scary to me.

What is your real-world experience? Are the warning still valid?
Must I really fear to break cygwin if I press Ctrl-C?

Do I really need to reboot regularly? I don't think this is an
option. Nowadays our Windows boxes run for months, too. I can't
seriously tell people that they need to regularly reboot if they
want to use git.

Here's the list, copied from http://git.or.cz/gitwiki/WindowsInstall

    * Use git on local NTFS disks -- Network drives disks don't  
support the filesystem semantics GIT needs; for interoperability  
purposes you can store bare repositories on FAT32 disks.
    * Be careful with the case in filenames. Similarly, avoid special  
chars in filenames.
    * Run git gc early and often. There are slowdowns with many  
unpacked objects. Be careful to not create very big packfiles (bigger  
than 2 Gb).
    * Avoid using ActiveState Perl if possible. Ask in the  
MailingLists if you must.
    * Try to avoid interrupting (Ctrl-C) processes - it breaks cygwin.
    * Consider setting core.fileMode to false (git repo-config  
core.fileMode false) if file modes are frequently the only  
differences detected by Git. Many Windows applications make the  
execute bit be set in Cygwin when they save a file. Besides Cygwin  
detects file mode by stupid combination of content analysis, file  
name extension and moon phase.
    * Insert "set CYGWIN=tty binmode" after the first line of C: 
\cygwin\cygwin.bat, so you can use Ctrl-z in cygwin's bash to suspend  
a program.
    * Windows usually writes end-of-line as CRLF, while Unix/POSIX  
writes LF. This can cause a variety of problems. There are current  
efforts to address this.
    * Setup binary mode for cygwin (there is an option in cygwin's  
setup program), otherwise Cygwin mangles everything read and written  
(Git repos have binary files in control structures).
    * Avoid big repos.
    * Avoid big blobs (very big files. Basically anything larger than  
10Mb is too big).
    * Avoid big trees (directories with many files in them).
    * Avoid deep hierarchies.
    * Reboot regularly (memory fragmentation)
    * Defragment often (filesystems fragmentation)

	Steffen
