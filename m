From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v2 0/4] implement automatic submodule merge strategy when possible
Date: Tue,  6 Jul 2010 21:34:30 +0200
Message-ID: <cover.1278444110.git.hvoigt@hvoigt.net>
Cc: git@vger.kernel.org, jens.lehmann@web.de, jherland@gmail.com
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jul 06 21:34:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWDun-0003j4-Pv
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 21:34:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755618Ab0GFTem (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 15:34:42 -0400
Received: from darksea.de ([83.133.111.250]:56038 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754608Ab0GFTei (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 15:34:38 -0400
Received: (qmail 13675 invoked from network); 6 Jul 2010 21:34:34 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 6 Jul 2010 21:34:34 +0200
X-Mailer: git-send-email 1.7.2.rc1.217.g7dc0db.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150400>


Changes since the previous iteration:

 * Add missing option --ancestry-path to setup_revisions()
 * Drop unnecessary caching of submodule refs
 * Use buf.len instead of NUL-padding for path buffer in
   git_path_submodule()
 * Extend the testcases so they will check for the correct suggestion
   output in case of a failed merge.
 * cleanup of some comments


Heiko Voigt (4):
  add missing && to submodule-merge testcase
  teach ref iteration module about submodules
  extent setup_revisions() so it works with submodules
  implement automatic fast forward merge for submodules

 cache.h                    |    3 +
 merge-recursive.c          |    9 ++-
 path.c                     |   38 +++++++++++
 refs.c                     |  149 ++++++++++++++++++++++++++++++++---------
 refs.h                     |    8 ++
 revision.c                 |   32 +++++----
 revision.h                 |    1 +
 submodule.c                |  158 ++++++++++++++++++++++++++++++++++++++++++++
 submodule.h                |    2 +
 t/t7405-submodule-merge.sh |  129 ++++++++++++++++++++++++++++++++++--
 10 files changed, 473 insertions(+), 56 deletions(-)

-- 
1.7.2.rc1.217.g7dc0db.dirty
