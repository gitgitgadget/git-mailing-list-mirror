From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Following renames
Date: Mon, 27 Mar 2006 07:47:04 +0200
Message-ID: <e5bfff550603262147t3aec8da6p6bf2a333e2d35f1d@mail.gmail.com>
References: <20060326014946.GB18185@pasky.or.cz>
	 <7virq1sywj.fsf@assigned-by-dhcp.cox.net> <e06fl8$p9f$1@sea.gmane.org>
	 <Pine.LNX.4.64.0603260843250.15714@g5.osdl.org>
	 <e06hts$1ne$1@sea.gmane.org>
	 <Pine.LNX.4.64.0603260947100.15714@g5.osdl.org>
	 <e5bfff550603261122m5e680c62ye1290f3e601e947e@mail.gmail.com>
	 <Pine.LNX.4.64.0603261422280.15714@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 27 07:47:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNkZK-0000Kd-Th
	for gcvg-git@gmane.org; Mon, 27 Mar 2006 07:47:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWC0FrG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Mar 2006 00:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbWC0FrG
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Mar 2006 00:47:06 -0500
Received: from wproxy.gmail.com ([64.233.184.231]:60975 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750725AbWC0FrF convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Mar 2006 00:47:05 -0500
Received: by wproxy.gmail.com with SMTP id i13so1339891wra
        for <git@vger.kernel.org>; Sun, 26 Mar 2006 21:47:05 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Zzu824qErm1gqOkhnDcc9PxQn7ZnfE8IyMO6WaK7kHGiGb9Jj9SrI0aHBnNh+1zoFvwfTKd6INdPyJEgcLhA4/XzW/Ius9jQuittCZAfm9i9F9VWsfOGJbTerxKTDAytD/ZjZqCNlVt8u1vx7cMAGpjCgTUw5IMPw5Mk4qz1sKg=
Received: by 10.64.181.16 with SMTP id d16mr45570qbf;
        Sun, 26 Mar 2006 21:47:04 -0800 (PST)
Received: by 10.65.163.13 with HTTP; Sun, 26 Mar 2006 21:47:04 -0800 (PST)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603261422280.15714@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18071>

On 3/27/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Sun, 26 Mar 2006, Marco Costalba wrote:
> >
> > FIRST WAY
> >
> > After annotating a file history (double click on a file name in
> > bottom-right window or directly from tree view), you see the whole
> > file annotated. If you have the diff window open you see also the
> > corresponding patch (scrolled to selected file name).
>
> The problem is that this step is already _way_ too expensive.
>
> I don't want to work with any tool that makes "Step 1" take a minute or
> two for a project that has a few years of history. Try it on the linux
> historic project with some file that gets lots of modifications.
>

Historic Linux test (63428 revisions)

File: drivers/net/tg3.c
Revisions that modify tg3.c : 292

With qgit
15s to retrieve file history (git-rev-list)
19.5s to annotate (git-diff-tree -p, current GNU algorithm, not new faster one)

and...

$ time git-whatchanged HEAD drivers/net/tg3.c > /dev/null
98.01user 2.44system 1:46.19elapsed 94%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (797major+43033minor)pagefaults 0swaps

NOTE: It seems that  git-whatchanged asks for checked the out file to
work. It didn't work with no repository checked out.


Marco
