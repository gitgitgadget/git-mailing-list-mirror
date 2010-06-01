From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: How to add daily tags for a central repo?
Date: Tue, 01 Jun 2010 10:52:31 +0200
Message-ID: <4C04CA4F.40106@drmicha.warpmail.net>
References: <1275369711233-5124575.post@n2.nabble.com>	<4C04AC1E.7040502@drmicha.warpmail.net>	<AANLkTim02FQ3BfV88iylMqbHA5sBbJvp5TmWg52OXCzn@mail.gmail.com>	<4C04BF33.70300@drmicha.warpmail.net> <AANLkTinHU5z5njEpx1S_6DIR5ECauJbzWlcM95wNUVxf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Roy Lee <roylee17@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 01 10:53:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJNDX-0007gm-Ph
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 10:53:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755594Ab0FAIwy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 04:52:54 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:47039 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753647Ab0FAIwx (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Jun 2010 04:52:53 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 7C4C7F8446;
	Tue,  1 Jun 2010 04:52:53 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 01 Jun 2010 04:52:53 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=qpA2yJMLICEfieuJ25aJWgOf1EM=; b=VPkrvgc4+jfBYW5zcjgqCahJBiyUe6VF3jG+p9PJ5FTVSJWdbr6woGuUpLmJTaDgl32idQ8T6Obrgp59UK9jBtrQL4D2r+SARENLl5TlJftkBalX70KjY96mJH/9pRnyc1N4+wuWYrPch1yut4yQMoXozjYZiXV4l1fQPXcyWNM=
X-Sasl-enc: NGFUu1NqHt6OBRHMkCTkUSu0wlGQOQG8treeknuu//PM 1275382373
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D5E6249F535;
	Tue,  1 Jun 2010 04:52:52 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100526 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <AANLkTinHU5z5njEpx1S_6DIR5ECauJbzWlcM95wNUVxf@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148093>

Roy Lee venit, vidit, dixit 01.06.2010 10:25:
> On Tue, Jun 1, 2010 at 4:05 PM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> Roy Lee venit, vidit, dixit 01.06.2010 09:55:
>>> Hi Michael,
>>>
>> Well, as I wrote: HEAD@{datetimespec} for the HEAD,
>> branchname@{datetimespec} for a branch "branchname". datetimespec is
>> decribed in git rev-parse's manpage but can be what you'd think (e.g.
>> "date time") and more ("yesterday").
>> If you really want to inspect the reflog (not the commits listed in the
>> reflog) use "git log -g" or, unsurprisingly, "git reflog".
>>
>>> Or any alternatives for developer to query this information.
>>
>> The reflog is local to the repo, which is why you would create tags on
>> the central repo based on the reflog there, if that is your "trusted
>> time and push reference source".
> 
> Does this mean the tagging must be done on the server?

Yes.

> Is there any way to query this information from a client repo,
> do the tagging locally, and than push the tag back to the server?

No.

This answer assumes that what you want to do is the following:

* Create a tag for the state of a ref (such as HEAD) on the central repo
at a specific date and time.

No client can know this. Reflogs are local. The point of your tagging
(as I understand it) is to create an authoritative date based tag, and
only the central repo has the necessary info.

If you want to do something different you should say so ;) But note that
committer and author dates are completely bogus from the point of view
of "was in the central repo at a certain date", they have nothing to do
with that.

Michael
