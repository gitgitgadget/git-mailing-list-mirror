From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: [PATCH v5 1/3] completion: factor out untracked file modes into a variable
Date: Fri, 10 Jun 2016 12:23:59 +0200
Message-ID: <20160610102400.9864-1-thomas.braun@virtuell-zuhause.de>
References: <xmqq8tymp385.fsf@gitster.mtv.corp.google.com>
Cc: peff@peff.net, Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 10 12:24:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBJcG-00050t-LB
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 12:24:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161032AbcFJKYd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 06:24:33 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:46404 "EHLO
	wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932288AbcFJKYR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jun 2016 06:24:17 -0400
Received: from p4fc87c53.dip0.t-ipconnect.de ([79.200.124.83] helo=localhost.localdomain); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1bBJbr-0008QC-BZ; Fri, 10 Jun 2016 12:24:15 +0200
X-Mailer: git-send-email 2.8.4.windows.1
In-Reply-To: <xmqq8tymp385.fsf@gitster.mtv.corp.google.com>
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1465554257;3950f0df;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296964>

Signed-off-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
---
 contrib/completion/git-completion.bash | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 3402475..addea89 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1098,6 +1098,8 @@ _git_clone ()
 	esac
 }
 
+__git_untracked_file_modes="all no normal"
+
 _git_commit ()
 {
 	case "$prev" in
@@ -1119,7 +1121,7 @@ _git_commit ()
 		return
 		;;
 	--untracked-files=*)
-		__gitcomp "all no normal" "" "${cur##--untracked-files=}"
+		__gitcomp "$__git_untracked_file_modes" "" "${cur##--untracked-files=}"
 		return
 		;;
 	--*)
-- 
2.8.4.windows.1
