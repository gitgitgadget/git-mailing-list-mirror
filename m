From: Yakup Akbay <yakbay@ubicom.com>
Subject: Re: Confused about `git gc`
Date: Tue, 09 Jun 2009 14:18:51 +0300
Message-ID: <4A2E451B.3080600@ubicom.com>
References: <4A2E1D37.9010909@ubicom.com> <m3ljo14r61.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 13:19:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDzMT-0001xF-98
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 13:19:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754266AbZFILTG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 07:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753528AbZFILTF
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 07:19:05 -0400
Received: from server70b.appriver.com ([74.205.4.150]:2018 "EHLO
	server70.appriver.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753315AbZFILTE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 07:19:04 -0400
Received: by server70.appriver.com (CommuniGate Pro PIPE 5.2.13)
  with PIPE id 95226975; Tue, 09 Jun 2009 07:19:08 -0400
Received: from [216.112.109.98] (HELO stork.scenix.com)
  by server70.appriver.com (CommuniGate Pro SMTP 5.2.13)
  with ESMTP id 95226969; Tue, 09 Jun 2009 07:19:01 -0400
Received: from [172.18.200.101] ([172.18.200.101]) by stork.scenix.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 9 Jun 2009 04:17:09 -0700
User-Agent: Thunderbird 2.0.0.21 (X11/20090409)
In-Reply-To: <m3ljo14r61.fsf@localhost.localdomain>
X-OriginalArrivalTime: 09 Jun 2009 11:17:09.0968 (UTC) FILETIME=[D4AE9D00:01C9E8F3]
X-Policy: GLOBAL - ubicom.com
X-Policy: GLOBAL - ubicom.com
X-Primary: yakbay@ubicom.com
X-Note: This Email was scanned by AppRiver SecureTide
X-Virus-Scan: V-
X-Note: TCH-CT/SI:0-40/SG:2 6/9/2009 7:18:25 AM
X-GBUdb-Analysis: 0, 216.112.109.98, Ugly c=0.592148 p=-0.72524 Source Normal
X-Signature-Violations: 0-0-0-2761-c
X-Note: Spam Tests Failed: 
X-Country-Path: PRIVATE->UNITED STATES->UNITED STATES
X-Note-Sending-IP: 216.112.109.98
X-Note-Reverse-DNS: 216.112.109.98.ptr.us.xo.net
X-Note-WHTLIST: yakbay@ubicom.com
X-Note: User Rule Hits: 
X-Note: Global Rule Hits: 112 113 114 115 119 120 210 
X-Note: Mail Class: VALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121166>

Jakub Narebski wrote:
> Yakup Akbay <yakbay@ubicom.com> writes:
>
>   
>> Looks like I didn't quite understand the actual role of `git gc`. I
>> just thought that `git gc` would remove all unreferenced objects
>> during the unpack-pack process. However, I'm not seeing the result
>> what I was expecting from `git gc`.
>>
>> I'm adding an object into the database, which is ignored by git. Then
>> I expect the object to be removed after `git gc`. But, it's still
>> there.
>>     
>
> [...]
>   
>> What am I overlooking?
>>     
>
> You are probably overlooking the safety introduced to "git gc" to make
> it safer against concurrently run git operations, namely the fact that
> it would not remove new loose objects (it would remove loose objects
> only when they are old enough).
>
>   
Hmm, I see.

    git gc --prune=<date>

helped me remove all loose objects.


Thanks,
Yakup
