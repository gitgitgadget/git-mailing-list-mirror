From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Make "git clone" less of a deathly quiet experience
Date: Fri, 10 Feb 2006 20:37:26 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602102032410.3691@g5.osdl.org>
References: <Pine.LNX.4.64.0602102018250.3691@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sat Feb 11 05:37:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7mVy-0005bK-V9
	for gcvg-git@gmane.org; Sat, 11 Feb 2006 05:37:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbWBKEhi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Feb 2006 23:37:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbWBKEhi
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Feb 2006 23:37:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:681 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932227AbWBKEhi (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Feb 2006 23:37:38 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1B4bRDZ014652
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 10 Feb 2006 20:37:27 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1B4bQP9019240;
	Fri, 10 Feb 2006 20:37:27 -0800
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>, Petr Baudis <pasky@suse.cz>
In-Reply-To: <Pine.LNX.4.64.0602102018250.3691@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15924>



On Fri, 10 Feb 2006, Linus Torvalds wrote:
> 
> Instead, it at least prints out how much data it's gotten, and what the 
> packign speed is. Which makes the user realize that it's actually doing 
> something useful instead of sitting there silently (and if the recipient 
> knows how large the final result is, he can at least make a guess about 
> when it migt be done).

Btw, we should print out the other "stages" too - the checkout in 
particular can be a big part of the overhead, and it would probably make 
sense to tell people about the fact that "hey, now we're checking the 
result out, we're not actually trying to destroy your disk".

Quite often, the way to make users happy is not by being impossibly fast 
or beautiful or otherwise wonderful, but by just _managing_ their 
expectations, so that they don't say "that's some slow crud", but instead 
say "Ok, it's a nice program, and it's doing a lot of hard work for me".

It takes me 15 minutes to clone a kernel repo over the network. Once I can 
see that most of that is getting a 106MB pack-file at 146 kB/s, I say "ok, 
that's fairly reasonable".

			Linus
