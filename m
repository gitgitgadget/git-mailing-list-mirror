From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Make "git clone" less of a deathly quiet experience
Date: Sat, 11 Feb 2006 11:04:35 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602111100270.3691@g5.osdl.org>
References: <Pine.LNX.4.64.0602102018250.3691@g5.osdl.org>
 <20060211183959.GA9984@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>, Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Feb 11 20:05:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F803O-0005jJ-MN
	for gcvg-git@gmane.org; Sat, 11 Feb 2006 20:05:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbWBKTEq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Feb 2006 14:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964776AbWBKTEq
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Feb 2006 14:04:46 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51178 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964773AbWBKTEq (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Feb 2006 14:04:46 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1BJ4aDZ014568
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 11 Feb 2006 11:04:36 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1BJ4ZXQ009600;
	Sat, 11 Feb 2006 11:04:35 -0800
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <20060211183959.GA9984@steel.home>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15958>



On Sat, 11 Feb 2006, Alex Riesen wrote:
> 
> I'd put a \n before finish_pack to make it nicer.

Yes.

Duh. I did all my testing with "time git clone ..", so I had the extra \n 
added by the fact that "time" itself will do it.

Side comment: the pack preparation stage seems to take about 90s for the 
kernel. Of course, that will keep growing with history, but so will 
probably the pack-size, so percentage-wise, the 90% / 10% thing is likely 
to hold for DSL (yes, DSL gets faster too, but so do CPU ;).

That 90s is unquestionably irritating, though, so we do want to either 
cache them, or add similar "I'm working on it" output to that phase too.

		Linus
