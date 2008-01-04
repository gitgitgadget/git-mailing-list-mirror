From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] git stash: one bug and one feature request
Date: Fri, 04 Jan 2008 12:34:37 -0600
Message-ID: <477E7C3D.8030501@nrlssc.navy.mil>
References: <e5bfff550801040814n82f34b2g17c485a207093440@mail.gmail.com>	 <Pine.LNX.4.64.0801041030420.31161@torch.nrlssc.navy.mil>	 <477E6D26.9020809@obry.net>	 <e5bfff550801040944p7f8e722asfa726b34a4a712fa@mail.gmail.com>	 <477E7439.9090209@nrlssc.navy.mil> <e5bfff550801041005x3ab682dam8535c7bde75038dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Pascal Obry <pascal@obry.net>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 04 19:35:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JArOT-0006hF-JH
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 19:35:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751829AbYADSfU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 13:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752251AbYADSfT
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 13:35:19 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:43492 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692AbYADSfT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 13:35:19 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m04IYeSv021321;
	Fri, 4 Jan 2008 12:34:40 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 4 Jan 2008 12:34:38 -0600
User-Agent: Thunderbird 2.0.0.6 (X11/20070728)
In-Reply-To: <e5bfff550801041005x3ab682dam8535c7bde75038dc@mail.gmail.com>
X-OriginalArrivalTime: 04 Jan 2008 18:34:38.0167 (UTC) FILETIME=[76326E70:01C84F00]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15638001
X-TM-AS-Result: : Yes--16.294900-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTcwMDA3NS0xMzkw?=
	=?us-ascii?B?MTAtNzAwMTYwLTcwMzQ1NC03MDQ0MjEtNzA0NDI1LTcwNzQ1MS03?=
	=?us-ascii?B?MDE0NTUtNzAxOTM3LTcwOTkwOC03MDMxNTctNzAzMzkzLTcwMjYz?=
	=?us-ascii?B?OC03MDM4MDctNzAxMjAyLTcwMjA0NC03MDM3ODgtNzAwNjkzLTcw?=
	=?us-ascii?B?MzMzMC03MDE0NjEtNzAzNjkyLTE0ODAzOS0yMDA0Mg==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69591>

Marco Costalba wrote:
> On Jan 4, 2008 7:00 PM, Brandon Casey <casey@nrlssc.navy.mil> wrote:
>> Marco Costalba wrote:
>>> Ok, drop is better then clear, but, if we need to add a new command I
>>> vote for 'delete' or 'rm' to be consistent with git naming.
>> If the stash list is thought of as a stack, then drop makes sense.
>>
> 
> Yes, but is _not_ as a stack because you can say
> 
> git stash apply stash@{3}
> git stash apply stash@{1}
> git stash apply stash@{4}
> 
> i.e. you can access reflogs in any order, so thinking to a stack is
> misleading IMHO.

I think it is like a stack because new things are always added to the top
and shift everything else down.
i.e. we can't say 'git stash replace stash@{3}' and we probably wouldn't
want to.

When we call git stash, the previous item on 'top' is pushed down
so that it is the second item stash@{1}. The new item just stashed
(pushed), is now on top at stash@{0}.

Doesn't seem like too far of a stretch.

-brandon
