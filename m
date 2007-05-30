From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] diff-delta: use realloc instead of xrealloc
Date: Tue, 29 May 2007 23:17:01 -0700
Message-ID: <7vhcpu4yzm.fsf@assigned-by-dhcp.cox.net>
References: <1180465715346-git-send-email-mkoegler@auto.tuwien.ac.at>
	<7v1wgz5gus.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.99.0705292252220.11491@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed May 30 08:17:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtHUZ-0001Mc-MW
	for gcvg-git@gmane.org; Wed, 30 May 2007 08:17:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbXE3GRE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 02:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbXE3GRE
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 02:17:04 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:61750 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057AbXE3GRD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2007 02:17:03 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070530061701.FUWK2758.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Wed, 30 May 2007 02:17:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 5JH11X0041kojtg0000000; Wed, 30 May 2007 02:17:01 -0400
In-Reply-To: <alpine.LFD.0.99.0705292252220.11491@xanadu.home> (Nicolas
	Pitre's message of "Tue, 29 May 2007 22:57:06 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48745>

Nicolas Pitre <nico@cam.org> writes:

> On Tue, 29 May 2007, Junio C Hamano wrote:
>
>> Wasn't there a discussion around this exact issue when the
>> original patch was applied?
>
> Maybe, but I cannot remember it, not can I justify that xrealloc now.

Actually, the discussion was older than the patch.

    http://thread.gmane.org/gmane.comp.version-control.git/43766/focus=43783

And I myself suggested to use non x- variant of allocation
routines in diff-delta.c as the callers know how to handle near
oom condition ;-).
