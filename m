From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: Re: push.default: current vs upstream
Date: Tue, 17 Apr 2012 21:13:58 +0100
Message-ID: <4F8DCF06.5010505@pileofstuff.org>
References: <7vty15ltuo.fsf@alter.siamese.dyndns.org> <vpqty12h995.fsf@bauges.imag.fr> <20120405131301.GB10293@sigill.intra.peff.net> <vpqwr5uceis.fsf@bauges.imag.fr> <20120406071520.GD25301@sigill.intra.peff.net> <vpqr4w12tjj.fsf@bauges.imag.fr> <20120406080004.GA27940@sigill.intra.peff.net> <4F7FF19B.1060407@alum.mit.edu> <20120407075150.GA18168@sigill.intra.peff.net> <4F7FFD7A.80104@pileofstuff.org> <20120412071150.GB31122@sigill.intra.peff.net> <4F874639.5090207@pileofstuff.org> <7vlim04ou1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 22:14:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKEmw-00077T-9Q
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 22:14:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350Ab2DQUOF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 16:14:05 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:51825 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750763Ab2DQUOE (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Apr 2012 16:14:04 -0400
Received: from aamtaout02-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120417201400.QEI28064.mtaout02-winn.ispmail.ntl.com@aamtaout02-winn.ispmail.ntl.com>;
          Tue, 17 Apr 2012 21:14:00 +0100
Received: from [192.168.0.3] (really [94.170.150.126])
          by aamtaout02-winn.ispmail.ntl.com
          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP
          id <20120417201400.XEAP3795.aamtaout02-winn.ispmail.ntl.com@[192.168.0.3]>;
          Tue, 17 Apr 2012 21:14:00 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.28) Gecko/20120313 Thunderbird/3.1.20
In-Reply-To: <7vlim04ou1.fsf@alter.siamese.dyndns.org>
X-Cloudmark-Analysis: v=1.1 cv=JvdXmxIgLJv2/GthKqHpGJEEHukvLcvELVXUanXFreg= c=1 sm=0 a=yXtjXN6ItgYA:10 a=-PimNzO8mcAA:10 a=u4BGzq-dJbcA:10 a=8nJEP1OIZ-IA:10 a=qOz2pZ_4AAAA:8 a=f2el1u5E4MLN0RL0XxgA:9 a=wPNLvfGTeEIA:10 a=7qzHkXPk5l4A:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195798>

On 12/04/12 22:33, Junio C Hamano wrote:
> Andrew Sayers <andrew-git@pileofstuff.org> writes:
> 
>> So if the problem is that the documentation cues the reader to think
>> about upstreams but not to think about downstreams, the solution is to
>> find excuses to talk more about downstreams.  As far as I'm concerned
>> @{upstream} means "the place that commits come from when I `git pull`",
>> so it makes perfect sense to me that @{downstream} would mean "the place
>> commits go to when I `git push`".
> 
> In a separate message I completely misunderstood what you meant by
> "downstream".
> 
> If you had something like this:
> 
> 	[remote "origin"]
>         	url = ...
>         [remote "destination"]
>                 pushURL = ...
> 
> 	[branch "topic"]
>         	remote = origin
>                 merge = refs/heads/master
> 		pushRemote = destination # new
>                 push = refs/heads/topic # new
> 
> you could express that asymmetric layout in a natural way.  When you say
> "git push" while on your "topic" branch, it will go to "destination"
> remote to update their "topic" branch.
> 
> Interesting...
> 

If "upstream" and "downstream" are ambiguous, it makes sense to avoid
the words altogether - you can't reduce ambiguity by adding more
definitions.  I'm replying to the above instead of your most recent
message because it might provide a fresh angle on the problem.

We already have language to describe "upstream" unambiguously, and an
intuitive way of describing the opposite of it, so specifying revisions
with the same language would help tie some things together and make git
easier to learn.  The only problem  is that we currently use two words
instead of one.

We could talk about @{remote}/@{pushRemote}, which I'd expect to be
intuitive to a beginner despite the inaccuracy - we already talk about
"remote repositories" and "remote tracking branches", so @{remote} would
be easy to guess.  Alternatively, @{merge}/@{push} would a bit more
accurate but a bit less obvious to people that don't really understand
merging yet (or are figuring out merge vs. rebase).  Or we could make up
some similar-but-distinct terms like @{mergeSource} and @{pushSink} that
reinforce the language above without overlapping.

	- Andrew
