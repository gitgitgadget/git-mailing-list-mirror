Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC4081FEAA
	for <e@80x24.org>; Fri, 17 Jun 2016 20:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846AbcFQUYQ (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 16:24:16 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:60128 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964807AbcFQUYP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 16:24:15 -0400
Received: (qmail 21569 invoked from network); 17 Jun 2016 20:24:14 -0000
Received: (qmail 4007 invoked from network); 17 Jun 2016 20:24:14 -0000
Received: from unknown (HELO linux-omuo.lan) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 17 Jun 2016 20:24:13 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:	Vasco Almeida <vascomalmeida@sapo.pt>
To:	git@vger.kernel.org
Cc:	Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 08/38] merge-octupus: use die shell function from git-sh-setup.sh
Date:	Fri, 17 Jun 2016 20:20:57 +0000
Message-Id: <1466194887-18236-9-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
References: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Source git-sh-setup in order to use die shell function from
git-sh-setup.sh library instead of using the one defined in
git-merge-octopus.sh. Remove the former die function.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 git-merge-octopus.sh | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/git-merge-octopus.sh b/git-merge-octopus.sh
index 89e967a..d79fc84 100755
--- a/git-merge-octopus.sh
+++ b/git-merge-octopus.sh
@@ -5,16 +5,12 @@
 # Resolve two or more trees.
 #
 
+. git-sh-setup
 . git-sh-i18n
 
 LF='
 '
 
-die () {
-    echo >&2 "$*"
-    exit 1
-}
-
 # The first parameters up to -- are merge bases; the rest are heads.
 bases= head= remotes= sep_seen=
 for arg
-- 
2.6.6

