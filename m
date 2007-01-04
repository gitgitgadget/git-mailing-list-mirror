From: Andreas Ericsson <ae@op5.se>
Subject: Re: Possible regression in git-rev-list --header
Date: Thu, 04 Jan 2007 16:21:04 +0100
Message-ID: <459D1B60.1050604@op5.se>
References: <e5bfff550612300956mef4691fqf607fad173c571da@mail.gmail.com>	 <Pine.LNX.4.63.0612310211300.25709@wbgn013.biozentrum.uni-wuerzburg.de>	 <7v64bsj0s4.fsf@assigned-by-dhcp.cox.net>	 <e5bfff550612310345j4c882b7av51879ca1175a1c6b@mail.gmail.com>	 <Pine.LNX.4.63.0612311613180.22628@wbgn013.biozentrum.uni-wuerzburg.de>	 <e5bfff550612310743t4ca1b017ubceddffafd06ac59@mail.gmail.com>	 <7vodpja0u8.fsf@assigned-by-dhcp.cox.net>	 <e5bfff550701030121n700fab25x63278457c884a3f7@mail.gmail.com>	 <8c5c35580701030221w5c04e2eaq757d12c4ca0b0780@mail.gmail.com>	 <e5bfff550701030235g6f26044h8dd73e8abe1ec9e3@mail.gmail.com> <8c5c35580701030314t69b6a7dbhf9cb99de4567b93e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Marco Costalba <mcostalba@gmail.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 04 16:21:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2UP1-0003Uq-51
	for gcvg-git@gmane.org; Thu, 04 Jan 2007 16:21:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964902AbXADPVH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Jan 2007 10:21:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964903AbXADPVH
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jan 2007 10:21:07 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:54613 "EHLO
	smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964902AbXADPVG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jan 2007 10:21:06 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id D0DF26BCC2; Thu,  4 Jan 2007 16:21:04 +0100 (CET)
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
To: Lars Hjemli <hjemli@gmail.com>
In-Reply-To: <8c5c35580701030314t69b6a7dbhf9cb99de4567b93e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35933>

Lars Hjemli wrote:
> On 1/3/07, Marco Costalba <mcostalba@gmail.com> wrote:
>> On 1/3/07, Lars Hjemli <hjemli@gmail.com> wrote:
>> > On 1/3/07, Marco Costalba <mcostalba@gmail.com> wrote:
>> > >         - one blank line
>> > >         - zero or one line with log title
>> > >         - zero or more lines with log message
>> > >         - a terminating '\0'
>> >
>> > I think the should be:
>> >   -zero or more blank lines
>>
>> Isn't it zero or _one_ blank line? Why more then one? would be it
>> useful? surely is slower to parse.
> 
> My point is just that the log message is unformatted. There is nothing
> stopping you from
> adding blank lines at the start of the message.
> 
> But then I tested it, and it seems as 'git-commit' strips off any
> leading blank lines (but git-commit-tree does not). So expecting one
> blank _might_ be good enough.
> 

Other scm's from which we can import repositories have no such 
mechanisms though. It would be nice to have this functionality in 
rev-list. I'm looking into it at the moment.

> 
>>
>> >   -zero or more blank lines
>>
>> Why? this is necessary only to disambiguate muti (non blank) lines
>> titles, but as Junio pointed out distinction between log title and log
>> message is only in the Porcelain, not encoded in git. So the Porcalain
>> is going to show _one_line title if any an the remaining stuff in the
>> log message.
> 
> Well, if the porcelain chooses to do so, it probably is ok. But I
> think the parsing/presentation of the log title/message would be more
> correct/better formatted if the parser is more "adaptive" to the
> content.
> 

I disagree. If the title spans over more than one line, it's most likely 
because it's too long to fit in one, in which case it won't look good 
(or even be viewable in qgit / gitk) when printed anyways.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
