From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 p1 00/13] fast-export and remote-testgit improvements
Date: Wed, 28 Nov 2012 23:10:56 +0100
Message-ID: <1354140669-23533-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 28 23:11:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tdpr4-0002XV-HR
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 23:11:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454Ab2K1WL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 17:11:27 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:43342 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755683Ab2K1WL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 17:11:26 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so5972393bkw.19
        for <git@vger.kernel.org>; Wed, 28 Nov 2012 14:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=XHRw6t7uAiKiTgPLPlNcILRtNjVo1POh8S+etpA5cbU=;
        b=E0XOjC5Bwin0ytiEnamM15z8t4/xR6AyPl3m0Riug+XPdl4n05dH29RNmhgQxkXpsQ
         /dQO2aKjrGuOE97haVSO+SlRHrk+Chtu96mrpT/2P/YOlzVUM2XoKfoN+lW8ENhjnamV
         NlAyuA8h2D1FUiVHvFjbZ48qcKn5/vpZhK2vGh6JxGGe98fmp5cnvahoVjDcjh42Jo8E
         BveAcHCkxAJQh7DRt2szxBM5OcBpc74+7/uB1i+h7wLke9mCdkSvvUn3j8zBZSE4KTi6
         ocZJYCLUyioJMbbYsftocCeFtIMdACXFMGafgIwQB3b5c/MBwnUzdRDykEijpPsHqPKj
         +Fmg==
Received: by 10.204.11.79 with SMTP id s15mr6295679bks.136.1354140684838;
        Wed, 28 Nov 2012 14:11:24 -0800 (PST)
Received: from localhost (ip-109-43-0-26.web.vodafone.de. [109.43.0.26])
        by mx.google.com with ESMTPS id 18sm4560338bkv.0.2012.11.28.14.11.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Nov 2012 14:11:23 -0800 (PST)
X-Mailer: git-send-email 1.8.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210784>

Hi,

Basically the same as v6, except the last patch was dropped, and testgit
switched to '#!/usr/bin/env bash'.

Shouldn't break any tests now.

Felipe Contreras (13):
  fast-export: avoid importing blob marks
  remote-testgit: fix direction of marks
  remote-helpers: fix failure message
  Rename git-remote-testgit to git-remote-testpy
  Add new simplified git-remote-testgit
  remote-testgit: remove non-local functionality
  remote-testgit: remove irrelevant test
  remote-testgit: cleanup tests
  remote-testgit: exercise more features
  remote-testgit: report success after an import
  remote-testgit: implement the "done" feature manually
  fast-export: trivial cleanup
  fast-export: fix comparison in tests

 .gitignore                           |   2 +-
 Documentation/git-remote-testgit.txt |   2 +-
 Makefile                             |   2 +-
 builtin/fast-export.c                |   6 +-
 git-remote-testgit                   |  90 ++++++++++++
 git-remote-testgit.py                | 272 -----------------------------------
 git-remote-testpy.py                 | 272 +++++++++++++++++++++++++++++++++++
 git_remote_helpers/git/importer.py   |   2 +-
 t/t5800-remote-helpers.sh            | 148 -------------------
 t/t5800-remote-testpy.sh             | 148 +++++++++++++++++++
 t/t5801-remote-helpers.sh            | 165 +++++++++++++++++++++
 t/t9350-fast-export.sh               |  20 ++-
 12 files changed, 701 insertions(+), 428 deletions(-)
 create mode 100755 git-remote-testgit
 delete mode 100644 git-remote-testgit.py
 create mode 100644 git-remote-testpy.py
 delete mode 100755 t/t5800-remote-helpers.sh
 create mode 100755 t/t5800-remote-testpy.sh
 create mode 100755 t/t5801-remote-helpers.sh

-- 
1.8.0.1
