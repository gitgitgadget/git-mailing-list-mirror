From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] sequencer: preserve commit messages
Date: Wed, 25 Feb 2015 10:50:47 +0100
Message-ID: <54ED9AF7.6080908@drmicha.warpmail.net>
References: <1424540906.15539.22.camel@scientia.net>	<f58ae048d7fd468cfdd7f7d369b3b4fc0a564641.1424697676.git.git@drmicha.warpmail.net>	<xmqqsidwtq4i.fsf@gitster.dls.corp.google.com>	<54EC98BD.7060100@drmicha.warpmail.net> <xmqq8ufnrwm1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Christoph Anton Mitterer <calestyo@scientia.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 10:51:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQYcR-00008j-Rn
	for gcvg-git-2@plane.gmane.org; Wed, 25 Feb 2015 10:51:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753082AbbBYJux (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2015 04:50:53 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:42101 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752755AbbBYJuu (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Feb 2015 04:50:50 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 9A5A4209BB
	for <git@vger.kernel.org>; Wed, 25 Feb 2015 04:50:49 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 25 Feb 2015 04:50:50 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=ccUh0uKPyFZOV9TQpMxnSa
	e6dEQ=; b=L1oK7JLoM2pROi40ErXcEr59stK3KfjAjEwgDcOGgtN6dNmQOJf6pZ
	6fkYo2PtTK7ycqHHlNSZv9ODC3/fMZqC/AL6zlbYEb84FuCzlKf0W4v4vAbamfVX
	uO9alyqOQEbAUggwtJrtJEI1CJNBgYAlSnrr2Qye5aFU1LId24gKU=
X-Sasl-enc: H12tmmGqNi/tgFIyrYrlhkTOpGjq3WHyfkkWwtFjtYAw 1424857850
Received: from localhost.localdomain (unknown [188.96.93.179])
	by mail.messagingengine.com (Postfix) with ESMTPA id C5732C002A3;
	Wed, 25 Feb 2015 04:50:49 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <xmqq8ufnrwm1.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264375>

Junio C Hamano venit, vidit, dixit 24.02.2015 19:29:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>>> Hmm, wouldn't it introduce a grave regression for users who
>>> explicitly ask to clean crufty messages up (by setting their own
>>> commit.cleanup configuration) if you unconditionally force
>>> "--cleanup=verbatim" here?
>>>
>>
>> That's what I meant by possible side-effects below.
>> ...
>> But git cherry-pick without conflict should no re-cleanup the commit
>> message either, should it?
> 
> Hmm, but if it does not, wouldn't that countermand the wish of the
> user who explicitly asked to clean crufty messages up by setting
> their own commit.cleanup configuration?
> 

Note that "verbatim" is not the default - we cleanup commits even
without being asked to. And this makes sense for "git commit", of course.

I myself certainly expected "git cherry-pick" to transfer a commit as
verbatim as possible. "git rebase" preserves the commit message (at
least more than cherry-pick). What's the difference between them?
Technically the difference between commit-tree and commit, sure, but for
the user?

Michael
