From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Add git-imap-send.
Date: Thu, 09 Mar 2006 12:39:58 +0100
Message-ID: <4410140E.2000609@op5.se>
References: <440C3499.9080000@codeweavers.com> <7vacbz7vod.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0603091227560.20277@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Mike McCormack <mike@codeweavers.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 09 12:40:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHJUy-00075v-0p
	for gcvg-git@gmane.org; Thu, 09 Mar 2006 12:40:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811AbWCILkA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Mar 2006 06:40:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751831AbWCILkA
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Mar 2006 06:40:00 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:24283 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751811AbWCILj7
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 9 Mar 2006 06:39:59 -0500
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 610E56BCFF; Thu,  9 Mar 2006 12:39:58 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0603091227560.20277@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17408>

Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 9 Mar 2006, Junio C Hamano wrote:
> 
> 
>>Mike McCormack <mike@codeweavers.com> writes:
>>
>>
>>>+		if (!memcmp( "imaps:", val, 6 )) {
>>>+			if (!memcmp( "imap:", val, 5 ))
>>
>>Is val always longer than 5 or 6 bytes here?
> 
> 
> That does not matter, since they are strings, and the memcmp should not 
> look further if they are shorter (because the comparison to '\0' failed 
> already).
> 

That's what strcmp() does. memcmp() walks the lenghth even if it 
encounters nul bytes. Perhaps you confuse it with strncmp()?


> However, if !memcmp("imaps:", val, 6), it means that val starts with 
> the string "imaps:", right? Then !memcmp("imap:", val, 5) must always 
> fail, no?
> 

Yes. Recent gcc's will recognize it as dead code and remove it. It's 
still ugly though.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
