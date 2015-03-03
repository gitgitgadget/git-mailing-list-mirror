From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Interested in helping open source friends on HP-UX?
Date: Tue, 03 Mar 2015 17:05:53 +0100
Message-ID: <54F5DBE1.6080004@drmicha.warpmail.net>
References: <xmqq4mt2fx2m.fsf@gitster.dls.corp.google.com>	<20150218170007.784be6aa@pc09.procura.nl>	<54E4CFDC.40401@drmicha.warpmail.net>	<20150218182547.GA6346@peff.net>	<xmqqpp972h1n.fsf@gitster.dls.corp.google.com>	<20150218185734.GB7257@peff.net>	<54E5BBDD.7040100@drmicha.warpmail.net>	<20150219121438.59050ce8@pc09.procura.nl>	<54E5C6E2.9040101@drmicha.warpmail.net>	<20150219125433.GA1591@peff.net>	<54E5E347.4070401@drmicha.warpmail.net>	<20150219195622.2828cc6a@pc09.procura.nl>	<54F5CB74.2090403@drmicha.warpmail.net> <20150303163042.655fe00c@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Tue Mar 03 17:06:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSpKa-0003Lp-2H
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 17:06:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756884AbbCCQF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 11:05:56 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:49186 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756422AbbCCQFz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2015 11:05:55 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id C795E20BD9
	for <git@vger.kernel.org>; Tue,  3 Mar 2015 11:05:53 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Tue, 03 Mar 2015 11:05:54 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=7rOPI7Jzvz3aGac1w1bGu9
	MdUbo=; b=j5gYn6OoEmCGip7bmT9lKKDk3Hn/dCbRy7FT3cur8XO6id5i8K5eHd
	6SWmXFMtNsm7F1ph8sRVjaHODjRfX48y4rycqpT7JGIoHbED/iaLy8ZAXvCh6hQ5
	Pd1ogUyHyF3kpznTm1p+smuitl2osnHj0brUcgF2PJOM3CWcj+bfc=
X-Sasl-enc: K76cYCzf0Ug8XIFO72Fy9D7CSpnKfUplzn3uKUl3yatO 1425398754
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 211D3C0028C;
	Tue,  3 Mar 2015 11:05:54 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <20150303163042.655fe00c@pc09.procura.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264667>

H.Merijn Brand venit, vidit, dixit 03.03.2015 16:30:
> On Tue, 03 Mar 2015 15:55:48 +0100, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
> 
>> H.Merijn Brand venit, vidit, dixit 19.02.2015 19:56:
>>> On Thu, 19 Feb 2015 14:21:11 +0100, Michael J Gruber
>>> <git@drmicha.warpmail.net> wrote:
>>>
>>>> Jeff, you got it wrong. You should do the hard part and leave the easy
>>>> part to us!
>>>>
>>>> Thanks anyways, I'll add this to my HP_UX branch.
>>>
>>> I did not mention this in earlier mails. When using the HP C-ANSI-C
>>> compiler, MAX_INT is not set.
>>>
>>> I had to add
>>> --8<---
>>> #ifndef   SIZE_MAX
>>> #  define SIZE_MAX              (18446744073709551615UL)
>>> /* define SIZE_MAX              (4294967295U) */
>>> #  endif
>>> -->8---
>>>
>>> to these files
>>>
>>> sha1_file.c
>>> utf8.c
>>> walker.c
>>> wrapper.c
>>>
>>> And yes, that could be dynamic and probably be in another header file
>>>
>>
>> In compat/regex/regex_internal.h we have
>>
>> /* For loser systems without the definition.  */
>> #ifndef SIZE_MAX
>> # define SIZE_MAX ((size_t) -1)
>> #endif
>>
>> Does this work in your environment?
> 
> I think it does:
> 
> make
>     CC sha1_file.o
>     CC utf8.o
>     CC walker.o
> "walker.c", line 119: warning #4232-D: conversion from "struct object *" to a
>           more strictly aligned type "struct commit *" may cause misaligned
>           access
>                 if (process_commit(walker, (struct commit *)obj))
>                                            ^
> 
> "walker.c", line 124: warning #4232-D: conversion from "struct object *" to a
>           more strictly aligned type "struct tree *" may cause misaligned
>           access
>                 if (process_tree(walker, (struct tree *)obj))
>                                          ^
> 
> "walker.c", line 132: warning #4232-D: conversion from "struct object *" to a
>           more strictly aligned type "struct tag *" may cause misaligned access
>                 if (process_tag(walker, (struct tag *)obj))
>                                         ^
> 
>     CC wrapper.o
>     AR libgit.a
> 
> 

Hmmh. Did you get these same warnings with the fix you had before? They
don't make feel that confident...

>> [Trying to not let this fall into oblivion...]
> 
> Much appreciated!
> 
>> Michael
> 
> 
