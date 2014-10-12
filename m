From: Max Kirillov <max@max630.net>
Subject: [PATCH 0/4] Multiple worktrees vs. submodules fixes
Date: Sun, 12 Oct 2014 08:13:07 +0300
Message-ID: <1413090791-14428-1-git-send-email-max@max630.net>
Cc: git@vger.kernel.org, Max Kirillov <max@max630.net>
To: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Oct 12 07:14:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XdBTq-0006vU-CH
	for gcvg-git-2@plane.gmane.org; Sun, 12 Oct 2014 07:14:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbaJLFN6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2014 01:13:58 -0400
Received: from p3plsmtpa09-01.prod.phx3.secureserver.net ([173.201.193.230]:40291
	"EHLO p3plsmtpa09-01.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750848AbaJLFNy (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Oct 2014 01:13:54 -0400
Received: from wheezy.pp.htv.fi ([82.181.81.240])
	by p3plsmtpa09-01.prod.phx3.secureserver.net with 
	id 25Dj1p00F5B68XE015DoUV; Sat, 11 Oct 2014 22:13:51 -0700
X-Mailer: git-send-email 2.0.1.1697.g73c6810
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi.

These are fixes of issues with submodules with use of multiple working
trees.

To be applied on top of the $gmane/257559, (6b4ce012cb in current pu).

Max Kirillov (4):
  checkout: do not fail if target is an empty directory
  submodule refactor: use git_path_submodule() in add_submodule_odb()
  git-common-dir: make "modules/" per-working-directory directory
  path: implement common_dir handling in git_path_submodule()

 Documentation/gitrepository-layout.txt |  4 +--
 builtin/checkout.c                     |  2 +-
 cache.h                                |  1 +
 path.c                                 | 26 +++++++++++---
 setup.c                                | 17 +++++++---
 submodule.c                            | 28 ++++++---------
 t/t2025-checkout-to.sh                 |  7 +++-
 t/t7410-submodule-checkout-to.sh       | 62 ++++++++++++++++++++++++++++++++++
 8 files changed, 114 insertions(+), 33 deletions(-)
 create mode 100755 t/t7410-submodule-checkout-to.sh

-- 
2.0.1.1697.g73c6810
