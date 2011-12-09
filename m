From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v3 0/6] Fix '&&' chaining in tests
Date: Fri,  9 Dec 2011 16:59:12 +0530
Message-ID: <1323430158-14885-1-git-send-email-artagnon@gmail.com>
References: <1323349817-15737-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@mgmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 12:30:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYyem-0000B1-Cy
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 12:30:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752512Ab1LILaT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 06:30:19 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34509 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429Ab1LILaS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 06:30:18 -0500
Received: by iakc1 with SMTP id c1so4103014iak.19
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 03:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=wxWlYe8jx81o2d9yFgH4Z2zLgXAvrnMoCILSTBNTnBY=;
        b=aScbAfyOKJGnWIRn1bRwSP8I9xCosXi10XS6o5eF5Nn/FXJsNQvIsysqPGcvsRTZMg
         sQ8PfTDgKKJ7hs3uT0gg90plKdeBabdHrqfwwBDbk1vv+n/jwnbFAijFN6g39bmS+gRM
         JifHm4fRYscfV5AGA498TSSlWBGY15O7V8VPg=
Received: by 10.42.197.195 with SMTP id el3mr2381912icb.54.1323430218333;
        Fri, 09 Dec 2011 03:30:18 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id d19sm9096588ibh.8.2011.12.09.03.30.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 09 Dec 2011 03:30:17 -0800 (PST)
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1323349817-15737-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186624>

This replaces the previous iteration of the series at $gmane/186553.
Thanks to Jonathan for reviewing.

-- Ram

Ramkumar Ramachandra (6):
  t3040 (subprojects-basic): fix '&&' chaining, modernize style
  t3030 (merge-recursive): use test_expect_code
  t1006 (cat-file): use test_cmp
  t3200 (branch): fix '&&' chaining
  t1510 (worktree): fix '&&' chaining
  tests: fix '&&' chaining

 t/t1006-cat-file.sh                   |  119 +++++++++++++--------------
 t/t1007-hash-object.sh                |    2 +-
 t/t1013-loose-object-format.sh        |    2 +-
 t/t1300-repo-config.sh                |    2 +-
 t/t1412-reflog-loop.sh                |    2 +-
 t/t1501-worktree.sh                   |    6 +-
 t/t1510-repo-setup.sh                 |    4 +-
 t/t1511-rev-parse-caret.sh            |    2 +-
 t/t3030-merge-recursive.sh            |   72 ++---------------
 t/t3040-subprojects-basic.sh          |  144 ++++++++++++++++----------------
 t/t3200-branch.sh                     |    4 +-
 t/t3310-notes-merge-manual-resolve.sh |   10 +-
 t/t3400-rebase.sh                     |    4 +-
 t/t3418-rebase-continue.sh            |    4 +-
 t/t3419-rebase-patch-id.sh            |    2 +-
 15 files changed, 156 insertions(+), 223 deletions(-)

-- 
1.7.7.3
