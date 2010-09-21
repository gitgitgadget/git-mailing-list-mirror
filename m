From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: can git-describe learn first-parent behavior?
Date: Tue, 21 Sep 2010 14:34:13 +0200
Message-ID: <4C98A645.8070601@viscovery.net>
References: <AANLkTi=6o15y-6Q+tn40=hrPf9pmo+Y1Jd97hGxr5mH2@mail.gmail.com> <4C987C2E.3060001@drmicha.warpmail.net> <4C98830A.70203@viscovery.net> <4C989BBD.80106@drmicha.warpmail.net> <4C989E6B.1070703@viscovery.net> <4C98A0B7.9050501@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Joshua Shrader <jshrader83@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Sep 21 14:34:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oy23D-0004YK-MV
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 14:34:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754494Ab0IUMeQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 08:34:16 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:6931 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754154Ab0IUMeP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 08:34:15 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Oy234-0007Gb-96; Tue, 21 Sep 2010 14:34:14 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 08B271660F;
	Tue, 21 Sep 2010 14:34:13 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.12) Gecko/20100914 Thunderbird/3.0.8
In-Reply-To: <4C98A0B7.9050501@drmicha.warpmail.net>
X-Enigmail-Version: 1.0.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156719>

Am 9/21/2010 14:10, schrieb Michael J Gruber:
> Johannes Sixt venit, vidit, dixit 21.09.2010 14:00:
>> Am 9/21/2010 13:49, schrieb Michael J Gruber:
>>> searching to describe e5498e8a
>>>  annotated         38 v1.7.1.1
>>>  annotated        252 v1.7.1
>>>  annotated        268 v1.7.1-rc2
>>>  annotated        318 v1.7.1-rc1
>>>  annotated        355 v1.7.1-rc0
>>>  annotated        478 v1.7.0.7
>>>  annotated        492 v1.7.0.6
>>>  annotated        512 v1.7.0.5
>>>  annotated        539 v1.7.0.4
>>>  annotated        564 v1.7.0.3
>>> traversed 1267 commits
>>> more than 10 tags found; listed 10 most recent
>>> gave up search at 97222d9634b5518cd3d328aa86b52746a16334a7
>>> v1.7.1.1-38-ge5498e8
>>>
>>> v1.7.1.1 clearly wins by depth priority.
>>
>> If "depth priority" is not the shortest ancestry path (and it obviously is
>> not given the numbers above), what is it then, and why does it not work
>> with Joshua's example? Wouldn't it be better to make it Just Work instead
>> of adding a workaround that has to be enabled manually?
> 
> I don't consider the existing behaviour wrong, though it may be a bit
> tough to figure out. It may even be that the depth calculation has an
> off-by-1 error which leads to this behaviour.

I faintly recall that the current behavior was already made
--first-parent-like on purpose, exactly for cases like Joshua's and the
one I cited. Why does it work with mine, but not with Joshua's?

Notice that v1.7.0.7 is an immediate parent of e5498e8a, but still its
calculated "depth" is much higher than for v1.7.1.1, which is 25 commits
down in the history. Why? Why isn't it the same with Joshua's history? Is
it due to the commit dates? Or the tag dates?

-- Hannes
