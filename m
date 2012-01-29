From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/3] completion: remove unused code
Date: Mon, 30 Jan 2012 01:41:19 +0200
Message-ID: <1327880479-25275-4-git-send-email-felipe.contreras@gmail.com>
References: <1327880479-25275-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 30 00:42:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RreNt-00089H-Qx
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 00:42:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754004Ab2A2XmE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jan 2012 18:42:04 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41448 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752334Ab2A2XmB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jan 2012 18:42:01 -0500
Received: by wgbed3 with SMTP id ed3so3937687wgb.1
        for <git@vger.kernel.org>; Sun, 29 Jan 2012 15:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=vQR/4xkjLxn0Y/r/Lq11Z2+n2ZjDOUD7lviUIsii7wU=;
        b=v7ik7GmCCLiMQ3du/vatp0obcwJ69DCVUtaDI+w4r9SKo+enlBwlsxLObbGeW46HnD
         T3oHBDmV+bBBh1UXnACtIEn/mFYO11ICxAzmIM0nqOmRbGvB+dbXvx6+d/Mz6ez15m87
         KVgE8JyfvfRZzntOYcwubZVRj61acdF+/rTYs=
Received: by 10.180.108.232 with SMTP id hn8mr23953950wib.16.1327880520441;
        Sun, 29 Jan 2012 15:42:00 -0800 (PST)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi. [91.153.253.80])
        by mx.google.com with ESMTPS id fr8sm46600909wib.10.2012.01.29.15.41.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 29 Jan 2012 15:41:59 -0800 (PST)
X-Mailer: git-send-email 1.7.8.3
In-Reply-To: <1327880479-25275-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189306>

No need for thus rather complicated piece of code :)

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash |   30 ------------------------------
 1 files changed, 0 insertions(+), 30 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index f7278b5..59a4650 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2730,33 +2730,3 @@ if [ Cygwin = "$(uname -o 2>/dev/null)" ]; then
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
1.7.8.3
