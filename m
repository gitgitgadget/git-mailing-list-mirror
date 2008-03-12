From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH v2] gc: call "prune --expire 2.weeks.ago" by default
Date: Wed, 12 Mar 2008 15:25:55 -0500
Message-ID: <47D83C53.7000602@nrlssc.navy.mil>
References: <alpine.LSU.1.00.0803112157560.3873@racer.site> <7vskywadum.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0803112234470.2947@xanadu.home> <alpine.LSU.1.00.0803121833210.1656@racer.site> <47D8193B.901@nrlssc.navy.mil> <m3prtzyens.fsf@localhost.localdomain> <47D83532.70103@nrlssc.navy.mil> <alpine.LSU.1.00.0803122058430.1656@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, Nicolas Pitre <nico@cam.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 12 21:27:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZXXe-0002au-AP
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 21:27:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918AbYCLU0b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 16:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751844AbYCLU0b
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 16:26:31 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:43303 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751780AbYCLU0a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 16:26:30 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m2CKPtq3002229;
	Wed, 12 Mar 2008 15:25:56 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 12 Mar 2008 15:25:55 -0500
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <alpine.LSU.1.00.0803122058430.1656@racer.site>
X-OriginalArrivalTime: 12 Mar 2008 20:25:55.0637 (UTC) FILETIME=[465E7E50:01C8847F]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15778001
X-TM-AS-Result: : Yes--9.893000-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTE1MDcwNC0xNTA2?=
	=?us-ascii?B?NjgtNzAwMDc1LTEzOTAxMC03MDA3ODItNzAyMzc2LTcwMDU3My03?=
	=?us-ascii?B?MDY1NjEtNzAyMzU4LTcwNzg1Ni03MDEyMDItNzAyMDQ0LTcwNDQy?=
	=?us-ascii?B?NS03MDU0MzEtNzA4MzM5LTEwNjQyMC0xODcwNjctMTA2NjQwLTEy?=
	=?us-ascii?B?MTUzNi03MDEyMzYtNzAxODM3LTcwMDEwNC03MDc5MzUtNzA2NzI1?=
	=?us-ascii?B?LTcwMTkxNC03MDUxMDItNzA0OTgwLTcwNzQ1MS03MDIwNjctNzAy?=
	=?us-ascii?B?MDIwLTE0ODAzOS0xNDgwNTEtMjAwNDI=?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76983>

Johannes Schindelin wrote:
> Hi,
> 
> On Wed, 12 Mar 2008, Brandon Casey wrote:
> 
>> I think git-prune is seldomly used by normal users for the reasons Dscho 
>> described, and I think once the behavior implemented by his patch 
>> becomes standard it will never be used by normal users (except the ones 
>> who always use --prune for the reasons Geert Bosch described, and 
>> they'll probably want the new behavior). So I think git-prune will sink 
>> a little lower into plumbing and common users won't need to know 
>> anything about pruning, and only sophisticated users will need to know 
>> git-prune.
> 
> But because we are nice people, we will deprecate --prune before we remove 
> it, should we go that route at all.

I am not suggesting that git-gc stop parsing --prune and instead start erroring
out on it. If it is ok to change the behavior of git-gc, it seems like it
is ok to change the behavior of 'git-gc --prune' in the same way, especially if
the change makes it less destructive.

I would suggest not having the somewhat ambiguous state of 'git-gc' prunes one
way and 'git-gc --prune' prunes in another more dangerous way. And only one is
controlled by a config option named gc.pruneExpire (_and_ it's not the obvious
usage of git-gc which actually has the word 'prune' on the command line).

So I hope making --prune a noop fits your definition of nice deprecation.

-brandon
