From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitk shows an empty line between "Comments" and changed files
Date: Fri, 28 Oct 2005 16:00:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510281557580.3348@g5.osdl.org>
References: <1130434230.19641.21.camel@dv>  <7vslum3l2w.fsf@assigned-by-dhcp.cox.net>
 <1130463389.2186.14.camel@dv>  <7v4q72xavz.fsf@assigned-by-dhcp.cox.net>
 <1130539503.10531.43.camel@dv>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 29 01:01:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVdDX-0004Da-VF
	for gcvg-git@gmane.org; Sat, 29 Oct 2005 01:01:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751894AbVJ1XAy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Oct 2005 19:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751896AbVJ1XAx
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Oct 2005 19:00:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47560 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751894AbVJ1XAu (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Oct 2005 19:00:50 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9SN0gFC007335
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 28 Oct 2005 16:00:42 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9SN0fND025668;
	Fri, 28 Oct 2005 16:00:41 -0700
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1130539503.10531.43.camel@dv>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10777>



On Fri, 28 Oct 2005, Pavel Roskin wrote:
> > 
> > I do not oppose dropping the commit-id line from the default
> > output, but having it optionally available would be useful in
> > one application.  Somebody _could_ write a tool that does
> > something like:
> > 
> >     git-rev-list ^$old_head $new_head |
> >     git-diff-tree -p -m --stdin --with-commit-ids |
> >     git-patch-id
> 
> Sounds good.  Perhaps the commit IDs should have a prefix identifying
> them.

Guys, why do you want to drop it? We've always had it, and it doesn't 
really hurt.

Yes, gitk got a new empty line because I didn't realize that the output of 
"git-diff-tree $commit" is slightly different from "git-diff-tree $t2 
$t2", but hey, that was due to a gitk change, and I think it should be 
trivial for gitk to just react to it.

So if we add a new flag, please make it go the other way: one that makes 
the output really quiet, but keeps the standard output the same.

		Linus
