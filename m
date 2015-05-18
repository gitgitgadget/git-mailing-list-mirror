From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 0/8] Improve git-pull test coverage
Date: Mon, 18 May 2015 21:32:50 +0800
Message-ID: <1431955978-17890-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 18 15:33:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuLAc-0000yh-GF
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 15:33:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753963AbbERNdP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 09:33:15 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:34549 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752717AbbERNdK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 09:33:10 -0400
Received: by pdbnk13 with SMTP id nk13so54534086pdb.1
        for <git@vger.kernel.org>; Mon, 18 May 2015 06:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=mhnBNIVF3pGMf0/lQd+PZUvD2Uy81XNqaKJsmbNen9c=;
        b=sJ4xAHTu69lzddwgUSW70PWtbrOYzfIOaBok+1Oaz2SnfB/BLCsH7erlDsxEmV7MYj
         Fb6yhyK1/f0YRMYkn9FeVbp/jnN+jWIkRMCcKRjRakGjjjyouMwVyEJkj3OpJqdVyb94
         uqMfK5OaQqF134QuEeNTeGOfsCtC7vP62QOsw0V+aJKpw7xtup7AabiCl4/l4DgBi3Fm
         65IbVS2a+Lf1X/3l1M9GtTSvewZzQ+Sb02dfkeob+1gRkgVUDHKFBheE4dMqqtCN2Dj4
         5RO7ln8I1hdkVqF+1r7zKz8Q1nIiJxFLudpS48QqQJbZakYmKZzSo5GLGswvDZ05l8F4
         B47A==
X-Received: by 10.67.2.98 with SMTP id bn2mr44974581pad.83.1431955989734;
        Mon, 18 May 2015 06:33:09 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id da2sm10119540pbb.57.2015.05.18.06.33.07
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 May 2015 06:33:08 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269236>

This is a re-roll of [1]. This series depends on jc/merge.

This patch series improves test coverage of git-pull.sh, and is part of my
GSoC project to rewrite git-pull into a builtin. Improving test coverage
helps to prevent regressions that could occur due to the rewrite.

This re-roll contains various small fixups. It also removes the use of
"verbose" for now, since its use is currently under discussion.

Thanks Junio and Matthieu for the reviews last round, and thanks Michael for
reporting the test failure.

[1] http://thread.gmane.org/gmane.comp.version-control.git/268950

Paul Tan (8):
  t5520: prevent field splitting in content comparisons
  t5520: test no merge candidates cases
  t5520: test for failure if index has unresolved entries
  t5520: test work tree fast-forward when fetch updates head
  t5520: test --rebase with multiple branches
  t5520: test --rebase failure on unborn branch with index
  t5521: test --dry-run does not make any changes
  t5520: check reflog action in fast-forward merge

 t/t5520-pull.sh         | 199 +++++++++++++++++++++++++++++++++++++++---------
 t/t5521-pull-options.sh |  13 ++++
 2 files changed, 176 insertions(+), 36 deletions(-)

-- 
2.1.4
