From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Submodule object store
Date: Tue, 27 Mar 2007 12:53:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703271250130.6730@woody.linux-foundation.org>
References: <20070326220302.GH22773@admingilde.org> <7vfy7rvct2.fsf@assigned-by-dhcp.cox.net>
 <20070326231637.GJ22773@admingilde.org> <7vy7ljtwir.fsf@assigned-by-dhcp.cox.net>
 <20070326233603.GL22773@admingilde.org> <20070327112549.GA12178@informatik.uni-freiburg.de>
 <20070327115029.GC12178@informatik.uni-freiburg.de> <20070327155306.GQ22773@admingilde.org>
 <20070327172216.GA24200@informatik.uni-freiburg.de>
 <Pine.LNX.4.64.0703271124590.6730@woody.linux-foundation.org>
 <20070327194233.GA28229@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463790079-464085319-1175025233=:6730"
Cc: Martin Waitz <tali@admingilde.org>,
	Junio C Hamano <junkio@cox.net>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Eric Lesh <eclesh@ucla.edu>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Tue Mar 27 21:54:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWHkd-0007NM-Tv
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 21:54:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752700AbXC0Tyg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 15:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753905AbXC0Tyf
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 15:54:35 -0400
Received: from smtp.osdl.org ([65.172.181.24]:40357 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752689AbXC0Tye (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 15:54:34 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2RJrsU2011580
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 27 Mar 2007 12:53:55 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2RJrr3x026379;
	Tue, 27 Mar 2007 12:53:54 -0700
In-Reply-To: <20070327194233.GA28229@informatik.uni-freiburg.de>
X-Spam-Status: No, hits=-0.469 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43300>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463790079-464085319-1175025233=:6730
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT



On Tue, 27 Mar 2007, Uwe Kleine-König wrote:
> 
> In the state above (i.e. linux-2.6 being a commit) the
> superproject's odb doesn't necessarily needs the object
> 0123456789abcde0, right.  But the commit before that had linux-2.6 being
> a tree.

Well, you're saying that somebody split an existing non-supermodule 
project?

If so, the supermodule really *does* have the old tree as its state, and 
sure, there will be duplication, but it's duplication that existed in the 
actual projects themselves, not something that the superproject 
introduced.

In other words, I don't think that's an argument for or against sharing 
the object database. You should *always* be able to share the object 
database by setting GIT_OBJECT_DIR if you want (or by using alternates). 
But that's independent of whether you are a sub/supermodule..

After all, if you generate two totally *separate* projects (no subproject 
at all) and they just shared some state on their own (say, git and xdiff 
both as totally independent git repositories), they have objects that can 
be in common. Do you want to use alternates or share an object database? 
Maybe, or maybe not. It depends on the user, not on whether it's a 
subproject.

		Linus
---1463790079-464085319-1175025233=:6730--
