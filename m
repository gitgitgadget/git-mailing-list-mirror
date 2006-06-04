From: Sean <seanlkml@sympatico.ca>
Subject: Re: Using subversion tools on Mozilla CVS
Date: Sun, 4 Jun 2006 11:20:29 -0400
Message-ID: <BAYC1-PASMTP08068F9BD23CF4FA8A1BDBAE970@CEZ.ICE>
References: <9e4733910606032009p252ff5fai7401401427ae3ec3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 04 17:21:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmuPm-0003xp-Iv
	for gcvg-git@gmane.org; Sun, 04 Jun 2006 17:21:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507AbWFDPVO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Jun 2006 11:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751506AbWFDPVO
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jun 2006 11:21:14 -0400
Received: from bayc1-pasmtp08.bayc1.hotmail.com ([65.54.191.168]:16968 "EHLO
	BAYC1-PASMTP08.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S1751507AbWFDPVO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jun 2006 11:21:14 -0400
X-Originating-IP: [65.93.43.191]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.191]) by BAYC1-PASMTP08.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 4 Jun 2006 08:26:24 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 6D552644C28;
	Sun,  4 Jun 2006 11:21:12 -0400 (EDT)
To: "Jon Smirl" <jonsmirl@gmail.com>
Message-Id: <20060604112029.cb3405ab.seanlkml@sympatico.ca>
In-Reply-To: <9e4733910606032009p252ff5fai7401401427ae3ec3@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.9.1; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 04 Jun 2006 15:26:24.0984 (UTC) FILETIME=[3DC23580:01C687EB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 3 Jun 2006 23:09:00 -0400
"Jon Smirl" <jonsmirl@gmail.com> wrote:

> I found this tool written in Python for importing CVS into Subversion.
> It seems to be handling the Mozilla CVS repository with fewer problems
> than parsecvs.
> 
> http://cvs2svn.tigris.org/cvs2svn.html
> 
> Since I'm not a native Python speaker, anyone else want to give a try
> at changing it to support git?
 
Hi Jon,

If you haven't tried to import into git with a recent version of
git-cvsimport, it would be worth a shot.

As for the tool you've referenced above, it does look pretty good.
It makes multiple passes and saves to a temp file after each, letting
you resume from that point and means it can use less memory overall.

It can produce a pretty straight forward looking dump file if you
pass it the "--dump-only" option, rather than it pushing the results
into svn; for instance:

 $ cvs2svn --dump-only --dumpfile DUMPFILE <cvs directory>

It shouldn't be too hard to write a script that imports the revisions
found in the resulting DUMPFILE into git.

Sean
