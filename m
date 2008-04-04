From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] git-clone.txt: Adjust note to --shared for new pruning
 behavior of git-gc
Date: Fri, 04 Apr 2008 09:25:53 -0500
Message-ID: <47F63A71.2010100@nrlssc.navy.mil>
References: <47F52145.306@nrlssc.navy.mil>	<alpine.LSU.1.00.0804032113280.4008@racer.site>	<47F54342.1040901@nrlssc.navy.mil>	<alpine.LSU.1.00.0804032200310.4008@racer.site> <m3prt6t8sn.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 04 16:27:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jhmsn-0000Hd-Jn
	for gcvg-git-2@gmane.org; Fri, 04 Apr 2008 16:27:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755567AbYDDO00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Apr 2008 10:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752031AbYDDO00
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Apr 2008 10:26:26 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:47536 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755419AbYDDO0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Apr 2008 10:26:25 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m34EPtvO002842;
	Fri, 4 Apr 2008 09:25:55 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 4 Apr 2008 09:25:54 -0500
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <m3prt6t8sn.fsf@localhost.localdomain>
X-OriginalArrivalTime: 04 Apr 2008 14:25:54.0264 (UTC) FILETIME=[CA72CD80:01C8965F]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15820001
X-TM-AS-Result: : Yes--16.925000-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTE1MDY2OC03MDAw?=
	=?us-ascii?B?NzUtMTM5MDEwLTcwMzczMS03MDU5MDEtNzA0NDEwLTcwMDczMy03?=
	=?us-ascii?B?MDA2OTMtNzA0OTI3LTcwMzc4OC03MDE3MTktNzExOTUzLTcwNjA2?=
	=?us-ascii?B?MC03MDkyOTEtNzAxNzM1LTcwMTQ1NS03MDEyODQtNzA0OTgzLTcw?=
	=?us-ascii?B?MjY0MC03MDEzODQtNzA1Mzg4LTcxMDgzMy03MTA4MzctMTQ4MDM5?=
	=?us-ascii?B?LTE0ODA1MS0yMDA0Mg==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78807>

Jakub Narebski wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>> On Thu, 3 Apr 2008, Brandon Casey wrote:
>>> But what I was really trying to point out in the documentation changes 
>>> was that now _other_ commands such as git-commit are also unsafe since 
>>> they call 'git-gc --auto' and could cause loose unreferenced objects to 
>>> be deleted. So it is not enough to just avoid calling git-gc when 
>>> dealing with a --shared repository.
>> Right.  Hmm.  I missed that completely when I thought about prune 
>> --expire.
> 
> I think that if you are using repository from which other repos borrow
> objects via alternates, it is a good idea to turn off automatic
> repacking with "git gc --auto" by setting gc.auto to 0

Either that or disable only the automatic pruning by setting gc.pruneexpire
to never.

> (or, hopefully, "never" or "false").

I think those only work for dates and booleans respectively. gc.auto is
parsed as an int.

-brandon
