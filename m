From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: OSX, ZFS, UTF8, git - somebody hates me in this list
Date: Sun, 04 May 2008 14:07:35 -0700
Message-ID: <86wsm9dbhk.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 04 23:09:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JslRn-0005j8-Ax
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 23:08:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757882AbYEDVHh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 17:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757880AbYEDVHh
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 17:07:37 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:9816 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753131AbYEDVHg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 17:07:36 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 654531DE211; Sun,  4 May 2008 14:07:35 -0700 (PDT)
x-mayan-date: Long count = 12.19.15.5.8; tzolkin = 2 Lamat; haab = 11 Uo
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81200>


repeat by:
    0) download the OSX ZFS drivers
    1) Make a ZFS partition on OSX.
    2) Clone git.git to the ZFS partition
    3) immediately type git-status:

    # On branch master
    # Untracked files:
    #   (use "git add <file>..." to include in what will be committed)
    #
    #       "gitweb/test/Ma\314\210rchen"
    nothing added to commit but untracked files present (use "git add" to track)

    4) try "git-clean -f"
    Removing "gitweb/test/Ma\314\210rchen"

    5) try git-status now:
    # On branch master
    # Changed but not updated:
    #   (use "git add/rm <file>..." to update what will be committed)
    #
    #       deleted:    "gitweb/test/M\303\244rchen"
    #
    no changes added to commit (use "git add" and/or "git commit -a")

    6) still broken.  try git-reset --hard HEAD
    HEAD is now at c697ad1 Cleanup xread() loops to use read_in_full()
    7) and now git-status again:

    # On branch master
    # Untracked files:
    #   (use "git add <file>..." to include in what will be committed)
    #
    #       "gitweb/test/Ma\314\210rchen"
    nothing added to commit but untracked files present (use "git add" to track)

That's broke, and a show-stopper for me to use ZFS on OSX.  Ugh.

Can someone with ZFS on solaris try this, to try to figure out if this
is a problem with git, ZFS, OSX, or some combination?

Thanks.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.vox.com/ for Smalltalk and Seaside discussion
