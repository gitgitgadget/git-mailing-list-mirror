From: John Tapsell <johnflux@gmail.com>
Subject: [PATCH 1/2] Modify description file to say what this file is
Date: Tue, 17 Feb 2009 10:44:59 +0000
Message-ID: <200902171044.59974.johnflux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 17 11:46:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZNTH-00055W-ST
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 11:46:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbZBQKpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 05:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbZBQKpG
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 05:45:06 -0500
Received: from wa-out-1112.google.com ([209.85.146.177]:20541 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921AbZBQKpE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 05:45:04 -0500
Received: by wa-out-1112.google.com with SMTP id v33so1327920wah.21
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 02:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:date:to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=L3KK/cXQS/PrqQaN2l0akI290jpiw2CvF4UHhzKjAw0=;
        b=ttYy+ELD8fx0GlIdGw5swt7vMvCTq71qOnV24SBn5NxGBVOI0+WB6RgtzVCRtsvQFJ
         G85BC0yJDWUoU2zE7BEbVa2syeF+KlTV1zOuW3i7SvDMgZd3kXttgreRNwbgwj+MvuB8
         /ENBICeQSpT9+zbsgufaXxB2vsTVS97I1B3l0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:date:to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=Vt0ZlvBeciuz+MEediaLHdu1DP0zjAp04+0V1emcToAfhjlOt65ZGpqnPM8q3eBvxx
         htKyeJfQwEvf4qnQURc7VDZhHFvAL6N0fGu8sTjA6ZoIR6wAuScyV2gNsdi8XakxOwTa
         7CSdyOkaGOJ1jY/f2Pc/c8if8+SkMIQl4GZEU=
Received: by 10.115.32.18 with SMTP id k18mr2570990waj.98.1234867502959;
        Tue, 17 Feb 2009 02:45:02 -0800 (PST)
Received: from johnflux-desktop.localnet (58-190-81-184.eonet.ne.jp [58.190.81.184])
        by mx.google.com with ESMTPS id g14sm4403629rvb.0.2009.02.17.02.45.01
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 17 Feb 2009 02:45:02 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110356>

A lot of people see this message for the first time on the gitweb
interface, where there is no clue as to what 'this file' means.

Signed-off-by: John Tapsell <johnflux@gmail.com>
---
 templates/hooks--update.sample |    5 +++--
 templates/this--description    |    2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/templates/hooks--update.sample b/templates/hooks--update.sample
index 93c6055..f753d28 100755
--- a/templates/hooks--update.sample
+++ b/templates/hooks--update.sample
@@ -43,10 +43,11 @@ allowdeletetag=$(git config --bool hooks.allowdeletetag)
 
 # check for no description
 projectdesc=$(sed -e '1q' "$GIT_DIR/description")
-if [ -z "$projectdesc" -o "$projectdesc" = "Unnamed repository; edit this file to name it for gitweb." ]; then
+case $projectdesc in "Unnamed repository;"*|'')
 	echo "*** Project description file hasn't been set" >&2
 	exit 1
-fi
+	;;
+esac
 
 # --- Check types
 # if $newrev is 0000...0000, it's a commit to delete a ref.
diff --git a/templates/this--description b/templates/this--description
index c6f25e8..914a64e 100644
--- a/templates/this--description
+++ b/templates/this--description
@@ -1 +1 @@
-Unnamed repository; edit this file to name it for gitweb.
+Unnamed repository; edit the .git/description file to name it for gitweb.
-- 
1.6.2.rc1
