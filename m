From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [PATCH v4 0/2] push limitations
Date: Sun, 14 Aug 2011 10:57:40 +0200
Message-ID: <1313312262-2460-1-git-send-email-iveqy@iveqy.com>
Cc: git@vger.kernel.org, jens.lehmann@web.de, hvoigt@hvoigt.net,
	iveqy@iveqy.com
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Aug 14 10:58:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsWWZ-0002NJ-HE
	for gcvg-git-2@lo.gmane.org; Sun, 14 Aug 2011 10:58:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752599Ab1HNI6R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Aug 2011 04:58:17 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42814 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751939Ab1HNI6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2011 04:58:16 -0400
Received: by bke11 with SMTP id 11so2448236bke.19
        for <git@vger.kernel.org>; Sun, 14 Aug 2011 01:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=woRI5FJ1M4KadzcOduvGFUnljMWc/9GNzZ2l420fNGU=;
        b=AZrHc/2xM37qrxgYR6eP9IL+DCy7UZ81eJlUYlPUZQe7Ve2u6UYhxj6V/F7Kv66e34
         kxqnxfVi/xd7HikAXQ2a1gzg79aVqnSwtL3hNUpvpqeK+1RnXxACOfytR4DHlQebW8Fl
         /NMdsrHl59/I9znnDEbwfb9751bYWS3McKv7g=
Received: by 10.204.39.15 with SMTP id d15mr1003212bke.383.1313312293982;
        Sun, 14 Aug 2011 01:58:13 -0700 (PDT)
Received: from kolya (1-1-3-35a.mfb.mlm.bostream.se [82.182.194.253])
        by mx.google.com with ESMTPS id b17sm1230423bkd.65.2011.08.14.01.58.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Aug 2011 01:58:13 -0700 (PDT)
Received: from iveqy by kolya with local (Exim 4.72)
	(envelope-from <iveqy@kolya>)
	id 1QsWW1-0000eE-M7; Sun, 14 Aug 2011 10:57:56 +0200
X-Mailer: git-send-email 1.7.6.398.g2f0e9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179317>

The first iteration of this patch series can be found here:
http://thread.gmane.org/gmane.comp.version-control.git/176328/focus=176327

The second iteration of this patch series can be found here:
http://thread.gmane.org/gmane.comp.version-control.git/177992

The third iteration of this patch series can be found here:
http://thread.gmane.org/gmane.comp.version-control.git/179037/focus=179048


Fredrik Gustafsson (2):
  rev-parse: add option --is-well-formed-git-dir [path]
  push: Don't push a repository with unpushed submodules

 Documentation/git-push.txt      |    6 ++
 Documentation/git-rev-parse.txt |    4 ++
 builtin/push.c                  |   17 ++++++
 builtin/rev-parse.c             |    8 +++
 cache.h                         |    1 +
 combine-diff.c                  |    2 +-
 setup.c                         |    7 +++
 submodule.c                     |  108 +++++++++++++++++++++++++++++++++++++++
 submodule.h                     |    1 +
 t/t5531-deep-submodule-push.sh  |   94 ++++++++++++++++++++++++++++++++++
 t/t7400-submodule-basic.sh      |    4 +-
 t/t7403-submodule-sync.sh       |    5 +-
 t/t7407-submodule-foreach.sh    |   97 ++++++++++++++++++-----------------
 transport.c                     |    9 +++
 transport.h                     |    1 +
 15 files changed, 312 insertions(+), 52 deletions(-)

-- 
1.7.6.398.g64865.dirty
