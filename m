From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/3] git-pull.sh: prefer invoking "git <command>" over "git-<command>"
Date: Fri, 22 Mar 2013 17:59:57 +0530
Message-ID: <1363955399-13153-2-git-send-email-artagnon@gmail.com>
References: <1363955399-13153-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 22 13:29:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ164-0005Jm-LZ
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 13:29:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110Ab3CVM2x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 08:28:53 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47]:48866 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753719Ab3CVM2u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 08:28:50 -0400
Received: by mail-pb0-f47.google.com with SMTP id rp2so3044976pbb.20
        for <git@vger.kernel.org>; Fri, 22 Mar 2013 05:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=N5jit903F2oKx8pSZLoEKw2ZmmLf09zGTQ+D1qXJyVU=;
        b=Gawxs8hTEsCQJFI6YZCrF1Z6PbzsO3anFk9bqjUnua7IBN4CkqL25UbErWgTyD1qYb
         oQbicvsnRyoVeoeJK1qAVdnWwfyWZz2mD1NBJzqFp1IAC/9IH6nmTUJgPMSm7r97FpGf
         mUjf59TyUxVisWwympFIoz0rqaTQw5njwxmRWCFDWIMsWSv3i0PZCLxNrC4IjzDUqgyR
         OOckclBIWOJ14jMSg0XMHH5XwlyyFCkG2LPLzMLfa018NVA/89GO9QaDfU4GXQ2B3oca
         LD5BS/7xZi8BMytdQON6adxKiAQwel1qUA5tNpB9KYW7ZWG7/vxgWcp+o33RL/5QFVnH
         FDmw==
X-Received: by 10.68.143.197 with SMTP id sg5mr2364607pbb.101.1363955330388;
        Fri, 22 Mar 2013 05:28:50 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id ve7sm2839591pab.11.2013.03.22.05.28.48
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 22 Mar 2013 05:28:49 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.141.gad203c2.dirty
In-Reply-To: <1363955399-13153-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218796>

14e5d40c (pull: Fix parsing of -X<option>, 2010-01-17) added the lines
containing "git-push" and "git-merge", even though the prevelant style
at the time was to use the unhyphenated "git <command>" form.  Fix
this.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-pull.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 266e682..37e1cd4 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -279,11 +279,11 @@ fi
 merge_name=$(git fmt-merge-msg $log_arg <"$GIT_DIR/FETCH_HEAD") || exit
 case "$rebase" in
 true)
-	eval="git-rebase $diffstat $strategy_args $merge_args"
+	eval="git rebase $diffstat $strategy_args $merge_args"
 	eval="$eval --onto $merge_head ${oldremoteref:-$merge_head}"
 	;;
 *)
-	eval="git-merge $diffstat $no_commit $edit $squash $no_ff $ff_only"
+	eval="git merge $diffstat $no_commit $edit $squash $no_ff $ff_only"
 	eval="$eval  $log_arg $strategy_args $merge_args $verbosity $progress"
 	eval="$eval \"\$merge_name\" HEAD $merge_head"
 	;;
-- 
1.8.2.141.gad203c2.dirty
