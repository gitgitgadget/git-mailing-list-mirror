From: Andreas Ericsson <ae@op5.se>
Subject: Re: Buffer overflows
Date: Fri, 31 Aug 2007 11:53:22 +0200
Message-ID: <46D7E512.2010905@op5.se>
References: <1188502009.29782.874.camel@hurina>	 <alpine.LFD.0.999.0708301340470.25853@woody.linux-foundation.org>	 <7D84F3C7-129D-4197-AAF1-46298E5D0136@iki.fi>	 <alpine.LFD.0.999.0708302050170.25853@woody.linux-foundation.org> <1188536430.29782.903.camel@hurina>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Timo Sirainen <tss@iki.fi>
X-From: git-owner@vger.kernel.org Fri Aug 31 11:53:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR3By-0007MS-Ey
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 11:53:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbXHaJxZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 05:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbXHaJxY
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 05:53:24 -0400
Received: from mail.op5.se ([193.201.96.20]:51416 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755497AbXHaJxY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 05:53:24 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 945DC194421;
	Fri, 31 Aug 2007 11:53:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3kmbtgzSSdyZ; Fri, 31 Aug 2007 11:53:22 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.178])
	by mail.op5.se (Postfix) with ESMTP id 262C51943C5;
	Fri, 31 Aug 2007 11:53:22 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <1188536430.29782.903.camel@hurina>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57144>

Timo Sirainen wrote:
> On Thu, 2007-08-30 at 21:09 -0700, Linus Torvalds wrote:
>> On Fri, 31 Aug 2007, Timo Sirainen wrote:
>>>> Perhaps because your patch was using a totally nonstandard and slow
>>>> interface, and had nasty string declaration issues, as people even pointed
>>>> out to you.
>>> Slow?
>> Having a string library, and then implementing "str_append()" with a 
>> strlen() sounds pretty disgusting to me. 
>>
>> Gcc could have optimized the strlen() away for constant string arguments, 
>> but since you made the thing out-of-line, it can't do that any more.
>>
>> So yes, I bet there are faster string libraries out there.
> 
> Oh, well that's easy to fix. But I don't think the speed matters much in
> string manipulation, it's usually not done in performance critical
> paths.
> 

In git it is, as strings are manipulated en masse in order to traverse
history, look up paths from index/filesystem etc, etc.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
