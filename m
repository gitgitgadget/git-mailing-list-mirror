From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [REVISED PATCH 2/6] Introduce commit notes
Date: Thu, 19 Jul 2007 17:20:00 -0700
Message-ID: <7vbqe82afj.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707152326080.14781@racer.site>
	<Pine.LNX.4.64.0707160022560.14781@racer.site>
	<7vejj96igx.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0707190258550.14781@racer.site>
	<alpine.LFD.0.999.0707181949490.27353@woody.linux-foundation.org>
	<7vfy3l3rj0.fsf@assigned-by-dhcp.cox.net>
	<7vodi83fg7.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.999.0707191032320.27353@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alberto Bertogli <albertito@gmail.com>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jul 20 02:20:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBgE4-0004Sf-AI
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 02:20:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757448AbXGTAUF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 20:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757286AbXGTAUF
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 20:20:05 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:44329 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757217AbXGTAUD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 20:20:03 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070720002001.YVND1349.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Thu, 19 Jul 2007 20:20:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id RcL01X00Q1kojtg0000000; Thu, 19 Jul 2007 20:20:01 -0400
In-Reply-To: <alpine.LFD.0.999.0707191032320.27353@woody.linux-foundation.org>
	(Linus Torvalds's message of "Thu, 19 Jul 2007 10:42:18 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53041>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, 19 Jul 2007, Junio C Hamano wrote:
>> > ...
>> > But the real problem of this approach of course is that this is
>> > not reliable and can get a false match.  You can find your
>> > beginning NUL in the SHA-1 part of one entry, and terminating
>> > NUL later in the SHA-1 part of next entry, and you will never
>> > notice.
>
> [ I didn't react to this in your first email, because I thought you were 
>   talking about your "use the rules for the ASCII part", and thought you 
>   talked about how *that* was not reliable and can get a false match). But 
>   it seems that you were actually talking about the NUL character test ]
>
> Nope, wrong.
>
> Why? Because there must always be a NUL *between* different SHA1's. 
> There's *always* a NUL character that precedes a SHA1. So when you have 
> two NUL characters (with no other NUL's between them), you *know* that 
> they cannot be from two different SHA1's. If the first one was from an 
> earlier SHA1, then the second one is *guaranteed* to be the one that 
> happens *before* the next SHA1.
>
> See?

Ok.  As usual, you are more right than I am ;-).
