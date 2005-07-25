From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [RFC] extending git-ls-files --exclude.
Date: Mon, 25 Jul 2005 21:51:18 +0100
Message-ID: <1122324678.6866.5.camel@localhost.localdomain>
References: <20050721202309.8216.19338.stgit@h164.c77.b0.tor.eicat.ca>
	 <7v3bq71rmb.fsf@assigned-by-dhcp.cox.net> <tnx1x5ryvn2.fsf@arm.com>
	 <20050722192424.GB8556@mars.ravnborg.org>
	 <7vy87yr2xh.fsf@assigned-by-dhcp.cox.net>
	 <20050722205948.GE11916@pasky.ji.cz>
	 <7vd5p73jlu.fsf@assigned-by-dhcp.cox.net> <tnxmzobutsf.fsf@arm.com>
	 <7vk6jelkty.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.58.0507251306420.6074@g5.osdl.org>
	 <7vll3uk4w7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org, Marco Costalba <mcostalba@yahoo.it>
X-From: git-owner@vger.kernel.org Mon Jul 25 22:52:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dx9v4-0000PQ-1c
	for gcvg-git@gmane.org; Mon, 25 Jul 2005 22:51:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261655AbVGYUvV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jul 2005 16:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbVGYUvV
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jul 2005 16:51:21 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:62043 "EHLO
	mta08-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S261655AbVGYUvU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2005 16:51:20 -0400
Received: from aamta09-winn.ispmail.ntl.com ([81.103.221.35])
          by mta08-winn.ispmail.ntl.com with ESMTP
          id <20050725205119.PHQN889.mta08-winn.ispmail.ntl.com@aamta09-winn.ispmail.ntl.com>;
          Mon, 25 Jul 2005 21:51:19 +0100
Received: from cpc1-cmbg5-3-0-cust179.cmbg.cable.ntl.com ([81.104.192.179])
          by aamta09-winn.ispmail.ntl.com with ESMTP
          id <20050725205119.GJEO19483.aamta09-winn.ispmail.ntl.com@cpc1-cmbg5-3-0-cust179.cmbg.cable.ntl.com>;
          Mon, 25 Jul 2005 21:51:19 +0100
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vll3uk4w7.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.2.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 2005-07-25 at 13:27 -0700, Junio C Hamano wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> > Imagine, for example, that you have separate subdirectory structures for 
> > Documentation and for source - maybe you'd put the "*.o" rule in the 
> > source directory, and a "*.1" rule in the Docs subdirectory.
> 
> I imagined it, but it appears to me that this is a bad example.
> My understanding of what Catalin and the proposed patch
> disagrees is whether the patterns in .gitignore at the top level
> should govern files under ppc/ and mozilla-sha1/ subdirectories;
> Catalin thinks they should not.

I really don't have a strong preference for this. Linus' example makes
sense as well. It's up to you how you implement its behaviour,
Porcelains shouldn't be affected by this.

Since I'm the only one with this idea, you can forget about it (I don't
mind :-) ). If others express a preference for this, you could implement
a 'cut' label (similar to Prolog's cut operator) which clears the
pattern stack before diving into subdirectories. Anyway, I don't think
it's worse the hassle since it might never be used.

-- 
Catalin
