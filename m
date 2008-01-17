From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] git-commit: exit non-zero if we fail to commit the index
Date: Wed, 16 Jan 2008 19:49:36 -0600
Message-ID: <478EB430.1040604@nrlssc.navy.mil>
References: <478E9C59.9070008@nrlssc.navy.mil> <7vir1tmey8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 02:56:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFJz9-0001Zg-1X
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 02:56:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752713AbYAQBze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 20:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752667AbYAQBze
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 20:55:34 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:40714 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653AbYAQBzd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 20:55:33 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m0H1nbwJ001283;
	Wed, 16 Jan 2008 19:49:37 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 16 Jan 2008 19:49:37 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <7vir1tmey8.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 17 Jan 2008 01:49:37.0168 (UTC) FILETIME=[375EF100:01C858AB]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15666001
X-TM-AS-Result: : Yes--12.503300-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTcwMDA3NS0xMzkw?=
	=?us-ascii?B?MTAtNzAwMTYwLTcwMzczMS03MDkwNjUtNzA5MDUwLTEyMTU4OC03?=
	=?us-ascii?B?MDEyMzItNzAzOTEyLTExMzY4MS03MDkxODUtNzAxNzA4LTcwNTkw?=
	=?us-ascii?B?MS03MDI3MjYtNzAxNjE4LTEyMTY2NS03MDA3NTYtNzAzNzg4LTcw?=
	=?us-ascii?B?NDQyNS03MDE0NTUtNzAwMjcwLTcwMzc4Mi03MDM3MTItMTQ4MDM5?=
	=?us-ascii?B?LTE0ODA1MS0yMDA0Mg==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70809>

Junio C Hamano wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
> 
>> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
>> ---
>>
>>
>> Shouldn't we be doing this? I think if quiet is set,
>> then a failed rename will go undetected since we
>> won't enter print_summary to have lookup_commit fail.
> 
> But then it's a bit too late, isn't it?  We already have
> successfully made the commit and updated the HEAD to point at
> it.

Ok, so the commit has been made, but the index (since the rename
failed), is out of sync?

>  We would need to tell the user that the index is not where
> it is when we detect the error, though.

The new index we are trying to rename will be deleted.
Are you saying we should 
  warn the user that the index is now out of sync?
  Or prevent the deletion of the updated index?
  or just ignore this case which I now see as very unlikely to occur?

-brandon
