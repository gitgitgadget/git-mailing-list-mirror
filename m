From: Junio C Hamano <junkio@cox.net>
Subject: Re: [BUG] git-new-workdir doesn't understand packed refs
Date: Wed, 18 Apr 2007 11:17:43 -0700
Message-ID: <7vlkgph7i0.fsf@assigned-by-dhcp.cox.net>
References: <20070417161720.GA3930@xp.machine.xx>
	<Pine.LNX.4.64.0704172253140.14155@beast.quantumfyre.co.uk>
	<20070418055215.GA32634@xp.machine.xx>
	<7v7isajfl1.fsf@assigned-by-dhcp.cox.net>
	<20070418081122.GB32634@xp.machine.xx>
	<Pine.LNX.4.64.0704181251040.19261@reaper.quantumfyre.co.uk>
	<7vfy6xird9.fsf@assigned-by-dhcp.cox.net>
	<20070418174350.GB5913@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 18 20:17:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeEiy-0003yE-Gl
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 20:17:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753807AbXDRSRp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 14:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753873AbXDRSRp
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 14:17:45 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:55165 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753807AbXDRSRo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 14:17:44 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070418181744.FAKI1271.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Wed, 18 Apr 2007 14:17:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id oiHj1W00t1kojtg0000000; Wed, 18 Apr 2007 14:17:44 -0400
cc: Julian Phillips <julian@quantumfyre.co.uk>
In-Reply-To: <20070418174350.GB5913@xp.machine.xx> (Peter Baumann's message of
	"Wed, 18 Apr 2007 19:43:50 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44923>

Peter Baumann <waste.manager@gmx.de> writes:

> On Wed, Apr 18, 2007 at 09:23:14AM -0700, Junio C Hamano wrote:
>> 
>> Recursively dereferencing the symbolic link by hand to a limit
>> to avoid infinite recursion (error out when we reach the limit)
>> would be a more elaborate solution that probably is the right
>> thing to do.
>>
> I thought about the case where packed-refs is a symlink to another symlink
> and then decided that it's not worth to implement this because a workdir
> should be linked to a _repo_ and not another workdir.

That's incredibly weak, as the initial motivation of this patch
is that you did not want to say "you should run gc only in the
_repo_ not in workdir".
