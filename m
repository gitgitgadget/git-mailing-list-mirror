From: Felipe Contreras <felipec@infradead.org>
Subject: [PATCH v2 2/4] completion: remove unused code
Date: Mon, 30 Jan 2012 19:23:15 +0200
Message-ID: <1327944197-6379-3-git-send-email-felipec@infradead.org>
References: <1327944197-6379-1-git-send-email-felipec@infradead.org>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 30 18:23:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RruxB-0004hn-7D
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 18:23:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752644Ab2A3RXd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 12:23:33 -0500
Received: from merlin.infradead.org ([205.233.59.134]:54086 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752329Ab2A3RXb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 12:23:31 -0500
Received: from canuck.infradead.org ([2001:4978:20e::1])
	by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1Rrux1-0005bt-1I; Mon, 30 Jan 2012 17:23:31 +0000
Received: from bombadil.infradead.org ([2001:4830:2446:ff00:4687:fcff:fea6:5117] helo=localhost)
	by canuck.infradead.org with esmtpsa (Exim 4.76 #1 (Red Hat Linux))
	id 1Rrux0-0004wr-Fr; Mon, 30 Jan 2012 17:23:30 +0000
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1327944197-6379-1-git-send-email-felipec@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <felipec@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189379>

From: Felipe Contreras <felipe.contreras@gmail.com>

No need for this rather complicated piece of code anymore :)

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash |   30 ------------------------------
 1 files changed, 0 insertions(+), 30 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 086e38d..4f68f0a 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2728,33 +2728,3 @@ if [ Cygwin = "$(uname -o 2>/dev/null)" ]; then
 complete -o bashdefault -o default -o nospace -F _git git.exe 2>/dev/null \
 	|| complete -o default -o nospace -F _git git.exe
 fi
-
-if [[ -n ${ZSH_VERSION-} ]]; then
-	__git_shopt () {
-		local option
-		if [ $# -ne 2 ]; then
-			echo "USAGE: $0 (-q|-s|-u) <option>" >&2
-			return 1
-		fi
-		case "$2" in
-		nullglob)
-			option="$2"
-			;;
-		*)
-			echo "$0: invalid option: $2" >&2
-			return 1
-		esac
-		case "$1" in
-		-q)	setopt | grep -q "$option" ;;
-		-u)	unsetopt "$option" ;;
-		-s)	setopt "$option" ;;
-		*)
-			echo "$0: invalid flag: $1" >&2
-			return 1
-		esac
-	}
-else
-	__git_shopt () {
-		shopt "$@"
-	}
-fi
-- 
1.7.8
