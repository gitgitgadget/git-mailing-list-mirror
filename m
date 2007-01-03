From: Junio C Hamano <junkio@cox.net>
Subject: preview of "What's cooking" (topics)
Date: Wed, 03 Jan 2007 02:25:03 -0800
Message-ID: <7virfopfuo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Wed Jan 03 11:25:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H23J6-0005wp-Fo
	for gcvg-git@gmane.org; Wed, 03 Jan 2007 11:25:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbXACKZG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 3 Jan 2007 05:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbXACKZG
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 05:25:06 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:49191 "EHLO
	fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706AbXACKZF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Jan 2007 05:25:05 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070103102504.LGDL19398.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>;
          Wed, 3 Jan 2007 05:25:04 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 6aRJ1W00S1kojtg0000000; Wed, 03 Jan 2007 05:25:19 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35855>

My git day this week hasn't started yet, but for people to base
their improvements on, here is a quick status before I go to
bed.

 - Detached HEAD along with two patches to teach git-status and
   git-branch about not being on any branch are in 'pu'; I
   removed -d option from git-checkout from the previous round.

 - J=FCrgen's git-status improvements are mostly in 'next' but
   one of them is queued in 'pu', waiting for comments.

 - I've queued my counterproposal to Shawn's lockfile fix in
   'pu', waiting for comments.

On the 'master' front, I've merged Andy's xwrite() loop.  I
think this is applicable to many other places after generalizing
it a bit more and perhaps merging it with safe_write in
pkt-line.c.

builtin-apply.c, builtin-unpack-objects.c, copy.c, csum-file.c,
index-pack.c, merge-recursive.c and pkt-line.c have
implementations of something very similar, with different policy
on error handling.

Also index-pack.c and upload-pack.c (in the status reporting
code path) also has unprotected xwrite() that can result in
short write.

Have fun.
