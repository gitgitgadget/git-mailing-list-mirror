From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/4] Documentation: Allow custom diff tools to be specified in 'diff.tool'
Date: Thu,  7 Apr 2011 00:16:50 +0530
Message-ID: <1302115611-1950-4-git-send-email-artagnon@gmail.com>
References: <1302083854-2448-1-git-send-email-artagnon@gmail.com>
 <1302115611-1950-1-git-send-email-artagnon@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 06 20:48:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7XmQ-0007ED-LU
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 20:48:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756583Ab1DFSsU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 14:48:20 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63758 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756572Ab1DFSsM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 14:48:12 -0400
Received: by mail-iy0-f174.google.com with SMTP id 14so1697854iyb.19
        for <git@vger.kernel.org>; Wed, 06 Apr 2011 11:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=4gZq2W1gwT9xd1EGF0NkrMYKqc/OijhN4To4yCDP+cI=;
        b=xO5Yg+iBtoHuRBYkdD/aY5POiSRdDNyoKuEQLCEIS7T0PxqdPwUThldtAUiAJKyvRF
         +JvjEc6uEHJfubZ1esXkqJHDU6JcBszIhXQ6KxlEvRKs1PZV2aNksIkQLAJ3ys63itr4
         zUqpElz2gfiPkqa6XfltUr+wtcUCKKg+gWlrk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=N31TFLEtl2PwYFlC6tWYOjp5ROZ+ptayPPWJt2LAoX1lJkGlk9/PAADPQsrzOeenYT
         bT8zp+xdKdykyAOPh8Et5E2fo6Mnd0hQFgucaU8u2otmi+JfK5FUv4cCtFPSEFH9AiII
         0bQ4512c6NJVu9S3KmUUuZREoLtjKiggY4AP0=
Received: by 10.42.149.132 with SMTP id w4mr2137166icv.267.1302115691981;
        Wed, 06 Apr 2011 11:48:11 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id vr5sm495851icb.0.2011.04.06.11.48.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Apr 2011 11:48:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1302115611-1950-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171005>

Apart from the list of "valid values", 'diff.tool' can take any value,
provided there is a corresponding 'difftool.<tool>.cmd' option.  Also,
describe this option just before the 'difftool.*' options.

Helped-by: Michael J Gruber <git@drmicha.warpmail.net>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/diff-config.txt |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index 0796d5e..d604484 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -55,12 +55,6 @@ diff.suppressBlankEmpty::
 	A boolean to inhibit the standard behavior of printing a space
 	before each empty output line. Defaults to false.
 
-diff.tool::
-	Controls which diff tool is used.  `diff.tool` overrides
-	`merge.tool` when used by linkgit:git-difftool[1] and has
-	the same valid values as `merge.tool` minus "tortoisemerge"
-	and plus "kompare".
-
 diff.<driver>.command::
 	The custom diff driver command.  See linkgit:gitattributes[5]
 	for details.
@@ -88,3 +82,11 @@ diff.<driver>.wordregex::
 diff.<driver>.cachetextconv::
 	Set this option to true to make the diff driver cache the text
 	conversion outputs.  See linkgit:gitattributes[5] for details.
+
+diff.tool::
+	The diff tool to be used by linkgit:git-difftool[1].  This
+	option overrides `merge.tool`, and has the same valid built-in
+	values as `merge.tool` minus "tortoisemerge" and plus
+	"kompare".  Any other value is treated as a custom diff tool,
+	and there must be a corresponding `difftool.<tool>.cmd`
+	option.
-- 
1.7.4.rc1.7.g2cf08.dirty
