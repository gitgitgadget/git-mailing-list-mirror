From: Adam Roben <aroben@apple.com>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Sun, 25 Nov 2007 22:36:58 -0800
Message-ID: <474A698A.70100@apple.com>
References: <200711252248.27904.jnareb@gmail.com>
 <20071125222314.GC21121@artemis.corp> <20071126012837.GA5402@dervierte>
 <7vejedh6xl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7BIT
Cc: Steven Walter <stevenrwalter@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 07:37:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwXat-0004BL-Ka
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 07:37:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752672AbXKZGhB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 01:37:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752671AbXKZGhB
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 01:37:01 -0500
Received: from mail-out3.apple.com ([17.254.13.22]:49596 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752607AbXKZGhA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 01:37:00 -0500
Received: from relay13.apple.com (relay13.apple.com [17.128.113.29])
	by mail-out3.apple.com (Postfix) with ESMTP id E203E1971073
	for <git@vger.kernel.org>; Sun, 25 Nov 2007 22:36:59 -0800 (PST)
Received: from relay13.apple.com (unknown [127.0.0.1])
	by relay13.apple.com (Symantec Mail Security) with ESMTP id C94DD28052
	for <git@vger.kernel.org>; Sun, 25 Nov 2007 22:36:59 -0800 (PST)
X-AuditID: 1180711d-9d2b7bb0000008bf-71-474a698b37ab
Received: from et.apple.com (et.apple.com [17.151.62.12])
	by relay13.apple.com (Apple SCV relay) with ESMTP id A8CBC2804F
	for <git@vger.kernel.org>; Sun, 25 Nov 2007 22:36:59 -0800 (PST)
Received: from [10.0.1.200] ([67.160.250.192])
 by et.apple.com (Sun Java System Messaging Server 6.2-8.04 (built Feb 28
 2007)) with ESMTPSA id <0JS300D4NP1ND000@et.apple.com> for
 git@vger.kernel.org; Sun, 25 Nov 2007 22:36:59 -0800 (PST)
In-reply-to: <7vejedh6xl.fsf@gitster.siamese.dyndns.org>
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66048>

Junio C Hamano wrote:
> Steven Walter <stevenrwalter@gmail.com> writes:
>   
>> Heartily seconded.  I think checkout is the most egregrious of the
>> three.  git-checkout can be used to:
>>
>>     * Switch branches
>>     * Create a branch
>>     * Change the state of all files to a particular commit
>>     * Change the state of a particular file to that of the index
>>     * Change the state of a particular file (and index) to a particular
>>       commit
>>     
>
> Come on.  The second one is just to give a short-hand side-effet for
> commonly used operation and you do not have to use it nor learn it.
>   

I think the overwhelming majority of git users learn `git checkout -b`. 
The cases where you do want to switch to a branch you just created seem 
far more common than the cases where you don't (particularly for new 
users), which is the whole reason the -b option exists in the first 
place. So I don't think it's reasonable to say "you can choose not to be 
confused by ignoring this incredibly useful command."

> Let's clear the confusion.  Although it is not bad like the above
> "random 5 different operations", checkout does serve 2 quite different
> purposes:
>
>  (1) checkout a revision.
>  (2) checkout selected paths out of a commit (or the index).
>   

Given the above, I'd argue that it serves 3 purposes:

   (1) check out a revision
   (2) check out selected paths out of a commit (or the index)
   (3) start working on a new branch

It's true that (1) and (3) are very closely related, but I think in the 
minds of many git users (particularly new ones) they are distinct. (2) 
really seems the most out of place here, and has the most potential for 
finding a new home (perhaps within git-reset).

-Adam
