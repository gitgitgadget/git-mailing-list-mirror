From: Jacopo Notarstefano <jacopo.notarstefano@gmail.com>
Subject: [PATCH] git-bisect.sh: fix a few style issues
Date: Tue,  4 Mar 2014 01:21:43 +0100
Message-ID: <1393892503-12765-1-git-send-email-jacopo.notarstefano@gmail.com>
Cc: Jacopo Notarstefano <jacopo.notarstefano@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 04 01:16:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKd1u-00076z-2e
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 01:16:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755326AbaCDAQO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 19:16:14 -0500
Received: from mail-ea0-f178.google.com ([209.85.215.178]:49401 "EHLO
	mail-ea0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755248AbaCDAQN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 19:16:13 -0500
Received: by mail-ea0-f178.google.com with SMTP id a15so9539eae.9
        for <git@vger.kernel.org>; Mon, 03 Mar 2014 16:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=QDUD23eQxTx16bXSAgS1YQtysLnnReHhGRiA50H2+wE=;
        b=KnfYxSOC3ZIp77OxW1ua0VVVnxu3Znoha+LvA8c4tq0KyYaYocRz/W99BN7zsc4yna
         mQp5MSk+9w4c1CJJ1tyYfitegKNZnF8LwUozVq4egzAJAj5JDV29G+Zj2xOEwIhXong4
         eedu0rw+Q1HjG9AOyj/EpNBnJG2zA6Fy7lgv3YqN4OHR1agPB3rMccyedmQEDNXTEbya
         afj0GBzLMjH7N6V/byjpjWysTRElkpQLmA1CDbU4hiyx/6VcBMLFi/2zchviI9dHRn5r
         jRx75aiqgYTbtL7dFxtRhyEXf6AVmcwSIqdzXmTkT/FjuRCcOwQHz85AkJuQ7wgk7H1C
         /XSA==
X-Received: by 10.14.246.196 with SMTP id q44mr32624247eer.45.1393892172517;
        Mon, 03 Mar 2014 16:16:12 -0800 (PST)
Received: from localhost.localdomain (dynamic-adsl-78-12-95-178.clienti.tiscali.it. [78.12.95.178])
        by mx.google.com with ESMTPSA id x3sm56297110eep.17.2014.03.03.16.16.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Mar 2014 16:16:11 -0800 (PST)
X-Mailer: git-send-email 1.9.0.1.g641f09f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243319>

Redirection operators should have a space before them, but not after them.

Signed-off-by: Jacopo Notarstefano <jacopo.notarstefano@gmail.com>
---
 git-bisect.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 73b4c14..af4d04c 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -365,7 +365,7 @@ bisect_reset() {
 	}
 	case "$#" in
 	0) branch=$(cat "$GIT_DIR/BISECT_START") ;;
-	1) git rev-parse --quiet --verify "$1^{commit}" > /dev/null || {
+	1) git rev-parse --quiet --verify "$1^{commit}" >/dev/null || {
 			invalid="$1"
 			die "$(eval_gettext "'\$invalid' is not a valid commit")"
 		}
@@ -458,13 +458,13 @@ exit code \$res from '\$command' is < 0 or >= 128" >&2
 		fi
 
 		# We have to use a subshell because "bisect_state" can exit.
-		( bisect_state $state > "$GIT_DIR/BISECT_RUN" )
+		( bisect_state $state >"$GIT_DIR/BISECT_RUN" )
 		res=$?
 
 		cat "$GIT_DIR/BISECT_RUN"
 
 		if sane_grep "first bad commit could be any of" "$GIT_DIR/BISECT_RUN" \
-			> /dev/null
+			>/dev/null
 		then
 			gettextln "bisect run cannot continue any more" >&2
 			exit $res
@@ -477,7 +477,7 @@ exit code \$res from '\$command' is < 0 or >= 128" >&2
 			exit $res
 		fi
 
-		if sane_grep "is the first bad commit" "$GIT_DIR/BISECT_RUN" > /dev/null
+		if sane_grep "is the first bad commit" "$GIT_DIR/BISECT_RUN" >/dev/null
 		then
 			gettextln "bisect run success"
 			exit 0;
-- 
1.9.0.1.g641f09f
