From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH] completion.bash: add 'skip' and 'run' to git-bisect
Date: Wed,  2 Jul 2008 17:29:50 +0400
Message-ID: <1215005390-1506-1-git-send-email-dpotapov@gmail.com>
Cc: Dmitry Potapov <dpotapov@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 02 15:31:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE2QM-00078L-17
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 15:31:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753627AbYGBNaH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 09:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753388AbYGBNaH
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 09:30:07 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:32803 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753206AbYGBNaG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 09:30:06 -0400
Received: by yw-out-2324.google.com with SMTP id 9so176387ywe.1
        for <git@vger.kernel.org>; Wed, 02 Jul 2008 06:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=DX+Z0tXmYihivRtfxne5Y6y/b1b4OXu5THFfKWbcFxg=;
        b=X6BiVEHntw0PCltq0PoI+F742/vJFhPpxhdAo9GL6QmE3Gz4IuolqWxRYq6Cuj1RfH
         HgduZs0+9GKaNriDzo03gitlf+cJqYoqlT0OrDRCSbQZeU8q3dEQuBjvoA+eVAKy/vwX
         7b05iEe7PM7wsHhrGJPI/VswYmrO+ALNzTydY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=JDTxCyXPHq/Il3ZZAuPINFcnmw/R2ujbnC098ralUDwTqCXauJb34NY6oVhOq3YE4X
         jHZNm6RcUimXrC88b+QLsqv09g+pOMVSpeRCtU7FMJ/fj+SznZE0/HNW56xMZ7faGZgQ
         44rakT5OmGTTing/LR/oZGe2oJiBHv9oJaU/Q=
Received: by 10.103.2.17 with SMTP id e17mr3577366mui.118.1215005394259;
        Wed, 02 Jul 2008 06:29:54 -0700 (PDT)
Received: from localhost ( [83.237.184.117])
        by mx.google.com with ESMTPS id j10sm10597213muh.18.2008.07.02.06.29.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 02 Jul 2008 06:29:53 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87133>

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---
 contrib/completion/git-completion.bash |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ebf7cde..3d15434 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -511,7 +511,7 @@ _git_add ()
 
 _git_bisect ()
 {
-	local subcommands="start bad good reset visualize replay log"
+	local subcommands="start bad good skip reset visualize replay log run"
 	local subcommand="$(__git_find_subcommand "$subcommands")"
 	if [ -z "$subcommand" ]; then
 		__gitcomp "$subcommands"
@@ -519,7 +519,7 @@ _git_bisect ()
 	fi
 
 	case "$subcommand" in
-	bad|good|reset)
+	bad|good|reset|skip)
 		__gitcomp "$(__git_refs)"
 		;;
 	*)
-- 
1.5.6.1
