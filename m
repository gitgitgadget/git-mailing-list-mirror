From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH] Docs: Clarify the --tags option of `git fetch'
Date: Thu, 22 Sep 2011 03:39:00 -0000
Message-ID: <58d5d7abced4468ea7587a8aeddfb5ed-mfwitten@gmail.com>
References: <1314997486-29996-1-git-send-email-anatol.pomozov@gmail.com>
            <1316649176-32352-1-git-send-email-anatol.pomozov@gmail.com>
            <CAMOZ1BuSd52woX0utOQ84gbCzBkZg3ATKnE+7G_BrD5_hUQSiQ@mail.gmail.com>
            <7vwrd1z9it.fsf@alter.siamese.dyndns.org>
            <CAMOZ1Bvxc+vcofb_KyeLS7Gy=KOtX1SKv72cXA2NtwgYCWA31A@mail.gmail.com>
            <CAMOZ1Bt6gGVd6QuRZduZ4mJ=eoZ9d7xK-WfwZ3G-+oswT0RN_Q@mail.gmail.com>
            <CAH5451nb=DTed2kAVNQmFBbGFJ9zvQAtBE+VCzKqZfGMgYpx5w@mail.gmail.com>
            <CAMOZ1BtPJ_Ddxo1UG2cxJMnGv9y8sR0rAyk3d_5JEz4kLsUQJQ@mail.gmail.com>
Cc: Anatol Pomozov <anatol.pomozov@gmail.com>,
	Drew Northup <drew.northup@maine.edu>,
	Andrew Ardill <andrew.ardill@gmail.com>,
	Daniel Johnson <computerdruid@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 22 05:48:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6aHI-0000Vm-3E
	for gcvg-git-2@lo.gmane.org; Thu, 22 Sep 2011 05:48:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995Ab1IVDnu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Sep 2011 23:43:50 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61887 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760Ab1IVDnt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Sep 2011 23:43:49 -0400
Received: by iaqq3 with SMTP id q3so2370722iaq.19
        for <git@vger.kernel.org>; Wed, 21 Sep 2011 20:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=subject:date:from:to:cc:message-id:in-reply-to:references;
        bh=zoMiJVy8BSmldnhzMgyJfhVsJdlCTdzY5Lwc40eo/Lw=;
        b=sMnqqoKNRbjThzeQ2KOGADLa0mP5Q/Ikj+gbpnfAyx+evWMfuDqudxb6AvTa8R2qj3
         pvVCqYNkZ0PkC0I777W1kt8YaUomYimB/vEXEMVyYuufhBcCbTgPtMUmhc2vJiTI4MY5
         agNK0QMphkubmqEZbDuPbkr6hVRlJW2axKYQc=
Received: by 10.43.133.133 with SMTP id hy5mr1238325icc.82.1316663029189;
        Wed, 21 Sep 2011 20:43:49 -0700 (PDT)
Received: from gmail.com (tor-exit-router40-readme.formlessnetworking.net. [199.48.147.40])
        by mx.google.com with ESMTPS id fy35sm6938178ibb.4.2011.09.21.20.43.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 21 Sep 2011 20:43:48 -0700 (PDT)
In-Reply-To: <CAMOZ1BtPJ_Ddxo1UG2cxJMnGv9y8sR0rAyk3d_5JEz4kLsUQJQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181880>

See the discussion starting here:

  [PATCH] Clarify that '--tags' fetches tags only
  Message-ID: <1314997486-29996-1-git-send-email-anatol.pomozov@gmail.com>
  http://thread.gmane.org/gmane.comp.version-control.git/180636

Suggested-by: Anatol Pomozov <anatol.pomozov@gmail.com>
Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 Documentation/fetch-options.txt |   21 ++++++++++++++++++---
 1 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 39d326a..fb743fa 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -61,9 +61,24 @@ ifndef::git-pull[]
 	objects reachable from the branch heads that are being
 	tracked will not be fetched by this mechanism.  This
 	flag lets all tags and their associated objects be
-	downloaded. The default behavior for a remote may be
-	specified with the remote.<name>.tagopt setting. See
-	linkgit:git-config[1].
+	downloaded.
++
+This option is merely a short-hand for writing the
+refspec `refs/tags/\*:refs/tags/\*'; consequently,
+using this option overrides any default refspec that
+would be used if no refspec were provided on the
+command line. That is,
++
+	git fetch origin --tags
+	git fetch origin frotz --tags bar
++
+are equivalent to:
++	
+	git fetch origin 'refs/tags/*:refs/tags/*'
+	git fetch origin frotz 'refs/tags/*:refs/tags/*' bar
++
+The default behavior for a remote may be specified with
+the remote.<name>.tagopt setting. See linkgit:git-config[1].
 
 --recurse-submodules[=yes|on-demand|no]::
 	This option controls if and under what conditions new commits of
-- 
1.7.6.409.ge7a85
