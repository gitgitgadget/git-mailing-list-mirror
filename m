From: Junio C Hamano <junkio@cox.net>
Subject: What's cooking in git.git (topics)
Date: Wed, 23 May 2007 14:46:24 -0700
Message-ID: <7vodkb1adr.fsf@assigned-by-dhcp.cox.net>
References: <7v646wqrvm.fsf@assigned-by-dhcp.cox.net>
	<7vfy5wcnbg.fsf@assigned-by-dhcp.cox.net>
	<7vd50xz7lq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 23 23:46:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hqyf7-0003sj-R2
	for gcvg-git@gmane.org; Wed, 23 May 2007 23:46:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755552AbXEWVq0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 17:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755589AbXEWVq0
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 17:46:26 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:59895 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755552AbXEWVqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 17:46:25 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070523214624.PQNH2758.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Wed, 23 May 2007 17:46:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 2lmP1X00H1kojtg0000000; Wed, 23 May 2007 17:46:24 -0400
X-master-at: ed82edc402c271a707da632083f1f4c19155d573
X-next-at: 2c002c6df80d087f20ee36691e19acf63e2ef9f4
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48179>

Nothing controversial has been queued since v1.5.2 yet.

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The topics list the commits in reverse chronological
order.

* fl/cvsserver (Mon May 21 00:31:58 2007 +0200) 3 commits
 + t9400: Add some basic pserver tests
 + t9400: Add some more cvs update tests
 + t9400: Add test cases for config file handling

Will push this out on 'master' by the end of this week.

* dh/repack (Wed May 23 10:11:33 2007 -0700) 6 commits
 + pack-objects: clarification & option checks for --max-pack-size
 + git-repack --max-pack-size: add option parsing to enable feature
 + git-repack --max-pack-size: split packs as asked by
   write_{object,one}()
 + git-repack --max-pack-size: write_{object,one}() respect pack
   limit
 + git-repack --max-pack-size: new file statics and code
   restructuring
 + Alter sha1close() 3rd argument to request flush only

I've commented on this series in a separate message.  Looks
quite clean modulo a few minor details, which was fixed up this
morning.  Will be in 'master' shortly.

* db/remote (Tue May 15 22:50:19 2007 -0400) 4 commits
 + Update local tracking refs when pushing
 + Add handlers for fetch-side configuration of remotes.
 + Move refspec parser from connect.c and cache.h to remote.{c,h}
 + Move remote parsing into a library file out of builtin-push.

Will need to look at this once more; I do not expect too much
problems with it.

* jc/nodelta (Tue May 22 23:04:49 2007 -0700) 3 commits
 + builtin-pack-objects: remove unnecessary code for no-delta
 + Teach "delta" attribute to pack-objects.
 + pack-objects: pass fullname down to add_object_entry()

I am a bit worried about potential performance penalty that can
come from attribute look-up on big trees, which I've never
measured so far.  Independent measurement would be very much
appreciated, and if it turns out to be too bad, we might want to
discard this.

The remainder is backburnered.

* jc/blame (Fri Apr 20 16:25:50 2007 -0700) 4 commits
* jc/diff (Mon Dec 25 01:08:50 2006 -0800) 2 commits
