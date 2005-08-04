From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] (preview) Renaming push.
Date: Wed, 3 Aug 2005 22:42:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508032236470.3258@g5.osdl.org>
References: <Pine.LNX.4.63.0508030109210.21304@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.58.0508030944210.3258@g5.osdl.org>
 <Pine.LNX.4.63.0508031849270.24318@wgmdd8.biozentrum.uni-wuerzburg.de>
 <200508031908.22562.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.58.0508031102590.3258@g5.osdl.org>
 <7vek9a8uy9.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0508031641270.3258@g5.osdl.org>
 <7vy87i46il.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 04 07:43:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0YVA-00083z-Dp
	for gcvg-git@gmane.org; Thu, 04 Aug 2005 07:42:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbVHDFma (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Aug 2005 01:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261843AbVHDFma
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Aug 2005 01:42:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20171 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261832AbVHDFmO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Aug 2005 01:42:14 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j745g7jA024420
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 3 Aug 2005 22:42:07 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j745g6Ph031339;
	Wed, 3 Aug 2005 22:42:07 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy87i46il.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 3 Aug 2005, Junio C Hamano wrote:
> 
> While I have not updated the send-pack <src>:<dst> syntax, I
> added a horrible hack that some people may love to see.  This
> removes the need to use git-rev-parse from many commands.

Yes, I think this makes sense. We had three different sha1 parsers: 
get_sha1(), get_sha1_hex(), and get_extended_sha1().

None of the users of get_sha1() really have any reason to want the limited
form, so I think your patch does the right thing.

Now, for extra bonus points, maybe you should make "git-rev-list" also 
understand the "rev..rev" format (which you can't do with just the 
get_sha1() interface, since it expands into more).

Of course, most people don't tend to use git-rev-list directly, so maybe 
that's not a biggie, and so git-rev-parse is fine.

		Linus
