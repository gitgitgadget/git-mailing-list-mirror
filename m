From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] Add platform-independent .git "symlink"
Date: Mon, 04 Feb 2008 15:17:56 -0600
Message-ID: <47A78104.9050909@nrlssc.navy.mil>
References: <8c5c35580802020959v613b9e32v321e97f93f2af761@mail.gmail.com> <1201975757-13771-1-git-send-email-hjemli@gmail.com> <alpine.LSU.1.00.0802021815510.7372@racer.site> <alpine.LSU.1.00.0802021825220.7372@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Lars Hjemli <hjemli@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 04 22:20:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM8jQ-0006uO-I9
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 22:20:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755588AbYBDVSJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 16:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757408AbYBDVSI
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 16:18:08 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:56820 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755588AbYBDVSG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 16:18:06 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m14LHuv1012452;
	Mon, 4 Feb 2008 15:17:57 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 4 Feb 2008 15:17:56 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <alpine.LSU.1.00.0802021825220.7372@racer.site>
X-OriginalArrivalTime: 04 Feb 2008 21:17:56.0574 (UTC) FILETIME=[694EEFE0:01C86773]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15706001
X-TM-AS-Result: : Yes--17.342000-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTcwMDA3NS0xMzkw?=
	=?us-ascii?B?MTAtNzAxNDU1LTE4NzA2Ny03MDQwNTEtNzAyMDIwLTcwNDQyNS03?=
	=?us-ascii?B?MDQ3ODItNzA0MjU3LTE4ODAxOS03MDUzODgtNzA4MTc5LTcwNzEx?=
	=?us-ascii?B?OS03MDE4MzctNzEwNDQyLTcwNTEwMi03MDA0NTQtNzA3NjYzLTcw?=
	=?us-ascii?B?MTcxOS0xODgxOTgtNzAwMTMzLTcwNDcxMi03MDI2MjYtNzA5MTM3?=
	=?us-ascii?B?LTE0ODAzOS0xNDgwNTEtMjAwNDA=?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72571>

Johannes Schindelin wrote:
> Hi,
> 
> BTW just to tell you why I am so excited with your patch: I have a patch 
> to git-branch in my tree, which implements the git-new-workdir 
> functionality (it's a patch to git-branch, not git-checkout, mainly 
> because git-checkout is no builtin yet).

Are you planning something that works like:

  $ cd <my_repo>
  $ git branch
    * master
      other_branch
  $ git checkout --new-workdir ../<other_work_dir> other_branch

(not sure how it would work using git-branch).

Have you thought about using git-clone instead?

It seems a good fit but would require a new option to specify a
branch to checkout (which I believe is a requested feature for
clone). --shared seems like a good option name*, too bad it's
already taken. But how about --conjoined to communicate that the new
repo and the original repo are "attached at the hip"?

  $ git clone --conjoined -b other_branch <my_repo> <other_work_dir>

-brandon

* I really do think "shared" is the most appropriate since _both_
  repos would be sharing, rather than the current meaning or shared which
  is just a short-hand for --reference and in which the original repo gets
  nothing from the selfish "sharer".
