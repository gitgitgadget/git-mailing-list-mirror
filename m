From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH v2 08/22] merge-octupus: use die shell function from git-sh-setup.sh
Date: Mon, 23 May 2016 19:27:27 +0000
Message-ID: <1464031661-18988-9-git-send-email-vascomalmeida@sapo.pt>
References: <1464031661-18988-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 23 21:29:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4vXw-0001jR-6k
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 21:29:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753672AbcEWT3k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 15:29:40 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:47370 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753556AbcEWT3j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 15:29:39 -0400
Received: (qmail 23981 invoked from network); 23 May 2016 19:29:36 -0000
Received: (qmail 3193 invoked from network); 23 May 2016 19:29:36 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 23 May 2016 19:29:35 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1464031661-18988-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295362>

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
2.7.3
