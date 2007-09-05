From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: People unaware of the importance of "git gc"?
Date: Wed, 5 Sep 2007 13:46:42 -0500 (CDT)
Message-ID: <Pine.LNX.4.64.0709051339420.30020@torch.nrlssc.navy.mil>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
 <20070905174427.GC13314@fieldses.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Wed Sep 05 20:47:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISzuG-00032q-K7
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 20:47:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754643AbXIESrJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 14:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754491AbXIESrI
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 14:47:08 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:34212 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754459AbXIESrG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 14:47:06 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id l85Ikgd2005814;
	Wed, 5 Sep 2007 13:46:45 -0500
Received: from torch.nrlssc.navy.mil ([128.160.25.59]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 5 Sep 2007 13:46:42 -0500
In-Reply-To: <20070905174427.GC13314@fieldses.org>
X-OriginalArrivalTime: 05 Sep 2007 18:46:42.0776 (UTC) FILETIME=[1A1D3D80:01C7EFED]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-3.6.0.1039-15336001
X-TM-AS-Result: : Yes--6.188300-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTcwNzcwMS03MDAw?=
	=?us-ascii?B?NzUtMTM5MDEwLTcwMTIyMi03MDY4OTEtNzA2MjQ5LTcwMjEyNi03?=
	=?us-ascii?B?MDQ5MjEtNzA4MzI4LTEwNjQyMC03MDQ5MjctNzAxNTEzLTcwNTQ1?=
	=?us-ascii?B?MC03MDQ0MzAtNzAyMzQ3LTcwMTU3Ni03MDMxNTctNzAxNzE5LTEy?=
	=?us-ascii?B?MTExNC0xNDgwMzktMTQ4MDUwLTIwMDQw?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57737>

On Wed, 5 Sep 2007, J. Bruce Fields wrote:

> Well, this may just prove I'm an idiot, but one of the reasons I rarely
> run it is that I have trouble remembering exactly what it does; in
> particular,
>
> 	- does it prune anything that might be needed by a repo I
> 	  cloned with -s?

     YES! yikes.

This is about the best argument put forth so far for not automatically
running git-gc. Personally, I think git-gc should not remove unreferenced
objects without --prune (but I haven't done anything about it). But even
if git-gc was modified in this way, an occasional git-gc --prune would
still be necessary to remove all of the unreferenced and dangling objects
safely with a human thinking about the shared repo implications (unless
shared repo handling is modified).

-brandon
