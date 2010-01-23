From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv4 0/5] git-gui: more robust handling of fancy repos
Date: Sat, 23 Jan 2010 11:03:33 +0100
Message-ID: <1264241018-6616-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Markus Heidelberg <markus.heidelberg@web.de>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 23 11:04:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYcr7-0000WZ-Fo
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 11:04:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754744Ab0AWKEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 05:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754740Ab0AWKEH
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 05:04:07 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:64393 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751590Ab0AWKEC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 05:04:02 -0500
Received: by fxm21 with SMTP id 21so155449fxm.29
        for <git@vger.kernel.org>; Sat, 23 Jan 2010 02:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=23PthbEILHdFnZ7W7HKC+7Dwesd0JoV/uJsPSUizv2w=;
        b=AZMbJ4IcewAB+IUPxTXlkSXHiCgdzUhh/msw7CA169oeVkJGhqp+FApUFjQmqTI6d/
         HhUVl/YwI+8jlHkMcLt7zi5FepWEj/UUx6VEjv6jdYg20n+wAn8AHCmwVKIcfUCB2okj
         kxVkf7t3GmkrVR2mfUJqrGstgy2XAPAHS+0pg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=SYgUIPBrlc0eF+42AoXpKSd3Y/urp/xg7iPcv/+oDgot4SrlqvyJ+VyvZKi5GgNjgK
         zSx0Qnug0lCTaz8+G1Pb943lcNSJw6Gxw6C6fCtBXOXr9TMZsjxo3zq0967hWDpbfurr
         XTQk3zGY2aR8oZ7a4XaBxbKb4H3kHKAycbAKQ=
Received: by 10.103.127.35 with SMTP id e35mr2097712mun.45.1264241041318;
        Sat, 23 Jan 2010 02:04:01 -0800 (PST)
Received: from localhost ([151.60.177.52])
        by mx.google.com with ESMTPS id u26sm12099573mug.15.2010.01.23.02.03.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 23 Jan 2010 02:04:00 -0800 (PST)
X-Mailer: git-send-email 1.6.6.rc1.295.g3a4e71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137828>

A re-issue of the patchest to make git-gui more robust towards
non-standard repository setup, with two additional fixes.

The first three patches are unchanged from the previous iteration (still
waiting for review, actually).

The 4th sets GIT_DIR and GIT_WORK_TREE in git-gui to ensure that all
external tool invocation work in the same setup.

The last one also updates the shortcut library to make use of
_gitworktree instead of the old assumption that the worktree is the
updir of the git dir. I can't really test this patch though because
I don't have Windows.


Giuseppe Bilotta (5):
  git-gui: handle non-standard worktree locations
  git-gui: handle bare repos correctly
  git-gui: work from the .git dir
  git-gui: set GIT_DIR and GIT_WORK_TREE after setup
  git-gui: update shortcut tools to use _gitworktree

 git-gui/git-gui.sh       |  101 ++++++++++++++++++++++++++++++++++------------
 git-gui/lib/shortcut.tcl |    7 ++-
 2 files changed, 79 insertions(+), 29 deletions(-)
