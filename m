From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: [PATCH 1/2] completion: create variable for untracked file modes
Date: Wed, 1 Jun 2016 01:42:33 +0200
Message-ID: <5a3d279f-d3cc-90ec-a0e7-90b7ef438966@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	=?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 01 02:05:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7tem-0003U0-TB
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 02:05:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756670AbcFAAFD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 20:05:03 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:44537 "EHLO
	wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752711AbcFAAFB (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2016 20:05:01 -0400
Received: from p4fc87c53.dip0.t-ipconnect.de ([79.200.124.83] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	id 1b7tMN-000865-Gt; Wed, 01 Jun 2016 01:46:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1464739501;9497f263;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296039>

Signed-off-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
---
 contrib/completion/git-completion.bash | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 3402475..57a0acc 100644
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
+		__gitcomp "$(__git_untracked_file_modes)" "" "${cur##--untracked-files=}"
 		return
 		;;
 	--*)
-- 
2.8.3.windows.1
