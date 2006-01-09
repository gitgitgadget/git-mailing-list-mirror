From: Andreas Ericsson <ae@op5.se>
Subject: Re: git-bisect is magical
Date: Tue, 10 Jan 2006 00:39:14 +0100
Message-ID: <43C2F422.9070209@op5.se>
References: <dpuoqf$3rp$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 00:39:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ew6be-0002ir-Sw
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 00:39:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751636AbWAIXjQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jan 2006 18:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751640AbWAIXjQ
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jan 2006 18:39:16 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:60301 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751636AbWAIXjQ
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 9 Jan 2006 18:39:16 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id E93E96BCBE; Tue, 10 Jan 2006 00:39:14 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: walt <wa1ter@myrealbox.com>
In-Reply-To: <dpuoqf$3rp$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14390>

walt wrote:
> 
> I have one minor suggestion for howto/isolate-bugs-with-bisect.
> Linus states:
>        git bisect good ORIG_HEAD       <- mark ORIG_HEAD as good (or
>                                            whatever other known-good
>                                            thing you booted last)
> 
> Well, in my case, I new the last good kernel was *two* updates ago,
> so ORIG_HEAD wasn't the right thing to use.  I had to guess what
> to type instead of 'ORIG_HEAD'.
> 

It would be neat if resets could optionally be stored as unannotated 
tags as well as ORIG_HEAD, with a date and time in the tag-name.

	git tag reset-$(date '+%F_%H.%M.%S')

works fine for me, although I expect the quibbling about the date-format 
will never stop. I'll get going on it tomorrow unless I get some 
seriously vehement requests not to, or someone beats me to it.

If someone *does* beat me to it, perhaps "git reset --clean-tags" should 
be implemented as well?


> Which leads to one more question:  I have my kernel configured to
> add the -gxxxxxxxx localversion string to the kernel name.  I took
> a wild guess that the xxxxxxxx was the right thing to substitute
> for 'ORIG_HEAD' and I got lucky.  But what about someone who
> doesn't know the magic 'xxxxxxxx' to use? 


I expect you remember the date and approximate time you built it so the 
--tag option should work fairly well there, I'd say. Otherwise, tagging 
the build like you do is a very good idea.


>If I didn't know enough
> to keep a week's worth of daily kernel-builds with the 'xxxxxxxx'
> to guide me, would I still be able to do what I did today?
> (For example, if this had been a 'git' bug instead of a kernel bug,
> I don't think I could have figured out how to use git-bisect to find
> the bug -- could I?)
> 

Most likely not as easily, although it would have been fairly easy to 
mark the most recent tag as a known good build, or Linus' latest tree 
from upstream.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
