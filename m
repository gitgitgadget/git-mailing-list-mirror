From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: Merge-Recursive Improvements
Date: Wed, 13 Feb 2008 09:17:45 +0100
Message-ID: <BE8E2652-6FB7-46F8-ACE7-1F5141F0E504@zib.de>
References: <A21B3CA8-6240-434F-87A9-C6F76DA15265@gmail.com> <47B29EBF.7060607@viscovery.net>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Voltage Spike <voltspike@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Feb 13 09:17:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPCoV-0004Qs-1v
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 09:17:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763680AbYBMIRA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 03:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761315AbYBMIQ7
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 03:16:59 -0500
Received: from mailer.zib.de ([130.73.108.11]:46670 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759401AbYBMIQ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 03:16:58 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m1D8GuUh005510;
	Wed, 13 Feb 2008 09:16:56 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m1D8GlJI019143
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 13 Feb 2008 09:16:48 +0100 (MET)
In-Reply-To: <47B29EBF.7060607@viscovery.net>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73752>


On Feb 13, 2008, at 8:39 AM, Johannes Sixt wrote:

> Voltage Spike schrieb:
>> Third, git doesn't appear to have any sense of context when  
>> performing a
>> merge. Another contrived example which wouldn't be flagged as a merge
>> conflict:
>>
>>   ptr = malloc(len); // Added in HEAD.
>>   init();            // Included in merge-base.
>>   ptr = malloc(len); // Added in "merge".
>
> You seem to say that you want this to result in a merge conflict.
>
> I'm opposed to this: It means that you would mark a conflict if  
> there is a
> single unchanged line between the two changes that come from the  
> merged
> branches. So far it has happened for me much more frequently that such
> merges were correct, and I should not be bothered with conflict  
> markers. I
> conciously prefer to pay the price that such a merge is incorrect  
> on occasion.
>
> You also need to draw a border line: a single unchanged line  
> between the
> changes? Or better also conflict at 2 lines? Or 3?

Maybe git could try various numbers and print a certainty
measure that tells the user how far appart non-conflicting
changes are.  If changes are near git would print a low
certainty and the user could decide to review the merge in
more detail than he would usually do.

	Steffen
