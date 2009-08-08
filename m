From: Emmanuel Trillaud <etrillaud@gmail.com>
Subject: [PATCH 1/9] add long options completion for 'git checkout'
Date: Sat, 8 Aug 2009 10:55:21 +0200
Message-ID: <9f50533b0908080155o45163caby4f91b05ac1152a81@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Aug 08 10:55:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZhiF-0004u9-Bw
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 10:55:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754860AbZHHIzX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 04:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754834AbZHHIzW
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 04:55:22 -0400
Received: from mail-fx0-f228.google.com ([209.85.220.228]:55025 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754221AbZHHIzW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 04:55:22 -0400
Received: by fxm28 with SMTP id 28so169935fxm.17
        for <git@vger.kernel.org>; Sat, 08 Aug 2009 01:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=ZtyHppf1HuvaeL96QyawMJgy1BoEPqH7VPNVgOGpRuQ=;
        b=m3IiGT3aqT5X0rJJUGiXZW6rEkkhEq1iONPW4Z45KKkxEmXvNbl+E26cjDMrRyw5zp
         DpSH8g9dDDqgcGONBtoIhLv/2k1ooIiddj6Q56zPRJdjyXd/Fgnsot0ItNQeYRLd+g5T
         sX8iQnCBlEenRkBRptzdOBNO02eJhIYW7ww2E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=h2GU+6hoAnXM3Ibn1lBBQJmi7fBbpGPgLLV/fwA/NzWXb390AM8rjjWYStYonWgDir
         YGT33PAMmkF5V2Kb84S79kCp9UXzmDWesOZhAijjSZku4wPfnGgikh8YrKPECVgLG34S
         dvrF84RODHaDYaXiinSDEmm8wt/GftEKRanhw=
Received: by 10.204.118.70 with SMTP id u6mr3928684bkq.198.1249721721823; Sat, 
	08 Aug 2009 01:55:21 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125265>

add long options completion to git checkout

Signed-off-by: Emmanuel Trillaud <etrillaud@gmail.com>
---
 contrib/completion/git-completion.bash |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash
b/contrib/completion/git-completion.bash
index 745b5fb..bc5427f 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -815,8 +815,18 @@ _git_bundle ()
 _git_checkout ()
 {
 	__git_has_doubledash && return
-
-	__gitcomp "$(__git_refs)"
+    case "${COMP_WORDS[COMP_CWORD]}" in
+    --*)
+        __gitcomp "
+            --ours --theirs --track --no-track --merge
+            --conflict=
+            "
+            ;;
+    *)
+        __gitcomp "$(__git_refs)"
+        ;;
+    esac
+	
 }

 _git_cherry ()
-- 
1.6.4
