From: John Tapsell <johnflux@gmail.com>
Subject: [PATCH 1/6] Modify description file to say what this file is
Date: Thu, 19 Feb 2009 07:36:00 +0000
Message-ID: <200902190736.00462.johnflux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 19 08:37:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La3TY-0002k2-0q
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 08:37:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751566AbZBSHgM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 02:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbZBSHgM
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 02:36:12 -0500
Received: from wf-out-1314.google.com ([209.85.200.169]:20229 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123AbZBSHgL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 02:36:11 -0500
Received: by wf-out-1314.google.com with SMTP id 28so363579wfa.4
        for <git@vger.kernel.org>; Wed, 18 Feb 2009 23:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:date:to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=QXNpQQCliDRxyBuiABFtH+G64qLFpXdgueo2buTHHFQ=;
        b=U8OMBTbArTTGfOq0ig45047IcTlfln2Rpa5Ye7xVCR7hMtQ1X7CCCqoP5Pd9PgHZLv
         8JOk0iBRJscgv+N5THTFfz5AagBQ1MD/eoJXoZKi/hM8kL9503pDFeP+NFLOh4Dy2oEG
         qOi9Rguf53ha99Ifv0bQtnXoux1mJHFkiWB9c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:date:to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=itw3ndEEEfGCsZYS+bnpE0c3022YnPK2sCNPg+ueA49YhoGyh08W23NO3M0dJD9/7o
         yP0f2+sNixjFrHF/AHh7EihyCh9EZUgRrHAh3WP6Hr/oT+qtSq1yOsN+PCJ5ZXUHQfiv
         PdraNncDmA0TNwjlvxkQ96R/RwwJQcC95NXng=
Received: by 10.143.45.14 with SMTP id x14mr4137318wfj.165.1235028968868;
        Wed, 18 Feb 2009 23:36:08 -0800 (PST)
Received: from johnflux-desktop.localnet (58-190-81-184.eonet.ne.jp [58.190.81.184])
        by mx.google.com with ESMTPS id 28sm1159996wfd.5.2009.02.18.23.36.07
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 18 Feb 2009 23:36:08 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110635>

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
index c6f25e8..dcde3c5 100644
--- a/templates/this--description
+++ b/templates/this--description
@@ -1 +1 @@
-Unnamed repository; edit this file to name it for gitweb.
+Unnamed repository; edit this file 'description' to name the repository
-- 
1.6.2.rc1.3.g7d31b.dirty
