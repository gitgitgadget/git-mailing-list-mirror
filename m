From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Add an empty directory?
Date: Sat, 13 Aug 2005 12:41:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508131238150.3553@g5.osdl.org>
References: <20050813173043.GA25013@hpsvcnb.fc.hp.com> <20050813180008.GJ5608@pasky.ji.cz>
 <20050813181945.GA2191@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 13 21:49:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E41zQ-0007W6-G7
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 21:48:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbVHMTsQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 15:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbVHMTsP
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 15:48:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12504 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932274AbVHMTsP (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Aug 2005 15:48:15 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7DJfkjA026203
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 13 Aug 2005 12:41:47 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7DJfj6U025691;
	Sat, 13 Aug 2005 12:41:46 -0700
To: Carl Baldwin <cnb@fc.hp.com>
In-Reply-To: <20050813181945.GA2191@hpsvcnb.fc.hp.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.44__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 13 Aug 2005, Carl Baldwin wrote:
> 
> The bottom line is that I don't really see many situations where it is
> absolutely necessary but it is a convenience.  Not supporting it may
> seem like an artificial limit that really didn't need to be there.

Well, there is an argument for not supporting it, namely that the way 
patches work, traditionally a directory that became empty is deleted 
(because patches have no way of saying "remove directory" or "create 
directory").

So a system where the existence of a directory flows from the existence of 
the files within the directory will automatically always do the right 
thing with patches floating around.

Which is a big deal for me, since most of the kernel development still 
ends up being done with patches. Yes, we merge things with git, but a lot 
of the development is about passing patches around for review and 
commentary.

And the thing is, you can always create the directory in your workspace. 
Git won't care, and won't know about it, but there's really no downside to 
it. 

			Linus
