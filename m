From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH 2/2] git-filter-branch.sh: don't use --default when calling
 rev-list
Date: Wed, 30 Jan 2008 19:35:21 -0600
Message-ID: <47A125D9.2070105@nrlssc.navy.mil>
References: <47A109A7.1070502@nrlssc.navy.mil> <1201738186-28132-1-git-send-email-casey@nrlssc.navy.mil> <47A11317.2010409@nrlssc.navy.mil> <alpine.LSU.1.00.0801310048350.23907@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 31 02:37:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKOMb-00029k-MI
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 02:37:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758758AbYAaBg2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2008 20:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758063AbYAaBg2
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 20:36:28 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:56457 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754803AbYAaBg1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2008 20:36:27 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m0V1ZM39012676;
	Wed, 30 Jan 2008 19:35:22 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 30 Jan 2008 19:35:22 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <alpine.LSU.1.00.0801310048350.23907@racer.site>
X-OriginalArrivalTime: 31 Jan 2008 01:35:22.0821 (UTC) FILETIME=[8BEC6F50:01C863A9]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15694001
X-TM-AS-Result: : Yes--3.986500-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTE1MDY2OC0xNTA1?=
	=?us-ascii?B?NDEtNzAwMDc1LTEzOTAxMC03MDc0NTEtNzAyMDM3LTcwMjkwMC0x?=
	=?us-ascii?B?MDY0MjAtNzAyNjA5LTcwMDE1MS03MDE0NTUtNzA1Mzg4LTcwOTE4?=
	=?us-ascii?B?NS03MDE0MjgtNzAyMTY5LTcwODE0My03MDA2MDctMTQ4MDM5LTE0?=
	=?us-ascii?B?ODA1MS0yMDA0MA==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72088>

Johannes Schindelin wrote:
> Hi,
> 
> On Wed, 30 Jan 2008, Brandon Casey wrote:
> 
>> This command requires a revision to be specified on the command line, so 
>> remove '--default HEAD' from the arguments to git rev-list. They are 
>> unnecessary.
> 
> But I thought that you wanted "git filter-branch --msg-filter=rot13" to 
> work on HEAD by default?

I do. But isn't that inconsistent with "git filter-branch" does _not_ work
on HEAD by default and instead prints out usage information?

If I do:

	git filter-branch -d /tmp/git_temp

and it is successful, I think I would also expect this to succeed:

	git filter-branch

So, I think the "operates on HEAD" by default is consistent with what other
git tools do, but I think it is not consistent for filter-branch to sometimes
operate on HEAD by default and sometimes error with usage information.

Disclaimer: I have only used filter-branch for two tasks.

-brandon
