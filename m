From: Andreas Ericsson <ae@op5.se>
Subject: Re: Linux 2.6.15-rc2
Date: Fri, 25 Nov 2005 09:42:16 +0100
Message-ID: <4386CE68.1020200@op5.se>
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org> <Pine.LNX.4.64.0511241020050.13959@g5.osdl.org> <20051124195256.GR3968@reactrix.com> <200511242151.00162.tomlins@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nick Hengeveld <nickh@reactrix.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750801AbVKYIme@vger.kernel.org Fri Nov 25 09:44:24 2005
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750801AbVKYIme@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfZAT-0006x3-1S
	for glk-linux-kernel-3@gmane.org; Fri, 25 Nov 2005 09:42:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbVKYIme (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 25 Nov 2005 03:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbVKYIme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 03:42:34 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:51356 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1750801AbVKYImd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 03:42:33 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 5E2D86BCBE; Fri, 25 Nov 2005 09:42:16 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: Ed Tomlinson <tomlins@cam.org>
In-Reply-To: <200511242151.00162.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12729>

Ed Tomlinson wrote:
> On Thursday 24 November 2005 14:52, Nick Hengeveld wrote:
> 
>>On Thu, Nov 24, 2005 at 10:37:15AM -0800, Linus Torvalds wrote:
>>
>>
>>>I just repacked and updated it now, so how http should work too, although 
>>>inefficiently (because it will get a whole new pack - just one of the 
>>>disadvantages of the non-native protocols).
>>
>>There's room to improve on that particular inefficiency.  The http
>>commit walker could use Range: headers to fetch loose objects directly
>>from inside a pack if it didn't make sense to fetch the entire pack.
>>For this to work, pack fetches would need to be deferred until the
>>entire tree had been walked, and the commit walker could decide whether
>>to fetch the pack or loose objects based on the percentage of packed
>>objects it needed to fetch.  It would also need to fetch all
>>tag/commit/tree objects using ranges to be able to fully walk the tree.
> 
> 
> Alternately, when creating a new archive the client could ask the server
> what protocols are active.  It could then use the best one for the clone and
> update the .git/origin files with the optimal one for incremental pulls.
> 

This would only work with the git protocol, and since that's the fastest 
protocol (theoretically that is, Pasky seems to have gotten other 
figures but I'm not sure I believe those) it should really only ever 
return itself which wouldn't make much sense.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
