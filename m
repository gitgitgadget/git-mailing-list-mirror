From: "Albert L. Lash, IV" <albert.lash@gmail.com>
Subject: [PATCH 3/4] docs/git-clone: clarify use of --no-hardlinks option
Date: Sat,  8 Feb 2014 15:41:36 -0500
Message-ID: <1391892097-16169-3-git-send-email-alash3@bloomberg.net>
References: <1391892097-16169-1-git-send-email-alash3@bloomberg.net>
Cc: "Albert L. Lash, IV" <alash3@bloomberg.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 08 21:51:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCEs2-00058Z-Iz
	for gcvg-git-2@plane.gmane.org; Sat, 08 Feb 2014 21:51:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751689AbaBHUvU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Feb 2014 15:51:20 -0500
Received: from mail-qa0-f53.google.com ([209.85.216.53]:56163 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644AbaBHUvE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Feb 2014 15:51:04 -0500
Received: by mail-qa0-f53.google.com with SMTP id cm18so7452340qab.12
        for <git@vger.kernel.org>; Sat, 08 Feb 2014 12:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ku0mX6yGlqqjP5ubEpvAU2BGPfXLRJWAwgRCDtmOyzM=;
        b=EfjOH9yH7yCCyWWsjLMPp0JvzZA8MrZ+UIHrkL5qvBwpaZpAWoCIX26MDUymTtX3rc
         qy8yokIgwiV4eLUJhxi1wVBPTaLcsmh4HU+yUFFS6Tq0ENecuLrW11i/EPgNotaNecfy
         FX2iswP97Xh5YixdL9V8otxsSXODc9K7WV7qdY+EF91LD6APs/Urju++i7KF8FBn63ZK
         lWbvh5fPWOPnjpxlLBu5s4R0BZScOSwp60AUf1oNh+EZtTsc+8C2wA7Ls8gj7d4yLTfd
         ImMRtcfwQSPUk1HJxA/s5fIYo9+fsMcX0mNOwtukyyXwjfdSF+noCVHNsCr/jijJMmA2
         MLBA==
X-Received: by 10.224.28.197 with SMTP id n5mr34340394qac.43.1391892664031;
        Sat, 08 Feb 2014 12:51:04 -0800 (PST)
Received: from osday-ubuntu.bloomberg.com ([65.115.226.27])
        by mx.google.com with ESMTPSA id o75sm15994005qgd.11.2014.02.08.12.51.03
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Feb 2014 12:51:03 -0800 (PST)
X-Mailer: git-send-email 1.9.0.rc3.4.g9111436
In-Reply-To: <1391892097-16169-1-git-send-email-alash3@bloomberg.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241857>

Current text claims optimization, implying the use of
hardlinks, when this option ratchets down the level of
efficiency. This change explains the difference made by
using this option, namely copying instead of hardlinking,
and why it may be useful.

Signed-off-by: Albert L. Lash, IV <alash3@bloomberg.net>
---
 Documentation/git-clone.txt | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index bf3dac0..0363d00 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -55,15 +55,12 @@ repository is specified as a URL, then this flag is ignored (and we
 never use the local optimizations).  Specifying `--no-local` will
 override the default when `/path/to/repo` is given, using the regular
 Git transport instead.
-+
-To force copying instead of hardlinking (which may be desirable if you
-are trying to make a back-up of your repository), but still avoid the
-usual "Git aware" transport mechanism, `--no-hardlinks` can be used.
 
 --no-hardlinks::
-	Optimize the cloning process from a repository on a
-	local filesystem by copying files under `.git/objects`
-	directory.
+	Force the cloning process from a repository on a local
+	filesystem to copy the files under the `.git/objects`
+	directory instead of using hardlinks. This may be desirable
+	if you are trying to make a back-up of your repository.
 
 --shared::
 -s::
-- 
1.8.3.2
