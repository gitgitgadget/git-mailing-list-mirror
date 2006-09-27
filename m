From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] diff --stat: sometimes use non-linear scaling.
Date: Wed, 27 Sep 2006 00:05:37 -0700
Message-ID: <7vfyedg56m.fsf@assigned-by-dhcp.cox.net>
References: <7vfyeejakq.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64N.0609262005150.520@attu4.cs.washington.edu>
	<7vmz8lj3pl.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64N.0609262216390.12560@attu2.cs.washington.edu>
	<7vejtxhlv6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64N.0609262320260.9088@attu4.cs.washington.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 09:05:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSTUQ-00044g-3E
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 09:05:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965401AbWI0HFj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 03:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965399AbWI0HFj
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 03:05:39 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:43457 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932445AbWI0HFi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 03:05:38 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060927070538.DBXP16798.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>;
          Wed, 27 Sep 2006 03:05:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id TK5a1V00U1kojtg0000000
	Wed, 27 Sep 2006 03:05:35 -0400
To: David Rientjes <rientjes@cs.washington.edu>
In-Reply-To: <Pine.LNX.4.64N.0609262320260.9088@attu4.cs.washington.edu>
	(David Rientjes's message of "Tue, 26 Sep 2006 23:49:20 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27883>

David Rientjes <rientjes@cs.washington.edu> writes:

> Your argument of saying to yourself "if line_width cannot fit max + len 
> then we do this" has no relevance at all.  I can say "if max + len is too 
> big for line_width we do this" just the same.

Actually that is exactly my point.  "Just the same".  There is
no reason to choose one way or the other from purely logical or
mathematical point of view.

Comparisons written always in textual order, when one gets used
to, takes less thinking to parse and understand, and that is
what I'm used to.  Have number line handy in your head and you
will hopefully like it too ;-).

>> Well, the program _firstly_ matches the logic flow better, and
>> _in_ _addition_ if you write it another way it becomes
>> unnecessarily too deeply indented.  So while I agree with you as a
>> general principle that indentation depth should not dictate how
>> we code it does not apply to this particular example.
>
> This is a ridiculous argument.  The C code will emit the exact same 
> assembly regardless of how you write it.  You say that you wrote it that 
> way to avoid idents which is an absolutely horrible way to dictate the 
> code you use.

I guess probably I was unclear (I did not talk anything about
code generation -- where did it come from?).  I say I wrote it
that way _firstly_ because the flow of the program matches
exactly what I saw the code needed to do -- if A I do not have
to do anything else if B I do this else I do that.  In addition
not having that "do nothing" made the code indent unnecessarily
deep but that is "in addition" and not the primary cause.  It
was an added bonus.

> And in one of your patches you had:
> 	if (...)
> 		;
> 	else {
> 		...
> 	}
>
> without any other if statements.

Yes, indeed that was very funny looking.

It was refactored from the final one that had "else if" in the
middle (else if was to add the non-linear scaling).  I agree
that any sane would not have done that if that was the real
first version.
