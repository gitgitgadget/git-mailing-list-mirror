From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Summary of core GIT while you are away.
Date: Thu, 26 May 2005 22:21:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505262216190.17402@ppc970.osdl.org>
References: <7vzmuy13od.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0505160837080.28162@ppc970.osdl.org> <20050526004411.GA12360@vrfy.org>
 <Pine.LNX.4.58.0505251826460.2307@ppc970.osdl.org> <20050526202712.GA6024@vrfy.org>
 <7vd5rdbtif.fsf@assigned-by-dhcp.cox.net> <20050526232953.GA6215@vrfy.org>
 <7vll618rnw.fsf@assigned-by-dhcp.cox.net> <42967CFE.7030007@zytor.com>
 <7vk6ll2vde.fsf@assigned-by-dhcp.cox.net> <42969B98.7070701@zytor.com>
 <7v4qcp2tp1.fsf@assigned-by-dhcp.cox.net> <42969E6E.5080606@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Kay Sievers <kay.sievers@vrfy.org>, pasky@ucw.cz,
	braddr@puremagic.com, nico@cam.org, david@dgreaves.com,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 27 07:18:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbXEB-0005zF-CC
	for gcvg-git@gmane.org; Fri, 27 May 2005 07:17:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261814AbVE0FTr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 01:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbVE0FTr
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 01:19:47 -0400
Received: from fire.osdl.org ([65.172.181.4]:46553 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261814AbVE0FTp (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 May 2005 01:19:45 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4R5JQjA005171
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 26 May 2005 22:19:26 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4R5JOVH002964;
	Thu, 26 May 2005 22:19:25 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <42969E6E.5080606@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 26 May 2005, H. Peter Anvin wrote:
> 
> It would still be a lot nicer to have them decoupled.

Yes, but git has been changing so much that I think it has made sense to 
have it together with cogito, so that you don't have version skew.

Have we gotten to the point where git is calming down? Judging by the raw
diff etc changes, I'd say no, but on the other hand, those are largely
over, and maybe we don't have any serious real incompatibilities pending
any mroe...

The object data structures have been pretty stable (thank the Gods!), but 
command line switches and some data output formats certainly have not.

The one big change I see coming is that I really want to make
"git-rev-list HEAD TAIL" work right (ie do a real reachabilty thing rather
than the date-based thing), at which point you'd _usually_ not need to use
the full logic of git-rev-tree that can do multiple parents etc. But that
change should be compatible, I hope (ie old scripts will continue to use
git-rev-tree and play games with the output, because they'd not know any
better).

			Linus
