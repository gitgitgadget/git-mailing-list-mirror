From: Andreas Ericsson <ae@op5.se>
Subject: Re: I: git-fetch: -n option disappeared but git-fetch(1) still describe
 it
Date: Wed, 12 Mar 2008 17:06:38 +0100
Message-ID: <47D7FF8E.5040700@op5.se>
References: <20080312105102.GE14040@wo.int.altlinux.org> <47D7EE27.50407@op5.se> <alpine.LSU.1.00.0803121703010.1656@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Dmitry V. Levin" <ldv@altlinux.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 12 17:08:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZTU8-00086r-KK
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 17:07:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbYCLQGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 12:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbYCLQGm
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 12:06:42 -0400
Received: from mail.op5.se ([193.201.96.20]:39007 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751124AbYCLQGl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 12:06:41 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id C776D1F080AB;
	Wed, 12 Mar 2008 17:07:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LEWgSNq29qaH; Wed, 12 Mar 2008 17:07:41 +0100 (CET)
Received: from clix.int.op5.se (unknown [192.168.1.27])
	by mail.op5.se (Postfix) with ESMTP id E4B371F08048;
	Wed, 12 Mar 2008 17:07:40 +0100 (CET)
User-Agent: Thunderbird 2.0.0.12 (X11/20080226)
In-Reply-To: <alpine.LSU.1.00.0803121703010.1656@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76963>

Johannes Schindelin wrote:
> Hi,
> 
> On Wed, 12 Mar 2008, Andreas Ericsson wrote:
> 
>> Dmitry V. Levin wrote:
>>
>>> git-fetch builtinification (commit v1.5.3.2-93-gb888d61) apparently 
>>> dropped -n option (alias to --no-tags) documented in 
>>> Documentation/fetch-options.txt
>>>
>>> Either builtin-fetch.c or Documentation/fetch-options.txt should be 
>>> adjusted to sync the code with its docs.
>>>
>>> Original bug report: 
>>> https://bugzilla.altlinux.org/show_bug.cgi?id=14870
>> I have a (very) vague memory that git-fetch.sh had to iterate over tags 
>> one by one, making tag-heavy projects excruciatingly slow to fetch from 
>> with the shellscript version. Some pathological case with 2700 tags was 
>> presented where a fetch took nearly an hour, iirc. AFAIR, the 
>> builtinification (or was it a protocol extension?) reduced that time to 
>> something around 10 seconds for the pathological case.
> 
> AFAIR this was helped by the fetch--tool helper, even at the time of 
> non-builtin fetch.
> 
>> Does anyone else have a sharper memory of what caused the -n option to 
>> be dropped?
> 
> AFAICT this was done because of the parsopt'ification.  But I forgot the 
> details.
> 

I had a look at the code. It seems the new way of specifying -n is
to say --no-tags or -t 0, or --tags=0 (although I'm not well-versed
enough in the parseopt thing to be sure). I have no time now, but I'll
take a stab at adding the -n option back tomorrow if nobody beats me
to it.


-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
