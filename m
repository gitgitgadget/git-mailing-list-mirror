From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Cogito: cg-clone doesn't like packed tag objects
Date: Tue, 27 Sep 2005 14:44:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509271441210.3308@g5.osdl.org>
References: <7virwna2oi.fsf@assigned-by-dhcp.cox.net> <7v3bnra20z.fsf@assigned-by-dhcp.cox.net>
 <43348086.2040006@zytor.com> <20050924011833.GJ10255@pasky.or.cz>
 <20050926212536.GF26340@pasky.or.cz> <7virwna2oi.fsf@assigned-by-dhcp.cox.net>
 <20050926222944.GG26340@pasky.or.cz> <7vr7bb5d8w.fsf@assigned-by-dhcp.cox.net>
 <8764snyufn.fsf@ualberta.net> <7v4q875bbj.fsf@assigned-by-dhcp.cox.net>
 <20050927094029.GA30889@pasky.or.cz> <7v64sm30dh.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0509271020530.3308@g5.osdl.org> <7v64sm1hp3.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0509271414000.3308@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, Tom Prince <tom.prince@ualberta.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 27 23:46:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKNFe-0001Av-5h
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 23:44:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965158AbVI0Vof (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Sep 2005 17:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965160AbVI0Vof
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Sep 2005 17:44:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2760 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965158AbVI0Vof (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Sep 2005 17:44:35 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8RLiP4s009268
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 27 Sep 2005 14:44:26 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8RLiNBq001316;
	Tue, 27 Sep 2005 14:44:24 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.58.0509271414000.3308@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.118 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9416>



On Tue, 27 Sep 2005, Linus Torvalds wrote:
> 
> Yes, it would work, but I really think that there's no downside to just 
> having a
> 
> 	git fetch --tags <dest>
> 
> since that's just a few lines of trivial code, with no special cases.

Btw, there are upsides too. Remember how confused people were about your
very own v0.99.7a-d releases? They are _not_ on your main path, so those
tags wouldn't have been picked up even if Petr did his "pick up tags to
stuff you merge automatically" thing.

In fact, if you'd add "--tags" as some kind of automated flag in the
.git/remote/ file, then doing a "git fetch origin" could automatically 
fetch tags by default, _without_ having the mistake of fetching them in 
general (it probably _does_ make sense to track tags from the origin, 
since you get the ones the origin had at "clone" time anyway).

		Linus
