From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: Re: Please discuss: what "git push" should do when you do not say
 what to push?
Date: Mon, 19 Mar 2012 22:47:39 +0000
Message-ID: <4F67B78B.6080208@pileofstuff.org>
References: <7v7gyjersg.fsf@alter.siamese.dyndns.org> <7vty1ndcoi.fsf@alter.siamese.dyndns.org> <4F6461D7.40303@pileofstuff.org> <7vipi1d9r7.fsf@alter.siamese.dyndns.org> <4F6792DE.80208@pileofstuff.org> <7v62e09sig.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 19 23:47:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9lMk-0007Sm-PT
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 23:47:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757973Ab2CSWrq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Mar 2012 18:47:46 -0400
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:51793 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964799Ab2CSWro (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Mar 2012 18:47:44 -0400
Received: from aamtaout04-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout01-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120319224742.ODDH6650.mtaout01-winn.ispmail.ntl.com@aamtaout04-winn.ispmail.ntl.com>;
          Mon, 19 Mar 2012 22:47:42 +0000
Received: from [192.168.0.2] (really [94.170.150.126])
          by aamtaout04-winn.ispmail.ntl.com
          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP
          id <20120319224742.ZYPZ23925.aamtaout04-winn.ispmail.ntl.com@[192.168.0.2]>;
          Mon, 19 Mar 2012 22:47:42 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.27) Gecko/20120216 Thunderbird/3.1.19
In-Reply-To: <7v62e09sig.fsf@alter.siamese.dyndns.org>
X-Cloudmark-Analysis: v=1.1 cv=JvdXmxIgLJv2/GthKqHpGJEEHukvLcvELVXUanXFreg= c=1 sm=0 a=pFZ1vDXyzkQA:10 a=thCgSaaV3M8A:10 a=u4BGzq-dJbcA:10 a=8nJEP1OIZ-IA:10 a=qOz2pZ_4AAAA:8 a=VXyBlBbcmqxut6A2UtMA:9 a=k857nZmpOnmNzgQ8wkAA:7 a=wPNLvfGTeEIA:10 a=7qzHkXPk5l4A:10 a=3ak68Tv0hvght0in:21 a=hKrQjsZ63jxhNTbf:21 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193471>

On 19/03/12 21:43, Junio C Hamano wrote:
> Andrew Sayers <andrew-git@pileofstuff.org> writes:
> 
>> On 18/03/12 18:50, Junio C Hamano wrote:
>>>
>>> ... but in short, it is not a problem we can solve
>>> (nor we should be solving), as long as we have a reasonable migration plan
>>> and if the user is locked out of that migration plan---whoever is doing
>>> the locking-out is taking responsibility for these users who are out of
>>> our reach.
>>
>> I take the point that distros have their own support infrastructure, so
>> perhaps this would be a better example:
>>
>> Many administrators in corporate environments will install git from
>> source, because they don't trust RPM/need some feature in the latest
>> version/are just that way inclined.  Having installed it, they tend to
>> sit on that version for a few years ...
> 
> The same response applies. These administrators are taking responsibility
> for their users by making them out of our reach.
> 

I'm not sure I follow.  It sounds like you're saying we should avoid
helping anyone that doesn't stick to our upgrade schedule, but that
would mean it's redundant to add code at all - all the publicity this
change has got means everyone close enough to the process has heard
about it already.

>> ... a
>> slightly better solution:
>>
>> When a user upgrades to a mid- or post-change version of git, I think
>> it's a good idea for them to be warned about the change of behaviour.
>> But new users, and old users with new repositories, gain nothing from
>> the little history lesson.
> 
> You are right for new users, but are wrong for old users who aren't aware
> of the switch-over, *and* are harmed by the switch-over.

You're right that the solution I suggested would harm people who
regularly create new repositories, but have written scripts that expect
the old behaviour in those new repositories.  The only solution that
would completely avoid harming that small group would be to permanently
make the default push.default "print a warning and give up" - otherwise
you're just harming people with long schedules instead of those with
short ones.

	- Andrew
