From: Max Kirillov <max@max630.net>
Subject: [PATCH v3 0/3] Multiple worktrees vs. submodules fixes
Date: Tue,  9 Dec 2014 06:44:40 +0200
Message-ID: <1418100283-8995-1-git-send-email-max@max630.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Max Kirillov <max@max630.net>
To: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Dec 09 05:44:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyCfT-0000s0-7D
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 05:44:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756484AbaLIEoz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 23:44:55 -0500
Received: from p3plsmtpa08-04.prod.phx3.secureserver.net ([173.201.193.105]:38567
	"EHLO p3plsmtpa08-04.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755745AbaLIEoy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Dec 2014 23:44:54 -0500
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa08-04.prod.phx3.secureserver.net with 
	id RGkh1p00V5B68XE01GknvH; Mon, 08 Dec 2014 21:44:53 -0700
X-Mailer: git-send-email 2.2.0.50.gb2b6831
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261107>

After discussions I came to basically same as v1.

* Resubmitting the 2 patches which have not been taken to worktrees reroll -
  they fix visible issue. Mostly unchanged except small cleanup in test.
* Added GIT_COMMON_DIR to local_repo_env. While it is obviously a right
  thing, I wasn't able to observe any change in behavior.

Max Kirillov (3):
  submodule refactor: use git_path_submodule() in add_submodule_odb()
  path: implement common_dir handling in git_path_submodule()
  Add GIT_COMMON_DIR to local_repo_env

 cache.h                          |  1 +
 environment.c                    |  1 +
 path.c                           | 24 ++++++++++++++++++++----
 setup.c                          | 17 ++++++++++++-----
 submodule.c                      | 28 ++++++++++------------------
 t/t7410-submodule-checkout-to.sh | 10 ++++++++++
 6 files changed, 54 insertions(+), 27 deletions(-)

-- 
2.2.0.50.gb2b6831
