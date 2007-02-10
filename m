From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: 'git status' is not read-only fs friendly
Date: Sat, 10 Feb 2007 15:41:22 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702101536090.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <e5bfff550702091125j202620cfqb2450a3ee69ed421@mail.gmail.com> 
 <Pine.LNX.4.63.0702101517360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <e5bfff550702100631w1b6243e7i44039ceaa8d3fe93@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, GIT list <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 10 15:41:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFtPr-00065x-5u
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 15:41:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbXBJOlY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 09:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbXBJOlY
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 09:41:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:58163 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932374AbXBJOlX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 09:41:23 -0500
Received: (qmail invoked by alias); 10 Feb 2007 14:41:22 -0000
X-Provags-ID: V01U2FsdGVkX1+gQcIdGTSgadJIszgANJ+CAR23Cl/YZfmD9drfqW
	rMMQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <e5bfff550702100631w1b6243e7i44039ceaa8d3fe93@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39223>

Hi,

On Sat, 10 Feb 2007, Marco Costalba wrote:

> On 2/10/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Fri, 9 Feb 2007, Marco Costalba wrote:
> > 
> > > I just need to know if current working directory is clean and report
> > > back to qgit user, so read-only access would be ok for me.
> > 
> > So, why don't you just do a
> > 
> >         git diff --name-only HEAD
> > 
> > and check for an empty output???
> 
> It seems to have the same issues of 'git runstatus' in case of ntfs 
> filesystems, so I would prefer, eventually, use 'git runstatus' that at 
> least gives me index status of the files.

Which issues? That the lstat data are not equal on Cygwin and Linux? The 
patch does not help here. Maybe a patch to Linux' ntfs driver 
would, but I fail to see how Git could possibly help here.

If git-diff is trying to write files, _that_ would be a bug.

As for your use of git-status: I think it is wrong. You said you want to 
check if the working directory is clean. Then just do that, and do not try 
to generate the message meant for editing the commit message.

> > No need for a patch to Git (so late in the -rc phase), or backwards 
> > incompatibility...
> 
> Well, it's a _new_ option so I fail to see backwards incompatibility.

You need a new version of _Git_ if you use that option.

And if you can do without depending on a newer Git, it is _bad_ to do it 
nevertheless.

Ciao,
Dscho
