From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Bizarre missing changes (git bug?)
Date: Sun, 27 Jul 2008 11:47:18 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807271144520.3486@nehalem.linux-foundation.org>
References: <8502DF7C-5303-49E8-8C67-F837343E2F0C@gmail.com> <alpine.LFD.1.10.0807211331390.31863@woody.linux-foundation.org> <200807260512.40088.zippel@linux-m68k.org> <alpine.LFD.1.10.0807261249430.4188@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807270049290.6791@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Roman Zippel <zippel@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sun Jul 27 20:51:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNBLZ-0004Xr-4I
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 20:51:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752685AbYG0Su5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 14:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752595AbYG0Su4
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 14:50:56 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33850 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751388AbYG0Su4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Jul 2008 14:50:56 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6RIoHHi004749
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 27 Jul 2008 11:50:18 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6RIoHiq032343;
	Sun, 27 Jul 2008 11:50:17 -0700
In-Reply-To: <Pine.LNX.4.64.0807270049290.6791@localhost.localdomain>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.405 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90356>



On Sun, 27 Jul 2008, Roman Zippel wrote:

> Hi,
> 
> On Sat, 26 Jul 2008, Linus Torvalds wrote:
> 
> > > Is there a way to change that default?
> > 
> > Use an alias or something.
> 
> This doesn't help with the graphical front ends and they only use what git 
> gives them.

And the graphical front-ends is exactly why --full-history cannot be the 
default.

We _could_ make it the default for non-graphical ones, if we also say 
"--no-merges". But then:

> > To see why it's the default, do a few tests. In particular, try it with 
> > gitk on the kernel. Try it on some fairly simple file that doesn't get a 
> > lot of churn. Example:
> > 
> > 	gitk lib/vsprintf.c
> > 
> > vs
> > 
> > 	gitk --full-history lib/vsprintf.c
> > 
> > and if you don't _immediately_ see why --full-history isn't the default, 
> > there's likely something wrong with you. One is useful. The other is not.
> > 
> > So we absolutely _have_ to simplify merges. There is no question about it.
> 
> Well, I don't want that much history.

Right. Nobody does.

> Let's take a different example.

No, let's not.

Unless you can solve that _one_ example efficiently, nothing else matters. 

The above example is all you ever need. Make that one work right (and 
efficiently), and everything is fine.

And no, some random ruby code doesn't make any difference what-so-ever. 
There are efficiency constraints here that make any ruby solution be 
unrealistic to begin with.

			Linus
