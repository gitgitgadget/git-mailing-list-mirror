From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] extending git-ls-files --exclude.
Date: Mon, 25 Jul 2005 13:27:36 -0700
Message-ID: <7vll3uk4w7.fsf@assigned-by-dhcp.cox.net>
References: <20050721202309.8216.19338.stgit@h164.c77.b0.tor.eicat.ca>
	<7v3bq71rmb.fsf@assigned-by-dhcp.cox.net> <tnx1x5ryvn2.fsf@arm.com>
	<20050722192424.GB8556@mars.ravnborg.org>
	<7vy87yr2xh.fsf@assigned-by-dhcp.cox.net>
	<20050722205948.GE11916@pasky.ji.cz>
	<7vd5p73jlu.fsf@assigned-by-dhcp.cox.net> <tnxmzobutsf.fsf@arm.com>
	<7vk6jelkty.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507251306420.6074@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	Marco Costalba <mcostalba@yahoo.it>
X-From: git-owner@vger.kernel.org Mon Jul 25 22:31:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dx9ax-0005tY-Eg
	for gcvg-git@gmane.org; Mon, 25 Jul 2005 22:30:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbVGYUaJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jul 2005 16:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbVGYU2I
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jul 2005 16:28:08 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:7409 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261503AbVGYU1i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2005 16:27:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050725202733.QPEZ12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 25 Jul 2005 16:27:33 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507251306420.6074@g5.osdl.org> (Linus Torvalds's message of "Mon, 25 Jul 2005 13:09:26 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Mon, 25 Jul 2005, Junio C Hamano wrote:
>> 
>> I personally do not have preference either way, but am slightly
>> biased towards the "cumulative" behaviour the patch attempts to
>> implement, which was what Pasky said he wanted to have.
>
> I think that makes sense.
>
> Imagine, for example, that you have separate subdirectory structures for 
> Documentation and for source - maybe you'd put the "*.o" rule in the 
> source directory, and a "*.1" rule in the Docs subdirectory.

I imagined it, but it appears to me that this is a bad example.
My understanding of what Catalin and the proposed patch
disagrees is whether the patterns in .gitignore at the top level
should govern files under ppc/ and mozilla-sha1/ subdirectories;
Catalin thinks they should not.

What I meant by "cumulative" (now I realize I might have
misunderstood what Pasky wanted to mean by that word, though)
was not just .gitignore in subdirectory being added, but the
effect of patterns being added so far, either from the command
line or by parent directories, last while in the deeper
directories.
