From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Submodules and rewind
Date: Tue, 19 Feb 2008 16:47:15 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802191635010.7833@woody.linux-foundation.org>
References: <20080219140604.04afc91f@extreme> <20080219223201.GE4703MdfPADPa@greensroom.kotnet.org> <20080219152357.5ab397cf@extreme> <alpine.LSU.1.00.0802200033530.8333@wbgn129.biozentrum.uni-wuerzburg.de> <20080219161517.34fd5878@extreme>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, skimo@liacs.nl,
	skimo@kotnet.org, git@vger.kernel.org
To: Stephen Hemminger <shemminger@vyatta.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 01:48:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRd8k-0003gF-OY
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 01:48:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757069AbYBTAsQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 19:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756616AbYBTAsQ
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 19:48:16 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:56915 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751406AbYBTAsP (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Feb 2008 19:48:15 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1K0lk6g011120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 19 Feb 2008 16:47:47 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1K0lFUI008376;
	Tue, 19 Feb 2008 16:47:28 -0800
In-Reply-To: <20080219161517.34fd5878@extreme>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.74 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74485>



On Tue, 19 Feb 2008, Stephen Hemminger wrote:
> 
> Don't be stupid, I am not trying be obstreperous, just fix the problem.

Umm. Stephen - this is the first time you even *describe* the problem.

Your previous emails were just "hey, submodules don't work, fix it".

Why do you then call Dscho stupid for pointing out that you never even 
bothered to reveal any details of what your problem was?

But it's not clear how you even got into that state to begin with. How did 
your index get that confused? You said "I had to rewind one project back 
to a known good state", but considering the output, it looks like you 
didn't actually rewind it, but left it in some half-way state. 

A "git reset" should have reset the index, or you could probably have done 
something like "git add <submodule>" to basically force the index entry 
for just that submodule to the current state it had.

At a guess, it *looks* like you reset the submodules themselves, but never 
reset the superproject.

		Linus
