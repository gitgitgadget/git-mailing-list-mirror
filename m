From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH v2] gc: call "prune --expire 2.weeks.ago" by default
Date: Wed, 12 Mar 2008 12:56:11 -0500
Message-ID: <47D8193B.901@nrlssc.navy.mil>
References: <alpine.LSU.1.00.0803112157560.3873@racer.site> <7vskywadum.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0803112234470.2947@xanadu.home> <alpine.LSU.1.00.0803121833210.1656@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 12 18:57:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZVCo-0006Hi-9U
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 18:57:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752009AbYCLR4y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 13:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751909AbYCLR4y
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 13:56:54 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:51158 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833AbYCLR4y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 13:56:54 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m2CHuBJK022649;
	Wed, 12 Mar 2008 12:56:11 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 12 Mar 2008 12:56:11 -0500
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <alpine.LSU.1.00.0803121833210.1656@racer.site>
X-OriginalArrivalTime: 12 Mar 2008 17:56:11.0206 (UTC) FILETIME=[5B3B1E60:01C8846A]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15778001
X-TM-AS-Result: : Yes--12.302000-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTE1MDcwNC0xNTA2?=
	=?us-ascii?B?NjgtNzAwMDc1LTEzOTAxMC03MDE0NTUtNzAyMDQ0LTcwMDE5NC03?=
	=?us-ascii?B?MDU3NTQtNzA0NDI1LTcwMzc4OC03MDUxMDItNzAzNzEyLTcwMjk2?=
	=?us-ascii?B?Mi03MDQ5MjctNzA2MDYwLTcwMDY5My03MDE3MzUtNzAyMzU4LTEx?=
	=?us-ascii?B?MDA1My03MDY0NTQtNzAxNzE5LTcwOTU4NC03MDQ5ODMtNzA0Nzgy?=
	=?us-ascii?B?LTE0ODAzOS0xNDgwNTEtMjAwNDI=?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76969>

Johannes Schindelin wrote:
> If you want to override this grace period, just set the config variable
> gc.pruneExpire to a different value; an example would be
> 
> 	[gc]
> 		pruneExpire = 6.months.ago
> 
> if you feel really paranoid.
> 
> Note that this new behaviour does not affect git-gc when you pass the
> option --prune; in that case, prune will clean up the loose objects with no
> grace period at all.

Hmm. Perhaps 'git-gc' should always call 'prune' with the '--expire' argument
for simplicity of the 'git-gc' interface and --prune should become a noop?

Is 'git-gc --prune' still useful to end users when those in-the-know can use
git-prune when they really want all loose unreferenced objects to be removed?

Also, what about clones created with --shared or --reference? Should there be
a way to disable this functionality? gc.pruneExpire never

-brandon
