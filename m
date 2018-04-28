Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BB951F428
	for <e@80x24.org>; Sat, 28 Apr 2018 22:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752705AbeD1Wp0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Apr 2018 18:45:26 -0400
Received: from mout.gmx.net ([212.227.17.20]:59913 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752307AbeD1WpZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Apr 2018 18:45:25 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0M9eHT-1f5e3D2tcl-00D1hK; Sun, 29 Apr 2018 00:45:20 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v7 10/12] technical/shallow: stop referring to grafts
Date:   Sun, 29 Apr 2018 00:45:13 +0200
Message-Id: <99e43b91665c99c566ebbc598fc30c26e3712abd.1524955439.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.36.gdf4ca5fb72a
MIME-Version: 1.0
In-Reply-To: <cover.1524955439.git.johannes.schindelin@gmx.de>
References: <cover.1524865158.git.johannes.schindelin@gmx.de> <cover.1524955439.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:uyk3r4s6ZdCf0wcUAchmQG9OGjcXZMqkNQ0Kc2+Uv/YnFoKH7lJ
 Z0ZbqXaXHRaaWTzMVKgjBD7txF9IgzTmedT3xph57dcVWn8WKSvVBaTMbysD0l5j4UnrGi5
 2yto4CBJD0az1BkZswm8XYeDDcgSKPmJW7JB6vAMz42+4R67TdhjhKGbAKxlwIxGVmupE+p
 7GtZW01szDFCOxvuYj/aw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ng0K9CgGKmo=:qWx8d/I3/xVeEDKLmYTogo
 yeeVhxyeeMn9kg9cIcoXiQ6WBqr0ANj8Cg2G356dUNIw9zvbq/sMpadRUgzVmEvbzjvYUERMu
 VBUU9EzTgI27RDCTM0NFueiFTsuooIVKN7qJq7yPxSmXXccnAR27rTM5R4WeQqLyf93w6UITR
 zXuyHk0GGRutk+aMrYA30v4ZpfdNGQO2AAqMaJv92001XsEwzKYSj8SLXVOxcH5ypdl8nYquf
 iavYOuhTuzmAKXTRLq6YPx9Hwnm2WpXk0+uJHk+ln5kJmWcv5mpQYp8cf8qJiWDSlW42cH1RJ
 IAmd2TVXXi8QofZM+mFdtvEUEXq2wesAuxxxEY8xVs7PCVpUoEp+DNqDBZq5aS8ds1hdZzDGg
 3ttU/G/3/Z3ydpuD65jPa8oWHmL4xLSHsDw4OT14FLSrKKRjOerIUGzVZVPSGyDcc5aRuwTdv
 bToDNoXgdRgzG4Q0k57Ptbx55Fur3C9X6QPpFTnn/N4Pk76aNj7DpCQRtbjaarK6Zf5vRdYWb
 aKMKUUGYNNiiAbsazBNAKYdHHjRr4dyLO95j26ptEN2DlmcXrPGX21HtXFiHyDRNEIirWIVNP
 MsWHLS9n2zI9StVHiGaLvKu5PXa8wYQ7AVk3ObtfBeWfgoa+99QUIF7O5oO9KmJeylGgvdvS4
 VODV/iQWwGt0ADd5XGvfz99zmSS7/uNLrc2Ipnu90uU4t2vJzWTBzpx14wLVQHv+SrU9qtn4y
 arYEg1//dMlAanoKGUfg+E6Xzphi9DwegQMGVsdqUQFf6pzU4TK1l9ZuYv9AUr+KXZdTU/osn
 COPU9EJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that grafts are deprecated, we should start to assume that readers
have no idea what grafts are. So it makes more sense to make the
description of the "shallow" feature stand on its own.

Suggested-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Junio Hamano <gitster@pobox.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/technical/shallow.txt | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/Documentation/technical/shallow.txt b/Documentation/technical/shallow.txt
index 5183b154229..4ec721335d2 100644
--- a/Documentation/technical/shallow.txt
+++ b/Documentation/technical/shallow.txt
@@ -8,15 +8,10 @@ repo, and therefore grafts are introduced pretending that
 these commits have no parents.
 *********************************************************
 
-The basic idea is to write the SHA-1s of shallow commits into
-$GIT_DIR/shallow, and handle its contents like the contents
-of $GIT_DIR/info/grafts (with the difference that shallow
-cannot contain parent information).
-
-This information is stored in a new file instead of grafts, or
-even the config, since the user should not touch that file
-at all (even throughout development of the shallow clone, it
-was never manually edited!).
+$GIT_DIR/shallow lists commit object names and tells Git to
+pretend as if they are root commits (e.g. "git log" traversal
+stops after showing them; "git fsck" does not complain saying
+the commits listed on their "parent" lines do not exist).
 
 Each line contains exactly one SHA-1. When read, a commit_graft
 will be constructed, which has nr_parent < 0 to make it easier
-- 
2.17.0.windows.1.36.gdf4ca5fb72a


