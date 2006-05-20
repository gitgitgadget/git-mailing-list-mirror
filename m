From: Sean <seanlkml@sympatico.ca>
Subject: Re: dangling commits.
Date: Sat, 20 May 2006 19:08:02 -0400
Message-ID: <BAYC1-PASMTP12721518DAEC49D36EF4B8AEA40@CEZ.ICE>
References: <20060520230531.GA27511@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 21 01:14:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fhadv-00009O-Fs
	for gcvg-git@gmane.org; Sun, 21 May 2006 01:13:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964841AbWETXNx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 May 2006 19:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbWETXNw
	(ORCPT <rfc822;git-outgoing>); Sat, 20 May 2006 19:13:52 -0400
Received: from bayc1-pasmtp12.bayc1.hotmail.com ([65.54.191.172]:27827 "EHLO
	BAYC1-PASMTP12.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S964841AbWETXNw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 May 2006 19:13:52 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP12.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 20 May 2006 16:21:24 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 49BF6644C28;
	Sat, 20 May 2006 19:13:50 -0400 (EDT)
To: Dave Jones <davej@redhat.com>
Message-Id: <20060520190802.0df67730.seanlkml@sympatico.ca>
In-Reply-To: <20060520230531.GA27511@redhat.com>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 20 May 2006 23:21:25.0203 (UTC) FILETIME=[1D044230:01C67C64]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 20 May 2006 19:05:31 -0400
Dave Jones <davej@redhat.com> wrote:

> What's wrong here?
> 
> (tmp)$ mkdir git
> (tmp)$ cd git
> (git)$ rsync -azq rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/git.git/ .git
> (git)$ git-fsck-objects --full
> dangling commit fc024e5e1b92fb11d11aa3c15e9e3f92a888acb6
> dangling commit be49def3dd524b241e3f14c657e740f2e4d73d39
> dangling commit e659abda29b2b25db2771c3e6086f15bc74b1d06
> dangling commit 0f5aaf12d411debc2958dfb029ffcf873d980f15
> dangling commit 8eed8a5da8330df6901f254eab4b7056855b919c
> 
> The version of git on that box is 1.2.6-1 from Debian etch.
> 
> 		Dave
> 

Nothing wrong.  Those commits were just dropped from the "pu" branch at
one time or another when it was rewound.  The repository could use a
pruning, but there's no harm done by having those objects remain in
the object database.   If you had used any protocol other than rsync,
they would not have appeared in your cloned copy.

Sean
