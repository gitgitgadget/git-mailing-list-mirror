From: Andreas Ericsson <ae@op5.se>
Subject: Re: [ANNOUNCE] GIT 0.99.9g
Date: Thu, 10 Nov 2005 19:34:21 +0100
Message-ID: <437392AD.20906@op5.se>
References: <7vmzkc2a3e.fsf@assigned-by-dhcp.cox.net> <43730E39.6030601@pobox.com> <43737F9E.60703@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Nov 10 19:39:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaHG6-0004D7-Hm
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 19:34:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbVKJSeY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 13:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbVKJSeY
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 13:34:24 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:24222 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932144AbVKJSeX
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2005 13:34:23 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 0ECBB6BCFF
	for <git@vger.kernel.org>; Thu, 10 Nov 2005 19:34:22 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <43737F9E.60703@zytor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11501>

H. Peter Anvin wrote:
> Jeff Garzik wrote:
> 
>>
>>> Oh, and we will not be moving things out of /usr/bin/ during 1.0
>>> timeframe.
>>
>>
>>
>> :(  bummer.  I do like the elegance of having /usr/bin/git executing 
>> stuff out of /usr/libexec/git.
>>
>> /usr/libexec/git also makes it IMO cleaner when integrating git 
>> plugins from third parties (rpm -Uvh git-newfeature), because you 
>> don't have to worry about the /usr/bin namespace.
>>
> 
> It's nice in concept, but I think there are a lot of reasons why this is 
> a bad idea:
> 
> - "man" doesn't handle it.  It would be another thing if "man" could be 
> taught to understand commands like "man cvs checkout" or "man git fetch".
> 

This is moot. man-pages can still be named git-fetch.

> - There is no general way to teach shells etc about it, for tab 
> completion etc.
> 

Add the lib directory to the path (for git-<tab><tab>) or have it 
auto-evaluate the result of a git command-listing.

> - Makes it harder (but not impossible) to run git from a build directory 
> without installing it first.
> 

Provided adding --lib=. is considered difficult, yes. Btw, this problem 
still applies as some of the programs run other programs that are 
expected to be in the path.

I've just posted a patch (used my submit-patch script, which was stupid 
since I should have posted it here) that doesn't have any of these problems.

> In comparison, the issue of clutter in /usr/bin is actually a pretty 
> small issue, especially with htree.  Most vendors have gone back to 
> putting everything into /usr/bin since all variants that involve 
> splitting it up seem to be more of a loss than a gain.
> 

Fair enough. With the patch I've just sent (C implementation of the 
'git' program) this option is certainly available.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
