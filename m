From: David Barr <david.barr@cordelta.com>
Subject: vcs-svn: purge obsolete data structures and code
Date: Sat, 19 Mar 2011 18:03:42 +1100
Message-ID: <1300518231-20008-1-git-send-email-david.barr@cordelta.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 19 08:12:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0qKr-0004lS-1h
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 08:12:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754013Ab1CSHMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 03:12:13 -0400
Received: from [119.15.97.146] ([119.15.97.146]:57042 "EHLO mailhost.cordelta"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753395Ab1CSHML (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 03:12:11 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailhost.cordelta (Postfix) with ESMTP id 12C96C04C;
	Sat, 19 Mar 2011 18:00:32 +1100 (EST)
X-Virus-Scanned: amavisd-new at mailhost.cordelta
Received: from mailhost.cordelta ([127.0.0.1])
	by localhost (mailhost.cordelta [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xGlgPsyxFGKG; Sat, 19 Mar 2011 18:00:27 +1100 (EST)
Received: from dba.cordelta (unknown [192.168.123.140])
	by mailhost.cordelta (Postfix) with ESMTP id B9F3DC046;
	Sat, 19 Mar 2011 18:00:27 +1100 (EST)
X-Mailer: git-send-email 1.7.3.2.846.gf4b062
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169386>

Patches 1-8:
Now that vcs-svn delegates tracking the repository structure to
fast-import, reorganise the code and drop the internal data
structures and supporting code.

Patch 9:
One final optimisation jumps out after the clean up, apply it.

 .gitignore              |    3 -
 Makefile                |   13 +--
 t/t0080-vcs-svn.sh      |  117 ---------------------
 test-obj-pool.c         |  116 ---------------------
 test-string-pool.c      |   31 ------
 test-treap.c            |   70 -------------
 vcs-svn/LICENSE         |    3 -
 vcs-svn/fast_export.c   |   64 ++++++------
 vcs-svn/fast_export.h   |   14 ++--
 vcs-svn/obj_pool.h      |   61 -----------
 vcs-svn/repo_tree.c     |   36 ++-----
 vcs-svn/repo_tree.h     |   12 +--
 vcs-svn/string_pool.c   |  113 --------------------
 vcs-svn/string_pool.h   |   12 --
 vcs-svn/string_pool.txt |   43 --------
 vcs-svn/svndump.c       |  260 ++++++++++++++++++++++++++---------------------
 vcs-svn/trp.h           |  237 ------------------------------------------
 vcs-svn/trp.txt         |  109 --------------------
 18 files changed, 197 insertions(+), 1117 deletions(-)
