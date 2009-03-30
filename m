From: "Daniel Cheng (aka SDiZ)" <j16sdiz+freenet@gmail.com>
Subject: [PATCH] Fix bash completion in path with spaces
Date: Mon, 30 Mar 2009 19:27:37 +0800
Message-ID: <1238412457-29674-1-git-send-email-j16sdiz+freenet@gmail.com>
Cc: git@vger.kernel.org,
	"Daniel Cheng (aka SDiZ)" <j16sdiz+freenet@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Mar 30 13:29:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoFg4-0005Yv-Aq
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 13:29:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756440AbZC3L1p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 07:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754638AbZC3L1p
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 07:27:45 -0400
Received: from wf-out-1314.google.com ([209.85.200.168]:8515 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753445AbZC3L1o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 07:27:44 -0400
Received: by wf-out-1314.google.com with SMTP id 29so2532394wff.4
        for <git@vger.kernel.org>; Mon, 30 Mar 2009 04:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=eh8YThjY+TarxwjCMGmaWN9/9Mwx/+dpKATIIiWwmaI=;
        b=Pir4ho5Q+XYqJVFzA5n9sf8RlGtLnBWCCW3ccgRP5VAsTS6muaJClfg6EWcWI1l+iZ
         rYdtz//Ei+e3DFgecBNDJb4h/IryaySSJpo3pkFvc1nMm9QktPqKSLgAtdhvsG2L95Mh
         kHs+sWBylDfuZKPI5/mE7eJn8nbueLS9Uopp8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        b=GMpW1lzUyUKg2rynQnMbsbtZTHhg0BX5QKxPkPdo/zl4i2Veox4aTuoArflvU7dnez
         6Xr5j7OzxdoSvWSN0Vt+UtNmqFzIfFTggRQvhCQ1FaFL/zbCM+AbEQifiYV2xMGnrVxR
         xFid/Bmw6F/Xhn+23w1uMICpoUFNnhRUjZEaM=
Received: by 10.143.162.8 with SMTP id p8mr2095933wfo.34.1238412462449;
        Mon, 30 Mar 2009 04:27:42 -0700 (PDT)
Received: from localhost.localdomain ([116.49.56.87])
        by mx.google.com with ESMTPS id 24sm8423740wff.42.2009.03.30.04.27.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 30 Mar 2009 04:27:41 -0700 (PDT)
X-Mailer: git-send-email 1.6.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115136>


Signed-off-by: Daniel Cheng (aka SDiZ) <j16sdiz+freenet@gmail.com>
---
 contrib/completion/git-completion.bash |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1c6b0e2..e72ce24 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1103,7 +1103,7 @@ _git_log ()
 	local cur="${COMP_WORDS[COMP_CWORD]}"
 	local g="$(git rev-parse --git-dir 2>/dev/null)"
 	local merge=""
-	if [ -f $g/MERGE_HEAD ]; then
+	if [ -f "$g/MERGE_HEAD" ]; then
 		merge="--merge"
 	fi
 	case "$cur" in
@@ -1943,7 +1943,7 @@ _gitk ()
 	local cur="${COMP_WORDS[COMP_CWORD]}"
 	local g="$(__gitdir)"
 	local merge=""
-	if [ -f $g/MERGE_HEAD ]; then
+	if [ -f "$g/MERGE_HEAD" ]; then
 		merge="--merge"
 	fi
 	case "$cur" in
-- 
1.6.2
