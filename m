From: David Rientjes <rientjes@cs.washington.edu>
Subject: Re: [PATCH 3/3] diff --stat: sometimes use non-linear scaling.
Date: Wed, 27 Sep 2006 00:19:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.64N.0609270006020.9602@attu4.cs.washington.edu>
References: <7vfyeejakq.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64N.0609262005150.520@attu4.cs.washington.edu>
 <7vmz8lj3pl.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64N.0609262216390.12560@attu2.cs.washington.edu>
 <7vejtxhlv6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64N.0609262320260.9088@attu4.cs.washington.edu>
 <7vfyedg56m.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 09:19:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSThI-0006XT-4D
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 09:19:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965413AbWI0HTI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 03:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965416AbWI0HTI
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 03:19:08 -0400
Received: from mx2.cs.washington.edu ([128.208.2.105]:7371 "EHLO
	mx2.cs.washington.edu") by vger.kernel.org with ESMTP
	id S965413AbWI0HTF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 03:19:05 -0400
Received: from attu4.cs.washington.edu (attu4.cs.washington.edu [128.208.1.140])
	by mx2.cs.washington.edu (8.13.7/8.13.7/1.6) with ESMTP id k8R7J2Ub020244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 27 Sep 2006 00:19:02 -0700
	(envelope-from rientjes@cs.washington.edu)
Received: from localhost (rientjes@localhost)
	by attu4.cs.washington.edu (8.13.7/8.13.7/Submit/1.2) with ESMTP id k8R7J2Yt011325;
	Wed, 27 Sep 2006 00:19:02 -0700
	(envelope-from rientjes@cs.washington.edu)
X-Authentication-Warning: attu4.cs.washington.edu: rientjes owned process doing -bs
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfyedg56m.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27884>

On Wed, 27 Sep 2006, Junio C Hamano wrote:

> David Rientjes <rientjes@cs.washington.edu> writes:
> 
> > Your argument of saying to yourself "if line_width cannot fit max + len 
> > then we do this" has no relevance at all.  I can say "if max + len is too 
> > big for line_width we do this" just the same.
> 
> Actually that is exactly my point.  "Just the same".  There is
> no reason to choose one way or the other from purely logical or
> mathematical point of view.
> 

Nothing about this is "mathematical" at all and I never claimed it was.  
But there _is_ a reason to choose one way over the other and that is 
because the MAJORITY of programmers do it one way and YOU do it another 
way.  Why is it so hard to write all the code in the same style so that 
there is as little variation in the code as possible?

> Comparisons written always in textual order, when one gets used
> to, takes less thinking to parse and understand, and that is
> what I'm used to.  Have number line handy in your head and you
> will hopefully like it too ;-).
> 

Doing what you prefer and not what the majority of your developers do is 
the first step to a stagnant source tree.

> >> Well, the program _firstly_ matches the logic flow better, and
> >> _in_ _addition_ if you write it another way it becomes
> >> unnecessarily too deeply indented.  So while I agree with you as a
> >> general principle that indentation depth should not dictate how
> >> we code it does not apply to this particular example.
> >
> > This is a ridiculous argument.  The C code will emit the exact same 
> > assembly regardless of how you write it.  You say that you wrote it that 
> > way to avoid idents which is an absolutely horrible way to dictate the 
> > code you use.
> 
> I guess probably I was unclear (I did not talk anything about
> code generation -- where did it come from?).  I say I wrote it
> that way _firstly_ because the flow of the program matches
> exactly what I saw the code needed to do -- if A I do not have
> to do anything else if B I do this else I do that.  In addition
> not having that "do nothing" made the code indent unnecessarily
> deep but that is "in addition" and not the primary cause.  It
> was an added bonus.
> 

The concept of code generation is the whole point.  Both of our styles 
emits the same assembly code so by definition there is no difference since 
it achieves the exact same goal.  But there's a reason git is written in C 
and not in assembly and that reason is not just for portability.  A 
.c source file is the bridge between most programmers and assembly and 
since our coding styles differ but emit the same assembly, then it 
inherently comes with a freedom in how it's written.  And on a 
collaborative project such as git, that freedom should be confined to 
resembling the surrounding source code.

		David
