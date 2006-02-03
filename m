From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] combine-diff: add safety check to --cc.
Date: Thu, 2 Feb 2006 17:05:40 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602021702170.3732@g5.osdl.org>
References: <Pine.LNX.4.64.0602012212200.21884@g5.osdl.org>
 <7v8xsuuto5.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0602012334360.21884@g5.osdl.org>
 <Pine.LNX.4.64.0602012353130.21884@g5.osdl.org> <Pine.LNX.4.64.0602020002110.21884@g5.osdl.org>
 <7voe1qtbr5.fsf_-_@assigned-by-dhcp.cox.net> <7vvevyrtn9.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0602021454060.21884@g5.osdl.org> <7v64nxmhqn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 03 02:05:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4pOW-0005LO-Pk
	for gcvg-git@gmane.org; Fri, 03 Feb 2006 02:05:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbWBCBFq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Feb 2006 20:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbWBCBFq
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Feb 2006 20:05:46 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45772 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751239AbWBCBFp (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Feb 2006 20:05:45 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1315fDZ015088
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 2 Feb 2006 17:05:41 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1315eqL017891;
	Thu, 2 Feb 2006 17:05:41 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64nxmhqn.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.67__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15521>



On Thu, 2 Feb 2006, Junio C Hamano wrote:
> 
> Two seconds?  You must be using CPUs/disks/memory that are lot
> faster than what I use (the kernel.org machine available to me
> seems to do it at around 3.5 wallclock seconds).  Envy, envy,...

That's not even the fastest machine I have.

However, a lot of it may be due to packing. Packed repositories tend to be 
a lot faster, and this was fully packed.

> Two things to note.
> 
>  * Somebody said he missed "index" lines.  There is one now, but
>    I am wondering if it might be just be an added noise.  It
>    gets absolutely horrible if you run diff-tree on Len's merge.
>    On the other hand, being able to cut&paste them to "git
>    cat-file blob" command line might be handy.
> 
>    Do we want to keep it?

I don't mind it, I have no strong opinions.

>  * I show the line number from the result (+1,93) and then
>    parents' line numbers (-1,87 for the first parent, -1,3 for
>    the second parent).  To be consistent with the normal ones, I
>    am thinking it might be better to move the line number for
>    the result to the last.

I think you're right. The "far off to the right" case is the unusual case, 
I think, and consistency is more important.

But it's certainly not a huge deal for me either.

		Linus
