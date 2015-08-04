From: Max Kirillov <max@max630.net>
Subject: [PATCH v6 0/2] path: implement common_dir handling in git_path_submodule()
Date: Wed,  5 Aug 2015 00:51:05 +0300
Message-ID: <1438725067-3295-1-git-send-email-max@max630.net>
References: <1438635836-7857-1-git-send-email-max@max630.net>
Cc: Max Kirillov <max@max630.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>, Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 23:58:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMkEU-0004RO-A2
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 23:58:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752976AbbHDV6d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 17:58:33 -0400
Received: from p3plsmtpa12-05.prod.phx3.secureserver.net ([68.178.252.234]:60383
	"EHLO p3plsmtpa12-05.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752609AbbHDV6c (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Aug 2015 17:58:32 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Aug 2015 17:58:32 EDT
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa12-05.prod.phx3.secureserver.net with 
	id 0lr71r00D5B68XE01lrM44; Tue, 04 Aug 2015 14:51:23 -0700
X-Mailer: git-send-email 2.3.4.2801.g3d0809b
In-Reply-To: <1438635836-7857-1-git-send-email-max@max630.net>
In-Reply-to: <1438635836-7857-1-git-send-email-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275338>

Fixed the pointer declaration spacing issue and updated commit messages.

The 1/2 refactoring still might leave some cases behind. I could grep only function
connect_work_tree_and_git_dir() which, as far as I can see, involved in moving repositories.
Have not touched it because correct moving parts of multiple-worktree
repositories probably is a bigger task than just fix config file location.

Max Kirillov (2):
  submodule refactor: use git_path_submodule() in add_submodule_odb()
  path: implement common_dir handling in git_path_submodule()

 cache.h                          |  1 +
 path.c                           | 24 ++++++++++++++++++++----
 setup.c                          | 17 ++++++++++++-----
 submodule.c                      | 28 ++++++++++------------------
 t/t7410-submodule-checkout-to.sh | 10 ++++++++++
 5 files changed, 53 insertions(+), 27 deletions(-)

-- 
2.3.4.2801.g3d0809b
