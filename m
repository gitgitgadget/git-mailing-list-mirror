From: Justin Frankel <justin@cockos.com>
Subject: Re: [RFC/PATCH] cherry-pick/revert: add support for -X/--strategy-option
Date: Mon, 27 Dec 2010 17:07:10 -0500
Organization: Cockos Incorporated
Message-ID: <4D190E0E.7080000@cockos.com>
References: <20101211005144.GA6634@burratino> <20101227212515.GA32352@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Kevin Ballard <kevin@sb.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 27 23:16:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXLMg-00022n-C8
	for gcvg-git-2@lo.gmane.org; Mon, 27 Dec 2010 23:16:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752068Ab0L0WQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Dec 2010 17:16:21 -0500
Received: from mail.cockos.com ([204.11.104.234]:38040 "EHLO mail.cockos.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751503Ab0L0WQV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Dec 2010 17:16:21 -0500
X-Greylist: delayed 546 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Dec 2010 17:16:21 EST
Received: from localhost (localhost [127.0.0.1])
	by mail.cockos.com (Postfix) with ESMTP id 13199EC48B;
	Mon, 27 Dec 2010 14:11:10 -0800 (PST)
X-Virus-Scanned: amavisd-new at mail.cockos.com
Received: from mail.cockos.com ([127.0.0.1])
	by localhost (mail.cockos.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JAQ5p9vzqtSi; Mon, 27 Dec 2010 14:11:09 -0800 (PST)
Received: from [192.168.2.42] (cpe-74-66-229-188.nyc.res.rr.com [74.66.229.188])
	by mail.cockos.com (Postfix) with ESMTPSA id E264FEC324;
	Mon, 27 Dec 2010 14:11:08 -0800 (PST)
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
In-Reply-To: <20101227212515.GA32352@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164227>

I think this is a good thing -- all commands that use an underlying 
merge should support these options.

Would it make sense at some level to allow some other means of cleanly 
passing this information around? Perhaps an environment variable for 
merge options?


Jonathan Nieder wrote:
> Jonathan Nieder wrote:
> 
>> For example, this would allow cherry-picking or reverting patches from
>> a piece of history with a different end-of-line style, like so:
>>
>> 	$ git revert -Xrenormalize old-problematic-commit
>>
>> Currently that is possible with manual use of merge-recursive but the
>> cherry-pick/revert porcelain does not expose the functionality.
>>
>> While at it, document the existing support for --strategy.
>>
>> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>> ---
>> Thoughts?
> 
> Ping?  I use this with -Xpatience fairly often.  Am I the only one who
> has wanted such a thing?
