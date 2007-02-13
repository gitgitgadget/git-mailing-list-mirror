From: Junio C Hamano <junkio@cox.net>
Subject: linux-2.6.git/packed-refs???
Date: Tue, 13 Feb 2007 01:27:03 -0800
Message-ID: <7v7ium1k7s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: torvalds@linux-foundation.org
X-From: git-owner@vger.kernel.org Tue Feb 13 10:27:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGtwQ-0005Ee-Pj
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 10:27:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbXBMJ1H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 04:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbXBMJ1H
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 04:27:07 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:38213 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225AbXBMJ1F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 04:27:05 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070213092703.ETBQ22948.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Tue, 13 Feb 2007 04:27:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id NxT31W00X1kojtg0000000; Tue, 13 Feb 2007 04:27:04 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39504>

I noticed while scanning #git log that it appears that pack-refs
was run in your public repo and some people cannot clone over
dumb protocols with older git.

    commit 2986c02217f98809d8990e7679edf0f5d99f904d
    Author: Junio C Hamano <junkio@cox.net>
    Date:   Wed Nov 22 22:24:09 2006 -0800

    git-fetch: fix dumb protocol transport to fetch from pack-pruned ref

was the first revision that aligned dumb protocol clients with
pack-ref; unfortunately anything older will not find the ref
that was packed.

We do have a backward compatibility warning on this in v1.5.0
release notes draft, but I think we would make it more obvious.

Sigh...
