Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD41A1FEAA
	for <e@80x24.org>; Fri, 17 Jun 2016 20:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933086AbcFQUYT (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 16:24:19 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:35344 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964845AbcFQUYR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 16:24:17 -0400
Received: (qmail 2185 invoked from network); 17 Jun 2016 20:24:16 -0000
Received: (qmail 4393 invoked from network); 17 Jun 2016 20:24:16 -0000
Received: from unknown (HELO linux-omuo.lan) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 17 Jun 2016 20:24:14 -0000
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
Subject: [PATCH v5 09/38] i18n: rebase: fix marked string to use eval_gettext variant
Date:	Fri, 17 Jun 2016 20:20:58 +0000
Message-Id: <1466194887-18236-10-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
References: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The string message marked for translation should use eval_gettext
variant instead of the gettext one, since we want to dollar-substitute
$head_name in the result.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 git-rebase.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 44ede36..1fadc04 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -154,7 +154,7 @@ move_to_original_branch () {
 		git symbolic-ref \
 			-m "rebase finished: returning to $head_name" \
 			HEAD $head_name ||
-		die "$(gettext "Could not move back to $head_name")"
+		die "$(eval_gettext "Could not move back to \$head_name")"
 		;;
 	esac
 }
-- 
2.6.6

