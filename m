From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] nicer eye candies for pack-objects
Date: Wed, 22 Feb 2006 15:05:46 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602221502410.3771@g5.osdl.org>
References: <Pine.LNX.4.64.0602221549250.5606@localhost.localdomain>
 <7vy803kp1n.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0602221733030.5606@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 23 00:06:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FC33n-0000IQ-Vn
	for gcvg-git@gmane.org; Thu, 23 Feb 2006 00:06:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbWBVXGM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Feb 2006 18:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbWBVXGM
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Feb 2006 18:06:12 -0500
Received: from smtp.osdl.org ([65.172.181.4]:4737 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751422AbWBVXGK (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Feb 2006 18:06:10 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1MN5pDZ020533
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 22 Feb 2006 15:05:51 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1MN5k70030212;
	Wed, 22 Feb 2006 15:05:48 -0800
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0602221733030.5606@localhost.localdomain>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16622>



On Wed, 22 Feb 2006, Nicolas Pitre wrote:

> On Wed, 22 Feb 2006, Junio C Hamano wrote:
> 
> > I like this, but like the "every second or every percent
> > whichever comes first" unpack-objects does even better.  How
> > about something like this on top of your patch?
> 
> Well... my concern is (if I'm right) that this status is generated 
> remotely and sent over the network when performing a fetch.  The "every 
> percent" might in this case generate quite some significant overhead if 
> the pack is small.

Well, my thinking behind the original unpack-objects behaviour was that we 
don't really care about the max 100 extra packets. 

The days of 150 baud line printers are gone. I cannot imagine any valid 
situation where you can't send a hundred small packets to update the 
screen.. And it did make a nice visual difference.

(In fact, over a network, if the line really is slow, you'll find that 
Nagle will fix things, and you'll just see one extra - but obviously 
slightly bigger - packet).

		Linus
