From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix 'crlf' attribute semantics.
Date: Sun, 15 Apr 2007 16:44:00 -0700
Message-ID: <7vd52519vj.fsf@assigned-by-dhcp.cox.net>
References: <7vr6qod4wh.fsf@assigned-by-dhcp.cox.net>
	<200704131033.15751.andyparkins@gmail.com>
	<7vejmm78qp.fsf@assigned-by-dhcp.cox.net>
	<7vvefy5tzo.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0704141839030.5473@woody.linux-foundation.org>
	<7vr6qm5r73.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0704142103210.5473@woody.linux-foundation.org>
	<7vr6ql1ben.fsf@assigned-by-dhcp.cox.net>
	<20070415233722.GA20222@hermes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Tom Prince <tom.prince@ualberta.net>
X-From: git-owner@vger.kernel.org Mon Apr 16 01:44:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdEO8-0007oh-7h
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 01:44:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754091AbXDOXoE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 19:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754094AbXDOXoE
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 19:44:04 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:39618 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754091AbXDOXoB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 19:44:01 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070415234400.LYQC1218.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sun, 15 Apr 2007 19:44:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id nbk01W00o1kojtg0000000; Sun, 15 Apr 2007 19:44:01 -0400
In-Reply-To: <20070415233722.GA20222@hermes> (Tom Prince's message of "Mon, 16
	Apr 2007 03:37:22 +0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44550>

Tom Prince <tom.prince@ualberta.net> writes:

<offtopic>Please do not rudely point other people with
mail-followup-to; I did not want to address this message to
Linus but wanted to talk to YOU specifically, and you stole a
few seconds of my time, forcing me to rewrite my To: line
</offtopic>

> On Sun, Apr 15, 2007 at 04:10:56PM -0700, Junio C Hamano wrote:
>> Earlier we said 'crlf lets the path go through core.autocrlf
>> process while !crlf disables it altogether'.  This fixes the
>> semantics to:
>
> This change means there is no way to enable the automatic heuristics for a
> specific pattern once it has been disable for a more generic pattern. Would it
> make sense to make the attributes more than simply boolean?

I do not think that is a problem in practice.  Do not set
something to "false" explicitly with a generic pattern, if you
might want to override it.
