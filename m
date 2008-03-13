From: Andreas Ericsson <ae@op5.se>
Subject: Re: I: git-fetch: -n option disappeared but git-fetch(1) still describe
 it
Date: Thu, 13 Mar 2008 07:50:14 +0100
Message-ID: <47D8CEA6.5040301@op5.se>
References: <20080312105102.GE14040@wo.int.altlinux.org> <47D7EE27.50407@op5.se> <alpine.LSU.1.00.0803121703010.1656@racer.site> <47D7FF8E.5040700@op5.se> <alpine.LSU.1.00.0803121710460.1656@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Dmitry V. Levin" <ldv@altlinux.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 13 07:50:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZhHG-0005px-6n
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 07:50:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbYCMGuS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 02:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbYCMGuS
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 02:50:18 -0400
Received: from mail.op5.se ([193.201.96.20]:57065 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750929AbYCMGuR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 02:50:17 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 5825A1F080D0;
	Thu, 13 Mar 2008 07:51:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QptNroOfeU85; Thu, 13 Mar 2008 07:51:20 +0100 (CET)
Received: from clix.int.op5.se (unknown [192.168.1.27])
	by mail.op5.se (Postfix) with ESMTP id 5F70B1F080CF;
	Thu, 13 Mar 2008 07:51:20 +0100 (CET)
User-Agent: Thunderbird 2.0.0.12 (X11/20080226)
In-Reply-To: <alpine.LSU.1.00.0803121710460.1656@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77040>

Johannes Schindelin wrote:
> Hi,
> 
> On Wed, 12 Mar 2008, Andreas Ericsson wrote:
> 
>> Johannes Schindelin wrote:
>>
>>> On Wed, 12 Mar 2008, Andreas Ericsson wrote:
>>>
>>>> Dmitry V. Levin wrote:
>>>>
>>>>> git-fetch builtinification (commit v1.5.3.2-93-gb888d61) 
>>>>> apparently dropped -n option (alias to --no-tags) documented in 
>>>>> Documentation/fetch-options.txt
>>>>>
>>>>> Either builtin-fetch.c or Documentation/fetch-options.txt should 
>>>>> be adjusted to sync the code with its docs.
>>>>>
>>>>> Original bug report: 
>>>>> https://bugzilla.altlinux.org/show_bug.cgi?id=14870
>>>> I have a (very) vague memory that git-fetch.sh had to iterate over 
>>>> tags one by one, making tag-heavy projects excruciatingly slow to 
>>>> fetch from with the shellscript version. Some pathological case with 
>>>> 2700 tags was presented where a fetch took nearly an hour, iirc. 
>>>> AFAIR, the builtinification (or was it a protocol extension?) 
>>>> reduced that time to something around 10 seconds for the 
>>>> pathological case.
>>> AFAIR this was helped by the fetch--tool helper, even at the time of 
>>> non-builtin fetch.
>>>
>>>> Does anyone else have a sharper memory of what caused the -n option 
>>>> to be dropped?
>>> AFAICT this was done because of the parsopt'ification.  But I forgot 
>>> the details.
>>>
>> I had a look at the code. It seems the new way of specifying -n is to 
>> say --no-tags or -t 0, or --tags=0 (although I'm not well-versed enough 
>> in the parseopt thing to be sure). I have no time now, but I'll take a 
>> stab at adding the -n option back tomorrow if nobody beats me to it.
> 
> Maybe like this (completely untested, that will be your task tomorrow):
> 

Looks like how I thought it should be. Test passed fine, both real and
automated. Proper patch incoming in a minute.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
