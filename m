From: Andreas Ericsson <ae@op5.se>
Subject: Re: Friendly refspecs
Date: Wed, 23 Apr 2008 08:24:13 +0200
Message-ID: <480ED60D.7050708@op5.se>
References: <20080409222500.GB19248@mithlond> <20080409225112.GB12103@sigill.intra.peff.net> <20080413093102.GC12107@mithlond.arda.local> <20080416034823.GA11727@sigill.intra.peff.net> <alpine.LNX.1.00.0804161126280.19665@iabervon.org> <7vod89pnxx.fsf@gitster.siamese.dyndns.org> <20080422105658.GA11238@sigill.intra.peff.net> <7v63u9zva9.fsf@gitster.siamese.dyndns.org> <20080422200550.GB29313@sigill.intra.peff.net> <7vd4ohy5ym.fsf@gitster.siamese.dyndns.org> <20080423042433.GA3291@mithlond.arda.local> <7v1w4xuni1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Teemu Likonen <tlikonen@iki.fi>, Jeff King <peff@peff.net>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 08:43:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoYhE-0000I0-Kj
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 08:43:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbYDWGm0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 02:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbYDWGm0
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 02:42:26 -0400
Received: from mail.op5.se ([193.201.96.20]:54926 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750738AbYDWGmZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 02:42:25 -0400
X-Greylist: delayed 1089 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Apr 2008 02:42:25 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id EDEF81F080AD;
	Wed, 23 Apr 2008 08:23:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yARZhzvX74EC; Wed, 23 Apr 2008 08:23:39 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id A4A651F08071;
	Wed, 23 Apr 2008 08:23:38 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.12 (X11/20080226)
In-Reply-To: <7v1w4xuni1.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80191>

Junio C Hamano wrote:
> Teemu Likonen <tlikonen@iki.fi> writes:
> 
>> Junio C Hamano wrote (2008-04-22 13:45 -0700):
>>
>>> I thought the original poster's example was
>>>
>>> 	git push $there $commit:branch2
>>>
>>> where $commit happened to be "branch1".  Would we dwim
>>>
>>> 	git push $there branch1~4:this_is_known_ok
>>>
>>> to refs/heads/?
>> I guess this is what I meant. My original question was about
>> inconsistent user interface: "git push $there branch1" creates branch1
>> on the remote side (if it does not exist) but "git push $there
>> branch1:branch2" gives an error if branch2 does not exist
>> (branch1:refs/heads/branch2 is required).
>>
>> The case has become much more complicated since, so I just speak aloud
>> my hope that need for refs/ paths in common situations would be reduced
>> to minimum.
> 
> I think everybody involved in this discussion understands _that_.  The
> issue is that you would not have said "branch2" in real life, but used
> some word that is _not_ "branch" to name the thing, and there is no way
> for git to guess correctly if you meant to create a branch or a
> light-weight tag.
> 

If the src ref is not a commit sha1, the user will almost certainly want
to create the same *type* of ref on the remote side, so

git tag foo
git branch boo
git push $there foo:wip
git push $there boo:wip-2008-04-24

would, on the remote side, create the branch "wip" and the tag "wip-2008-04-24"

I for one would certainly like that, and I don't think very many will be
surprised at that behaviour.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
