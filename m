From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: Re: Please discuss: what "git push" should do when you do not say
 what to push?
Date: Mon, 19 Mar 2012 20:11:10 +0000
Message-ID: <4F6792DE.80208@pileofstuff.org>
References: <7v7gyjersg.fsf@alter.siamese.dyndns.org> <7vty1ndcoi.fsf@alter.siamese.dyndns.org> <4F6461D7.40303@pileofstuff.org> <7vipi1d9r7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 19 21:11:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9ivI-0007GZ-8E
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 21:11:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964910Ab2CSULP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Mar 2012 16:11:15 -0400
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:62847 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753542Ab2CSULO (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Mar 2012 16:11:14 -0400
Received: from aamtaout02-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout03-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120319201112.NPCF21084.mtaout03-winn.ispmail.ntl.com@aamtaout02-winn.ispmail.ntl.com>;
          Mon, 19 Mar 2012 20:11:12 +0000
Received: from [192.168.0.2] (really [94.170.150.126])
          by aamtaout02-winn.ispmail.ntl.com
          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP
          id <20120319201112.GJCE5924.aamtaout02-winn.ispmail.ntl.com@[192.168.0.2]>;
          Mon, 19 Mar 2012 20:11:12 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.27) Gecko/20120216 Thunderbird/3.1.19
In-Reply-To: <7vipi1d9r7.fsf@alter.siamese.dyndns.org>
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=pFZ1vDXyzkQA:10 a=thCgSaaV3M8A:10 a=u4BGzq-dJbcA:10 a=8nJEP1OIZ-IA:10 a=qOz2pZ_4AAAA:8 a=VwQbUJbxAAAA:8 a=qZB2upWFR4h1POTL1VUA:9 a=NElMQDwOTx3z8RugopYA:7 a=wPNLvfGTeEIA:10 a=x8gzFH9gYPwA:10 a=7qzHkXPk5l4A:10 a=nVCxOMTkaIi2j9dC:21 a=guzHum4CUN1-3eW_:21 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193454>

On 18/03/12 18:50, Junio C Hamano wrote:
> Andrew Sayers <andrew-git@pileofstuff.org> writes:
> 
>> On 17/03/12 05:22, Junio C Hamano wrote:
>>> If the conclusion of the discussion is that we will change the default,
>>> the transition to the new default will go like this:
>>>
>>>  1. An announcement message to let the user communities know about the
>>>     future change will be distributed in a way similar to the previous
>>>     request-for-discussion message was distributed.
>>>
>>>  2. The first version of Git that is released after such an announcement
>>>     will start issuing a warning ...
>>>
>>>  3. We wait for a few release cycles.
>>>
>>>  4. The default changes. ... 
>>>     The warning message will be reworded ...
>>>     being the 'matching' in the future", it will say "has changed to X".
>>>
>>>  5. We wait for a few release cycles.
>>>
>>>  6. The warning is removed.
>>>
>>> A typical release cycle lasts for 8-10 weeks.
>>
>> Unfortunately, "a few release cycles" strikes me as a rather hopeful
>> description.  For example, a user installing the new Ubuntu LTS release
>> (due out next month) would feel completely justified in not upgrading
>> until 2017, whereas the rest of us would get rather bored disabling the
>> same old warning in every new repo we create for the next five years.
> 
> There is nothing hopeful about it.
> 
> The point of a release like LTS is to shield the users of the distribution
> from what happens in upstream, so it is up to the distro to help users. We
> do not have a way to help their users in a direct way, other than letting
> the distro know about the change, and educate the distros how they help
> their users.
> 
> If I were a user of such a distro whose sole point is a long term support,
> I would expect that a LTS that was originally released before point #2
> whose lifespan extends beyond point #6 to backport only the "warning"
> changes to such a release between #2 and #6 timespan as a point update to
> such a LTS release. Otherwise the distro is actively doing a disservice to
> its users.  Such a distro can also choose to revert the "warning removal"
> change #6 in their binary when they release a new LTS. If they did not
> backport "add warning" to their earlier LTS release, that is at least what
> they can do to help their users.
> 
> But again, that is not something we have direct control over, and it is
> not very useful to discuss this on this list. Ubuntu LTS support forum
> might be a better place, but in short, it is not a problem we can solve
> (nor we should be solving), as long as we have a reasonable migration plan
> and if the user is locked out of that migration plan---whoever is doing
> the locking-out is taking responsibility for these users who are out of
> our reach.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

I take the point that distros have their own support infrastructure, so
perhaps this would be a better example:

Many administrators in corporate environments will install git from
source, because they don't trust RPM/need some feature in the latest
version/are just that way inclined.  Having installed it, they tend to
sit on that version for a few years until they have to upgrade the
system/need some feature in the new latest version/are still just that
way inclined.  Their justification for not upgrading is often that new
versions of software tend to change behaviour in subtle ways that break
the scripts they've bodged together over the years.  Trying to argue
that one particular bit of software will only hurt you if you wait for
the wrong amount of time tends to be a losing battle, because
administrators hate special cases just as much as programmers.

Having said all that, here's a slightly different argument for a
slightly better solution:

When a user upgrades to a mid- or post-change version of git, I think
it's a good idea for them to be warned about the change of behaviour.
But new users, and old users with new repositories, gain nothing from
the little history lesson.  This should be solved in git itself, because
two users of the same binary might expect different behaviour.  An
automatic `git config push.default <whatever>` at repository creation
time would silence the noise without disrupting the signal.  As an added
bonus, this approach might take some heat out of the argument when the
umpteenth "is it time to remove the warning yet?" thread kicks off.

	- Andrew
