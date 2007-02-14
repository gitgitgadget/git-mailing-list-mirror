From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-pull and tag objects
Date: Wed, 14 Feb 2007 08:35:21 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702140831160.3604@woody.linux-foundation.org>
References: <1170933407.15431.38.camel@okra.transitives.com>
 <81b0412b0702090133qa4eb0c0v6a2d309fe9653a3f@mail.gmail.com>
 <7v4ppurka1.fsf@assigned-by-dhcp.cox.net> <20070210142322.GB25607@thunk.org>
 <Pine.LNX.4.64.0702100938540.8424@woody.linux-foundation.org>
 <7vy7n5gs0y.fsf@assigned-by-dhcp.cox.net> <20070212162745.GB2741@thunk.org>
 <7vr6su1szp.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702132230490.3604@woody.linux-foundation.org>
 <7vfy99td98.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702141213150.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Theodore Tso <tytso@mit.edu>,
	Alex Riesen <raa.lkml@gmail.com>,
	Alex Bennee <kernel-hacker@bennee.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 14 17:35:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHN6X-0006Ei-EL
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 17:35:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbXBNQfd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 11:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbXBNQfd
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 11:35:33 -0500
Received: from smtp.osdl.org ([65.172.181.24]:34711 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932375AbXBNQfc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 11:35:32 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1EGZMhB007566
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 14 Feb 2007 08:35:23 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1EGZLID002685;
	Wed, 14 Feb 2007 08:35:22 -0800
In-Reply-To: <Pine.LNX.4.63.0702141213150.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=-0.411 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.117__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39673>



On Wed, 14 Feb 2007, Johannes Schindelin wrote:
> 
> The chance of a mismerge is somewhat real, though. At first I thought that 
> you'd need a special script anyway, until I realized that it's just a 
> matter of "git merge -s theirs <from-devel>".

In fact, it's even quite doable as

	git commit-tree theirs^{tree} -p HEAD -p theirs < changelog

(choose your parent order at will) so it's not as if it's much of a 
"script". It's a core command to do something like this.

Using "git commit -s theirs" might not work (shouldn't, but I didn't test) 
for the first entry, so you probably *do* want to script this regardless. 
But git makes it really really easy.

		Linus
