From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Docs: git checkout --orphan: `root commit' and `branch
 head'
Date: Wed, 28 Sep 2011 10:00:43 +0200
Message-ID: <4E82D42B.2000103@drmicha.warpmail.net>
References: <1316960136073-6829212.post@n2.nabble.com> <1316961212.4388.5.camel@centaur.lab.cmartin.tk> <7vaa9r2jii.fsf@alter.siamese.dyndns.org> <1317073309.5579.9.camel@centaur.lab.cmartin.tk> <e88b6e560cab4ed1937dd191b4180387-mfwitten@gmail.com> <4E81F080.7010905@drmicha.warpmail.net> <CAMOZ1BsvnZ7PyfjOJURX+B7vCZcYheLS4pissGvPNjEivbYXtw@mail.gmail.com> <7v39fhyk21.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Michael Witten <mfwitten@gmail.com>,
	=?UTF-8?B?Q2FybG9zIE1hcnTDrW4gTmk=?= =?UTF-8?B?ZXRv?= 
	<cmn@elego.de>, vra5107 <venkatram.akkineni@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 28 10:00:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8p4c-0005f8-Ia
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 10:00:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753825Ab1I1IAs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 04:00:48 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:47228 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753397Ab1I1IAr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Sep 2011 04:00:47 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 76D3528F87;
	Wed, 28 Sep 2011 04:00:46 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute4.internal (MEProxy); Wed, 28 Sep 2011 04:00:46 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=eRfrHQYwEEmgX8I+NaRLiL
	sRq8o=; b=q2tJoC0xAYTZGDHUc3TWnz/kPg7/qb0NRmDrhlapjTw+rI2CFxhekc
	0Jc7ipqqdqHHkO8cXQYsDHT1wPAIs97Q8FSevRfuKoR2I0YrJ4Q7e+tAY4XyHG23
	5cQ1xpwOe4ScB0wRrXKwWvRcnHLFL/fEfuhRXSge2pPUyj4/jreuc=
X-Sasl-enc: u/iWLQ1KAEd11AEFZAeXbk2+7Ud5vEsLOhAyYmcbW45C 1317196846
Received: from localhost.localdomain (p5485957E.dip0.t-ipconnect.de [84.133.149.126])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6B4D16401AB;
	Wed, 28 Sep 2011 04:00:45 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0.2) Gecko/20110906 Thunderbird/6.0.2
In-Reply-To: <7v39fhyk21.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182299>

Junio C Hamano venit, vidit, dixit 27.09.2011 19:25:
> Michael Witten <mfwitten@gmail.com> writes:
> 
>> It seems like a more logical approach would be instead for "git
>> commit" to take a "--root" option that would create a new root commit
>> based on the current index and then point the current branch head to
>> the new root commit. Thus:
>>
>>   $ git checkout -b new_branch old_branch
>>   $ # Manipulate or not
>>   $ git commit --root
>>
>> That's how people think.
> 
> This may indeed be an improvement. I suspect that we'd need to think about
> it a bit more, but it feels right (perhaps introduce this new option,
> deprecate --orphan from the checkout, and then eventually remove it
> sometime in 1.8.0 timeframe).
> 
>>>>  The index and the working tree are adjusted as if you had previously run
>>>>  "git checkout <start_point>".  This allows you to start a new history
>>>> -that records a set of paths similar to <start_point> by easily running
>>>> +that records a set of paths similar to <start_point> by just running
>>>>  "git commit -a" to make the root commit.
>>>
>>> "similar" is an understatement here, maybe "as in"?
> 
> I do not think "as in" is an improvement. It completely ignores the
> "Manipulate or not" part in the above, and "similar" was very much an

I do not see that part in the above. If you really "just run git commit
-a" after git branch --orphan you get the same tree.

> attempt to say "you do not have to commit it right away, but start from
> the state and commit a deviation of it".
