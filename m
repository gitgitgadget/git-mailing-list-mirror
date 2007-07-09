From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Preferring shallower deltas on repack
Date: Mon, 09 Jul 2007 09:39:44 -0700
Message-ID: <7vir8tv8dr.fsf@assigned-by-dhcp.cox.net>
References: <20070709044326.GH4087@lavos.net>
	<7v1wfixhvk.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.999.0707090954550.26459@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Downing <bdowning@lavos.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Jul 09 18:40:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7wHd-0003WB-7J
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 18:40:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761338AbXGIQjr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 12:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761043AbXGIQjq
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 12:39:46 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:40463 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761211AbXGIQjp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 12:39:45 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070709163945.JSCG22777.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Mon, 9 Jul 2007 12:39:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id MUfk1X0041kojtg0000000; Mon, 09 Jul 2007 12:39:44 -0400
In-Reply-To: <alpine.LFD.0.999.0707090954550.26459@xanadu.home> (Nicolas
	Pitre's message of "Mon, 09 Jul 2007 11:58:06 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52004>

Nicolas Pitre <nico@cam.org> writes:

> On Sun, 8 Jul 2007, Junio C Hamano wrote:
>
>> It would become worrysome (*BUT* infinitely more interesting)
>> once you start talking about a tradeoff between slightly larger
>> delta and much shallower depth.  Such a tradeoff, if done right,
>> would make a lot of sense, but I do not offhand think of a way
>> to strike a proper balance between them efficiently.
>
> We already do something similar to that with max_size being a function 
> of the delta depth.  ...

Yeah, we had a fun thread about that; I forgot about it until
now.

> OK here it is.  And results on the GIT repo and another patalogical test 
> repo I keep around are actually really nice!  Not only the pack itself 
> is a bit smaller, but the delta depth distribution as shown by 
> git-verify-pack -v is much nicer with the bulk of deltas in the low 
> depth end of the spectrum and no more peak at the max depth level.

Looks obviously correct.  Brian, it would be very interesting to
see what Nico's patch does to your dataset.
