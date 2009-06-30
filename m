From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH] completion: add missing config variables
Date: Mon, 29 Jun 2009 21:24:24 -0700
Message-ID: <1246335864-1369-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jun 30 06:24:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLUtZ-0003fQ-QA
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 06:24:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbZF3EY2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 00:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750949AbZF3EY1
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 00:24:27 -0400
Received: from mail-px0-f190.google.com ([209.85.216.190]:51498 "EHLO
	mail-px0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878AbZF3EY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 00:24:26 -0400
Received: by pxi28 with SMTP id 28so3809432pxi.33
        for <git@vger.kernel.org>; Mon, 29 Jun 2009 21:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=R+U/3XNwIo02j6OsbfxhZpIaKx8RNGiXr3pwlqcRWpw=;
        b=fOmI8MPC3tdUw2m+JkyrZ8q+5HBmMRHbnWokUhvgUJRH3gAfbxq5aiXCDA6jY+CGM9
         mBFCJdIs4XarVrcJA8uirAYDIvzgv/Abb0w+1bgAFcu96Z0u7mv9J4q+LqQYcqfAqJVX
         ov38GwTufQ6+uH2A8iRXPW580iPwW3y5nNA0Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Z5oTGs3QhDWwcyTiliOHQoF39MkfAw92VOx8UeCQajnCK+8wKRzVKC9eLHcixNVff5
         UDEIaHi/gDd008cmtfgXgJLtslbwmwWAfLkUSN6Dd7J50F5Nnh2FF5jiCLX28k1Yf+M2
         TodKHwCK02QxU1t4QuQZiii1D11k9j2iJRCv0=
Received: by 10.114.208.12 with SMTP id f12mr12641499wag.226.1246335868778;
        Mon, 29 Jun 2009 21:24:28 -0700 (PDT)
Received: from earth (cpe-66-75-25-79.san.res.rr.com [66.75.25.79])
        by mx.google.com with ESMTPS id l28sm5515762waf.54.2009.06.29.21.24.26
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 29 Jun 2009 21:24:27 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Mon, 29 Jun 2009 21:24:24 -0700
X-Mailer: git-send-email 1.6.3.3.353.g4f2b1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122484>

Update to include branch.*.rebase, remote.*.pushurl, and
add.ignore-errors

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 contrib/completion/git-completion.bash |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b60cb68..ddb71e2 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1457,7 +1457,7 @@ _git_config ()
 	branch.*.*)
 		local pfx="${cur%.*}."
 		cur="${cur##*.}"
-		__gitcomp "remote merge mergeoptions" "$pfx" "$cur"
+		__gitcomp "remote merge mergeoptions rebase" "$pfx" "$cur"
 		return
 		;;
 	branch.*)
@@ -1504,7 +1504,7 @@ _git_config ()
 		cur="${cur##*.}"
 		__gitcomp "
 			url proxy fetch push mirror skipDefaultUpdate
-			receivepack uploadpack tagopt
+			receivepack uploadpack tagopt pushurl
 			" "$pfx" "$cur"
 		return
 		;;
@@ -1522,6 +1522,7 @@ _git_config ()
 		;;
 	esac
 	__gitcomp "
+		add.ignore-errors
 		alias.
 		apply.whitespace
 		branch.autosetupmerge
-- 
1.6.3.3.334.g916e1
