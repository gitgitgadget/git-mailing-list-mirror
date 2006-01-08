From: Andreas Ericsson <ae@op5.se>
Subject: Re: How do I apply a single "change"
Date: Sun, 08 Jan 2006 02:19:14 +0100
Message-ID: <43C06892.2030709@op5.se>
References: <20060108005152.46315.qmail@web31813.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 08 02:19:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvPDM-0006ne-Um
	for gcvg-git@gmane.org; Sun, 08 Jan 2006 02:19:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161122AbWAHBTQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 20:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161123AbWAHBTQ
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 20:19:16 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:31362 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1161122AbWAHBTQ
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 7 Jan 2006 20:19:16 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id DD4EA6BCBE; Sun,  8 Jan 2006 02:19:14 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: ltuikov@yahoo.com
In-Reply-To: <20060108005152.46315.qmail@web31813.mail.mud.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14300>

Luben Tuikov wrote:
> --- Junio C Hamano <junkio@cox.net> wrote:
>>
>>$ git-cherry-pick $object_name
> 
> 
> Ok, so git searches the db (other branches, etc) and
> does the job.  This worked for me.
> 
> How will I do this same thing but if the "change" is
> on a remote repository?
> 

You can't. cherry-pick doesn't work on remote repos, so you need to pull 
that branch to a local one first.

> 
>>>Alternatively, how do I apply the absolute output of
>>>"git-format-patch".  I tried but whatever I tried with
>>>complained that it couldn't find any email addressess.
>>>(roll eyes here)
>>
>>It is unclear what you mean by absolute output, but here is what
>>I regularly do:
>>
>>$ git-format-patch -k -m --stdout from to | git am -3 -k
> 
> 
> I did 
> $ git-format-patch commit^ commit
> 
> and the usual 0001-blah-blah file got created.  Then
> I tried to apply it, but whatever I tried it complained.
> Will "git-am -3 -k" work without complaining there is
> no "email field" or something?  (I cannot try it as
> git-cherry-pick worked for me already.)
> 

You need to specify the '--mbox' (or '-m') for git-format-patch, 
otherwise it can't find author-info in the generated patch and it won't 
know who committed what.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
