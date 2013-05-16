From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] branch: add show-tracking option
Date: Thu, 16 May 2013 10:40:37 +0200
Message-ID: <51949B85.40600@drmicha.warpmail.net>
References: <1368690532-12093-1-git-send-email-felipe.contreras@gmail.com> <5194921F.4080103@drmicha.warpmail.net> <CACsJy8CrGTa2XdfFkkKDQQjF8gM3011RiUE6roe9L7yZZq5J2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 10:40:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uctjr-0001un-8I
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 10:40:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756152Ab3EPIke (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 04:40:34 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:42419 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756117Ab3EPIka (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 May 2013 04:40:30 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 2DD0920889;
	Thu, 16 May 2013 04:40:28 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute3.internal (MEProxy); Thu, 16 May 2013 04:40:29 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=U4fIPgZdk06DDBaciVDf7v
	3xBfY=; b=hcIEIzm7UzZmn/FPJzxO61MowGMfreo+BAKrfNW1kWbG9vCKU2buyf
	+8wPB5jPiSZqykvQNGbSbb+5s9muyjz+xpotXH2tlwUGh4Ln5ubJ6LrxcnfKO4XO
	FE9asamfnqj4hmzmBt2d46YDf2neYd737Torr10v6N3LhNzm9YaTI=
X-Sasl-enc: szhbHpXRYoYpqcG52H/M/1VJNPmZaCFKFkHkWrXCMR9T 1368693628
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 39BC6C80005;
	Thu, 16 May 2013 04:40:28 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130402 Thunderbird/17.0.5
In-Reply-To: <CACsJy8CrGTa2XdfFkkKDQQjF8gM3011RiUE6roe9L7yZZq5J2g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224510>

Duy Nguyen venit, vidit, dixit 16.05.2013 10:23:
> On Thu, May 16, 2013 at 3:00 PM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> I feel, though, that we're really exploding our option and config realm.
>> For "git branch" in list mode, we are already able to stack "-v", i.e.
>> "-v" and "-vv" do different things. How about maybe adding "-vvv" and
>> arranging things so that the verbosity and the run time increases with
>> the number of v's?
>>
>> -v list with sha1 + subject of last commit
>> -vv add upstream branch name
>> -vvv add ahead/behind info (the only costly mode)
>> -vvvv same with "--cherry" (ahead/behind/same)
>>
>> Or maybe combine the middle two cases into "-vv", which means it would
>> be the same as "-vv", with only "-v" changing what it does now.
> 
> What if I want something in -vvvv except some in -vv? I think to avoid
> option explosion, maybe we can adopt --pretty=format:xxx from "git
> log" and let the user decideswhat (and how) to display. "pretty" code
> learns about alignment already, which may be useful here.
> --
> Duy

Sure, that is the big solution we've been talking about. Unify
for-each-ref formats and log formats and use that. After all, "git
branch" in list mode really is for-each-ref, and should be transparently
so; same goes for "git tag". Think "git rev-list" and "git ref-list"!

But I guess we'll be compabeaten ;)

Michael
