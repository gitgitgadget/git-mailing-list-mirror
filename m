From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ANNOUNCE] git-pasky-0.6.2 && heads-up on upcoming changes
Date: Wed, 20 Apr 2005 21:00:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504202056310.2344@ppc970.osdl.org>
References: <20050420205633.GC19112@pasky.ji.cz> <20050420211919.GA20129@kroah.com>
 <20050420215117.GJ19112@pasky.ji.cz> <Pine.LNX.4.58.0504201503050.6467@ppc970.osdl.org>
 <20050420222815.GM19112@pasky.ji.cz> <Pine.LNX.4.58.0504201710500.2344@ppc970.osdl.org>
 <Pine.LNX.4.58.0504201809170.2344@ppc970.osdl.org> <20050421033526.GA9404@nevyn.them.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, Greg KH <greg@kroah.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 05:54:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOSlt-00056M-KV
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 05:54:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbVDUD6w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 23:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbVDUD6w
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 23:58:52 -0400
Received: from fire.osdl.org ([65.172.181.4]:41151 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261196AbVDUD6u (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 23:58:50 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3L3wjs4005306
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 20 Apr 2005 20:58:46 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3L3wiqT013563;
	Wed, 20 Apr 2005 20:58:45 -0700
To: Daniel Jacobowitz <dan@debian.org>
In-Reply-To: <20050421033526.GA9404@nevyn.them.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 20 Apr 2005, Daniel Jacobowitz wrote:
> 
> My logic: it's a lot more intuitive to say "cg-log | less" to get
> paginated output than it is to say "cg-log | cat" to get unpaginated
> output.

I disagree.

There is _never_ any valid situation where you do "cg-log" with 
unpaginated output to a tty.

In _any_ real system you'll be getting thousands of lines of output. 
Possibly millions. unpaginated? What the hell are you talking about?

And as I pointed out, if the output is not a tty, then both less and more
automatically turn into cat, so there's no difference. This change _only_
triggers for a tty, and I dare you to show a single relevant project where 
it's ok to scroll thousands of lines.

Even git-pasky, which is just a two-week-old project right now outputs 
4338 lines of output to "git log". 

Unpaginated? You must be kidding.

(But if you are _that_ fast a reader, then hey, use "PAGER=cat", and 
you'll find yourself happy).

		Linus
