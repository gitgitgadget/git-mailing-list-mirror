From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] git-grep: --and to combine patterns with and instead
 of or
Date: Mon, 03 Jul 2006 09:54:22 +0200
Message-ID: <44A8CD2E.8020208@op5.se>
References: <20060625184757.f8273820.tihirvon@gmail.com>	<E1FuX8l-0001H5-2z@moooo.ath.cx>	<Pine.LNX.4.63.0606260108510.29667@wbgn013.biozentrum.uni-wuerzburg.de>	<E1FueYh-0004XE-Fg@moooo.ath.cx>	<20060629222009.GA9310@cip.informatik.uni-erlangen.de>	<7vejx7oa3x.fsf@assigned-by-dhcp.cox.net>	<E1Fw8hS-00023y-FY@moooo.ath.cx>	<7v7j2zmgbu.fsf@assigned-by-dhcp.cox.net>	<E1FwDiI-0007Xp-2s@moooo.ath.cx>	<7v3bdnkrfb.fsf@assigned-by-dhcp.cox.net>	<E1FwGgm-0006Nc-9a@moooo.ath.cx> <7vejx6k54p.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Matthias Lederhofer <matled@gmx.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 03 09:54:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxJGG-0003V3-5b
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 09:54:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWGCHyZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 03:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbWGCHyZ
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 03:54:25 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:14223 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1750724AbWGCHyY
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 3 Jul 2006 03:54:24 -0400
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 2BF276BCDA; Mon,  3 Jul 2006 09:54:23 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vejx6k54p.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23159>

Junio C Hamano wrote:
> Matthias Lederhofer <matled@gmx.net> writes:
> 
> 
>>Junio C Hamano wrote:
>>
>>>I see you are trying hard to think of a way to justify your
>>>original prefix "--and" (or --FOO) implementation, but I simply
>>>do not see much point in that.  I doubt changing the default
>>>operator from --or to --and is less confusing than changing the
>>>precedence for the users, so you would hear the same "I
>>>personally feel FOO should not even exist" objection from me.
>>
>>It just happens to make more sense to me and I don't see a reason not to
>>add this. If no one else is interested in this I'll just stop arguing :)
>>Here again an overview of the arguments if anyone is interested:
>>- Less to type for common searches using only AND (or more ANDs than
>>  ORs).
>>- Easy to implement (both with and without extended expressions).
>>- AND/* is the normal implicit operator in other contexts than grep
>>  (math).
>>- The high precedence operator (AND) should be implicit rather than
>>  the low precedence one (OR) (so this is only fulfilled when the
>>  option is used).
> 
> 
> Side note.  It would be interesting to have a slightly different
> form of --and called --near.  You would use it like this:
> 
> 	git grep -C -e AND --near -e OR
> 
> to find lines that has AND on it, and within the context
> distance there is a line that has OR on it.  The lines that are
> hit with such a query are still the ones that have AND on them
> (in other words, a line that has OR is used to further filter
> out the results so it will be prefixed with '-', not ':', unless
> that line happens to also have AND on it).
> 

It would also be neat to have --inside main or some such, to make it 
only check for things inside whatever's printed on the diff --git line.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
