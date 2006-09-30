From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 0/6] ref deletion and D/F conflict avoidance with packed-refs.
Date: Sat, 30 Sep 2006 15:26:25 -0700
Message-ID: <7v1wptc7ou.fsf@assigned-by-dhcp.cox.net>
References: <20060930220158.d331bb7c.chriscool@tuxfamily.org>
	<7vmz8hccxl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 01 00:26:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTnI1-0002H1-Il
	for gcvg-git@gmane.org; Sun, 01 Oct 2006 00:26:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbWI3W0a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Sep 2006 18:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbWI3W03
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Sep 2006 18:26:29 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:27307 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751473AbWI3W02 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Sep 2006 18:26:28 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060930222628.FIGT21457.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>;
          Sat, 30 Sep 2006 18:26:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id UmSU1V00W1kojtg0000000
	Sat, 30 Sep 2006 18:26:30 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28154>

This series cleans up the area that was affected by the recent
addition of "packed-refs".  Christian Couder and Jeff King CC'ed
since they seem to be touching in the general vicinity of the
code these patches touch.

[1/6] ref locking: allow 'foo' when 'foo/bar' used to exist but not anymore.
[2/6] refs: minor restructuring of cached refs data.
[3/6] lock_ref_sha1(): do not sometimes error() and sometimes die().
[4/6] lock_ref_sha1(): check D/F conflict with packed ref when creating.
[5/6] delete_ref(): delete packed ref
[6/6] git-branch: remove D/F check done by hand.

I opted for removing from the packed-ref file when a ref that is
packed is deleted.  
