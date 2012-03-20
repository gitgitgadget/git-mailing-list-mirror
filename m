From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: Re: Please discuss: what "git push" should do when you do not say
 what to push?
Date: Tue, 20 Mar 2012 21:20:35 +0000
Message-ID: <4F68F4A3.60506@pileofstuff.org>
References: <7v7gyjersg.fsf@alter.siamese.dyndns.org> <7vty1ndcoi.fsf@alter.siamese.dyndns.org> <4F6461D7.40303@pileofstuff.org> <7vipi1d9r7.fsf@alter.siamese.dyndns.org> <4F6792DE.80208@pileofstuff.org> <7v62e09sig.fsf@alter.siamese.dyndns.org> <4F67B78B.6080208@pileofstuff.org> <7vsjh48af1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 20 22:20:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SA6U0-0002JI-NI
	for gcvg-git-2@plane.gmane.org; Tue, 20 Mar 2012 22:20:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189Ab2CTVUk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Mar 2012 17:20:40 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:39170 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753832Ab2CTVUj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Mar 2012 17:20:39 -0400
Received: from aamtaout02-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120320212037.HMPS20752.mtaout02-winn.ispmail.ntl.com@aamtaout02-winn.ispmail.ntl.com>;
          Tue, 20 Mar 2012 21:20:37 +0000
Received: from [192.168.0.2] (really [94.170.150.126])
          by aamtaout02-winn.ispmail.ntl.com
          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP
          id <20120320212037.TZPN5924.aamtaout02-winn.ispmail.ntl.com@[192.168.0.2]>;
          Tue, 20 Mar 2012 21:20:37 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.27) Gecko/20120216 Thunderbird/3.1.19
In-Reply-To: <7vsjh48af1.fsf@alter.siamese.dyndns.org>
X-Cloudmark-Analysis: v=1.1 cv=JvdXmxIgLJv2/GthKqHpGJEEHukvLcvELVXUanXFreg= c=1 sm=0 a=pFZ1vDXyzkQA:10 a=thCgSaaV3M8A:10 a=u4BGzq-dJbcA:10 a=8nJEP1OIZ-IA:10 a=qOz2pZ_4AAAA:8 a=VwQbUJbxAAAA:8 a=0YUhwKr7wScdIXlt21UA:9 a=nIgX97JRLGZoBevw6noA:7 a=wPNLvfGTeEIA:10 a=7qzHkXPk5l4A:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193542>

On 19/03/12 22:59, Junio C Hamano wrote:
> Andrew Sayers <andrew-git@pileofstuff.org> writes:
> 
>> On 19/03/12 21:43, Junio C Hamano wrote:
>>>
>>> The same response applies. These administrators are taking responsibility
>>> for their users by making them out of our reach.
>>
>> I'm not sure I follow.  It sounds like you're saying we should avoid
>> helping anyone that doesn't stick to our upgrade schedule,...
> 
> I am not saying "should avoid".  I am saying it is not much use.
> 
> All we can do is to inform, educate and help those who are taking
> responsibility, be it LTS distro or these administrators, to help their
> users.  I've already outlined what LTS distros could do with backporting
> and reverting in the previous message.
> 
> We can make sure that the "default flip" and "stop warn" patches can be
> easily cherry-picked by them, even though we cannot force them to do so.

So we've identified the following groups:

1. People who can't be harmed by this change (e.g. new users and people
that would only ever use the new default behaviour)

2. People who are harmed by this change, and get information from this
list via some direct or indirect means (e.g. kernel devs or people using
a well-behaved distro)

3. People who are harmed by this change, are impervious to information
from this list, but update at sensible intervals and pay attention to
warning messages (e.g. corporate environments with frequent upgrade cycles)

4. People who are harmed by this change, are impervious to information
from this list, update at long intervals and pay attention to warning
messages (e.g. corporate environments with infrequent upgrade cycles)

5. People who are harmed by this change, upgrade their system
occasionally, but don't want to hear about behaviour changing from what
it has always been (Slackware users ;)

I guess we can agree that group 1 is already well cared for by recent
publicity, and group 5 is beyond our ability to handle.

Easy-to-cherry-pick patches are a good solution for group 2 - how about
also making a second "default flip" patch available earlier, for people
that want to go ahead of the main repo?  For example, Debian might want
to put this patch in before a feature freeze hits so that their build of
git behaves the same as everyone else once they've finished the
extensive QA process for the distro.

Warning messages as you've described them are a good solution for group
3.  I think we disagree about the size of this group, but I've only got
anecdotal evidence so what do I know.

People in group 4 aren't served well by any solution that involves some
day removing the warning altogether, because there will always be
someone that upgrades the day after we remove the warning and says "why
wasn't I informed?".

I assume the reason for removing the warning altogether is that some day
the signal:noise ratio will just get too bad.  Improving the S:N ratio
strikes me as useful even ignoring group 4, but anything that increases
the amount of time we can warn means that more of them will be informed.

This might have been implicit all along, but one easy way to improve the
S:N ratio would be to have the warning message tell people to use `git
config --global`.  Then people only ever need to see the message once
each, no matter how many repos they create.

We could also try to measure the S:N ratio by having a period where the
message says "... please e-mail git@vger.kernel.org if you found this
message useful, otherwise we'll assume nobody cares and delete it".
Then when somebody comes along and asks why they weren't informed, we at
least have a good answer.

Finally, as a modification to my previous suggestion, we could `git
config push.default <whatever>` when new repos are created and no
global/system push.default is found, *instead* of removing the warning
altogether at the end of the process. This would mean that everyone in
group 3 is informed, as are the vast majority of group 4.  The only
people that can then be harmed are those that do an exceptionally good
job of disguising themselves as new users (e.g. scripts that regularly
create throw-away repositories without ever looking at old ones).

	- Andrew
