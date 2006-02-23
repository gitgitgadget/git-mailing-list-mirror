From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] fmt-merge-msg: avoid open "-|" list form for Perl 5.6
Date: Thu, 23 Feb 2006 10:48:27 +0100
Message-ID: <43FD84EB.3040704@op5.se>
References: <Pine.LNX.4.63.0602201934270.28957@wbgn013.biozentrum.uni-wuerzburg.de>	 <81b0412b0602210930w5c1a71aage12bad2079dd515a@mail.gmail.com>	 <43FB79E2.1040307@vilain.net> <20060221215742.GA5948@steel.home>	 <43FB9656.8050308@vilain.net>	 <81b0412b0602220835p4c4243edm145ee827eb706121@mail.gmail.com>	 <Pine.LNX.4.63.0602222259480.6682@wbgn013.biozentrum.uni-wuerzburg.de>	 <81b0412b0602230000t58a88af6na1aa7e323dc0179d@mail.gmail.com>	 <7vwtfmihts.fsf@assigned-by-dhcp.cox.net>	 <81b0412b0602230135w472aa6f3v72980f6f63bb355f@mail.gmail.com> <81b0412b0602230141g46dbfaev6baa5083dee2d42@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 23 10:48:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCD5U-0007xm-Ro
	for gcvg-git@gmane.org; Thu, 23 Feb 2006 10:48:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751685AbWBWJsb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Feb 2006 04:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751686AbWBWJsb
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Feb 2006 04:48:31 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:28396 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751680AbWBWJsb
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2006 04:48:31 -0500
Received: from [192.168.1.20] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id EE7C26BCBE; Thu, 23 Feb 2006 10:48:27 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0602230141g46dbfaev6baa5083dee2d42@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16637>

Alex Riesen wrote:
> On 2/23/06, Alex Riesen <raa.lkml@gmail.com> wrote:
> 
>>On 2/23/06, Junio C Hamano <junkio@cox.net> wrote:
>>
>>>"Alex Riesen" <raa.lkml@gmail.com> writes:
>>>
>>>
>>>>I'll keep that in mind. But there are places where a safe pipe is unavoidable
>>>>(filenames. No amount of careful quoting will save you).
>>>
>>>Huh?
>>
>>Because you never know what did the next interpreter took for unquoting:
>>$SHELL, /bin/sh cmd /c, or something else.
>>
> 
> And that stupid activestate thing actually doesn't use any. Just tried:
> 
>   perl -e '$,=" ";open(F, "sleep 1000 ; # @ARGV |") and print <F>'
> 
> It passed the whole string "1000 ; # @ARGV" to sleep from $PATH.
> It failed to sleep at all, of course. The same code works perfectly on
> almost any UNIX system.


Not to be unhelpful or anything, but activestate perl seems to be quite 
a lot of bother. Is it worth supporting it?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
