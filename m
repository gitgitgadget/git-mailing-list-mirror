From: Andrew Morton <akpm@osdl.org>
Subject: Re: the war on trailing whitespace
Date: Sun, 26 Feb 2006 10:36:04 -0800
Message-ID: <20060226103604.2d97696c.akpm@osdl.org>
References: <20060225174047.0e9a6d29.akpm@osdl.org>
	<7v1wxq7psj.fsf@assigned-by-dhcp.cox.net>
	<20060225210712.29b30f59.akpm@osdl.org>
	<Pine.LNX.4.64.0602260925170.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 26 19:37:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDQlX-000214-4v
	for gcvg-git@gmane.org; Sun, 26 Feb 2006 19:37:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbWBZShA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Feb 2006 13:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbWBZShA
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Feb 2006 13:37:00 -0500
Received: from smtp.osdl.org ([65.172.181.4]:29070 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751360AbWBZSg7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Feb 2006 13:36:59 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1QIatDZ003136
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 26 Feb 2006 10:36:55 -0800
Received: from bix (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id k1QIatvP019908;
	Sun, 26 Feb 2006 10:36:55 -0800
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602260925170.22647@g5.osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16787>

Linus Torvalds <torvalds@osdl.org> wrote:
>
> 
> 
> On Sat, 25 Feb 2006, Andrew Morton wrote:
> > 
> > I'd suggest a) git will simply refuse to apply such a patch unless given a
> > special `forcing' flag, b) even when thus forced, it will still warn and c)
> > with a different flag, it will strip-then-apply, without generating a
> > warning.
> 
> This doesn't do the "strip-then-apply" thing, but it allows you to make 
> git-apply generate a warning or error on extraneous whitespace.
> 
> Use --whitespace=warn to warn, and (surprise, surprise) --whitespace=error 
> to make it a fatal error to have whitespace at the end.

Thanks.  But it defaults to nowarn.  Nobody will turn it on and nothing
improves.

> Totally untested, of course. But it compiles, so it must be fine.

Who cares, as long as the patch doesn't add trailing whitespace? ) ;)

> HOWEVER! Note that this literally will check every single patch-line with 
> "+" at the beginning. Which means that if you fix a simple typo, and the 
> line had a space at the end before, and you didn't remove it, that's still 
> considered a "new line with whitespace at the end", even though obviously 
> the line wasn't really new.
> 
> I assume this is what you wanted, and there isn't really any sane 
> alternatives (you could make the warning activate only for _pure_ 
> additions with no deletions at all in that hunk, but that sounds a bit 
> insane).

Yup.  So by the time we've patched every line in the kernel, it's
trailing-whitespace-free.
