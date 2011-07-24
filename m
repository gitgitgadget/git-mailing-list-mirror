From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 7/9] bisect: better diagnostics, in case of mis-typed option.
Date: Sun, 24 Jul 2011 15:57:52 +1000
Message-ID: <1311487074-25070-8-git-send-email-jon.seymour@gmail.com>
References: <1311487074-25070-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 24 07:58:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qkrhz-0007mm-0Y
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 07:58:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752179Ab1GXF62 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jul 2011 01:58:28 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:56778 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751914Ab1GXF6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2011 01:58:24 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so6276942pzk.1
        for <git@vger.kernel.org>; Sat, 23 Jul 2011 22:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=XesSwwQF4gLbc2seked3Oae0Ejg13DudgsjblCIe944=;
        b=TBsB3v92vJyFPWPMjuv4hOHHva1ZB7JNjjpzBFUpta2tVZ+uI+ny7jFGdINbkA3L4e
         yUwPYcS8lDXXNlT3Jnh2ZTQ1Pn/yfNUyiQpBmiYbr5zRHDpLSiyVYixEQdjV5M78AJyz
         jeWExxKdt6cNrRAgy/62WVs27tqgq0Wo6rQBA=
Received: by 10.68.38.4 with SMTP id c4mr4872048pbk.336.1311487104236;
        Sat, 23 Jul 2011 22:58:24 -0700 (PDT)
Received: from localhost.localdomain ([124.169.157.32])
        by mx.google.com with ESMTPS id b4sm3359124pba.43.2011.07.23.22.58.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 23 Jul 2011 22:58:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.347.g96e0b.dirty
In-Reply-To: <1311487074-25070-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177720>

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-bisect.sh |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index f3913ba..3ae1aa9 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -121,6 +121,9 @@ bisect_start() {
 		echo "$arg" > $GIT_DIR/BISECT_IGNORE_CHECKOUT_FAILURE
 		shift
 		;;
+	    --*)
+		die "unrecognised option: $arg"
+		;;
 	    *)
 		rev=$(git rev-parse -q --verify "$arg^{commit}") || {
 		    test $has_double_dash -eq 1 &&
-- 
1.7.6.347.g96e0b.dirty
