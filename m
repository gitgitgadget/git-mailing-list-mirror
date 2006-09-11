From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git
Date: Sun, 10 Sep 2006 19:21:10 -0700
Message-ID: <7vk64bnnxl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Sep 11 04:20:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMbPR-00026n-VK
	for gcvg-git@gmane.org; Mon, 11 Sep 2006 04:20:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbWIKCU1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Sep 2006 22:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751009AbWIKCU1
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Sep 2006 22:20:27 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:20442 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750972AbWIKCU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Sep 2006 22:20:26 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060911022025.IHUB3535.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>;
          Sun, 10 Sep 2006 22:20:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id LqLG1V00D1kojtg0000000
	Sun, 10 Sep 2006 22:20:16 -0400
To: git@vger.kernel.org
X-maint-at: 60a6bf5f53635005f4f68d8b8a33172309193623
X-master-at: a41fae9c46a4cb5e59cc1a17d19f6a3a6cbfbb2f
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26828>

It's been two weeks since the last "What's in" update, so here
is the current status.

* The 'master' branch has these since the last announcement.

 - Andy Whitcroft spotted a long-standing bug that prevented 
   send-pack to deal correctly with a ref whose name is longer
   than 45 bytes, where we did not have to have any such limit.

 - Jakub Narebski keeps working on gitweb, with help from Aneesh
   Kumar, Dennis Stosberg, Luben Tuikov, and Martin Waitz.
   There are a lot of clean-ups, including these notables:

   - mechanism to selectively enable or disable features by site
     administrators and repository owners.
   - snapshot and blame are now elective features using the above.
   - gitweb no longer uses temporary files to generate diffs.

 - Jakub also updated a few autoconf stuff.

 - Christian Couder's GIT_TRACE updates.

 - Franck Bui-Huu's clean-up to the code for "format-patch -s".

 - git-daemon acquired a mechanism to selectively enable or
   disable features by site administrators and repository
   owners.

 - pack-objects validates the data it copies from existing pack
   or new-style loose objects.

 - Other small clean-ups, fixes and updates from Johannes Schindelin,
   Jonas Fonseca, Linus Torvalds, Martin Langhoff, Matthias Kestenholz,
   Sergey Vlasov and Shawn Pearce.

 - gitk updates from Paul Mackerras.


* The 'next' branch, in addition, has these.

 - Andy Whitcroft taught send-pack to use git-rev-list --stdin
   so that we do not have to be limited by the number of refs
   exec() command-line can hold.

 - Pasky's Git.pm is on hold; it was discussed and agreed that
   Git.xs layer was a bit premature and is hurting the adoption
   of the entire series.

 - Franck Bui-Huu and Rene Scharfe with a bit help from me added
   git-archive command to unify git-tar-tree/git-zip-tree and
   make them accessible over network.

 - Jeff King rewrote run_status() shell function in git-commit
   and git-status in C.

 - Per requests from the list, "git apply" automatically applies
   binary patches without having to be given --binary flag.

 - Likewise, "git diff --binary" does not give full index line for
   non-binary part of the patch anymore.

 - Pack-objects learned to run rev-list logic internally when
   given --revs parameter; the refs arguments you would normally
   give the upstream rev-list can be fed from its standard
   input, instead of usual list of objects.

 - Pack-objects also knows how to pretend objects that are in
   named packs are unpacked.  This would make easy to update
   repack to incrementally pack loose objects and recent
   "active" pack(s).

 - I have a few patches to upload-pack that would help
   upload-pack when downloader has more roots than the uploader
   has, but this is frozen until I hear real-world feedback.

 - unpack-objects learned a trick not to stop when fed a corrupt
   pack; instead it can make the best effort to recover from
   such an error that was detected.


* The 'pu' branch, in addition, has these.

 - I have a wip to implement index, working tree and zero or
   more trees in parallel but I haven't looked at it for some
   time.
