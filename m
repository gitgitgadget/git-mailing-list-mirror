From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: Re: push.default: current vs upstream
Date: Thu, 12 Apr 2012 22:16:41 +0100
Message-ID: <4F874639.5090207@pileofstuff.org>
References: <7vty15ltuo.fsf@alter.siamese.dyndns.org> <vpqty12h995.fsf@bauges.imag.fr> <20120405131301.GB10293@sigill.intra.peff.net> <vpqwr5uceis.fsf@bauges.imag.fr> <20120406071520.GD25301@sigill.intra.peff.net> <vpqr4w12tjj.fsf@bauges.imag.fr> <20120406080004.GA27940@sigill.intra.peff.net> <4F7FF19B.1060407@alum.mit.edu> <20120407075150.GA18168@sigill.intra.peff.net> <4F7FFD7A.80104@pileofstuff.org> <20120412071150.GB31122@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 12 23:16:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIRNs-0004vI-HN
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 23:16:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756955Ab2DLVQs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 17:16:48 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:6760 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754236Ab2DLVQr (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Apr 2012 17:16:47 -0400
Received: from aamtaout03-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120412211644.TYPO23305.mtaout02-winn.ispmail.ntl.com@aamtaout03-winn.ispmail.ntl.com>;
          Thu, 12 Apr 2012 22:16:44 +0100
Received: from [192.168.0.2] (really [94.170.150.126])
          by aamtaout03-winn.ispmail.ntl.com
          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP
          id <20120412211643.JBVR13318.aamtaout03-winn.ispmail.ntl.com@[192.168.0.2]>;
          Thu, 12 Apr 2012 22:16:43 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.28) Gecko/20120313 Thunderbird/3.1.20
In-Reply-To: <20120412071150.GB31122@sigill.intra.peff.net>
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=yXtjXN6ItgYA:10 a=-PimNzO8mcAA:10 a=u4BGzq-dJbcA:10 a=IkcTkHD0fZMA:10 a=Vy_MkDFux6xh84UKhyoA:9 a=KqIhyaGudiaNddQ8uoAA:7 a=QEXdDO2ut3YA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195373>

On 12/04/12 08:11, Jeff King wrote:
> On Sat, Apr 07, 2012 at 09:40:26AM +0100, Andrew Sayers wrote:
> 
>> On a slight aside, should we add @{downstream} to describe the opposite
>> of @{upstream}?  Seeing that around the place would give intermediate
>> users a clue about why pull and push aren't as related as they think,
>> and would be useful here and there in code (e.g. __git_ps1 could show a
>> better bash prompt with GIT_PS1_SHOWUPSTREAM).
> 
> Maybe. I don't really see how it is useful, but maybe you want to flesh
> our your proposal with some examples? I do not use __git_ps1, so I'm not
> sure what you want to improve there.

This discussion has highlighted the fact that a lot of people (myself
included) had difficulty with the idea that push and pull could be
asymmetrical operations.  Speaking for myself,
push/pull/upstream/downstream/etc. has always been one of those things
in my peripheral vision that worked well enough that I never really
thought about it.  I think this is a fairly important bug in the
documentation, which I guess didn't come across when I suggested a
solution that was mostly about code.

I could be wrong, but looking over this discussion suggests to me a
pattern where people who actually thought about this stuff understood it
pretty quickly, whereas those of us who hadn't previously thought about
it had to unlearn the vague notion that "upstream" was somehow both the
place you push to and the place you pull from, despite being
incompatible with the meaning of the word.

I described this before as being "in my peripheral vision", which is as
different from being in central vision (like it is for you guys) as it
is different from being out of vision altogether (like it is for new
people).  Peripheral processing is a notoriously troubled route for
ideas, because people tend to pick up on cues and internalise them in
irrational ways without noticing.  A classic version control example is
how nobody ever said "commits are expensive and should be used
cautiously", but everyone just sort of came to that conclusion without
really thinking about it.  As soon as DVCSs forced us to actually focus
on the problem and think about it rationally, it became obvious that we
needed to unlearn the vague assumption and go with a model that made
more sense.

I'm pretty sure the cue I internalised to make me think "push" and
"pull" were symmetrical was that the word "upstream" gets thrown around
a lot in the documentation, whereas nobody ever uses the word
"downstream".  Having heard "upstream this" and "upstream that" every
time I opened a man page, the word "upstream" just naturally popped into
my head when I wondered where `git push` went.  Just to be clear - I'm
not arguing that anybody that consciously asked themselves the question
"where does `git push` go?" would rationally conclude the answer is
"upstream", I'm saying that those of us who never really thought about
it had a mental process bubbling away deep in some murky bit of our
brain which plugged the gap in our understanding with the only word it knew.

So if the problem is that the documentation cues the reader to think
about upstreams but not to think about downstreams, the solution is to
find excuses to talk more about downstreams.  As far as I'm concerned
@{upstream} means "the place that commits come from when I `git pull`",
so it makes perfect sense to me that @{downstream} would mean "the place
commits go to when I `git push`".  That would let us write documentation
like the following:

    Git has been optimised to make branching and merging very easy.
    Most git workflows involve using an upstream branch (that you pull
    other people's work from), your current branch (that you commit
    your changes to) and a downstream branch (that you push the
    combined work to).  To understand the this a bit better, try using
    these commands:

    git log # commits in your local repository
    git log @{upstream} # commits in your upstream branch
    git log @{downstream} # commits in your downstream branch
    git log HEAD..@{upstream} # commits you haven't pulled yet
    git log @{downstream}..HEAD # commits you haven't pushed yet

    A lot of workflows simplify the process by assuming that your
    upstream is also your downstream, and that both exist in some
    shared repository, but as far as git's concerned this is just one
    special case.

I realise the above is a bit simplistic and would need to be written
better, but hopefully it demonstrates how code support for "downstream"
terminology would let us write documentation that provides better cues
about how the whole process works.

I mentioned __git_ps1 before as an example of where @{downstream} would
be useful in code.  The idea is that you can set your prompt to include
e.g. "+3-2" if you have 3 commits to push and 2 commits to pull, which
probably tells you lies right now when your push target happens not to
be the same as your upstream.

	- Andrew
