From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 0/2] apply.c: a fix and an enhancement
Date: Fri, 22 Jul 2005 16:26:07 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507221619450.6074@g5.osdl.org>
References: <7vzmsewzik.fsf@assigned-by-dhcp.cox.net>
 <20050722181800.GU20369@mythryan2.michonline.com> <7vsly6vd2b.fsf@assigned-by-dhcp.cox.net>
 <42E1571B.8070108@gmail.com> <Pine.LNX.4.58.0507221340450.6074@g5.osdl.org>
 <7vhdempmgg.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507221447420.6074@g5.osdl.org>
 <7vfyu6jvrm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: A Large Angry SCM <gitzilla@gmail.com>,
	Ryan Anderson <ryan@michonline.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 23 01:29:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dw6xp-0003YG-GF
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 01:29:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262227AbVGVX3Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 19:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262231AbVGVX1K
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 19:27:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27349 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262229AbVGVX0U (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jul 2005 19:26:20 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6MNQAjA007517
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 22 Jul 2005 16:26:10 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6MNQ75B023346;
	Fri, 22 Jul 2005 16:26:08 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfyu6jvrm.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 22 Jul 2005, Junio C Hamano wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > I'd _really_ prefer to not have any preferences or other metadata files
> > under version control within that same project.
> 
> Don't you think that would be a per-project decision?  Is it
> acceptable if I make sure that .gitinfo/* is _optional_ and
> things do not break for projects that do not use it?

It can't be a per-project decision, since the preferences are 
per-developer.

In other words, if it's per-project, then that implies that every single 
developer has to agree on the same thing. Which just not possible - it 
makes no sense.

In contrast, if you have a separate local _branch_ that maintains a
".gitinfo"  totally separately (no common commits at all), then you can
choose to propagate/participate in that branch or not, as you wish, on a
per-developer basis.

> I agree.  The .gitinfo/fake-parents may be a good thing in that
> sense to have project-wide,

I disagree. Even something like fake-parents isn't project-wide. 

For example, what if I tried to dig out even _more_ information than what 
is in the BK CVS archives? Or if I wanted to have just the 2.6.0-> 
history? The whole point of fake-parents is that you can do things like 
that - you can point your history at alternative views.

If we'd make it project-global, then we might as well just rewrite the 
original commit entirely, and use "git-convert-cache" to convert the whole 
archive. At that point, fake-parents becomes pointless.

>			 and as long as the kernel person
> (that is you) do not add .gitinfo/commit-template you would be
> happy, wouldn't you?

What you're saying is that people can be happy if they just don't use a 
stupid decision. That's a sure sign that the decision shouldn't have been 
made in the first place.

		Linus
