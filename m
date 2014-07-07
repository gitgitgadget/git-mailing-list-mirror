From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 00/10] Add --graft option to git replace
Date: Mon, 07 Jul 2014 08:35:29 +0200
Message-ID: <20140707063342.3708.83493.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 08:36:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X42XZ-00073p-3U
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jul 2014 08:36:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639AbaGGGgg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2014 02:36:36 -0400
Received: from [194.158.98.45] ([194.158.98.45]:37386 "EHLO mail-3y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750889AbaGGGgf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2014 02:36:35 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id AA1B445;
	Mon,  7 Jul 2014 08:36:12 +0200 (CEST)
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252947>

Here is a small series to implement:

        git replace [-f] --graft <commit> [<parent>...]

This patch series goes on top of the patch series that
implements --edit.

The changes since v5, thanks to Junio, are:

- new patch 1/10 to clean up redirection style in t6050

- new patches 8/10, 9/10 and 10/10 to check mergetags

- add functions to test parents in patch 3/10 and 7/10

- improve testing signed commits in patch 7/10

- improve warning when removing commit signature in
  patch 6/10

Christian Couder (10):
  replace: cleanup redirection style in tests
  replace: add --graft option
  replace: add test for --graft
  Documentation: replace: add --graft option
  contrib: add convert-grafts-to-replace-refs.sh
  replace: remove signature when using --graft
  replace: add test for --graft with signed commit
  commit: add for_each_mergetag()
  replace: check mergetags when using --graft
  replace: add test for --graft with a mergetag

 Documentation/git-replace.txt             |  10 +++
 builtin/replace.c                         | 126 +++++++++++++++++++++++++++-
 commit.c                                  |  47 +++++++++++
 commit.h                                  |   7 ++
 contrib/convert-grafts-to-replace-refs.sh |  28 +++++++
 log-tree.c                                |  15 +---
 t/t6050-replace.sh                        | 135 ++++++++++++++++++++++++------
 7 files changed, 332 insertions(+), 36 deletions(-)
 create mode 100755 contrib/convert-grafts-to-replace-refs.sh

-- 
2.0.0.421.g786a89d.dirty
