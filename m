From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFD/PATCH] Documentation: mention category
Date: Wed, 10 Dec 2014 15:45:30 +0100
Message-ID: <54885C8A.1030300@drmicha.warpmail.net>
References: <538d1a10bda3793ea10ec6f7de43de371d17e709.1418123780.git.git@drmicha.warpmail.net> <xmqqiohklgbx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 15:45:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyiWI-0000Mv-Br
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 15:45:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757083AbaLJOpf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 09:45:35 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:60505 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756423AbaLJOpe (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Dec 2014 09:45:34 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 0799320DAC
	for <git@vger.kernel.org>; Wed, 10 Dec 2014 09:45:32 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 10 Dec 2014 09:45:32 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=DOr9WZk3TaMPk2U4Fscsyf
	6+eIY=; b=oUXH4d3dnc6Gh5J7ALSEaLLsp+DgKnre+x0Z90GomCIJlIFjWVU4GN
	Y7QV5NmaRI8GEN1JFu+GLN22zGzHP/o5CyAKdCdT7w/KHFcnOP+w0wvph3Z6IqY4
	V3zkCyZwyRQRi8W+zeRX7l2EjEOwD/1sj4JlfFwR7B6bOCjDhA574=
X-Sasl-enc: HNbYTJoDgI16V7wYtIF6oxxVTMnt1N3l+IHuiAjhHr0W 1418222731
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 6421FC00283;
	Wed, 10 Dec 2014 09:45:31 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <xmqqiohklgbx.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261214>

Junio C Hamano schrieb am 09.12.2014 um 21:26:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Rather than changing git-foo.txt, we could do the substitution magic
>> from Documentation/Makefile, of course, to keep man pages and command-list
>> in sync. Although this would keep me from submitting the final series
>> with 1 patch per file :)
> 
> I do not get that smiley.  Are you saying that these noisy patches
> add to your karma points?

Well, I didn't and I won't send them as 1p/f. Have I ever split my
patches noisilly atomically?

>> diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
>> index 9631526..b6a8bc6 100644
>> --- a/Documentation/git-add.txt
>> +++ b/Documentation/git-add.txt
>> @@ -13,6 +13,10 @@ SYNOPSIS
>>  	  [--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-missing]
>>  	  [--] [<pathspec>...]
>>  
>> +CATEGORY
>> +--------
>> +Main user interface command (porcelain)
>> +
>>  DESCRIPTION
>>  -----------
> 
> While I do not have objection to adding this information, I have
> a few problems with the execution:
> 
>  - These four lines at the very beginning is a precious real
>    estate.  The new reader would not benefit from the distinction
>    before reading the first paragraph of description to learn what
>    it does and what it is for anyway.  Move it much later, perhaps
>    at the end.

Then we can just leave it out.

The aim is to give new(er) users some orientation about which commands
to use and which to stay away from, unless they want to do scripting.
There's no point in putting a stop sign at the end of the road.

This series was triggered by the recent update-index discussion. I think
it showed: Sometimes users get confused by the plumbing man pages who
shouldn't even read them at all (and rather stick with porcelain commands).

>  - A phrase "Main user interface command" to a new user does not
>    help very much if it does not tell enough what that phrase really
>    means (e.g. you should not be using it for scripting).  Extend
>    the description more, after moving it to the end.

I'm all open for different wording, this is just a POC. Even though I
think that it should be okay to use a term like porcelain (defined in
the glossary) the same way as we use other central terms (revision,
object) which we don't spell out in each man page. The point is to give
some direction.

>  - As you said, this should be done in a way to keep the two sources
>    of information in sync.  Either add these from command-list, or
>    generate command-list from these.

Does the categorisation change a lot? My impression is that this is a
one-time business like adding a new command, which causes redundant work
already.

If we really want to automate it, Doc/Makefile would probably need to
translate foo.txt to foo.txt+ and operate on that. I'm not sure
automatisation is worth that effort.

Michael
