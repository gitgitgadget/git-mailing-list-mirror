From: sean <seanlkml@sympatico.ca>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links (and
 other commit links ideas)
Date: Tue, 25 Apr 2006 14:45:25 -0400
Message-ID: <BAYC1-PASMTP03E0B5376ACFF165B29ED1AEBF0@CEZ.ICE>
References: <20060425035421.18382.51677.stgit@localhost.localdomain>
	<e2kgga$d7q$1@sea.gmane.org>
	<7v7j5e2jv7.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604250811230.3701@g5.osdl.org>
	<Pine.LNX.4.64.0604250833540.3701@g5.osdl.org>
	<e2lijt$aco$1@sea.gmane.org>
	<Pine.LNX.4.64.0604251004410.3701@g5.osdl.org>
	<BAYC1-PASMTP091348C4C33C5A0E83C012AEBF0@CEZ.ICE>
	<Pine.LNX.4.64.0604251106400.3701@g5.osdl.org>
	<BAYC1-PASMTP04D82622D9D5DA7E352079AEBF0@CEZ.ICE>
	<Pine.LNX.4.64.0604251125010.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: jnareb@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 25 20:50:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYSbd-00074h-SD
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 20:49:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbWDYStr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Apr 2006 14:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbWDYStr
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 14:49:47 -0400
Received: from bayc1-pasmtp03.bayc1.hotmail.com ([65.54.191.163]:27140 "EHLO
	BAYC1-PASMTP03.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1751209AbWDYStq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Apr 2006 14:49:46 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP03.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 25 Apr 2006 11:49:45 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id A73C2644C28;
	Tue, 25 Apr 2006 14:49:44 -0400 (EDT)
To: Linus Torvalds <torvalds@osdl.org>
Message-Id: <20060425144525.3ef957cf.seanlkml@sympatico.ca>
In-Reply-To: <Pine.LNX.4.64.0604251125010.3701@g5.osdl.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 25 Apr 2006 18:49:45.0704 (UTC) FILETIME=[056E5680:01C66899]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 25 Apr 2006 11:26:25 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> It can't help porcelain.
> 
> If we have undefined or bad semantics for it, the only thing it can do is 
> _hurt_ porcelain, because it will cause confusion down the line.
> 
> Semantics for data objects are _the_ most important part of a SCM. Pretty 
> much any project, in fact. 
> 
> And bad or weakly defined semantics will invariably cause problems later.

Take your example of how git-revert works today, it copies the comment from 
the original, thus keeping this semantic-free meta-data intact between
related commits.  However, you'd have to jump through hoops to accomplish
this same simple task with any third party meta data, unless it was 
burried inside the commit message text.
 
> So why argue for it?
> 
> Just use the existing comment field.

The last argument you and I had was me taking the other side, saying that 
it was fine for git to parse the free form text area to extract information; 
you rightfully showed me why that was wrong.

It's no different for a bug tracker or other 3rd party software that wants
to interface with git, it's bad design to force them to parse a single
free form text comment into individual pieces to extract their meta data.
Especially when git could easily add the ability to add multple comments
to each commit.  

Sean
