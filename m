From: Andreas Ericsson <ae@op5.se>
Subject: Re: git-status too verbose?
Date: Tue, 07 Mar 2006 11:22:55 +0100
Message-ID: <440D5EFF.6050300@op5.se>
References: <38b80e980603040952j15152a21h2c903bd011d7e905@mail.gmail.com>	<7vacc36r4v.fsf@assigned-by-dhcp.cox.net> <440D503E.8090007@op5.se> <7v3bhumvt6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Eric Jaffe <jaffe.eric@gmail.com>, Carl Worth <cworth@cworth.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 07 11:23:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGZLK-0000d3-OH
	for gcvg-git@gmane.org; Tue, 07 Mar 2006 11:23:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752025AbWCGKW6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Mar 2006 05:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752123AbWCGKW6
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Mar 2006 05:22:58 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:24503 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1752025AbWCGKW5
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Mar 2006 05:22:57 -0500
Received: from [192.168.1.20] (unknown [192.168.1.20])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id EEC546BD01; Tue,  7 Mar 2006 11:22:55 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3bhumvt6.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17330>

Junio C Hamano wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
> 
>>>I agree that it would be useful if we had a tool that showed the
>>>two status that matter for each file, grouped together on one
>>>line, e.g.
>>>			HEAD->index	index->files
>>>	------------------------------------------------
>>>	hello.c		unmodified      modified
>>>        world.c		modified	unmodified
>>>	frotz.c		new		unmodified
>>>        ...
>>>	garbage.c~	???		n/a
>>>for the current index file and the current HEAD commit.
>>
>>Could we have 'same' or some such instead of 'unmodified'? It's a bit
>>close to 'modified' for the eye to find it quickly.
>>
>>
>>>You obviously need to learn how to read it though.  The first
>>>column means what you _would_ commit if you just said "git
>>>commit" without doing anything else now; the second column is
>>>what you _could_ commit if you did some update-index and then
>>>said "git commit" (or ran "git commit" with paths arguments).
>>
>>Pretty-printing will be easier if the filename is last, and it will
>>look a lot neater if all columns are aligned.
> 
> 
> Somebody who feels strongly about this can propose a design.
> Although I am not particularly fond of the current output, I am
> not volunteering ;-).
> 
> It would be nicer if the proposal was accompanied by a patch,
> but that is not a requirement for discussion.
> 

I'll see if I can get around to it tonight.

> The points that design would address should include:
> 
>    - what to do _if_ we choose to do rename detection?  you need
>      two pathnames.

I like the gitk view of these things, "renamed from" and "renamed to", 
although we'll likely want shorter names since the filename part can't 
start before column max_label_name * 2 + 4 if we assume two spaces 
minimum between word-columns. Perhaps mv-to and mv-from?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
