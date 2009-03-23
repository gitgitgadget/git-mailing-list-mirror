From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 3/3] completion: add --thread=deep/shallow to format-patch
Date: Mon, 23 Mar 2009 03:26:51 -0700
Message-ID: <1237804011-15419-4-git-send-email-bebarino@gmail.com>
References: <1237804011-15419-1-git-send-email-bebarino@gmail.com>
 <1237804011-15419-2-git-send-email-bebarino@gmail.com>
 <1237804011-15419-3-git-send-email-bebarino@gmail.com>
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Mar 23 11:28:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlhOV-0003Bn-1W
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 11:28:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754167AbZCWK1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 06:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754064AbZCWK1H
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 06:27:07 -0400
Received: from wf-out-1314.google.com ([209.85.200.168]:30790 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753793AbZCWK1E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 06:27:04 -0400
Received: by wf-out-1314.google.com with SMTP id 29so2759505wff.4
        for <git@vger.kernel.org>; Mon, 23 Mar 2009 03:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=5fLYjwpsSJXYaSXNSQoxuhizXLlmx80X4aADbHhaVm0=;
        b=rpmkvhCzD0Vs1u+5dSzLVm5+HnP0FCTM+SfQGR5ZUg/nRWyx50IS17X14ALylJUCgH
         OR24D894vKZLdFvVChtC9BKwILw2Mfzvbim8bJBvaO+9nwKDcESyHtSpzdHH4qJ20V9M
         hSQrk8CKLOt6pfXQiHVGWayrnZY/SaFUQNT0s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=w6OWH/TyMRwwkhdFNEXAZaL+2bIbLKrK7OqkuTepnZY8+133qau2dtxi19zUlRxuOp
         sm7UzGdKSme2TocQTg2d3bsEb/ymb4HiemEgz75ya42AoJWvizfUSemsjowWDns/SCVo
         c1tXjvrBjeF/yHCDUf6OFpll78zKalV3tQhc4=
Received: by 10.142.68.5 with SMTP id q5mr2797912wfa.12.1237804022275;
        Mon, 23 Mar 2009 03:27:02 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id 28sm11236939wfd.5.2009.03.23.03.27.00
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 23 Mar 2009 03:27:01 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Mon, 23 Mar 2009 03:26:59 -0700
X-Mailer: git-send-email 1.6.2
In-Reply-To: <1237804011-15419-3-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114274>

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 contrib/completion/git-completion.bash |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b96458f..1c6b0e2 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -930,9 +930,15 @@ _git_format_patch ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}"
 	case "$cur" in
+	--thread=*)
+		__gitcomp "
+			deep shallow
+			" "" "${cur##--thread=}"
+		return
+		;;
 	--*)
 		__gitcomp "
-			--stdout --attach --no-attach --thread
+			--stdout --attach --no-attach --thread --thread=
 			--output-directory
 			--numbered --start-number
 			--numbered-files
-- 
1.6.2
