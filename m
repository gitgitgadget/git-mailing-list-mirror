From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [WIP PATCH 0/5] Build in merge
Date: Sat, 24 May 2008 02:01:03 +0200
Message-ID: <cover.1211586801.git.vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 24 02:02:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzhD4-00012y-5d
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 02:02:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758896AbYEXABP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 20:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753774AbYEXABN
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 20:01:13 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:36659 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757771AbYEXABH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 20:01:07 -0400
Received: from vmobile.example.net (catv-5062e605.catv.broadband.hu [80.98.230.5])
	by yugo.frugalware.org (Postfix) with ESMTP id 84CAD1DDC5B
	for <git@vger.kernel.org>; Sat, 24 May 2008 02:01:04 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 6C348185E1A; Sat, 24 May 2008 02:01:08 +0200 (CEST)
X-Mailer: git-send-email 1.5.5.1.357.g1af8b.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

This is a work in progress patch, reflecting the current status of
builtin-merge I have. As far as I know all the tests pass, but there are
still some work to do. In general, a few problems I'm aware of:

 1) There are still TODOs/FIXMEs in the code.

 2) It should be possible to avoid some exec() calls, like write-tree,
    show-branch and fmt-merge-msg.

 3) Minor memory leaks.

Other than that, comments are welcome.

Miklos Vajna (5):
  Move reset_index_file() to a new reset.c
  Move split_cmdline() to libgit
  Make verbosity configurable in reset_index_file()
  Move commit_list_count() to commit.c
  Build in merge

 Makefile                                      |    4 +-
 alias.c                                       |   54 ++
 builtin-merge-recursive.c                     |    8 -
 builtin-merge.c                               | 1117 +++++++++++++++++++++++++
 builtin-reset.c                               |   19 +-
 builtin.h                                     |    1 +
 cache.h                                       |    1 +
 commit.c                                      |    8 +
 commit.h                                      |    1 +
 git-merge.sh => contrib/examples/git-merge.sh |    0 
 git.c                                         |   54 +--
 reset.c                                       |   29 +
 reset.h                                       |    6 +
 13 files changed, 1223 insertions(+), 79 deletions(-)
 create mode 100644 builtin-merge.c
 rename git-merge.sh => contrib/examples/git-merge.sh (100%)
 create mode 100644 reset.c
 create mode 100644 reset.h
