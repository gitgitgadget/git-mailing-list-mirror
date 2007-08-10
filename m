From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git and larger trees, not so fast?
Date: Thu, 09 Aug 2007 17:51:27 -0700
Message-ID: <7vhcn8w6sw.fsf@assigned-by-dhcp.cox.net>
References: <20070809163026.GD568@mbox.bz>
	<alpine.LFD.0.999.0708090948250.25146@woody.linux-foundation.org>
	<alpine.LFD.0.999.0708091015500.25146@woody.linux-foundation.org>
	<alpine.LFD.0.999.0708091056180.25146@woody.linux-foundation.org>
	<7vmyx0y3vp.fsf@assigned-by-dhcp.cox.net>
	<7v7io4xwvp.fsf@assigned-by-dhcp.cox.net>
	<20070809165218.9b76ebf7.seanlkml@sympatico.ca>
	<alpine.LFD.0.999.0708091426050.25146@woody.linux-foundation.org>
	<alpine.LFD.0.999.0708091444550.25146@woody.linux-foundation.org>
	<7vtzr8wemb.fsf@assigned-by-dhcp.cox.net>
	<7vps1wwa5w.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.999.0708091734210.25146@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sean <seanlkml@sympatico.ca>, moe <moe-git@mbox.bz>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 10 02:51:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJIj8-0005kq-9G
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 02:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756332AbXHJAva (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 20:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756190AbXHJAva
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 20:51:30 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:60026 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757047AbXHJAv3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 20:51:29 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070810005129.UDZG2095.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Thu, 9 Aug 2007 20:51:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id a0rT1X00F1kojtg0000000; Thu, 09 Aug 2007 20:51:28 -0400
In-Reply-To: <alpine.LFD.0.999.0708091734210.25146@woody.linux-foundation.org>
	(Linus Torvalds's message of "Thu, 9 Aug 2007 17:44:25 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55493>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, 9 Aug 2007, Junio C Hamano wrote:
>> 
>> While I do not think the previous one was hacky at all, this one
>> IS a hack, not meant for inclusion.
> ...
> Sadly, that removal is required for some of the other cases, so it's not 
> like we can remove the remove. But we could *possibly* make things 
> ridiculously much faster by making the remove a lazy thing, and if the 
> next index operation just adds it back in, we wouldn't move things around.

Heh, that makes the two of us.  I have been wanting to revamp or
kill off unpack-trees for quite some time, and after all the
patch you are responding to might be a small first step in the
right direction ;-).
