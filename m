From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH 1/2] t9902: fix 'test A == B' to use = operator
Date: Mon, 8 Jul 2013 17:20:31 +0200
Message-ID: <b9e889a27f648c44179ad39159240867f86525f3.1373296313.git.trast@inf.ethz.ch>
References: <8761wli0fe.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 08 17:20:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwDF2-0004LA-9Z
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 17:20:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752154Ab3GHPUg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 11:20:36 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:9742 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752001Ab3GHPUf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 11:20:35 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 8 Jul
 2013 17:20:33 +0200
Received: from linux-k42r.v.cablecom.net (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 8 Jul
 2013 17:20:33 +0200
X-Mailer: git-send-email 1.8.3.2.947.g0347b11
In-Reply-To: <8761wli0fe.fsf@linux-k42r.v.cablecom.net>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229863>

The == operator as an alias to = is not POSIX.  This doesn't actually
matter for the execution of the script, because it only runs when the
shell is bash.  However, it trips up test-lint, so it's nicer to use
the standard form.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---
 t/t9902-completion.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index d9e3103..272a071 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -69,7 +69,7 @@ run_completion ()
 	local -a COMPREPLY _words
 	local _cword
 	_words=( $1 )
-	test "${1: -1}" == ' ' && _words+=('')
+	test "${1: -1}" = ' ' && _words+=('')
 	(( _cword = ${#_words[@]} - 1 ))
 	__git_wrap__git_main && print_comp
 }
-- 
1.8.3.2.947.g0347b11
