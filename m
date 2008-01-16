From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH 2/2] close_lock_file(): new function in the lockfile API
Date: Wed, 16 Jan 2008 17:28:44 -0600 (CST)
Message-ID: <Pine.LNX.4.64.0801161725010.31161@torch.nrlssc.navy.mil>
References: <7vmyr6bluy.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.44.0801152006260.944-100000@demand> <7vejchr3pf.fsf_-_@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0801161207220.2806@woody.linux-foundation.org>
 <7vodblo6c9.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0801161443340.31161@torch.nrlssc.navy.mil>
 <7vtzldmk8p.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 00:30:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFHi2-0000hL-B4
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 00:30:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752506AbYAPX3n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 18:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751561AbYAPX3n
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 18:29:43 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:56071 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080AbYAPX3m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 18:29:42 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m0GNSikp030116;
	Wed, 16 Jan 2008 17:28:45 -0600
Received: from torch.nrlssc.navy.mil ([128.160.25.59]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 16 Jan 2008 17:28:44 -0600
In-Reply-To: <7vtzldmk8p.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 16 Jan 2008 23:28:44.0806 (UTC) FILETIME=[895EDA60:01C85897]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15666001
X-TM-AS-Result: : Yes--13.265700-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTE1MDY3NS03MDAw?=
	=?us-ascii?B?NzUtMTM5MDEwLTcwMDE2MC03MDM3MzEtNzExNDMyLTcwMDc1OC03?=
	=?us-ascii?B?MDM3ODgtMTM3NzE3LTcwNDkzMC03MDA0NzYtMTEzMjI4LTcwNTg2?=
	=?us-ascii?B?MS03MDY3MzctNzAzNzEyLTcwNzIyNS03MDIwMjAtMTQ4MDM5LTE0?=
	=?us-ascii?B?ODA1MC0yMDA0MA==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70773>

On Wed, 16 Jan 2008, Junio C Hamano wrote:

> Brandon Casey <casey@nrlssc.navy.mil> writes:
>
>> My patch does this, though I understand it may take some time to review.
>>
>> I left the lk->fd unmodified when close() failed in case the caller
>> would like to include it in an error message.
>
> But that would bring us back to the same double-close issue,
> wouldn't it?

Yes it would. Although I knew it would happen, I was disregarding
_that_ double close case for some reason.

You're right, your's and Linus's version is better.

-brandon
