From: "Rob Shearman" <robertshearman@gmail.com>
Subject: [PATCH 1/3] git-imap-send: Allow the program to be run from subdirectories of a git tree.
Date: Mon, 7 Jul 2008 09:05:22 +0100
Message-ID: <1096648c0807070105l49a6dc38ra1710b0aadb220d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 07 10:07:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFljs-0000np-TH
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 10:06:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751813AbYGGIFY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 04:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbYGGIFY
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 04:05:24 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:54403 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729AbYGGIFX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 04:05:23 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1391030wri.5
        for <git@vger.kernel.org>; Mon, 07 Jul 2008 01:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=SbACNJ3qJX424dM1g6bDwk1SvrCbL3K8+xtUwzLL9QU=;
        b=fMCUkcsz5TW2qJjLRaGCQPs3j/FZ3pxy8UluW0lci2DyqzlKfSnTa4hfJO3A5aCKxr
         7qRnD85y6+/aoXctspbn+kjMRPJqs3va01KstMLe17rl+BPIxQthpc41cyRWuPIEUlbq
         sQjSX8e3mFg8nR2mJUrUW/acl9pwRsZOxOkmo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=Xk+7CSHqNujWbrQUtx50KELngPmG02ax4PCysAqRPsSryZ9EicIADapk+rKdTrj7JI
         ryAJKBeUYGCsFbZ8Xi3muwCG2xgMnErNouv7CyAOXb12V4qZCkd4dXFFCLN8Ju4q5j5M
         FCOKvu1mjj2R/aKqrVWnc3TqYzeYLX5GYhgtM=
Received: by 10.90.91.9 with SMTP id o9mr4782852agb.35.1215417922102;
        Mon, 07 Jul 2008 01:05:22 -0700 (PDT)
Received: by 10.90.93.17 with HTTP; Mon, 7 Jul 2008 01:05:22 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87593>

Call setup_git_directory_gently to allow git-imap-send to be used from
subdirectories of a git tree.
---
 imap-send.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 1ec1310..89a1532 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1296,6 +1296,7 @@ main(int argc, char **argv)
 	/* init the random number generator */
 	arc4_init();

+	setup_git_directory_gently( NULL );
 	git_config(git_imap_config, NULL);

 	if (!imap_folder) {
-- 
1.5.6.GIT
