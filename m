From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: latest blob date (request)
Date: Mon, 16 Jan 2006 11:00:33 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601161055300.13339@g5.osdl.org>
References: <20060115173100.1134256b.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 16 20:01:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyZat-0007uM-3K
	for gcvg-git@gmane.org; Mon, 16 Jan 2006 20:00:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbWAPTAj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jan 2006 14:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbWAPTAj
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jan 2006 14:00:39 -0500
Received: from smtp.osdl.org ([65.172.181.4]:26497 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751025AbWAPTAi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jan 2006 14:00:38 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0GJ0bDZ008187
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 16 Jan 2006 11:00:37 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0GJ0Xac001198;
	Mon, 16 Jan 2006 11:00:35 -0800
To: "Randy.Dunlap" <rdunlap@xenotime.net>
In-Reply-To: <20060115173100.1134256b.rdunlap@xenotime.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.65__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14752>



On Sun, 15 Jan 2006, Randy.Dunlap wrote:
> 
> I would find it helpful (a user optimization) if each tree list
> contained a date-last-modified/updated.  This could be used
> to help decide if I (someone) wanted to click on a particular
> blob or history (OK, blobs are quick, but history can be
> very time-consuming, so being able to shortcut or skip
> history would be very helpful IMO).

That's fundamentally a very expensive operation in git.

A "blob" doesn't have a date - and indeed, it cannot have one, since the 
same blob may be associated with multiple different pathnames, and 
multiple different commits.

If you have a particular pathname, you can ask "when was this pathname 
changed last", which is basically

	git-rev-list --max-count=1 HEAD -- Makefile 

but that's not very cheap either.

		Linus
