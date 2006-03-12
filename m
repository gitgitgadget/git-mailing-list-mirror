From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Trivial warning fix for imap-send.c
Date: Sun, 12 Mar 2006 15:02:40 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603121457520.3618@g5.osdl.org>
References: <20060311192954.GQ16135@artsapartment.org>
 <slrne17urp.fr9.mdw@metalzone.distorted.org.uk> <Pine.LNX.4.64.0603120847500.3618@g5.osdl.org>
 <slrne18of5.fr9.mdw@metalzone.distorted.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 13 00:16:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIZaP-0008Me-D8
	for gcvg-git@gmane.org; Mon, 13 Mar 2006 00:02:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbWCLXCt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Mar 2006 18:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbWCLXCs
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Mar 2006 18:02:48 -0500
Received: from smtp.osdl.org ([65.172.181.4]:10462 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751275AbWCLXCs (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Mar 2006 18:02:48 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2CN2gDZ031654
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 12 Mar 2006 15:02:43 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2CN2ebm017153;
	Sun, 12 Mar 2006 15:02:41 -0800
To: Mark Wooding <mdw@distorted.org.uk>
In-Reply-To: <slrne18of5.fr9.mdw@metalzone.distorted.org.uk>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17529>



On Sun, 12 Mar 2006, Mark Wooding wrote:

> Linus Torvalds <torvalds@osdl.org> wrote:
> 
> > So in modern C, using NULL at the end of a varargs array as a pointer is 
> > perfectly sane, and the extra cast is just ugly and bowing to bad 
> > programming practices and makes no sense to anybody who never saw the 
> > horror that is K&R.
> 
> No!  You can still get bitten.  You're lucky that on common platforms
> all pointers look the same, but if you find one where `char *' (and
> hence `void *') isn't the same as `struct foo *' then, under appropriate
> circumstances you /will/ unless you put the casts in.

Not relevant. Show me any system that matters.

The fact is, compilers should conform to programmers, not the other way 
around. Bending over backwards for broken systems is _wrong_. The fact 
that there are insane build environments doesn't excuse bad manners, and 
explicit casts that aren't needed are HORRIBLE manners.

There is no valid reason to _ever_ cast NULL pointers. 

Btw, the same goes for casting the result from malloc etc, which some 
people also do. 

Put another way: you should not encourage insane systems, and you should 
definitely NOT encourage nit-picking people who read the standards in 
insane ways and say that the standards _allow_ badly behaved build 
environments.

It's true that the standards _allow_ crazy build environments. Who the 
f*ck cares? Crazy and bad build environments aren't any better for being 
allowed by the standard. Screw them. Call them names. And refuse to work 
with them.

		Linus
