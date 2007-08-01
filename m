From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: Git benchmark - comparison with Bazaar, Darcs, Git and Mercurial
Date: Wed, 01 Aug 2007 17:49:06 -0500
Message-ID: <46B10DE2.5060702@nrlssc.navy.mil>
References: <200708010216.59750.jnareb@gmail.com> <alpine.LFD.0.999.0707311850220.4161@woody.linux-foundation.org> <7vodhrby6f.fsf@assigned-by-dhcp.cox.net> <20070801092428.GB28106@thunk.org> <7vr6mn5znm.fsf@assigned-by-dhcp.cox.net> <20070801220350.GD28106@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Aug 02 00:49:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGN0c-0003do-1U
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 00:49:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753783AbXHAWtf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 18:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753899AbXHAWte
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 18:49:34 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:56212 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753779AbXHAWte (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 18:49:34 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id l71Mj2AK003590;
	Wed, 1 Aug 2007 17:45:05 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 1 Aug 2007 17:49:07 -0500
User-Agent: Thunderbird 2.0.0.5 (X11/20070716)
In-Reply-To: <20070801220350.GD28106@thunk.org>
X-OriginalArrivalTime: 01 Aug 2007 22:49:07.0321 (UTC) FILETIME=[2AE16E90:01C7D48E]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-3.6.0.1039-15334001
X-TM-AS-Result: : Yes--6.360000-0-2-1
X-TM-AS-Category-Info: : 2:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTcwMDA3NS0xMzkw?=
	=?us-ascii?B?MTAtNzAyMDA1LTcwMTA2Ni03MDkxMzctNzExNDMyLTcwNDg1Mi03?=
	=?us-ascii?B?MDI2MDktNzA2NzM3LTcwMTQ1NS03MTE5NTMtNzA0OTI3LTcwMDA1?=
	=?us-ascii?B?Ny03MDA3NzEtNzAyMzU4LTcwNDQzMC03MDA5MzYtNzAyNzI2LTM5?=
	=?us-ascii?B?MDExMy03MDA4MTUtNzA5MDY1LTcwMTgzNy0xODgwMTktMTA2NDIw?=
	=?us-ascii?B?LTcwNzIyNS03MDI2MjYtNzAzOTY4LTcwMDc1Ni03MDMyMzgtNzAx?=
	=?us-ascii?B?NTc2LTcwMzc4OC0xNDgwMzktMTQ4MDUxLTIwMDQw?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54495>

Theodore Tso wrote:
> On Wed, Aug 01, 2007 at 03:15:25AM -0700, Junio C Hamano wrote:

>> Perhaps if the destination is local,
>>
>>          - if -s is given, just set up alternates, do nothing else;
> 
> As I understand it, the main objection with making -s the default is
> surprising result that could happen if you do a git-prune in the base
> repository which causes objects which are borrowed from the base
> repository via .git/objects/info/alternates, right?

-s would be a lot safer to use if repack -a -d (as used by git-gc) was smarter.
-a -d has the nasty side effect of doing what it seems only prune is intended
to do... that is to remove unreferenced objects.

-s usage currently has to be very well thought out, unless you're just using it
for a short-lived temporary branch. If this unintended pruning could be avoided
then an average user could go about their merry business repacking and git-gc'ing
without a care, and only when doing a git-gc --prune would they need to do
something special.

-brandon
