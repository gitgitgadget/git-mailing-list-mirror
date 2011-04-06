From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/4] Documentation: Allow custom diff tools to be specified in 'diff.tool'
Date: Wed,  6 Apr 2011 15:27:33 +0530
Message-ID: <1302083854-2448-4-git-send-email-artagnon@gmail.com>
References: <1301654600-8901-1-git-send-email-artagnon@gmail.com>
 <1302083854-2448-1-git-send-email-artagnon@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 06 11:59:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7PW7-00062s-3d
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 11:59:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755509Ab1DFJ67 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 05:58:59 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44390 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755472Ab1DFJ64 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 05:58:56 -0400
Received: by mail-iy0-f174.google.com with SMTP id 14so1266731iyb.19
        for <git@vger.kernel.org>; Wed, 06 Apr 2011 02:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=ijs3RDeA5mlyvMre2jtswk5zHgitlK9sIR2vYRC6Jek=;
        b=QVCqJYZJRihsaoT+sZvzVJ74eoec8uDNe0+mC54R53SjLXoiqhuWobo4zhgYdkHvw5
         jP6FkVOK3xYmKtZ7JPASSI/PcuUwDf/YndzZFkArUtN5DW1KaS/wNR0oBdazTTdAH9R/
         0uOuN8md3G6UyDeq/4pvk5z2vuGiTcIjHuAVw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=BQAY4Qci6+TuiVpeRvoGJ2ftYHnzaAQYNA33kW1JJ7FXIV1Ah67wfbY3TpoBj8Zy6J
         ZUIBD65I/xaefRaKUB0Bb4+uerBAdbbFPVdwM78a6uF2F/uqxChGLBOGg1r8toUpkEne
         dZxpwtHkel+oSAGAiPNjk97mSUVfgdt1Kck04=
Received: by 10.43.62.72 with SMTP id wz8mr1188264icb.350.1302083935878;
        Wed, 06 Apr 2011 02:58:55 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id c1sm318477ibe.51.2011.04.06.02.58.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Apr 2011 02:58:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1302083854-2448-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170960>

Apart from the list of "valid values", 'diff.tool' can take any value,
provided there is a corresponding 'difftool.<tool>.cmd' option.  Also,
describe this option just before the 'difftool.*' options.

Helped-by: Michael J Gruber <git@drmicha.warpmail.net>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/diff-config.txt |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index 0796d5e..f1468df 100644
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
@@ -88,3 +82,10 @@ diff.<driver>.wordregex::
 diff.<driver>.cachetextconv::
 	Set this option to true to make the diff driver cache the text
 	conversion outputs.  See linkgit:gitattributes[5] for details.
+
+diff.tool::
+	The diff tool to used by linkgit:git-difftool[1].  This option
+	overrides `merge.tool`, and has the same valid values as
+	`merge.tool` minus "tortoisemerge" and plus "kompare".  Any
+	other value is treated as a custom diff tool, and there must
+	be a corresponding 'difftool.<tool>.cmd' option.	
-- 
1.7.4.rc1.7.g2cf08.dirty
