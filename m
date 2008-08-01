From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Monotone workflow compared to Git workflow ( was RE: Git vs
 Monotone)
Date: Thu, 31 Jul 2008 20:02:51 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807311956040.3277@nehalem.linux-foundation.org>
References: <bd6139dc0807311113n50dda9f0t1aab46b724510de2@mail.gmail.com> <alpine.LFD.1.10.0807311211260.3277@nehalem.linux-foundation.org> <63BEA5E623E09F4D92233FB12A9F79430238A5EE@emailmn.mqsoftware.com> <alpine.LFD.1.10.0807311253140.3277@nehalem.linux-foundation.org>
 <alpine.LFD.1.10.0807311426090.3277@nehalem.linux-foundation.org> <20080801025024.GA18529@anvil.corenet.prv>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Craig L. Ching" <cching@mqsoftware.com>, sverre@rabbelier.nl,
	Git Mailinglist <git@vger.kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 01 05:07:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOkyq-0004AE-Us
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 05:07:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753337AbYHADF7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 23:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753232AbYHADF7
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 23:05:59 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47707 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751304AbYHADF6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Jul 2008 23:05:58 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7135qar022350
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 31 Jul 2008 20:05:53 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7135piS025886;
	Thu, 31 Jul 2008 20:05:51 -0700
In-Reply-To: <20080801025024.GA18529@anvil.corenet.prv>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.405 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91023>



On Thu, 31 Jul 2008, Dmitry Torokhov wrote:

> > For example, for the kernel, I can literally rebuild my whole kernel 
> > (which is just what I use on _that_ machine) in about 16 seconds. This is 
> > _not_ using ccache or anything else - it's rebuilding the whole tree with 
> > -j16.
> 
> Is it after make mrproper (wow)?

Yeah. It's after doing

	git clean -dqfx
	make oldconfig

where I tend to use "git clean -dqfx" instead of "make mrproper" these 
days. 

Note that my "oldconfig" really only does the things I need, so this is 
_not_ a "allmodconfig" or anything like that. That would take much longer. 
It only has the drivers I use, and the stuff I actually need (it's not a 
embedded kernel in any way, but it's definitely pared down config exactly 
because I like being able to rebuild my kernels without wasting time on 
thousands of drivers that I can't use anyway).

Other people can do the "does it compile?" testing. Not worth my time, I 
feel ;)

> Because for me (and well, I dont have that beefy boxes as you do) 
> swithing between "for-linus" and "next" that based off a revision in 
> vicinity of 2.6.xx-rc1 and "work" which tracks the tip of your tree 
> takes time to rebuild.

Well, the difference really is the beefy box. And the fact that I hate 
modules, and I hate building stuff that I don't actually need. 

I literally turn off CONFIG_MODULES entirely. 

			Linus
