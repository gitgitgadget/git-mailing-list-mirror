From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: [PATCH v2 2/2] completion: suggest sequencer commands for revert
Date: Sat, 30 May 2015 18:01:31 +0200
Message-ID: <1433001691.5113.7.camel@virtuell-zuhause.de>
References: <CALkWK0m9Fj_3AnJcENL-kAFSbYjW4fKpN76Tftrt672hQj4qww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	SZEDER =?ISO-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 30 18:01:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyjCe-0001Q9-My
	for gcvg-git-2@plane.gmane.org; Sat, 30 May 2015 18:01:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755696AbbE3QBg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 May 2015 12:01:36 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:33552 "EHLO
	wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751131AbbE3QBe (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 May 2015 12:01:34 -0400
Received: from p5ddc33fc.dip0.t-ipconnect.de ([93.220.51.252] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1YyjCV-0004jc-Nz; Sat, 30 May 2015 18:01:31 +0200
In-Reply-To: <CALkWK0m9Fj_3AnJcENL-kAFSbYjW4fKpN76Tftrt672hQj4qww@mail.gmail.com>
X-Mailer: Evolution 3.12.9-1+b1 
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1433001694;33dc1631;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270287>

Signed-off-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
---
 contrib/completion/git-completion.bash | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index f6e5bf6..486c61b 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -868,6 +868,12 @@ __git_complete_sequencer ()
 			return 0
 		fi
 		;;
+	revert)
+		if [ -f "$dir"/REVERT_HEAD ]; then
+			__gitcomp "--continue --quit --abort"
+			return 0
+		fi
+		;;
 	rebase)
 		if [ -d "$dir"/rebase-apply ] || [ -d "$dir"/rebase-merge ]; then
 			__gitcomp "--continue --skip --abort"
@@ -2300,6 +2306,8 @@ _git_reset ()
 
 _git_revert ()
 {
+	__git_complete_sequencer "revert" && return
+
 	case "$cur" in
 	--*)
 		__gitcomp "--edit --mainline --no-edit --no-commit --signoff"
