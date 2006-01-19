From: Andreas Ericsson <ae@op5.se>
Subject: Re: New ref generates 8MB mail message
Date: Thu, 19 Jan 2006 13:35:29 +0100
Message-ID: <43CF8791.6050705@op5.se>
References: <20060118140907.GV19769@parisc-linux.org> <Pine.LNX.4.64.0601180810330.3240@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Matthew Wilcox <matthew@wil.cx>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 19 13:35:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzZ0o-0008JV-CM
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 13:35:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161073AbWASMfc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 07:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbWASMfb
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 07:35:31 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:26853 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751402AbWASMfb
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2006 07:35:31 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id DD27A6BD03; Thu, 19 Jan 2006 13:35:29 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601180810330.3240@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14900>

Linus Torvalds wrote:
> 
> On Wed, 18 Jan 2006, Matthew Wilcox wrote:
> 
>>Based on the idea that a new branch is probably a branch off master, and
>>if it isn't, then at least sending a log vs master is better than a log
>>vs the beginning of time, I propose this patch:
> 
> 
> Actually, since the update hook _should_ be called before the ref has 
> actually been updated, it's probably much better to instead of this:
> 
> 
>>-	git-rev-list --pretty "$3"
>>+	git-rev-list --pretty "$3" ^master
> 
> 
> do something like this:
> 
> 	git-rev-list --pretty "$3" $(git-rev-parse --not --all)
> 
> which basically says: show any commits that are in the new ref, but are 
> not in _any_ other ref.
> 
> Untested, of course.
> 

Tested. It works fine and is, surprisingly, insanely fast.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
