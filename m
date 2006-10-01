From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: What will happen to git.git in the near future
Date: Sun, 1 Oct 2006 13:23:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610011318100.3952@g5.osdl.org>
References: <7v7iztbldm.fsf@assigned-by-dhcp.cox.net> <7vd59c2vev.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610011132040.3952@g5.osdl.org>
 <Pine.LNX.4.63.0610012052520.14200@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0610011256580.3952@g5.osdl.org>
 <Pine.LNX.4.63.0610012208410.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 01 22:23:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GU7qe-0003uS-Fq
	for gcvg-git@gmane.org; Sun, 01 Oct 2006 22:23:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbWJAUXY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Oct 2006 16:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbWJAUXY
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Oct 2006 16:23:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26025 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932308AbWJAUXX (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Oct 2006 16:23:23 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k91KNGaX028369
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 1 Oct 2006 13:23:17 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k91KNGH7029288;
	Sun, 1 Oct 2006 13:23:16 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0610012208410.14200@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=-0.447 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28200>



On Sun, 1 Oct 2006, Johannes Schindelin wrote:
> 
> The problem is that the Makefile does not realize that Git.xs no longer is 
> there. Neither does the code which recreates the Makefile.

No. The problem is that top-level dependency rules for perl/Makefile are 
simply _wrong_. It claims it depends on some things (which is true), but 
then it totally ignores _other_ things that it also depends on.

Further, even if it was right, the rules to actually _generate_ the 
Makefile then seems wrong, in that it cares about files it shouldn't care 
about in the first place.

So why do that at all? Why accept such crap?

			Linus
