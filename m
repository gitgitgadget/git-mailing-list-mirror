From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 0/7] Improve git-pull test coverage
Date: Sat,  2 May 2015 23:37:08 +0800
Message-ID: <1430581035-29464-1-git-send-email-pyokagan@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 02 17:37:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoZTx-0002wB-TP
	for gcvg-git-2@plane.gmane.org; Sat, 02 May 2015 17:37:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197AbbEBPhY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 May 2015 11:37:24 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:33317 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106AbbEBPhX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2015 11:37:23 -0400
Received: by pdbnk13 with SMTP id nk13so121283789pdb.0
        for <git@vger.kernel.org>; Sat, 02 May 2015 08:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=4v1t2iiYqLvcvWZ4m/zdHLHk+tnOQrXByIG2c01mIwI=;
        b=kBnO+fTHZKO4T3OSA9vUSDvPH5GvR6W8S5RT0YjJXuX3cmJvVYSF5AtHux7FzOcTKi
         r3oXeZZIBcjOxHaKuRbaiq63XvqNUnx1By8Ps+u1TQZgIfdXJc5M86u/HTrq8fHBKfuV
         f4Kv81izEYRThD8FYkoB+4kU3eLNpd0/l80Usv9VB/s36SLrfI04eWqu2kZlkK8C3F9S
         IlRhWULYxxcxSgUHYWkJdlP+Y5Bvrb4bRAMN4otNPwN8WRGLMmJ2sH1zzakARupjRdoZ
         0GMBxc873tKzl5xDIe/88Tk7zd55xwF5Y9GJlvRj/jEH8NC/eGHFjryZsP49keQ+TqZR
         Fr9A==
X-Received: by 10.70.102.11 with SMTP id fk11mr27285032pdb.144.1430581043349;
        Sat, 02 May 2015 08:37:23 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.172.217])
        by mx.google.com with ESMTPSA id tk9sm7925072pbc.35.2015.05.02.08.37.19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 02 May 2015 08:37:20 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268231>

This patch series improves test coverage of git-pull.sh from 50.9%[1] to
73.4%[2]. Take the test coverage reports with a grain of salt though, as there
are known deficiencies[3].

This is part of my GSoC project to rewrite git-pull into a builtin. Improving
test coverage helps to prevent regressions that could occur due to the rewrite.

[1] http://pyokagan.github.io/git/20150430132408-a75942b//kcov-merged/git-pull.360f32c2.html
[2] http://pyokagan.github.io/git/20150502145725-c94dfc2//kcov-merged/git-pull.360f32c2.html
[3] https://github.com/pyokagan/git/commit/a7d6ab4677b97afd789b0ce860280c80f70f6e32

Paul Tan (7):
  t5520: test pulling multiple branches into an empty repository
  t5520: implement tests for no merge candidates cases
  t5520: test for failure if index has unresolved entries
  t5520: test work tree fast-forward when fetch updates head
  t5520: test --rebase with multiple branches
  t5520: test --rebase failure on unborn branch with index
  t5521: test --dry-run does not make any changes

 t/t5520-pull.sh         | 119 ++++++++++++++++++++++++++++++++++++++++++++++++
 t/t5521-pull-options.sh |  13 ++++++
 2 files changed, 132 insertions(+)

-- 
2.1.4
