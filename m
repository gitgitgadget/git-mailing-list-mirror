From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Fri, 19 Mar 2010 15:52:15 +0100
Message-ID: <4BA38F9F.8050007@drmicha.warpmail.net>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com>	 <m3tyscjt7h.fsf@localhost.localdomain> <9e4733911003190733h62e2aea0i7573bba641f4d931@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 19 16:03:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nsdj9-0001rQ-P5
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 16:03:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751863Ab0CSOzE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 10:55:04 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:52746 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751668Ab0CSOzC (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Mar 2010 10:55:02 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 6895CE8714;
	Fri, 19 Mar 2010 10:55:02 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 19 Mar 2010 10:55:02 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=/e0chGRJ2QwAnLqtC1YDhDmL4Dc=; b=JKGCMzR+ULoBS5qTgqU2XnCF3UnRK98Dk3qAuO1trWPp2njyVtvPqIesXcKWGocOKgsYTU0nQSKkPkyGrKHFl6X04SohmeezZ0uiE/vVhlsHuFOkMT+7xO3/RB5QjBnrXbGTbPmqpRjyti8akwe3I7nF4eAClRJ8VRc+2cAWkDw=
X-Sasl-enc: 3TqbfHfABXW/I7D0zRO6R7jBl5w+YsWKvIl7dCu3Re7j 1269010502
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 96C1F4B2009;
	Fri, 19 Mar 2010 10:55:01 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10pre) Gecko/20100319 Lightning/1.0b2pre Shredder/3.0.5pre
In-Reply-To: <9e4733911003190733h62e2aea0i7573bba641f4d931@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142608>

Jon Smirl venit, vidit, dixit 19.03.2010 15:33:
> On Fri, Mar 19, 2010 at 10:08 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>> Michael Witten <mfwitten@gmail.com> writes:
>>
>>> Short Version:
>>> -------------
>>>
>>>
>>> Rather than use a (name,email) pair to identify people, let's use
>>> a (uuid,name,email) triplet.
>>>
>>> The uuid can be any piece of information that a user of git determines
>>> to be reasonably unique across space and time and that is intended to
>>> be used by that user virtually forever (at least within a project's
>>> history).
>>>
>>> For instance, the uuid could be an OSF DCE 1.1 UUID or the SHA-1 of
>>> some easily remembered, already reasonably unique information.
>>
>> ... or 'canonical-name canonical-email' pair.
>>
>>>
>>> This could really help keep identifications clean, and it is rather
>>> straightforward and possibly quite efficient.
>>>
>>>
>>> Long Version:
>>> ------------
>> [...]
>>
>>> While git's use of (name,email) pairs to identify each person is
>>> extremely practical, it turns out that it's rather `unstable';
>>
>> This is non-solution to non-problem.
>>
>> First, the user.name and user.email does not need to be name and email
>> from some email account.  It might be some "canonical name" and
>> "canonical email".
>>
>> Second, there are (I think) two main sources of 'unstability' in
>> (name,email) pairs, namely A) misconfigured git (when fetching/pushing
>> using git itself), B) wrong name in email etc. (when sending patches
>> via email, 80% of patches in Linux kernel case).
> 
> Another top source is mangling of non-ASCII charsets when they go
> though the email system. Are the git work flow tools safe for
> alternative charsets? Do the email tools look at the charset header of
> the email message? Check people's names in the kernel commits and
> you'll find lots of examples of this type of mangling.
>

Or even the quoting of quotes for nick names, appearing as 'nick',
"nick", \"nick\", nick and what not.

> Or people not using UTF-8. There are files in the kernel where
> people's names are in conflicting codepages. Should git try to look
> for diffs that aren't UTF-8?

You and others are proving a very important point here: This is really
an lkml proxy fight being taken to the git list, after the futile
mailmap-ification there.

People may disagree on the best approach in general, but this thread
clearly shows:

- The Git community is happy with mailmap for git.git.
- The Git community does not see any need for amending the mailmap
mechanism.
- How you actually use mailmap (leniently or enforcing) is a per-project
decision, just like the patch workflow, the meaning and use of s-o-b
lines, the requirement for full names and many other things.

But since the git list is hosted on kernel.org we can't really complain
about providing room for an lkml discussion ;)

Michael
