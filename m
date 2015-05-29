From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v5 0/8] Improve git-pull test coverage
Date: Fri, 29 May 2015 19:44:37 +0800
Message-ID: <1432899885-25143-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 29 13:45:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyIih-0003mO-Qf
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 13:45:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754472AbbE2Lo4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 07:44:56 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34779 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485AbbE2Loy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 07:44:54 -0400
Received: by pabru16 with SMTP id ru16so56092429pab.1
        for <git@vger.kernel.org>; Fri, 29 May 2015 04:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=gEoFEgE27OdPadA+gAAmK5NsVCV1B1m9Qg9UCs7gAbM=;
        b=ika64HDeoKn+GV4WaIXviU0rCiDLjL/yJApSH8HOQBTKN2fka4LzJyAhT/bb9iT+qN
         jTu5NYt8QNUQP3gTtFJ9DmxlwWFVwIQ8T1eIQgzmrW3josmqFs6yxh7ypgsRIS9vlZ9J
         25gUKHMDY0H9H7rTS56rdcYYZxXcBMxg9nUhKq5jbCKO7KgTveE5HNLF7b1e6t3rHYL/
         YqmFsy9K6ryNIu9fAiWjpjKCcJOv/WBz2sWb5F0Re5ZE300Coz0X/wUxdupZzIc/sBPS
         vvG4hF5DhGM7fWNI3JZnCHx7k6REqC1r0BkyyczssWLb5irVfwzStZJKD87Ib7M8o+fx
         2sQg==
X-Received: by 10.66.163.38 with SMTP id yf6mr14154950pab.115.1432899894127;
        Fri, 29 May 2015 04:44:54 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qg5sm5392460pdb.13.2015.05.29.04.44.51
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 May 2015 04:44:52 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270228>

This is a re-roll of [1].

This patch series improves test coverage of git-pull.sh, and is part of my
GSoC project to rewrite git-pull into a builtin. Improving test coverage
helps to prevent regressions that could occur due to the rewrite.

Thanks Junio, Johannes and Stefan for the reviews last round.

[1] http://thread.gmane.org/gmane.comp.version-control.git/269236

Paul Tan (8):
  t5520: prevent field splitting in content comparisons
  t5520: test no merge candidates cases
  t5520: test for failure if index has unresolved entries
  t5520: test work tree fast-forward when fetch updates head
  t5520: test --rebase with multiple branches
  t5520: test --rebase failure on unborn branch with index
  t5521: test --dry-run does not make any changes
  t5520: check reflog action in fast-forward merge

 t/t5520-pull.sh         | 198 +++++++++++++++++++++++++++++++++++++++---------
 t/t5521-pull-options.sh |  13 ++++
 2 files changed, 175 insertions(+), 36 deletions(-)

-- 
2.1.4
