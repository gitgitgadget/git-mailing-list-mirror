From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: cherry-pick --since ?
Date: Mon, 23 Apr 2007 18:18:42 -0500 (CDT)
Message-ID: <Pine.LNX.4.64.0704231750230.4667@torch.nrlssc.navy.mil>
References: <Pine.LNX.4.64.0704201100050.4667@torch.nrlssc.navy.mil>
 <7v647qy7dn.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0704231208490.4667@torch.nrlssc.navy.mil>
 <7v8xciga42.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 24 01:18:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg7o5-0005N5-7D
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 01:18:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752670AbXDWXSt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 19:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753354AbXDWXSs
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 19:18:48 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:58901 "EHLO
	mail1.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752670AbXDWXSr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 19:18:47 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail1.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id l3NNIt8Z028844
	for <git@vger.kernel.org>; Mon, 23 Apr 2007 18:18:57 -0500
Received: from torch.nrlssc.navy.mil ([128.160.25.59]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 23 Apr 2007 18:18:42 -0500
In-Reply-To: <7v8xciga42.fsf@assigned-by-dhcp.cox.net>
X-OriginalArrivalTime: 23 Apr 2007 23:18:42.0945 (UTC) FILETIME=[BBED2710:01C785FD]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-3.6.0.1039-15128001
X-TM-AS-Result: : Yes--13.807900-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTE1MDY2OC0xNDcw?=
	=?us-ascii?B?MTgtNzAwMDc1LTEzOTAxMC03MDAxNjAtNzAzNzMxLTE4ODAxOS03?=
	=?us-ascii?B?MDA0ODEtNzAyMzU4LTcwMzcxMi03MDE1NzYtNzA0NDMwLTcwNTE3?=
	=?us-ascii?B?OC03MDM1MjktNzA5NTg0LTcwMTYxOC03MDE0NTUtNzAyMDE2LTcw?=
	=?us-ascii?B?MDY2MC03MDE3MzgtMTg3MDY3LTcwMzQxNy03MDM3NDctNzA0MzQx?=
	=?us-ascii?B?LTcwNzQxMC03MDA2MjQtNzAyMDM5LTcwMTQ2MS03MDIwNDQtNzAw?=
	=?us-ascii?B?NTE2LTcwMTcxOS03MDA5OTktNzA3NTY1LTcwMDc1Mi03MDA2NDgt?=
	=?us-ascii?B?NzAzMDQxLTcxMDIwNi03MDAxMDctNzAyMDIwLTcwNjczNy03MDA0?=
	=?us-ascii?B?MzMtNzA1NTI2LTcwMzI4My03MDgxNzktNzAwNzU2LTEyMTEyMi0x?=
	=?us-ascii?B?NDgwNTAtMjAwNDM=?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45378>

On Mon, 23 Apr 2007, Junio C Hamano wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
>
>> On Fri, 20 Apr 2007, Junio C Hamano wrote:
>>> Brandon Casey <casey@nrlssc.navy.mil> writes:
>>> ...
>>>> Here's my use case:
>>>>
>>>> Two branches, 'A' and 'B'.
>>>> 'A' is the master branch.
>>>> 'B' was forked some time ago and is in bug fix only mode.
>>>> Much of 'A' and 'B' are still the same, but there have been
>>>>   some intrusive changes made to 'A' that should not go into 'B'.
>>>
>>> You forgot to say "My objective is to make sure all the good
>>> fixes in B are forward ported to A" but I am assuming that is
>>> the case.
>>
>> Yes, that is the case, but the flow is both ways. Other developers
>> may implement fixes in 'A', which must be backported to 'B'. They
>> don't care about 'B'.
>
> That shows a problem in the project management that needs to be
> fixed independent of what SCM tool you use, doesn't it?
>
> I do not think you would necessarily want to have a VC tsar to
> say "No, that is perfectly valid fix for the maintenance branch
> and you should make it go through the maintenance branch, do not
> directly commit to the master".  People should be able to
> self-police that, with a general, shared understanding of what
> the overall process is, and can strive to make it easier for
> everybody.

Agreed.

I think our case is more similar to a linux 2.6.20 branch and a
2.6.21 branch. Everybody's working on 2.6.21, but maybe someone is
still relying on 2.6.20. That person implements their patches on 2.6.20
and pushes them to 2.6.21. Meanwhile, important fixes may be applied to
2.6.21 which is the official development version. So those fixes that
are applicable to 2.6.20 must be pulled from 2.6.21 by the developer
with the interest in 2.6.20.

Comments below noted, and thanks for your help.

-brandon


> Even with that, mistakes can happen, and sometimes you may
> realize that a fix or enhancement is applicable to the
> maintenance branch as well long after it hit the master branch.
> I would not disagree that you would need to have a way to deal
> with the ones that need backporting by cherry-picking (otherwise
> we would not have git-cherry-pick).  And I am certainly not
> against a cherry-pick that can do more than one commit.  What I
> am saying is that having to cherry-pick should be the exception,
> not the norm, and otherwise there is something wrong in the
> process.
>
> If you want to do a cherry-pick that handles more than one
> commit, I think you need to worry about sequencing -- how to let
> the user continue after aborting in the middle and having him
> resolve conflicts.  What "git-rebase --continue" does already
> can be used as a model for you to mimick in such an
> implementation.
>
>
