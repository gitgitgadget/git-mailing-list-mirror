From: Andreas Ericsson <ae@op5.se>
Subject: Re: git-send-mail in sh
Date: Tue, 29 Nov 2005 14:04:22 +0100
Message-ID: <438C51D6.8050207@op5.se>
References: <4386DD45.6030308@op5.se>	<20051125163358.GF16995@mythryan2.michonline.com>	<43874415.8040302@op5.se> <438A5401.3070008@michonline.com>	<438AC7A0.7030407@op5.se> <7v64qdxgiz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 29 15:03:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eh5A6-000131-28
	for gcvg-git@gmane.org; Tue, 29 Nov 2005 14:04:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbVK2NEY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 08:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbVK2NEY
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 08:04:24 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:27823 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751351AbVK2NEX
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2005 08:04:23 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 945016BD00; Tue, 29 Nov 2005 14:04:22 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64qdxgiz.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12940>

Junio C Hamano wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
> 
>>By "local" do you mean "local on Junio's laptop" or "local at cox.net"?
>>
>>"mail" uses the "local on Junio's laptop" SMTP server so he can 
>>configure it any way he wants.
> 
> 
> I am puzzled.  What if I do not run any SMTP server on the
> laptop and use ISP's SMTP server?  Right now my ISP's SMTP
> server does not seem to require AUTH, so it is not an issue for
> me, though..
> 

It uses whatever the /bin/mail program on your system uses. This is 
usually done by spooling the mail for delivery by the local MTA which 
doesn't have to listen to any ports anywhere (mutt and friends work the 
same way).

Having an MTA installed is a requirement of the LSB. The /bin/mail 
program requires that it's running, which the sendmail binary doesn't. 
The sendmail binary is always shipped along with an MTA though, so to 
get around having one at all one would have to re-implement the SMTP 
protocol (which Mail::Sendmail does, but without authentication). I can 
do that in C if you like. That way you can have support for SMTP over 
SSL with all sorts of funny authentication mechanisms.

The good thing about using the local MTA is that you get that for free 
with very thoroughly tested code and you only have to set it up once 
rather than passing all the auth stuff repeatedly on the command-line 
each time you want to submit a patch.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
