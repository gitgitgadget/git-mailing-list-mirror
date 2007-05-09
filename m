From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Add a birdview-on-the-source-code section to the user
 manual
Date: Wed, 9 May 2007 16:45:08 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0705091625200.18541@iabervon.org>
References: <Pine.LNX.4.64.0705081709230.4167@racer.site>
 <20070509031803.GA27980@fieldses.org> <Pine.LNX.4.64.0705091414280.4167@racer.site>
 <20070509123205.GN4489@pasky.or.cz> <Pine.LNX.4.64.0705091447110.4167@racer.site>
 <Pine.LNX.4.64.0705091210570.18541@iabervon.org> <Pine.LNX.4.64.0705091822590.4167@racer.site>
 <20070509170725.GB23778@fieldses.org> <Pine.LNX.4.64.0705092208230.4167@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Petr Baudis <pasky@suse.cz>, kha@treskal.com, junio@cox.net,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 09 22:45:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hlt2C-0003ub-MN
	for gcvg-git@gmane.org; Wed, 09 May 2007 22:45:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753317AbXEIUpM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 16:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754732AbXEIUpL
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 16:45:11 -0400
Received: from iabervon.org ([66.92.72.58]:4362 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753317AbXEIUpK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 16:45:10 -0400
Received: (qmail 28753 invoked by uid 1000); 9 May 2007 20:45:08 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 May 2007 20:45:08 -0000
In-Reply-To: <Pine.LNX.4.64.0705092208230.4167@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46788>

On Wed, 9 May 2007, Johannes Schindelin wrote:

> Let me explain it in this way:
> 
> If you parse a number, passed to a program, with strtol(argv[1], NULL, 0) 
> you would expect something like this on an Intel processor:
> 
> Input 0x1234 -> memory 0x34 0x12 0x00 0x00.
> 
> On a big endian machine, you'd expect 0x00 0x00 0x12 0x34.
> 
> That is what endianness means.
> 
> If you tell Git that it should look for commit e83c6516..., it will store 
> the sha1 as 0xe8 0x3c 0x65 0x16 ... in memory, no matter which 
> endianness the processor has.

But it would be really weird to get 0x90 0xf2 0x4a 0x60 ... 0x16 0x65 0x3c 
0xe8 unless you've got a 160-bit little-endian processor. That would be as 
strange as having "Test" stored as 0x74 0x73 0x65 0x54, I think.

> Which was positively confusing for me, since I automatically searched for 
> the sequence 0x90 0xf2 0x4a 0x60 ... (which is the tail of that hash).
> 
> But if all this sounds too confusing, I agree to delete the 
> "(big-endian)".

If it confused you, there should be something there. Maybe "(in order)" or 
something else implying that the underlying type is an octet sequence, 
rather than a 160-bit integer?

	-Daniel
*This .sig left intentionally blank*
