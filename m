From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: GIT vs Other: Need argument
Date: Fri, 20 Apr 2007 11:04:34 +0200
Message-ID: <200704201104.35539.jnareb@gmail.com>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com> <4627B292.6080202@midwinter.com> <7vd52054e3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 20 13:01:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Heqrj-0005cG-G8
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 13:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753394AbXDTLBU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 07:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753512AbXDTLBU
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 07:01:20 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:52136 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753394AbXDTLBT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 07:01:19 -0400
Received: by ug-out-1314.google.com with SMTP id 44so874330uga
        for <git@vger.kernel.org>; Fri, 20 Apr 2007 04:01:18 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=R07nVeAmcIp4iY9feysQ3aAtMdFwnolTQX/FR7EVAjiV7NQJBepMvXQB0M5VOs5D9IQ/yKwpEzmcANMjwfIiq0JtYklRsNb0xYGJkf7IRdlWJyJaHJkajsxOxYsMFVV3xme1+lYJYDc72L6FxiXbttCdKyE2hPSzVuJLoYjBJ/8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ZEpoTMfT7iRM8L+OYbNEnM4h+wplt6krXNuWdSrdYQDJU8x/y/OD/Fj2s4iKodprI3asfcKMYdLo+b1sLljHPxnwoEAu1hgW+yHnoGw1w5Nf05nyMhqBR8V+JU09QeXwyaba4eY/N0zo7HAj4enDB0vZ+Ax9EB/peKR8A/r1IJ4=
Received: by 10.67.117.18 with SMTP id u18mr2772981ugm.1177066878174;
        Fri, 20 Apr 2007 04:01:18 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id k2sm4241473ugf.2007.04.20.04.01.16;
        Fri, 20 Apr 2007 04:01:17 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vd52054e3.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45084>

Junio C Hamano <junkio@cox.net> wrote:
> Steven Grimm <koreth@midwinter.com> writes:
> 
>> I wonder if it makes sense to automate that even more and make git
>> pull behave a bit statefully like rebase does:
> 
> Making things stateful may help, but when done without thinking
> the consequence through, it would make things more confusing.
> 
> By the way, I never liked the way 'git rebase --continue' works.
[...]
> in practice, after 'git rebase' stops on a conflicting
> merge, I spend many braincycles to come up with a sensible merge
> and then many CPU cycles to run test, and by the time I do the
> final "git diff" to make sure everything look right and
> "update-index" them, I often end up getting confused and find me
> asking this question: what was I doing?  Was I resolving the
> merge because I merged, or was I in the middle of a rebase, or
> was I applying from a mailbox?
> 
> I do not know what would happen if I say "git commit" at that
> point, but I suspect it would be unpleasant, so I have never
> tried it myself.  But it takes nontrivial amount of effort to
> convince myself that 'git rebase --continue' is what I want to
> do next, not 'git commit' nor 'git am --resolved'.
> 
> And I suspect the reason this is confusing to me is not that
> rebase keeps state but that the state is not made more obvious
> to prevent mistakes from happening.  Earlier I mentioned perhaps
> we would want "git, whatnow?" command to remind people what they
> were in the middle of and suggest what the next step would be.
> Or perhaps "git, continue" command that makes the obvious next
> step to happen would be helpful.

You have even implemented "git explain" command, but it didn't get
into git. Perhaps it is time to resurrect it.
 
> I am very much afraid that introducing more hidden state without
> such "what now?"  framework in place would make things more
> confusing and harder to use, not easier.

It would be nice to have such "git explain" command, both for use
in scripts (and perhaps also in builtins), and for the user (perhaps
"git status" should use it, too). 

And it could be used to implement "git continue" and "git abort" 
commands... (or "git, continue" and "git, abort" ;-).

-- 
Jakub Narebski
Poland
