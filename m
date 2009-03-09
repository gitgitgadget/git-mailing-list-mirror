From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: git-grep Bus Error
Date: Sun, 8 Mar 2009 20:58:42 -0400
Message-ID: <49C11A48-5246-4477-9F33-26942B8C99D9@silverinsanity.com>
References: <C36B091A-ABE9-4C74-9E59-4EBD50E3B9F5@gernhardtsoftware.com> <20090308234141.GJ12880@zoy.org>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Sam Hocevar <sam@zoy.org>
X-From: git-owner@vger.kernel.org Mon Mar 09 02:03:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgTtm-0000KP-AU
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 02:03:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752679AbZCIA6r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2009 20:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752677AbZCIA6r
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Mar 2009 20:58:47 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:48588 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752353AbZCIA6q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2009 20:58:46 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id EE4851FFC3FB; Mon,  9 Mar 2009 00:58:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.1.115] (cpe-74-74-137-205.rochester.res.rr.com [74.74.137.205])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id AC59E1FFC043;
	Mon,  9 Mar 2009 00:58:34 +0000 (UTC)
In-Reply-To: <20090308234141.GJ12880@zoy.org>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112656>


On Mar 8, 2009, at 7:41 PM, Sam Hocevar wrote:

> On Sun, Mar 08, 2009, Brian Gernhardt wrote:
>
>>> 			printf( "%d %d %d",
>>> 				  match.rm_so, match.rm_eo,
>>> 				  match.rm_eo - match.rm_so );
>>
>> .gitignore:0 0 3\033[31m\033[1m(nugit
>> .mailmap:23 0 26(null)\033[31m\033[1m(nugit-shortlog to fix a few
>> botched name translations-shortlog to fix a few botched name
>> translations
>>
>> And now I'm baffled.  Apparently my computer thinks 0 - 0 == 3 and  
>> 0 -
>> 23 == 26.
>
>   rm_so and rm_eo are ints on Linux but off_t's on Darwin, hence
> probably int64_t's here. You should cast the arguments.


And that explains the warnings about the parameters to printf not  
being integers.  I was looking at compat/regex/regex.h and was confused.

Adding a cast to int on all of the format specifiers solves my  
problems.  Thank you.

~~ Brian
