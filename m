X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git (stable)
Date: Sun, 17 Dec 2006 23:26:18 -0800
Message-ID: <7v64c93bs5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 18 Dec 2006 07:26:24 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-maint-at: 7da41f48c8acea834e8204917fe59da2b975903b
X-master-at: 64fe031a7a78894955af217335b46059a36a582d
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34719>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwCtD-0005sj-1n for gcvg-git@gmane.org; Mon, 18 Dec
 2006 08:26:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753440AbWLRH0U (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006
 02:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753441AbWLRH0U
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 02:26:20 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:53407 "EHLO
 fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1753440AbWLRH0T (ORCPT <rfc822;git@vger.kernel.org>); Mon, 18 Dec 2006
 02:26:19 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061218072618.QMHA25875.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>; Mon, 18
 Dec 2006 02:26:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id 07SW1W00p1kojtg0000000; Mon, 18 Dec 2006
 02:26:31 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

I've updated 'master' with a handful topics along with a few
fixes:

 - Jakub's gitweb updates;

 - blame A..B's output shows lines attributed to the boundary
   commit with commit SHA-1 prefixed with '^';

 - "branch -m $old $new" renames branch.$old.* configuration
   variables to branch.$new.*;

 - "git add A/B C", when A and C/D used to be tracked files, now
   properly works, it used to result in a bogus index you cannot
   write-tree out;

 - "git show-branch --reflog=<n> <branch>" shows latest n entries
   of the reflog of the branch.

 - "git fetch" between repositories with tons of refs had huge
   performance problem; hopefully fixed.

* The 'master' branch has these since the last announcement.

   Jakub Narebski (8):
      gitweb: Don't use Content-Encoding: header in git_snapshot
      gitweb: Show target of symbolic link in "tree" view
      gitweb: Add generic git_object subroutine to display object of any type
      gitweb: Hyperlink target of symbolic link in "tree" view (if possible)
      gitweb: SHA-1 in commit log message links to "object" view
      gitweb: Do not show difftree for merges in "commit" view
      gitweb: Add title attribute to ref marker with full ref name
      gitweb: Add "next" link to commit view

   Johannes Schindelin (2):
      add a function to rename sections in the config
      git-branch: rename config vars branch.<branch>.*, too

   Junio C Hamano (11):
      git-blame: show lines attributed to boundary commits differently.
      update-index: make D/F conflict error a bit more verbose.
      git-add: remove conflicting entry when adding.
      Fix check_file_directory_conflict().
      Fix mis-mark-up in git-merge-file.txt documentation
      markup fix in svnimport documentation.
      Teach show-branch how to show ref-log data.
      git-fetch: Avoid reading packed refs over and over again
      avoid accessing _all_ loose refs in git-show-ref --verify
      show-ref: fix --quiet --verify
      show-ref: fix --verify --hash=length

   Quy Tonthat (1):
      Documentation: new option -P for git-svnimport

   Shawn Pearce (1):
      Default GIT_COMMITTER_NAME to login name in recieve-pack.
