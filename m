From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: can git-describe learn first-parent behavior?
Date: Tue, 21 Sep 2010 17:26:25 +0200
Message-ID: <4C98CEA1.2050405@drmicha.warpmail.net>
References: <AANLkTi=6o15y-6Q+tn40=hrPf9pmo+Y1Jd97hGxr5mH2@mail.gmail.com> <4C987C2E.3060001@drmicha.warpmail.net> <4C98830A.70203@viscovery.net> <4C989BBD.80106@drmicha.warpmail.net> <4C989E6B.1070703@viscovery.net> <4C98A0B7.9050501@drmicha.warpmail.net> <4C98A645.8070601@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Joshua Shrader <jshrader83@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Sep 21 17:26:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oy4jj-0006UH-ML
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 17:26:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754952Ab0IUP0T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 11:26:19 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:53141 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753276Ab0IUP0S (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Sep 2010 11:26:18 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 94F31155;
	Tue, 21 Sep 2010 11:26:17 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Tue, 21 Sep 2010 11:26:17 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=owiiMbkJdCmXR4NzO6LErLp4rGU=; b=KjWe/9DmtEKMHJCHdZE19hbQ0neLhRGQJrUjHPCo5ZRJ/LD9RHXQ7rz+deCAQKjArPVDVUiKp3Qy2oahsPsKXqnanPD6HkUHzX7aICusXuKOc/INTt+jSdF4R7mhe0itATqzJbHtAFeeXXGgaFO2uM98Ac1SyCM7SNPcI6K7Wh8=
X-Sasl-enc: SprO79ndJEEYoENq/iuK8M1iVn24iligBu5mPh067kG0 1285082777
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 023C05E09C6;
	Tue, 21 Sep 2010 11:26:16 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20100907 Fedora/3.1.3-1.fc13 Lightning/1.0b3pre Thunderbird/3.1.3
In-Reply-To: <4C98A645.8070601@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156729>

Johannes Sixt venit, vidit, dixit 21.09.2010 14:34:
> Am 9/21/2010 14:10, schrieb Michael J Gruber:
>> Johannes Sixt venit, vidit, dixit 21.09.2010 14:00:
>>> Am 9/21/2010 13:49, schrieb Michael J Gruber:
>>>> searching to describe e5498e8a
>>>>  annotated         38 v1.7.1.1
>>>>  annotated        252 v1.7.1
>>>>  annotated        268 v1.7.1-rc2
>>>>  annotated        318 v1.7.1-rc1
>>>>  annotated        355 v1.7.1-rc0
>>>>  annotated        478 v1.7.0.7
>>>>  annotated        492 v1.7.0.6
>>>>  annotated        512 v1.7.0.5
>>>>  annotated        539 v1.7.0.4
>>>>  annotated        564 v1.7.0.3
>>>> traversed 1267 commits
>>>> more than 10 tags found; listed 10 most recent
>>>> gave up search at 97222d9634b5518cd3d328aa86b52746a16334a7
>>>> v1.7.1.1-38-ge5498e8
>>>>
>>>> v1.7.1.1 clearly wins by depth priority.
>>>
>>> If "depth priority" is not the shortest ancestry path (and it obviously is
>>> not given the numbers above), what is it then, and why does it not work
>>> with Joshua's example? Wouldn't it be better to make it Just Work instead
>>> of adding a workaround that has to be enabled manually?
>>
>> I don't consider the existing behaviour wrong, though it may be a bit
>> tough to figure out. It may even be that the depth calculation has an
>> off-by-1 error which leads to this behaviour.
> 
> I faintly recall that the current behavior was already made

Better faintly than faintingly ;)

> --first-parent-like on purpose, exactly for cases like Joshua's and the
> one I cited. Why does it work with mine, but not with Joshua's?
> 
> Notice that v1.7.0.7 is an immediate parent of e5498e8a, but still its
> calculated "depth" is much higher than for v1.7.1.1, which is 25 commits
> down in the history. Why? Why isn't it the same with Joshua's history? Is
> it due to the commit dates? Or the tag dates?


By experimentation (inserting additional tag-less commits, not changing
topology), I can make v2.0-base have the same, lower or higher depth
than v1.1-stable.

In fact, the (commit) date order is important here: For describing
<commit>, "describe" builds a 1 item list with commit, pops it, inserts
its parents in date order (!), looks at each item in that order, in each
step again inserting the parents in date order. So, it's really that the
branch with more newer commits wins (this is a lousy description, but
you get the idea).

Reading commit messages like 80dbae makes me think that this was
intended; and it is completely different from a first-parent approach.
So I think the default really is a good default as is, and first-parent
is useful and different in some cases.

Michael
