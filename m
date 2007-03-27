From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: .gitlink for Summer of Code
Date: Tue, 27 Mar 2007 11:15:42 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703271114000.6730@woody.linux-foundation.org>
References: <1174825838.12540.5.camel@localhost> 
 <20070326220302.GH22773@admingilde.org><7vfy7rvct2.fsf@assigned-by-dhcp.cox
 .net> <200703270117.59205.Josef.Weidendorfer@gmx.de>
 <Pine.LNX.4.64.0703270952020.6730@woody.linux-foundation.org>
 <Pine.LNX.4.63.0703270858080.15345@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Junio C Hamano <junkio@cox.net>,
	Martin Waitz <tali@admingilde.org>,
	Eric Lesh <eclesh@ucla.edu>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: David Lang <david.lang@digitalinsight.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 20:16:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWGDg-0004pr-DH
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 20:16:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934082AbXC0SQT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 14:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934140AbXC0SQT
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 14:16:19 -0400
Received: from smtp.osdl.org ([65.172.181.24]:36605 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934082AbXC0SQS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 14:16:18 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2RIFjU2008791
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 27 Mar 2007 11:15:45 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2RIFgfN024223;
	Tue, 27 Mar 2007 11:15:43 -0700
In-Reply-To: <Pine.LNX.4.63.0703270858080.15345@qynat.qvtvafvgr.pbz>
X-Spam-Status: No, hits=-0.47 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43292>



On Tue, 27 Mar 2007, David Lang wrote:

> On Tue, 27 Mar 2007, Linus Torvalds wrote:
> 
> > - walking the *global* object list is simply not possible. You need to
> >   fsck every single subtree individually, and fsck the superproject on
> >   its own, *without* recursing into the subprojects. And you need to be
> >   able to clone the superproject and only one or two subprojects, and
> >   never see it as one "atomic" big repository.
> 
> you can do a fsck to make sure that all needed objects are available on each
> project individually, but a prune/gc _does_ need to go through the global

No it doesn't.

If you do per-project object stores, there's no need. There simply isn't 
anything to prune "globally". Everything is local.

Now, if you share the object directory, you can't prune. But that's true 
even without any "subproject" support, and has nothing to do with sub- or 
super-projects.
	
		Linus
