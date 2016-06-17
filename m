Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5472E1FEAA
	for <e@80x24.org>; Fri, 17 Jun 2016 21:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755695AbcFQVym (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 17:54:42 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:50926 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752644AbcFQVyl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 17:54:41 -0400
Received: (qmail 14915 invoked from network); 17 Jun 2016 21:54:39 -0000
Received: (qmail 30699 invoked from network); 17 Jun 2016 21:54:39 -0000
Received: from unknown (HELO linux-omuo.lan) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 17 Jun 2016 21:54:38 -0000
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
Subject: [PATCH v5 37/38] i18n: unmark die messages for translation
Date:	Fri, 17 Jun 2016 21:54:14 +0000
Message-Id: <1466200455-16951-8-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
References: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

These messages are relevant for the programmer only, not for the end
user.  Thus, they can be unmarked for translation, saving translator
some work.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 git-bisect.sh | 2 +-
 wt-status.c   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 30d01bb..ae3cb01 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -274,7 +274,7 @@ bisect_state() {
 	check_and_set_terms $state
 	case "$#,$state" in
 	0,*)
-		die "$(gettext "Please call 'bisect_state' with at least one argument.")" ;;
+		die "Please call 'bisect_state' with at least one argument." ;;
 	1,"$TERM_BAD"|1,"$TERM_GOOD"|1,skip)
 		bisected_head=$(bisect_head)
 		rev=$(git rev-parse --verify "$bisected_head") ||
diff --git a/wt-status.c b/wt-status.c
index 4f27bd6..5a91279 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -263,7 +263,7 @@ static const char *wt_status_unmerged_status_string(int stagemask)
 	case 7:
 		return _("both modified:");
 	default:
-		die(_("bug: unhandled unmerged status %x"), stagemask);
+		die("bug: unhandled unmerged status %x", stagemask);
 	}
 }
 
@@ -388,7 +388,7 @@ static void wt_status_print_change_data(struct wt_status *s,
 	status_printf(s, color(WT_STATUS_HEADER, s), "\t");
 	what = wt_status_diff_status_string(status);
 	if (!what)
-		die(_("bug: unhandled diff status %c"), status);
+		die("bug: unhandled diff status %c", status);
 	len = label_width - utf8_strwidth(what);
 	assert(len >= 0);
 	if (status == DIFF_STATUS_COPIED || status == DIFF_STATUS_RENAMED)
-- 
2.6.6

