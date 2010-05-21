From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Use "git pull --ff-only" by default?
Date: Fri, 21 May 2010 17:18:29 +0200
Message-ID: <4BF6A445.1030105@drmicha.warpmail.net>
References: <A612847CFE53224C91B23E3A5B48BAC74483234E90@xmail3.se.axis.com> <4BF68F5F.9010309@drmicha.warpmail.net> <A612847CFE53224C91B23E3A5B48BAC74483234EDE@xmail3.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
X-From: git-owner@vger.kernel.org Fri May 21 17:18:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFTzw-00049W-Uv
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 17:18:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758261Ab0EUPSs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 May 2010 11:18:48 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:44329 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758080Ab0EUPSr (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 May 2010 11:18:47 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 67901F7B78;
	Fri, 21 May 2010 11:18:40 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 21 May 2010 11:18:40 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=q2nSkqrOmMqqkyIVrAy+FQ3KuNo=; b=D4WcA0ChR4F18rmxmRYnNHKq6FZVF5+p8Pt6cjlY7f+Dv1dLDrltXfJbRVyk6Ok9k5rWzdvePopRvH0/9egDUrFK7aCgIGuDNjlv3CpmpYBCLn/2ZW0jSMVQmLvmGurcIHlBJfjLM5NUwUytP+jJOVPXAonzF7V6AoRNdTOKlKk=
X-Sasl-enc: /B0eupEaT+lYsCFYfDfV8864vS7v80KOzeIn9CFEnBbQ 1274455120
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C3CA64D2DA;
	Fri, 21 May 2010 11:18:39 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100519 Lightning/1.0b2pre Lanikai/3.1pre
In-Reply-To: <A612847CFE53224C91B23E3A5B48BAC74483234EDE@xmail3.se.axis.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147465>

Peter Kjellerstedt venit, vidit, dixit 21.05.2010 16:47:
>> -----Original Message-----
>> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
>> Behalf Of Michael J Gruber
>> Sent: den 21 maj 2010 15:49
>> To: Peter Kjellerstedt
>> Cc: git@vger.kernel.org
>> Subject: Re: Use "git pull --ff-only" by default?
>>
>> Peter Kjellerstedt venit, vidit, dixit 21.05.2010 14:59:
>>> Is there some way to make "git pull --ff-only" be the default?
>>> I could not find anything about this in "git config --help" and
>>> also the lack of a --no-ff-only option for git pull (it exists
>>> for git merge) indicates that there is no such support.
>>>
>>> I did considered the branch.<name>.mergeoptions configuration
>>> option, but it does not seem appropriate as it only applies to
>>> a specific branch, whereas I want it to apply to all branches
>>> by default.
>>>
>>> Yes, I know I could do "git config alias.pl 'pull --ff-only'",
>>> but since my intensions are for this to be the default for all
>>> developers in our organization (most of whom have no git knowledge
>>> at all yet) to avoid unnecessary branches caused by the developers
>>> hacking directly on master rather than a topic branch, I would
>>> very much prefer a configuration option rather than an alias (as
>>> I am unlikely to get the developers to remember to do "git pl"
>>> instead of "git pull").
>>
>> Problem is they have to remember to set your new config, or, if you are
>> able to set all developers system config, they have to refrain from
>> overriding it.
> 
> They would get it by default from our setup scripts. If they then 
> choose to turn it off, so be it.

If you're relying on setup scripts, you can

git config alias.pull 'pull --ff-only'

> 
>>> My idea was to add something like merge.options and pull.options
>>> as configuration options (I want to be able to specify the options
>>> separately for pull and merge). However, I wanted throw this out
>>> here first before starting to hack away at the code, in case I
>>> missed something obvious, or if others find this to be an
>>> incredibly stupid idea...
>>
>> In general, you can't control reliably what people do in their repos.
> 
> I sure wish I had more control over it, but that is a separate 
> discussion. ;)
> 
>> But you can control what kind of pushes into a central repo you allow.
>> That is the usual approach: Let them mess up their repos, they'll learn
>> their lesson when they can't push ;)
> 
> Can you differentiate between an automatic merge which happened
> because the user had made some local changes before pulling (which
> I do not want to appear in the central repo), and a real merge of 
> a topic branch (which I do want)?

I can't, and neither can Git. Who can?

I think this boils down to having a few people who are allowed to push
merges because they can make these decisions. Even if people don't merge
"origin" but their own branches they can create a mess, so you cannot
differentiate based on that.

Michael
