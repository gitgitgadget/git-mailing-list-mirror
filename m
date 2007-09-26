From: Glenn Rempe <glenn.rempe@mac.com>
Subject: Re: [PATCH] Add ability to specify SMTP server port when using git-send-email.
Date: Tue, 25 Sep 2007 17:23:03 -0700
Message-ID: <F45A8184-2867-47A4-87D1-64EB48340E3A@mac.com>
References: <1190759927-19493-1-git-send-email-glenn@rempe.us> <Pine.LNX.4.64.0709260004090.28395@racer.site> <7vzlza2vcl.fsf@gitster.siamese.dyndns.org> <7vmyva2uqd.fsf@gitster.siamese.dyndns.org>
Reply-To: glenn@rempe.us
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Glenn Rempe <glenn@rempe.us>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 26 02:23:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaKgT-00088a-R9
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 02:23:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbXIZAXO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 20:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750857AbXIZAXO
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 20:23:14 -0400
Received: from smtpoutm.mac.com ([17.148.16.74]:62678 "EHLO smtpoutm.mac.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750786AbXIZAXN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 20:23:13 -0400
Received: from mac.com (smtpin04-en2 [10.13.10.149])
	by smtpoutm.mac.com (Xserve/smtpout011/MantshX 4.0) with ESMTP id l8Q0N7lA008018;
	Tue, 25 Sep 2007 17:23:07 -0700 (PDT)
Received: from [192.168.0.22] (asterisk.rempe.org [64.142.55.11])
	(authenticated bits=0)
	by mac.com (Xserve/smtpin04/MantshX 4.0) with ESMTP id l8Q0N424025639;
	Tue, 25 Sep 2007 17:23:05 -0700 (PDT)
In-Reply-To: <7vmyva2uqd.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59198>


On Sep 25, 2007, at 4:25 PM, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>>> On Tue, 25 Sep 2007, Glenn Rempe wrote:
>>>
>>>> +if (($smtp_server =~ /:\d+/) && (defined $smtp_server_port)) {
>>>
>>> Not that I want to be a PITA, but this breaks down with IPv6, right?
>>
>> Right.  Do we care about symbolic "server.addre.ss:smtp"
>> notation as well, I wonder?
>
> Well, does it break?
>
> BTW, I do not think we care about ":smtp"; it was a
> tongue-in-cheek comment.

Unfortunately, I know little about IPv6 and whether this breaks IPv6  
addressing or not.  So I'll leave that question for others. Does the  
unpatched code work with IPv6?  Does anyone currently use it that way?

Junio, are you suggesting that I should remove the host:port form  
support entirely and leave only the --smtp-server port option as  
valid?  I kind of liked that this new method allows both forms of  
specifying port as equal citizens.  :-)  If you are suggesting that  
it be removed, I think we would have to reject the host:port form  
smtp-server addresses so we don't break when both --smtp- 
server=host:port and -smtp-ssl are provided. (which brings us back to  
the ipv6 question).  No?
