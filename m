From: sean <seanlkml@sympatico.ca>
Subject: Re: git-reset and clones
Date: Thu, 16 Mar 2006 09:52:13 -0500
Message-ID: <BAYC1-PASMTP09E59C4F23C4CDF45B1C42AEE70@CEZ.ICE>
References: <Pine.LNX.4.64.0603161424310.5276@sheen.jakma.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 16 15:54:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJts9-0004B6-QJ
	for gcvg-git@gmane.org; Thu, 16 Mar 2006 15:54:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWCPOyj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Mar 2006 09:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWCPOyi
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Mar 2006 09:54:38 -0500
Received: from bayc1-pasmtp09.bayc1.hotmail.com ([65.54.191.169]:38078 "EHLO
	BAYC1-PASMTP09.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S1751161AbWCPOyi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Mar 2006 09:54:38 -0500
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP09.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 16 Mar 2006 06:55:47 -0800
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 29A06644C28;
	Thu, 16 Mar 2006 09:54:36 -0500 (EST)
To: Paul Jakma <paul@clubi.ie>
Message-Id: <20060316095213.2a8f650a.seanlkml@sympatico.ca>
In-Reply-To: <Pine.LNX.4.64.0603161424310.5276@sheen.jakma.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.14; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 16 Mar 2006 14:55:47.0859 (UTC) FILETIME=[B5B32E30:01C64909]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 16 Mar 2006 14:34:42 +0000 (GMT)
Paul Jakma <paul@clubi.ie> wrote:

> If a git repository has a reset HEAD~X done, then any later pulls in 
> clone repositories get /really/ upset, with:
> 
> $ git pull
> * refs/heads/origin: does not fast forward to branch 'master' of 
> /home/paul/foo-git/;
> 
> Type of thing. This seems to be a similar issue to:
> 
>  	http://www.gelato.unsw.edu.au/archives/git/0510/10767.html
> 
> The question is has this improved at all since last year? Is there 
> anything the origin repository maintainer (the one who did reset) can 
> do to recover from this?

It's still not a recommended operation on a repository that is pulled 
by others.  If you realize you made a mistake by resetting the head, 
you can undo the operation afterward with:

$ git reset ORIG_HEAD

Sean
