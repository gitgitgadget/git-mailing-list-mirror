From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [RFC PATCH] Windows: Assume all file names to be UTF-8 encoded.
Date: Mon, 02 Mar 2009 21:52:41 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.0903022146510.20047@perkele.intern.softwolves.pp.se>
References: <alpine.DEB.2.00.0903020941120.17877@perkele.intern.softwolves.pp.se>
 <49ABD24B.5060005@viscovery.net>
 <alpine.DEB.2.00.0903021404000.17877@perkele.intern.softwolves.pp.se>
 <200903022058.33392.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7BIT
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Mon Mar 02 21:55:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeFAg-0007KG-06
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 21:55:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752284AbZCBUyB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 15:54:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752057AbZCBUyA
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 15:54:00 -0500
Received: from smtp.getmail.no ([84.208.20.33]:50496 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750820AbZCBUx7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 15:53:59 -0500
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0KFW00621CPX0300@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 02 Mar 2009 21:53:57 +0100 (CET)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0KFW00MI4CNTI930@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 02 Mar 2009 21:52:41 +0100 (CET)
Received: from perkele ([84.215.142.63]) by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0KFW001L5CNTMJ90@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 02 Mar 2009 21:52:41 +0100 (CET)
Received: by perkele (Postfix, from userid 501)	id 57C772FC03; Mon,
 02 Mar 2009 21:52:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])	by perkele (Postfix)
 with ESMTP id 548852FC02; Mon, 02 Mar 2009 21:52:41 +0100 (CET)
In-reply-to: <200903022058.33392.robin.rosenberg.lists@dewire.com>
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111964>

Robin Rosenberg:

> Pipes are just bytes so you have to know what you're piping by convention 
> or protocol. You can ask for the console output page, which may be set to 
> a multibyte locale or unicode and maybe trust that.... (just guessing, 
> really).

You can get cmd.exe to write data to pipes and redirections as UTF-16 
Unicode (cmd.exe /u), perhaps there is a way to capitalise on that? 
"Unfortunately", the Git stuff is mostly called from a bash shell inside 
msys, so it requires a "bit" more work...

> architecture? Like the "architecture" of species? No, it's evolution.

There's still an architecture there, somewhere. Perhaps not intended or 
specified, but there definitely is one :-)

> http://www.jgit.org/cgi-bin/gitweb/gitweb.cgi?p=GIT.git;a=shortlog;h=i18n
>
> The goal is locale neutrality yielding the "expected", in the users eyes, 
> result regardless of locale as much as possible.

Ah, yes, that looks like an interesting starting point. I already assumed 
that Git on Linux would use UTF-8 for everything already, since it already 
does that for the commit messages despite me using an iso8859-1 locale. 
Apparently I haven't done my homework.

> We let the runtime decide on how to encode file names in the file system 
> using the user's locale.

That's good. That's what I'm trying to achieve. Or, rather, avoid the user 
locale altogether (which is easy on Windows since the file names are always 
stored in Unicode, and the user locale can be bypassed).

> I'd be almost happy with a solution that works when people are interacting 
> using the subset that is convertible between the character sets in use.

You mean like the "invariant" character set? :-) Using Unicode internally 
(in whatever encoding) is nice, the problem is when you have to interact 
with the world around you.

-- 
\\// Peter - http://www.softwolves.pp.se/
