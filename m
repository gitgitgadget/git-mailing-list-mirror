From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Unresolved issues
Date: Tue, 20 Feb 2007 16:56:07 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702201648000.4043@woody.linux-foundation.org>
References: <7virdx1e58.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0702200934270.20368@woody.linux-foundation.org>
 <7vfy90v729.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702201621050.4043@woody.linux-foundation.org>
 <Pine.LNX.4.63.0702210136050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 21 01:56:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJfmP-0002Xu-6H
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 01:56:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbXBUA4P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 19:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932266AbXBUA4P
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 19:56:15 -0500
Received: from smtp.osdl.org ([65.172.181.24]:59525 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932244AbXBUA4O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 19:56:14 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1L0u8hB032072
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 20 Feb 2007 16:56:08 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1L0u7rp027453;
	Tue, 20 Feb 2007 16:56:08 -0800
In-Reply-To: <Pine.LNX.4.63.0702210136050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=-0.458 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40270>



On Wed, 21 Feb 2007, Johannes Schindelin wrote:
>
> Um, I don't want to spoil the party, but was not the original idea of this 
> auto-CRLF thing some sort of "emulation" of the CVS text checkout 
> behaviour?
> 
> In that case, .gitattributes (I mean a tracked one) would be wrong, wrong, 
> wrong.
> 
> It's a local setup if you want auto-CRLF or not. So, why not just make it 
> a local setting (if in config or $GIT_DIR/info/gitattributes, I don't 
> care) which shell patterns are to be transformed on input and/or output?

That is a good point. We *could* just make it a ".git/config" issue, which 
has the nice benefit that you can just set up some user-wide rules rather 
than making it be per-repo.

Of course, the config language may not be wonderful for this. But we could 
certainly have something like

	[format "crlf"]
		enable = true
		text = *.[ch]
		binary = *.jpg

which would just override the built-in rules (where anything that doesn't 
match is just "auto-content"). And make the default built-in ones be good 
enough that in _practice_ you never even need this in the first place.

		Linus
