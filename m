From: Charles Duffy <cduffy@spamcop.net>
Subject: Re: VCS comparison table
Date: Thu, 19 Oct 2006 06:10:14 -0500
Message-ID: <45375D16.90204@spamcop.net>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <45349162.90001@op5.se> <453536AE.6060601@utoronto.ca> <200610172301.27101.jnareb@gmail.com> <45354AD0.1020107@utoronto.ca> <BAYC1-PASMTP07AB11A64250AAF683424DAE0E0@CEZ.ICE> <45355CBB.80108@utoronto.ca> <BAYC1-PASMTP01369CD694D75CB61ACCC7AE0E0@CEZ.ICE> <eh64tk$rug$2@sea.gmane.org> <BAYC1-PASMTP069C473B2E79389E5BFC92AE0F0@CEZ.ICE> <eh6dgr$pu8$1@sea.gmane.org> <Pine.LNX.4.63.0610190144450.14200@wbgn013.biozentrum.uni-wuerzburg.de> <4536DBB1.6050701@spamcop.net> <Pine.LNX.4.63.0610191250400.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 19 13:10:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaVnJ-0001aR-07
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 13:10:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423272AbWJSLKe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 07:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423268AbWJSLKe
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 07:10:34 -0400
Received: from smtp.isgenesis.com ([204.57.75.199]:12520 "EHLO isgenesis.com")
	by vger.kernel.org with ESMTP id S1423080AbWJSLKd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Oct 2006 07:10:33 -0400
Received: from [69.91.92.72] (account ccd HELO [192.168.1.10])
  by isgenesis.com (CommuniGate Pro SMTP 5.0.4)
  with ESMTPSA id 1296620; Thu, 19 Oct 2006 06:10:31 -0500
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0610191250400.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29338>

Johannes Schindelin wrote:
>> I presume that for this reason you will also never, _never_ use a 
>> non-mainline branch of git -- even if its actual code only touches UI 
>> enhancements or something similarly non-core
>>     
>
> NO! The point was that I will not gladly run anything which could change 
> the core. If I know it touches only the UI, there is no problem.
>   

If you're willing to look at the source of a branch to know that it 
touches only the UI, why would you not be willing to look at the source 
of a plugin to do the same thing?

> If I get a shell script using git-core programs to do its job, I 
> _know_ that my repository will not be fscked afterwards.
>
> And _that_ was the whole point of my email.
>   

It's a silly point. If you're willing to look at what your shell script 
does and validate that it doesn't do LD_PRELOAD tricks or swap out git 
core pieces, why wouldn't you be willing to accept a plugin after a 
similar level of review, rather than stating outright that you would 
*never* use them?

>> The claim that an extensibility mechanism should be rejected wholesale 
>> on account of being excessively powerful, on the other hand, is just 
>> silly.
>>     
>
> Oh, but NO! An extensibility mechanism which allows for a fragile system 
> _is_ silly. Not my rejection of it.
>   

Shell scripts allow for a fragile system because they could include C 
code snippets which they then compile and LD_PRELOAD. Sure, they "allow 
for" a fragile system -- but the author has to go out of their way to 
make it so. Similarly, folks writing bzr plugins need to take explicit 
actions to monkeypatch existing code (as opposed to adding a new 
transport/storage format/command/etc but leaving the old ones alone).

If you trust the author of your shell script not to build their own 
LD_PRELOAD at runtime, why don't you trust the author of your bzr plugin 
not to monkeypatch in replacements to core code if they say they aren't?
