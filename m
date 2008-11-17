From: walt <w41ter@gmail.com>
Subject: Re: git-bisect not working correctly in the kvm.git repository?
Date: Mon, 17 Nov 2008 14:11:53 -0800
Organization: none
Message-ID: <alpine.LNX.2.00.0811171350540.4238@x9.ybpnyarg>
References: <gfs9hn$hq9$1@ger.gmane.org> <200811172047.03669.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463785984-1386026339-1226959320=:4238"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 17 23:13:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2CLV-0007qc-Ds
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 23:13:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752321AbYKQWMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2008 17:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752207AbYKQWMJ
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 17:12:09 -0500
Received: from main.gmane.org ([80.91.229.2]:56654 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752150AbYKQWMH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2008 17:12:07 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1L2CKD-0000WA-AX
	for git@vger.kernel.org; Mon, 17 Nov 2008 22:12:05 +0000
Received: from adsl-69-234-203-176.dsl.irvnca.pacbell.net ([69.234.203.176])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 17 Nov 2008 22:12:05 +0000
Received: from w41ter by adsl-69-234-203-176.dsl.irvnca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 17 Nov 2008 22:12:05 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-69-234-203-176.dsl.irvnca.pacbell.net
In-Reply-To: <200811172047.03669.chriscool@tuxfamily.org>
User-Agent: Alpine 2.00 (LNX 1169 2008-08-27)
Content-ID: <alpine.LNX.2.00.0811171411180.4238@x9.ybpnyarg>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101252>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463785984-1386026339-1226959320=:4238
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.LNX.2.00.0811171411181.4238@x9.ybpnyarg>



On Mon, 17 Nov 2008, Christian Couder wrote:

> Le lundi 17 novembre 2008, walt a écrit :
> > I'm trying to find a bug introduced somewhere between kvm-69
> > and kvm-70, so of course I want to git-bisect down to it.
> >
> > The weirdness is that when I give git-bisect the good and
> > bad tags, almost everything in my working directory just
> > disappears, leaving only the qemu subdirectory behind.
> >
> > Can anyone else reproduce this with the kvm.git repo?
> > (I don't see this problem with the linux.git repo or the
> > git.git repo, so it seems to be something with the kvm.git
> > repo itself.)
>
> I cannot reproduce this:
>
> $ git bisect start kvm-70 kvm-69
> Bisecting: 846 revisions left to test after this
> [80bfc25f42db6d4715c7688ae2352c5a8038fe7e] ntfs: le*_add_cpu conversion
> $ find . -type f |wc -l
> 24286
> $ git bisect reset
> Previous HEAD position was 80bfc25... ntfs: le*_add_cpu conversion
> Switched to branch "master"
> $ find . -type f |wc -l
> 24384

Your numbers are so different from mine I'm wondering if we are using
different repositories.

$~/src/kvm-userspace find . -type f | wc -l
1715

$~/src/kvm-userspace git bisect start kvm-70 kvm-69
Bisecting: 176 revisions left to test after this
[06508be8108f785caead849a717c9e6d67da62d7] Un-break MIPS conditional moves, by
Richard Sandiford.
wa1ter@k9:~/src/kvm-userspace find . -type f | wc -l
1413

$~/src/kvm-userspace cat .git/config
[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
[remote "origin"]
        url = git://git.kernel.org/pub/scm/virt/kvm/kvm-userspace.git
        fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
        remote = origin
        merge = refs/heads/master

I track Junio's git.git and it's current as of this morning, but I
also tried git v1.5.0 (chosen at random) and got the same results.
What repo are you using?

Thanks.
---1463785984-1386026339-1226959320=:4238--
