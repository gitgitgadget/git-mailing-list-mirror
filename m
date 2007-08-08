From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-svn: Finding the svn-URL of the current branch in git
Date: Wed, 08 Aug 2007 02:13:48 -0700
Message-ID: <7vy7gm4cdv.fsf@assigned-by-dhcp.cox.net>
References: <46B8BA03.1030809@gmx.de> <20070807205543.GB27703@xp.machine.xx>
	<f9c0d1$7md$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthias Kleine <matthias_kleine@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 08 11:13:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIhc2-0003bG-BW
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 11:13:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753164AbXHHJNx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 05:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753057AbXHHJNx
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 05:13:53 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:56784 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752381AbXHHJNt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 05:13:49 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070808091349.VDKW7349.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Wed, 8 Aug 2007 05:13:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ZMDo1X0041kojtg0000000; Wed, 08 Aug 2007 05:13:48 -0400
In-Reply-To: <f9c0d1$7md$1@sea.gmane.org> (Matthias Kleine's message of "Wed,
	08 Aug 2007 10:54:55 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55309>

Matthias Kleine <matthias_kleine@gmx.de> writes:

> Peter Baumann wrote:
>>
>> I had this situation, too.
>>
>>
>> 			a = svn branch 'a'
>> 	  m		b = svn branch 'b' (in my case, it was trunk)
>>       /   \		m = a merge of branch 'a' and 'b', not yet commited to svn
>>      a     b
>>
>> So trying to dcommit m, git svn can't figure out on which branch, as 'a'
>> and 'b' are both reachable. I had to use a graft file to lose one of the
>> parents, which let git-svn commit to SVN.
>
> You're right, both 'a' and 'b' are reachable from 'm'.  But if I got
> it right 'm' also contains information as to which one is the first
> parent and thereby which branch we're on. So wouldn't it be enough, if
> git-svn automatically chose the first parent (using log
> --first-parent)?

Parents' order and which branch you are on may not have anything
to do with each other.  Somebody else may have pulled a while on
b, and you might have pulled from him the merge he created by
doing so while you are on branch a.
