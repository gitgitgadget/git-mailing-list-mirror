From: "Tom G. Christensen" <tgc@statsbiblioteket.dk>
Subject: Re: [PATCH] Makefile: Handle broken curl version number in version
 check
Date: Fri, 30 Jan 2015 16:34:47 +0100
Message-ID: <54CBA497.7040804@statsbiblioteket.dk>
References: <54CA2E84.6090604@statsbiblioteket.dk>	<1422611554-15393-1-git-send-email-tgc@statsbiblioteket.dk> <87wq44gw4y.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Fri Jan 30 16:34:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YHDax-0003D7-IF
	for gcvg-git-2@plane.gmane.org; Fri, 30 Jan 2015 16:34:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753467AbbA3Pev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2015 10:34:51 -0500
Received: from sbexch03.sb.statsbiblioteket.dk ([130.225.24.68]:2373 "EHLO
	sbexch03.sb.statsbiblioteket.dk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751042AbbA3Pev (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jan 2015 10:34:51 -0500
Received: from [172.18.234.199] (172.18.234.199) by
 sbexch03.sb.statsbiblioteket.dk (130.225.24.68) with Microsoft SMTP Server id
 8.3.389.2; Fri, 30 Jan 2015 16:34:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.8.0
In-Reply-To: <87wq44gw4y.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263179>

On 30/01/15 15:50, Andreas Schwab wrote:
> "Tom G. Christensen" <tgc@statsbiblioteket.dk> writes:
>
>> diff --git a/Makefile b/Makefile
>> index c44eb3a..69a2ce3 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1035,13 +1035,13 @@ else
>>   	REMOTE_CURL_NAMES = $(REMOTE_CURL_PRIMARY) $(REMOTE_CURL_ALIASES)
>>   	PROGRAM_OBJS += http-fetch.o
>>   	PROGRAMS += $(REMOTE_CURL_NAMES)
>> -	curl_check := $(shell (echo 070908; curl-config --vernum) 2>/dev/null | sort -r | sed -ne 2p)
>> +	curl_check := $(shell (echo 070908; curl-config --vernum | sed -e '/^70[B-C]/ s/^7/07/') 2>/dev/null | sort -r | sed -ne 2p)
>
> How about 's/^.....$/0&/' ?
>

I have no preference so whatever is the most likely to be accepted and 
does the job is fine with me.

-tgc
