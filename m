From: Jonathan del Strother <maillist@steelskies.com>
Subject: Re: [PATCH 1/3] Fixing path quoting in git-rebase
Date: Wed, 17 Oct 2007 10:14:01 +0100
Message-ID: <B495731E-C854-450B-943B-B96248B8F609@steelskies.com>
References: <4711486B.1050301@op5.se> <11924540292687-git-send-email-maillist@steelskies.com> <47136D92.8060104@viscovery.net>
Mime-Version: 1.0 (Apple Message framework v907)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Oct 17 11:14:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ii4yp-0001mx-2z
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 11:14:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756053AbXJQJOH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 05:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754773AbXJQJOH
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 05:14:07 -0400
Received: from juliet.asmallorange.com ([207.210.105.70]:32947 "EHLO
	juliet.asmallorange.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756053AbXJQJOF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 05:14:05 -0400
Received: from [89.105.122.147] (helo=gir.office.bestbefore.tv)
	by juliet.asmallorange.com with esmtpa (Exim 4.68)
	(envelope-from <maillist@steelskies.com>)
	id 1Ii4ya-0005hY-67; Wed, 17 Oct 2007 05:14:04 -0400
In-Reply-To: <47136D92.8060104@viscovery.net>
X-Mailer: Apple Mail (2.907)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - juliet.asmallorange.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - steelskies.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61355>

On 15 Oct 2007, at 14:39, Johannes Sixt wrote:

> Jonathan del Strother schrieb:
>> -	eval GITHEAD_$hd='"$(cat $dotest/onto_name)"'
>> +	eval GITHEAD_$hd='"$(cat \"$dotest/onto_name\")"'
>
> I believe this is not correct. It should be this way:
>
> 	eval GITHEAD_$hd='$(cat "$dotest/onto_name")'
>
> You can test it with a conflicting git-rebase -m. It only affects  
> what the conflict markers look like. The test suite does not test it.

Thanks for catching that.  I'll post revised patches this morning
