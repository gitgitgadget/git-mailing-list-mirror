From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: [PATCH v3 1/2] completion: factor out untracked file modes into a
 variable
Date: Thu, 02 Jun 2016 17:16:31 +0200
Message-ID: <1464880591.4080.0.camel@virtuell-zuhause.de>
References: <20160601141510.Horde.M2zGuJrzBNqf_2zYLo0P2Sx@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	SZEDER =?ISO-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 02 17:16:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8UMR-00019T-53
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 17:16:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932941AbcFBPQf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 11:16:35 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:53641 "EHLO
	wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932892AbcFBPQe (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jun 2016 11:16:34 -0400
Received: from p4fc87c53.dip0.t-ipconnect.de ([79.200.124.83] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1b8UMJ-00055f-NM; Thu, 02 Jun 2016 17:16:31 +0200
In-Reply-To: <20160601141510.Horde.M2zGuJrzBNqf_2zYLo0P2Sx@webmail.informatik.kit.edu>
X-Mailer: Evolution 3.12.9-1+b1 
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1464880594;cc1b50d5;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296207>

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
