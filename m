From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: git-commit fatal: Out of memory? mmap failed: Bad file descriptor
Date: Mon, 14 Jan 2008 17:22:46 -0600 (CST)
Message-ID: <Pine.LNX.4.64.0801141715500.31161@torch.nrlssc.navy.mil>
References: <4787E981.7010200@nrlssc.navy.mil> <4787F1F5.2010905@nrlssc.navy.mil>
 <20080112201622.GA2992@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git Mailing List <git@vger.kernel.org>, drafnel@gmail.com
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 00:23:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEYeE-0008Ri-Kl
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 00:23:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753487AbYANXWv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2008 18:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753267AbYANXWv
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jan 2008 18:22:51 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:45595 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752520AbYANXWu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2008 18:22:50 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m0ENMlBx005399;
	Mon, 14 Jan 2008 17:22:47 -0600
Received: from torch.nrlssc.navy.mil ([128.160.25.59]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 14 Jan 2008 17:22:47 -0600
In-Reply-To: <20080112201622.GA2992@steel.home>
X-OriginalArrivalTime: 14 Jan 2008 23:22:47.0563 (UTC) FILETIME=[5F9C65B0:01C85704]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15666001
X-TM-AS-Result: : Yes--11.968900-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTE1NzA0Mi03MDAw?=
	=?us-ascii?B?NzUtMTM5MDEwLTcwMTMwNS0xMDU3MDAtNzAzNDE3LTcwMzc4OC03?=
	=?us-ascii?B?MTEzODUtMTg4MDE5LTcwNDIxNC03MDA5NzEtNzAxOTM3LTEwNjQ3?=
	=?us-ascii?B?MC03MDEyMzYtMTQ4MDM5LTE0ODA1MC0yMDA0MA==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70487>

On Sat, 12 Jan 2008, Alex Riesen wrote:

> Brandon Casey, Fri, Jan 11, 2008 23:47:17 +0100:
>>
>> It's reproduceable for me by amending the commit.
>>
>> Any suggestions?
>
> strace -o log -f git commit -C HEAD --amend
>
> and post the "log" here (assuming it failed)

It does not fail when -C HEAD is used.

Specifically I did...

   Modify Makefile.in (random file).
   git commit -a --amend
   <:wq when vi opens, i.e. save without making changes>
   <failure>

   Modify Makefile.in
   git commit -a -C HEAD --amend
   <successful completion>

   Modify Makefile.in
   git commit -a --amend
   <:wq save without making change>
   <failure>

-brandon
