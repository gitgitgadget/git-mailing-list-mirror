From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH 00/11] More preparatory work for multiparent tree-walker
Date: Fri,  7 Feb 2014 21:48:41 +0400
Message-ID: <cover.1391794688.git.kirr@mns.spb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@mns.spb.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 07 18:47:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBpWJ-0000Nk-Sk
	for gcvg-git-2@plane.gmane.org; Fri, 07 Feb 2014 18:47:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753229AbaBGRrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Feb 2014 12:47:12 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:33758 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752964AbaBGRrL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Feb 2014 12:47:11 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1WBpW6-0002Kf-Cj; Fri, 07 Feb 2014 21:47:06 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1WBpXr-00049z-NX; Fri, 07 Feb 2014 21:48:55 +0400
X-Mailer: git-send-email 1.9.rc1.181.g641f458
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241777>

Here I'm preparing tree-diff.c to be ready for the new tree-walker, so that the
final change is tractable and looks good and non noisy. Some small speedups
are gained along the way. The final bits are almost ready, but I don't want to
release them in a hurry.

Please apply and thanks,
Kirill

Kirill Smelkov (11):
  tree-diff: show_tree() is not needed
  tree-diff: consolidate code for emitting diffs and recursion in one place
  tree-diff: don't assume compare_tree_entry() returns -1,0,1
  tree-diff: move all action-taking code out of compare_tree_entry()
  tree-diff: rename compare_tree_entry -> tree_entry_pathcmp
  tree-diff: show_path prototype is not needed anymore
  tree-diff: simplify tree_entry_pathcmp
  tree-diff: remove special-case diff-emitting code for empty-tree cases
  tree-diff: rework diff_tree interface to be sha1 based
  tree-diff: no need to call "full" diff_tree_sha1 from show_path()
  tree-diff: reuse base str(buf) memory on sub-tree recursion

 diff.h      |   4 +-
 tree-diff.c | 270 ++++++++++++++++++++++++++++++++----------------------------
 2 files changed, 145 insertions(+), 129 deletions(-)

-- 
1.9.rc1.181.g641f458
