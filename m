From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH v3 38/39] i18n: unmark die messages for translation
Date: Wed,  1 Jun 2016 18:13:02 +0000
Message-ID: <1464804783-10195-9-git-send-email-vascomalmeida@sapo.pt>
References: <1464799289-7639-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 01 20:14:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8Aem-0006c3-KL
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 20:14:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbcFASOJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 14:14:09 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:60611 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752901AbcFASOI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 14:14:08 -0400
Received: (qmail 28976 invoked from network); 1 Jun 2016 18:13:51 -0000
Received: (qmail 23013 invoked from network); 1 Jun 2016 18:13:51 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 1 Jun 2016 18:13:46 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1464799289-7639-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296145>

These messages are relevant for the programmer only, not for the end
user.  Thus, they can be unmarked for translation, saving translator
some work.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 git-bisect.sh | 2 +-
 wt-status.c   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 737bf05..c9acab6 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -275,7 +275,7 @@ bisect_state() {
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
