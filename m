From: Junio C Hamano <junkio@cox.net>
Subject: Re: how to filter a pull
Date: Thu, 03 May 2007 11:21:04 -0700
Message-ID: <7vwszpzs33.fsf@assigned-by-dhcp.cox.net>
References: <20070503131704.GA7036@kernoel.kernoel.fr>
	<20070503150752.GB6500@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, marc.zonzon@gmail.com
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 03 20:21:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjfvU-0007ra-MO
	for gcvg-git@gmane.org; Thu, 03 May 2007 20:21:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161484AbXECSVJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 May 2007 14:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755263AbXECSVJ
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 14:21:09 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:45470 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755257AbXECSVH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2007 14:21:07 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070503182105.XBBK1268.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Thu, 3 May 2007 14:21:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id uiM41W00M1kojtg0000000; Thu, 03 May 2007 14:21:05 -0400
In-Reply-To: <20070503150752.GB6500@xp.machine.xx> (Peter Baumann's message of
	"Thu, 3 May 2007 17:07:52 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46093>

Peter Baumann <waste.manager@gmx.de> writes:

> On Thu, May 03, 2007 at 03:17:05PM +0200, marc.zonzon@gmail.com wrote:

>> I have projects that draw some parts from two or three other
>> projects. But it is usually some small part, that are included, and
>> patched in my project. I want to follow the development of these fellow
>> projects.
>> ...
> Perhaps the newly added merge strategy subtree [1] could work. Or the
> just added subproject support, but this is very new and only the lowlevel machinery
> is implemented right now.

I do not think subtree merge would work with this situation, as
it is only for cases that one side of the merge represents a
tree that is a subset of the tree of the other side of the
merge.  marc.zonzon's case does not fit the pattern.

If I were doing this 6 months from now, I would probably use
subproject to host the whole tree of other projects somewhere,
adjust the build procedure of the primary project to borrow the whole of these other
projects not just subtree -- or have appropriate symlinks in the
superproject that point into relevant subtrees in the
subprojects.

If I were doing this today, I would probably use separate
repositories, next to the primary project, to host the whole
tree of other projects, adjust the build procedure of the
primary project to borrow the whole of these other projects not
just subtree -- and/or have appropriate symlinks in the primary
project that point into relevant subtrees in the neighbouring
repositories that host these other projects.
