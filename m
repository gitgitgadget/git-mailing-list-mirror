From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: clarify git clone --local --shared --reference
Date: Mon, 04 Jun 2007 18:53:34 -0500
Message-ID: <4664A5FE.30208@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 05 02:17:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvMjW-0006lr-5L
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 02:17:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754168AbXFEARD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 20:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756052AbXFEARD
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 20:17:03 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:57688 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754168AbXFEARB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 20:17:01 -0400
X-Greylist: delayed 1402 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Jun 2007 20:17:00 EDT
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id l54Npi8n029336
	for <git@vger.kernel.org>; Mon, 4 Jun 2007 18:51:47 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 4 Jun 2007 18:53:34 -0500
User-Agent: Thunderbird 2.0.0.0 (X11/20070326)
X-OriginalArrivalTime: 04 Jun 2007 23:53:34.0870 (UTC) FILETIME=[90291360:01C7A703]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-3.6.0.1039-15212001
X-TM-AS-Result: : Yes--9.194700-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNjY4LTE1MDY3My0xNDcw?=
	=?us-ascii?B?MTgtNzA0OTI3LTcwNTI0OS03MDE1NzYtNzExNDMyLTcwMzc4OC03?=
	=?us-ascii?B?MDQwMzQtNzA1MTAyLTcwMTkxNC03MDIzNTgtNzAxNzkxLTE4NzA2?=
	=?us-ascii?B?Ny03MDg2MjUtNzA3MTE5LTcwOTU4NC03MDExNDItMTA2MjMwLTEy?=
	=?us-ascii?B?MTgyOC03MDMzNTUtNzExOTUzLTcwMDQwNS03MDU1ODQtNzA2NDU0?=
	=?us-ascii?B?LTcwMTcxOS03MDAzOTgtNzA5OTA4LTcwNTE2Ny03MDU5MDEtNzAy?=
	=?us-ascii?B?NzI2LTcwMTgzNy03MDM3MTItNzA0MzExLTcwMjA4NC03MDQ0OTYt?=
	=?us-ascii?B?NzA0MjE3LTcwNDQzNS03MDU0NjEtNzAxNDM3LTcwNDQyNS03MDIw?=
	=?us-ascii?B?NDQtNzAxNDU1LTcwMDEwNy0xNDgwNTE=?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49143>


I think the goal of these three objects is space savings (and speed),
but I don't understand when I should prefer one option over another, or
when/whether to use a combination of them. And I am unsure (SCARED)
about any side effects they may have.

This is all based on the information in git-clone.txt. If there is more
detail someplace else please let me know.

1) What does local mean?
   --local says repository must be on the "local" machine and claims it
   attempts to make hardlinks when possible. Of course hard links cannot
   be created across filesystems, so are there other speedups/space
   savings when repository is on local machine but not on the same
   filesystem? Is this option still valid then?

2) Does --shared imply shared write access? Does --local?
    I'll point out that git-init has an option with the same name.

3) --shared seems like a special case of --reference? Are there
    differences?

4) what happens if the source repository dissappears? Is --local ok
    but --shared screwed?

4) is space savings obtained only at initial clone? or is it on going?
    does a future git pull from the source repository create new hard
    links where possible?

Can --shared be used with --reference. Can --reference be used multiple 
times (and would I want to). Does -l with -s get you anything? (the
examples use this)

thanks,
-brandon
