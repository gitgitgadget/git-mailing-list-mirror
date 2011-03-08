From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: how to list commits on branch since last merge
Date: Tue, 08 Mar 2011 10:48:43 +0100
Message-ID: <4D75FB7B.70403@drmicha.warpmail.net>
References: <AANLkTi=zW9hOhnddw6HsjQwV2qLf_R_qeNna+XeN6U6x@mail.gmail.com> <4D75ED72.8030203@drmicha.warpmail.net> <AANLkTinOEutM92k4SUGEXbfTpzGcQitpW4CZbcQbg0R4@mail.gmail.com> <AANLkTikK8Uc8=wKROYWWxZ_6OtQtqBmFCZN760M1LO+c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 10:52:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwtaT-0006uC-0H
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 10:52:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752235Ab1CHJwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 04:52:12 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:55641 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750726Ab1CHJwK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Mar 2011 04:52:10 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id EE9DD206B3;
	Tue,  8 Mar 2011 04:52:09 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Tue, 08 Mar 2011 04:52:09 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=WybBRcrdOBFweWwjNM2U4X95/mE=; b=kL1kkN0iMZW9T63BjdSRuBUo2kQW0mM1tqp1duFdj6dOs79e4uRqqI7CKsVAaRfmRnnnZ8rILrJxAWNs3vFllvhFXA4UvITxPjx0yXYCG0/h2FdRs+gsF9OZE32l0YGJzkLH2S9xW8AJBEUzndjkLJ3pCyumSUOmB2PQCUZjsPI=
X-Sasl-enc: oFz0ORoTbYt1ZI6IjoX2Wv6Umpg6zwdoy8PmT8EOhpXD 1299577929
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 7C1694404B0;
	Tue,  8 Mar 2011 04:52:09 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.14) Gecko/20110301 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.8
In-Reply-To: <AANLkTikK8Uc8=wKROYWWxZ_6OtQtqBmFCZN760M1LO+c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168652>

Jay Soffian venit, vidit, dixit 08.03.2011 10:43:
> On Tue, Mar 8, 2011 at 4:35 AM, Jay Soffian <jaysoffian@gmail.com> wrote:
>> On Tue, Mar 8, 2011 at 3:48 AM, Michael J Gruber
>> <git@drmicha.warpmail.net> wrote:
>>> Have you tried:
>>>
>>> git rev-list --ancestry-path --left-right foo...bar
>>>
>>> If the ">" commits are the ones that you want you only have to wait for
>>> the "--right-only" option which is cooking in pu. And grep '^>' for now ;)
>>
>> Ah. The rev-list man page entry on --ancestry-path only talks about
>> using it with '..', so I didn't even try it with the symmetric diff
>> operator ('...').
> 
> And with the clue to use '...', it's easy:
> 
>   $ git log --ancestry-path foo...bar ^foo
> 
> Still want an easy way for merge-base to report the merge which
> contains the merge-base. That will wait for another day.

You mean shorter than:

git rev-list --merges -1 $(git merge-base foo bar)

Or maybe I'm misunderstanding "contain".

Michael
