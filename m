From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Inconsistencies with git log
Date: Fri, 9 Nov 2007 10:14:09 -0800 (PST)
Message-ID: <alpine.LFD.0.999.0711091009250.15101@woody.linux-foundation.org>
References: <9e4733910711071415i1729e277u6be19b72cd682a85@mail.gmail.com> 
 <9e4733910711071503va92a653s25fd978989d5917d@mail.gmail.com> 
 <Pine.LNX.4.64.0711072309380.4362@racer.site> 
 <9e4733910711071529m604f3b12v29b3a040074ea4e@mail.gmail.com> 
 <Pine.LNX.4.64.0711080003080.4362@racer.site> 
 <9e4733910711071609t3e5412f1mf02e501b2d820bb3@mail.gmail.com> 
 <alpine.LFD.0.999.0711090747210.15101@woody.linux-foundation.org> 
 <9e4733910711090920m6b0b7704x7c5a3849215f385c@mail.gmail.com> 
 <alpine.LFD.0.999.0711090929130.15101@woody.linux-foundation.org> 
 <alpine.LFD.0.999.0711090943120.15101@woody.linux-foundation.org>
 <9e4733910711091004p6b5dd0c3x2c92148a51dd9927@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 19:15:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqYNe-0001RT-3k
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 19:14:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753194AbXKISOm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 13:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753410AbXKISOm
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 13:14:42 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:54782 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753098AbXKISOm (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Nov 2007 13:14:42 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA9IE9YJ016209
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 9 Nov 2007 10:14:10 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA9IE9QM025807;
	Fri, 9 Nov 2007 10:14:09 -0800
In-Reply-To: <9e4733910711091004p6b5dd0c3x2c92148a51dd9927@mail.gmail.com>
X-Spam-Status: No, hits=-2.739 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64239>



On Fri, 9 Nov 2007, Jon Smirl wrote:
> 
> Should "git log" and "git log path"  have two different command names?

Do you think that would really help?

We actually have people complaining about the numebr of git commands 
already. And the thing is, "git log" is actually what things like "gitk" 
use to visualize the history, and all *those* commands want the two 
different modes too! You want a "global history" view in gitk, but you 
also want a "file limited view". So having two different commands is 
actually what people absolutely DO NOT want.

On the same note: several git commands have totally different fundamental 
behaviour based on arguments - in ways even more different than "git log". 
At least "git log" always shows a log, the arguments just change what 
*part* of the log they show.

For example, think about "git checkout": you can use it to check out 
individual files and directories, but you can obviously use it to switch 
branches (and create them!) too.  That's actually a much bigger difference 
than the different modes of "git log", but considering how many people 
have complained about "many different commands", I think people seem to be 
happier with commands that do somewhat related things just depending on 
the kinds of arguments they get.

		Linus
