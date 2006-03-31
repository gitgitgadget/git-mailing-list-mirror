From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH/RFC 2/2] Make path-limiting be incremental when possible.
Date: Fri, 31 Mar 2006 11:44:51 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603311139540.27203@g5.osdl.org>
References: <Pine.LNX.4.64.0603301648530.27203@g5.osdl.org>
 <Pine.LNX.4.64.0603301652531.27203@g5.osdl.org> <7v1wwjvwz9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 31 21:45:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FPPYK-0004HJ-08
	for gcvg-git@gmane.org; Fri, 31 Mar 2006 21:45:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbWCaTo5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Mar 2006 14:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbWCaTo5
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Mar 2006 14:44:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:40922 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932172AbWCaTo5 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Mar 2006 14:44:57 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2VJiqEX015507
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 31 Mar 2006 11:44:53 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2VJipwU001107;
	Fri, 31 Mar 2006 11:44:52 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1wwjvwz9.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18230>



On Fri, 31 Mar 2006, Junio C Hamano wrote:

> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > This is an absolutely huge deal for anything like "git log -- <pathname>", 
> > but also for some things that we don't do yet - like the "find where 
> > things changed" logic I've described elsewhere, where we want to find the 
> > previous revision that changed a file.
> >...
> > Btw, don't even bother testing this with the git archive. git itself is so 
> > small that parsing the whole revision history for it takes about a second 
> > even with path limiting.
> 
> By the way, I forgot to praise you ;-).  
> 
> Even on a fast machine, the old one was not very useful, but
> this one is _instantaneous_.  Very good job.

Indeed. It's why I'd really like this to be merged before 1.3.0 - it moves 
a certain class of problems from "it works" to "it's actually usable".

Now, the _real_ usage I foresee (which just wasn't practical before) is 
the interactive annotation thing - this won't help a _full_file_ annotate 
(which usually needs to go back to the very first version of a file 
anyway), but it should make it possible to play with an incremental one 
(the "graphical git-whatchanged" kind).

But even just the "git log" difference makes it worth it. 

		Linus
