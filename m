From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 1/6] Fix some "printf format" warnings.
Date: Tue, 13 Mar 2007 22:33:18 +0000
Message-ID: <45F726AE.2080609@ramsay1.demon.co.uk>
References: <45E9BE46.1020801@ramsay1.demon.co.uk> <7v4pp29eok.fsf@assigned-by-dhcp.cox.net> <45EAFD21.6010002@ramsay1.demon.co.uk> <45F55DC5.8060702@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
X-From: git-owner@vger.kernel.org Thu Mar 15 00:02:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRcUB-0002c9-MH
	for gcvg-git@gmane.org; Thu, 15 Mar 2007 00:02:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422746AbXCNXCR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 19:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422749AbXCNXCR
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 19:02:17 -0400
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:3528 "EHLO
	anchor-post-30.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1422746AbXCNXCP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Mar 2007 19:02:15 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-30.mail.demon.net with esmtp (Exim 4.42)
	id 1HRcU1-000E7M-39; Wed, 14 Mar 2007 23:02:14 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <45F55DC5.8060702@fs.ei.tum.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42245>

Simon 'corecode' Schubert wrote:
> Ramsay Jones wrote:
>>>> -        printf("%s%06o %s %d\t",
>>>> +        printf("%s%06lo %s %d\t",
>>>>                 tag,
>>>>                 ntohl(ce->ce_mode), 
>>> I think we should do this instead:
>>>
>>>     printf("%s%06o %s %d\t", tag, (unsigned) ntohl(ce->ce_mode), ...
>> Oops, yes you are right.
>> (cygwin typedef's uint32_t as unsigned long.)
>>
>> However, I would hate to add all those casts! Casts are not always
>> evil, but should be avoided if possible. Having said that, I don't
>> see another solution ...
> 
> shouldn't it be something like this?
> 
> printf("%s%06"PRIo32" %s %d\t", tag, ntohl(ce->ce_mode), ...)
> 
> that's the correct and allegedly portable way I guess.
> 
> cheers
>  simon
> 

Yes, that would work, but again I was trying not to depend on a
C99 header file (namely <inttypes.h>).

I suppose I should just assume that git now requires these C99
headers!

Junio, what do you think about Simon's solution?

ATB,

Ramsay Jones
