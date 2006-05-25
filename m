From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Slow fetches of tags
Date: Thu, 25 May 2006 14:27:46 +0100
Message-ID: <20060525132746.GA30476@linux-mips.org>
References: <20060524131022.GA11449@linux-mips.org> <Pine.LNX.4.64.0605240931480.5623@g5.osdl.org> <20060524180813.GA32519@linux-mips.org> <7vslmz6zah.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 25 15:28:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjFsn-0003f1-Ck
	for gcvg-git@gmane.org; Thu, 25 May 2006 15:28:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965173AbWEYN1t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 09:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965174AbWEYN1t
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 09:27:49 -0400
Received: from ftp.linux-mips.org ([194.74.144.162]:8349 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S965173AbWEYN1t
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 May 2006 09:27:49 -0400
Received: from localhost.localdomain ([127.0.0.1]:49349 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8134083AbWEYN1r (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 May 2006 15:27:47 +0200
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k4PDRkq5030839;
	Thu, 25 May 2006 14:27:46 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k4PDRkHq030838;
	Thu, 25 May 2006 14:27:46 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vslmz6zah.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20738>

On Wed, May 24, 2006 at 11:41:26AM -0700, Junio C Hamano wrote:

> > $ git-name-rev 0bcf7932d0ea742e765a40b
> > 0bcf7932d0ea742e765a40b master
> > $ git-name-rev 54e938a80873e85f9c02ab4
> > 54e938a80873e85f9c02ab4 34k-2.6.16.18
> > $ git-name-rev 2d0a9369c540519bab8018e
> > 2d0a9369c540519bab8018e 34k-2.6.16.18~1
> > $ git-name-rev bf3060065ef9f0a8274fc32
> > bf3060065ef9f0a8274fc32 34k-2.6.16.18~2
> > $ git-name-rev 27602bd8de8456ac619b77c
> > 27602bd8de8456ac619b77c 34k-2.6.16.18~3
> >
> > It's sending every object back to the start of history ...
> 
> Is this "master" commit 0bcf79 part of v2.6.16.18 history?  If
> not, how diverged are you?  That is, what does this command tell
> you?

No, the master branch is where the MIPS development happens and it's
tracking Linus' master branch.  The fact that I'm talking about this
in context of -stable / v2.6.16.18 is that I started looking into why
things were taking minutes when doing a small fetch from 2.6.16-stable.
It happens just as well with Linus' tree or yet others like Matthias
Urlich's -mm git tree.

> 	git rev-list b7d0617..master | wc -l
> 
> Here, b7d0617 is the name of the commit object that is pointed
> by v2.6.16.18 tag.

$ git rev-list b7d0617..master | wc -l
12845
$ git rev-list master..b7d0617 | wc -l		(that is swapped arguments)
173
$

  Ralf
