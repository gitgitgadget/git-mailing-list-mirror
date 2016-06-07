From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH v4 37/38] i18n: unmark die messages for translation
Date: Tue,  7 Jun 2016 12:55:40 +0000
Message-ID: <1465304141-9392-8-git-send-email-vascomalmeida@sapo.pt>
References: <1465300357-7557-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 14:56:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAGYO-0007D4-4S
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 14:56:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754948AbcFGM4Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 08:56:16 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:52233 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754905AbcFGM4P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 08:56:15 -0400
Received: (qmail 19419 invoked from network); 7 Jun 2016 12:56:13 -0000
Received: (qmail 18298 invoked from network); 7 Jun 2016 12:56:12 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 7 Jun 2016 12:56:07 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1465300357-7557-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296673>

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
2.7.3
