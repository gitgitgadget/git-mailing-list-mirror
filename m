From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git
Date: Wed, 26 Apr 2006 04:09:32 -0700
Message-ID: <7vhd4goaoj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 26 13:09:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYhu0-0002Ot-Lc
	for gcvg-git@gmane.org; Wed, 26 Apr 2006 13:09:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbWDZLJe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Apr 2006 07:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932392AbWDZLJe
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Apr 2006 07:09:34 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:19161 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932394AbWDZLJd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Apr 2006 07:09:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060426110932.ZBXP25666.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 26 Apr 2006 07:09:32 -0400
To: git@vger.kernel.org
X-maint-at: 7d09fbe4ab7f080a8f8f5dcef7e0f3edf5e26019
X-master-at: 3496277a561307c3d31d2085347af8eb4c667c36
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19198>

* The 'maint' branch has fixes mentioned in the 1.3.1 
  announcement.

  As I outlined in the 1.3.1 maintenance release announcement,
  people with that release will soon be missing many
  improvements.  The following is a list of what to expect.


* In addition to the above. the 'master' branch has these since
  the last announcement,

  - git-update-index --chmod=+x now affects all the subsequent
    files (Alex Riesen).

  - git-update-index --unresolve paths...; this needs
    documentation (hint).

  - minor "diff --stat" and "show --stat" fixes.

  - Makefile dependency fixes.  This fixes the infamous
    "libgit.a still contains stale diff.o" problem.

  - contrib has colordiff that understands --cc output.

  - beginning of libified "git diff" family.

  - git-commit-tree <ent> -p <parent> now takes extended SHA1
    expression, not limited to 40-byte SHA1, for <ent> (it
    already did so for <parent>).

  - updated gitk to handle repositories with large number of
    tags and heads (Paul).


* The 'next' branch, in addition, has these.

  - internal log/show/whatchanged family (Linus and me).

  - beginning of internal format-patch.

  - Geert's similarity code in contrib/

  - cache-tree optimization to speed up git-apply + write-tree
    cycles.

    Initially I was getting close to 50% improvement, but
    re-benching suggests it is more like 16%.  An earlier
    version in 'next' used a separate .git/index.aux to record
    the cache-tree information but now it is stored as part of
    the index.  If you used previous 'next' (ha, ha) version and
    see tmp-indexXXXX.aux or next-indexXXXX.aux files left in
    your $GIT_DIR, they can safely be removed.

  - more "diff --stat" fixes.

  - git-cvsserver: typofixes.

  - diff-delta interface reorganization (Nico)

  - git-repo-config --list (Pasky)


* The 'pu' branch, in addition, has these.

  - resurrect "bind commit"; this has been done only partially.

    I have not updated the rev-list/fsck-objects yet.  Probably
    need to drop the specific "bind " line and replace it with
    "link object bind" in the commit objects before going
    forward.

  - get_sha1(): :path and :[0-3]:path to extract from index.

  - Loosening path argument check a little bit in revision.c.

    I've been meaning to do the opposite of this, the tightening
    of ambiguous case mentione by Linus, but haven't got around
    to yet (I haven't got around to too many things, hint hint).

  - reverse the pack-objects delta window logic (Nico)

    This is in theory the right thing to do, but things are not
    quite there yet.  But Nico is on top of it so we will see
    quite an improvement in the pack generation hopefully very
    soon.
