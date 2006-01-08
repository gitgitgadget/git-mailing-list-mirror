From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] git-mv.perl: use stderr for error output and cleanup
Date: Sun, 08 Jan 2006 01:07:25 +0100
Message-ID: <43C057BD.7010201@op5.se>
References: <81b0412b0601050349s6bec1a36jc410fd315fbbc4c@mail.gmail.com>	<7vek3lq8wu.fsf@assigned-by-dhcp.cox.net>	<86wthd7ypx.fsf@blue.stonehenge.com>	<20060107102820.GB5536@steel.home>	<86sls0498w.fsf@blue.stonehenge.com> <7v7j9bg369.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 08 01:07:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvO5t-000281-SJ
	for gcvg-git@gmane.org; Sun, 08 Jan 2006 01:07:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161077AbWAHAH3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 19:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161078AbWAHAH3
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 19:07:29 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:21890 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1161077AbWAHAH3
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 7 Jan 2006 19:07:29 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 575CB6BD01; Sun,  8 Jan 2006 01:07:26 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7j9bg369.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14287>

Junio C Hamano wrote:
> 
> BTW, I never understood the usefulness of Statement Modifiers.
> Even reading the examples in perlsyn.pod:
> 
>     print "Basset hounds got long ears" if length $ear >= 10;
>     go_outside() and play() unless $is_raining;
> 
> seeing "do these things" upfront and then realize "ah, but that
> is done only when this holds true", interrupts the flow of
> understanding while reading a program by somebody else [*1*].


Here's what "Programming Perl" by O'Reilly (third edition, somewhere 
around page 604) has to say about it:
---%<---%<---%<---
*) Do things the most readable way. For instance:

     open(FOO, $foo) or die "Can't open $foo: $!";

is  better than

     die "Can't open $foo: $!" unless open(FOO, $foo);

because the second way hides the main point of the statement in a modifier.
---%<---%<---%<---

Considering the book was co-authored by Larry Wall, I'd say that's as 
good as an apology.


> It is worse if the Statement Modifier is a loop control.
> 
> (flamebait) Compound Statements take BLOCK and people who want
> to do a one-liner could not do so without braces.  I've always
> thought Statement Modifies as a lame workaround for that
> problem.
> 

Most things can be done without braces, so long as one doesn't spell out 
the 'if'.

	$opt_h and usage();
	-d $directory or mkdir($directory);

is perfectly valid perl. This way of writing it is familiar enough for 
shell-scripters. Hardcore C-programmers will look twice when they see a 
line that so obviously looks completely wrong and will almost certainly, 
with some revulsion, understand it.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
