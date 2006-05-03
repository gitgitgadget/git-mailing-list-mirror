From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git
Date: Wed, 03 May 2006 11:54:18 -0700
Message-ID: <7vac9zdjmt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed May 03 20:54:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbMUR-0003AB-4n
	for gcvg-git@gmane.org; Wed, 03 May 2006 20:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWECSyU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 14:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbWECSyU
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 14:54:20 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:38106 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1750733AbWECSyT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 May 2006 14:54:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060503185418.QKYD15447.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 3 May 2006 14:54:18 -0400
To: git@vger.kernel.org
X-maint-at: e923effb43fa952f9cb72ffe4c3625fce7655bff
X-master-at: 3d990f110c2e5b8df83f6ab3ef83497f43c7fd47
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19512>

* The 'maint' branch has these fixes since the last announcement.

 - Documentation cleanups (Sean Estabrooks)
 - git-format-patch uses rfc2822 compliant date (Huw Davies).
 - git-am usability fixes (Robert Shearman and me)
 - Fix filename verification when in a subdirectory (Linus)
 - git-send-email debuggability improvements (Martin Langhoff)
 - annotate fixes (Matthias Kestenholz)
 - rebase: typofix.
 - commit-tree.c: check_valid() microoptimization.
 - verify-pack: check integrity in a saner order.


* The 'master' branch has these since the last announcement, in
  addition to the above fixes.

 - gitk views and highlights enhancements (Paul Mackerras).
 - repo-config -l (Petr Baudis and Johannes Schindelin)
 - repo-config white-space fix (Johannes Schindelin)
 - diff --stat fix.
 - revision parsing more strictly checks "rev -- paths"
 - t0000-basic: more commit-tree tests.
 - Extended SHA1 -- "rev^@" syntax to mean "all parents"
 - Fix "git help -a" terminal autosizing (Linus)
 - git-fetch: resolve remote symrefs for HTTP transport (Nick Hengeveld)
 - daemon: socksetup: don't return on set_reuse_addr() error (Serge E. Hallyn)


* The 'next' branch, in addition, has these.

 - built-in git-count-objects
 - built-in git-diff.
 - built-in git-push (Linus with fix by Johannes Schindelin).
 - built-in git-log.
 - built-in git-grep.

   These not only implement them built-in, but remove the
   corresponding shell script versions.  I think all of them are
   ready to be pushed out, so expect them soon in your "master"
   branch ;-).

 - repo-config: support --get-regexp (Johannes Schindelin)
 - core.prefersymlinkrefs: use symlinks for .git/HEAD
 - get_sha1(): :path and :[0-3]:path to extract from index.
 
  Needs a bit more testing.

 - further diff-delta improvements (Nicolas Pitre)

   Benchmark impressions are welcome on this.  

 - cache-tree optimization

   This yields a nice speedup to (apply then write-tree)+
   sequence, but is rather intrusive and risky (if somebody
   forgets to invalidate a cached information the next write
   tree can write out corrupt data).  I am hoping we can redo
   this inside the index.

 - built-in git-fmt-patch

   This is not ready as format-patch replacement yet; it only
   does --stdout.

* The 'pu' branch, in addition, has these.

 - read-tree: --prefix=<path> option.
 - write-tree: --exclude=<prefix>
 - write-tree: --prefix=<path>
      
   These were originally done as part of "bind commit" series,
   but are useful outside the context of subproject support.
   read-tree --prefix=<path> allows you to graft a tree object
   at a subdirectory in an already populated index, and
   write-tree --prefix=<path> allows you to write out only a
   subdirectory out of an index as a tree object.  I am not in
   an urgent need for these features, but if some Porcelain
   finds them useful, they can be merged to "next".
