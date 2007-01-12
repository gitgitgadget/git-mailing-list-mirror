From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-status: wording update to deal with deleted files.
Date: Thu, 11 Jan 2007 16:13:06 -0800
Message-ID: <7v1wm114rx.fsf@assigned-by-dhcp.cox.net>
References: <87bql5cok3.fsf@morpheus.local>
	<7vejq12nlu.fsf@assigned-by-dhcp.cox.net>
	<7vsleh16ey.fsf_-_@assigned-by-dhcp.cox.net>
	<87ac0pxgl2.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 12 01:13:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5A31-0000Yd-3V
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 01:13:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531AbXALAN2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 19:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751533AbXALAN2
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 19:13:28 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:37288 "EHLO
	fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751531AbXALAN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 19:13:27 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070112001326.ZTDH2628.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Thu, 11 Jan 2007 19:13:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id A0Cb1W0091kojtg0000000; Thu, 11 Jan 2007 19:12:35 -0500
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <87ac0pxgl2.wl%cworth@cworth.org> (Carl Worth's message of "Thu,
	11 Jan 2007 15:56:57 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36640>

Carl Worth <cworth@cworth.org> writes:

> ... So conceptually, the user can be left
> with, "hmm... it's not updated, but how the heck do I update it?".
>
>>  - Suggestion is "git add ... to update what will be committed",
>>    instead of "... to add content to commit";
>>
>>  - If there are removed paths, the above suggestion becomes "git
>>    add/rm ... to update what will be committed";
>
> Here now we do start providing the user with some mechanisms for
> "update". Sometimes we suggest using "add" to update, and sometimes we
> suggest using "add" or "rm" to update. But as you yourself have
> pointed out, you consider "rm" a totally pointless command.

You are twisting my words ;-).

"rm" is pointless for a workflow that always uses "commit -a".
In the same sense, the three categorization "git-status" gives
is pointless -- "changed but not updated" class does not have
any significance if you always do "commit -a".

But that is not the only workflow we encourage.

I do encourage "commit -a" or "commit after update-index" and
frown upon but tolerate "commit <paths>..." --- all of the above
is in line with this world view.   And the categorization and
suggestions are about the latter: "commit after update-index".

Then the issue is how to expose update-index to the end users.
"add" is about adding the content.  What's unfortunate is that
adding a file as zero-length content is still different from
removing it.

Honestly, removing is so different from the norm that I do not
see major inconsistency nor inconvenience, practically nor in
philosophy, to have two separate Porcelain-ish commands, add and
rm, to perform content additions and removal.
