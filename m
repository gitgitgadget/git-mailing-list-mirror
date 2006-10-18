From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Wed, 18 Oct 2006 14:55:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610181449290.3962@g5.osdl.org>
References: <20061018053647.GA3507@coredump.intra.peff.net>
 <Pine.LNX.4.64.0610180739230.3962@g5.osdl.org> <20061018185225.GU20017@pasky.or.cz>
 <20061018185907.GV20017@pasky.or.cz> <7vy7rd1m4q.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610181510510.1971@xanadu.home> <20061018191834.GA18829@spearce.org>
 <Pine.LNX.4.64.0610181525410.1971@xanadu.home> <20061018204626.GA19194@spearce.org>
 <Pine.LNX.4.64.0610181358200.3962@g5.osdl.org> <20061018213225.GD19194@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 23:56:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaJOS-0004zT-Ru
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 23:56:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423050AbWJRV4G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 17:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423038AbWJRV4F
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 17:56:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57803 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423050AbWJRV4D (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Oct 2006 17:56:03 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9ILtmaX018872
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 18 Oct 2006 14:55:49 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9ILtlFf019845;
	Wed, 18 Oct 2006 14:55:48 -0700
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20061018213225.GD19194@spearce.org>
X-Spam-Status: No, hits=-0.97 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29284>



On Wed, 18 Oct 2006, Shawn Pearce wrote:
> 
> My comment that you quoted was about mmap'ing the pack files in
> large chunks (around 64-128 MiB at a time, but configurable from
> .git/config) rather than as an entire massive mapping.

Sure. I agree that we should do that, if only because it's clearly getting 
hard to handle large pack-files on a 32-bit architecture.

You just seemed to say that in the _context_ of wanting to support having 
multiple pack-files open (in order to allow deltas to refer to things 
outside their own pack-file).

I just wanted to head that particular idea off at the pass.

I think thin packs have been a good idea, and they certainly cut the 
amount of data sent over the network down by a large amount (much more 
than 50%), so I think thin packs are a great idea. Just _not_ when 
indexed.

So I don't object to mmap windows at all. I object to them only in the 
context of "they would allow us to use deltas between two different packs"
discussion ;)

		Linus
