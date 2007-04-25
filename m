From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Making git disappear when talking about my code (was: Re: GIT
 vs Other: Need argument)
Date: Wed, 25 Apr 2007 07:55:49 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0704250751330.9964@woody.linux-foundation.org>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com>
 <20070417104520.GB4946@moonlight.home> <8b65902a0704170841q64fe0828mdefe78963394a616@mail.gmail.com>
 <200704171818.28256.andyparkins@gmail.com> <20070417173007.GV2229@spearce.org>
 <462521C7.2050103@softax.com.pl> <Pine.LNX.4.64.0704181130150.12094@racer.site>
 <alpine.LFD.0.98.0704180851060.2828@woody.linux-foundation.org>
 <Pine.LNX.4.64.0704191118050.8822@racer.site>
 <alpine.LFD.0.98.0704190940330.9964@woody.linux-foundation.org>
 <4627ABBB.8060709@softax.com.pl> <alpine.LFD.0.98.0704191341370.9964@woody.linux-foundation.org>
 <877is29b1l.wl%cworth@cworth.org> <7vps5ud91x.fsf@assigned-by-dhcp.cox.net>
 <87vefm7l6g.wl%cworth@cworth.org> <alpine.LFD.0.98.0704231609440.9964@woody.linux-foundation.org>
 <7v1wiabbfr.fsf@assigned-by-dhcp.cox.net> <87mz0w7g3j.wl%cworth@cworth.org>
 <87k5w07dft.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Marcin Kasperski <Marcin.Kasperski@softax.com.pl>,
	git@vger.kernel.org
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Wed Apr 25 16:56:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgiuX-0003sm-AK
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 16:56:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161195AbXDYOz6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 10:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965620AbXDYOz6
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 10:55:58 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:58853 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965589AbXDYOz5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Apr 2007 10:55:57 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l3PEtn11029130
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 25 Apr 2007 07:55:51 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3PEtnLg004965;
	Wed, 25 Apr 2007 07:55:49 -0700
In-Reply-To: <87k5w07dft.wl%cworth@cworth.org>
X-Spam-Status: No, hits=-3.033 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45533>



On Wed, 25 Apr 2007, Carl Worth wrote:
> 
> Oops. I just noticed that that last command is wrong. Instead of "git
> checkout --track -b <branch>" that should of course be "git checkout
> --track -b <branch> origin/<branch>".

No, it really should be

	git branch --track newbranch origin/oldbranch

followed by

	git checkout newbranch

and then it's not so hard. It's two commands, but it's two _simpler_ 
commands, that make sense on their own. Don't use the complex version: 
it's a "expert mode" command that just knows how to do both.

Alternatively, we *could* make just

	git checkout --track branch

be a shorthand for

	git checkout --track -b branch origin/branch

when "branch" doesn't exist, but origin/branch does. With the "--track", 
it's already unambiguous (you cannot track a detached head, so we know we 
want a branch.

			Linus
