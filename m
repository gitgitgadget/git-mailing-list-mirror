From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 0/6] grep with textconv
Date: Sat, 20 Apr 2013 15:32:04 +0200
Message-ID: <517298D4.3030802@drmicha.warpmail.net>
References: <cover.1366389739.git.git@drmicha.warpmail.net> <7vhaj21ir3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 20 16:55:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTZCk-00022x-L9
	for gcvg-git-2@plane.gmane.org; Sat, 20 Apr 2013 16:55:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755379Ab3DTOzo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Apr 2013 10:55:44 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:36413 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755320Ab3DTOze (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Apr 2013 10:55:34 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id C68522082C;
	Sat, 20 Apr 2013 10:44:21 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute5.internal (MEProxy); Sat, 20 Apr 2013 10:44:21 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=D0C6Yi0T5vL+W4ZYF9tikR
	82i1M=; b=GhmPRZNX3RJ7FM3HkcY5Ks4s4c4AufCeZGQV7GWbnDU9dWv1M1YunD
	/4Az1SurJWzjTECj9v8aYU2F83DgIYIXWbzu2Bnsr7dSAYOUAap5UuLzpGychcOq
	mbYdIA0rBrMWfyiOpt72hRjjlohkun12XTdueUIo1ZVdq7DJADvhQ=
X-Sasl-enc: nzGOPgyUdmpqlQgXutL6bFYeYQ04UTK+8u4JU42L2WAl 1366469061
Received: from localhost.localdomain (unknown [88.70.147.219])
	by mail.messagingengine.com (Postfix) with ESMTPA id 0E3CAC80004;
	Sat, 20 Apr 2013 10:44:20 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130402 Thunderbird/17.0.5
In-Reply-To: <7vhaj21ir3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221859>

Junio C Hamano venit, vidit, dixit 19.04.2013 20:24:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> This series teaches show and grep to obey textconv: show by
>> default (like diff), grep only on request (--textconv).  We might
>> switch the default for the latter also, of course.  I'd actually
>> like that.
>>
>> Compared to an earlier (historic) series this one comes with tests.
> 
> It would have been nicer if you referred to the previous thread
> 
> cf.
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/215385

Yes, sorry, I was on a slow mobile connection due to DSL breakage...

>>   grep: allow to use textconv filters
> 
> This looked mostly sensible except for one minor "eh, do we really
> need to assume textconv output is text, or wouldn't using the same
> codepath for raw blob and textconv result to make them consistently
> honor opt->binary easier to explain?".
>

I think we assume in general that textconv produces text, which is maybe
not completely surprising given its name ;)

>>   t4030: demonstrate behavior of show with textconv
>>   t7008: demonstrate behavior of grep with textconv
> 
> It somehow felt they are better together in the patches that
> implement the features they exercise.

I added them after the fact. They can be squashed in, of course. On the
other hand you don't see the change in behavior that the latter patches
introduce any more if you that; which is why I left them separate at
least for review purposes and for camparing to the previous series which
I had failed to reference.

>>   show: obey --textconv for blobs
>>   cat-file: do not die on --textconv without textconv filters
>>   grep: obey --textconv for the case rev:path
> 
> I just let my eyes coast over these but didn't see anything
> obviously wrong.
> 
> By the way, "git log --no-merges | grep obey | wc -l" shows that we
> say "honor an option" a lot more than "obey an option".  We may want
> to be consistent here.

Okay, let's be honorable rather than obedient.

Michael
