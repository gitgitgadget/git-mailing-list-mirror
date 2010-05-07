From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH] blame-options.txt: Add default value for `-M/-C` options.
Date: Thu,  6 May 2010 21:51:57 -0700
Message-ID: <1273207917-17663-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 07 06:52:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAFXq-0008NQ-7x
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 06:52:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751579Ab0EGEwH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 May 2010 00:52:07 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55907 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703Ab0EGEwF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 May 2010 00:52:05 -0400
Received: by gyg13 with SMTP id 13so428683gyg.19
        for <git@vger.kernel.org>; Thu, 06 May 2010 21:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=3wYai30FfxSPjzJawcFMo9dT+mH2fTX0XyY7gw+QuRI=;
        b=Pf94TUqyttHdLik8xC4Oo8FID2m9aixmwQS7KaC5f8jkUucupYBjd3Vq6I850MU0Hs
         RIwKnG28U1u0ETHP6hefJlmYoM58aI9Z7A7Ht4/+anb6fH/NLJcotZIQ31ZYVuPs0zCM
         cUAEdi23lNYZBcg0tKuCFeEtQcJxwSnuCaLlA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=MhJpuDG9dol/rDKhoi+P1B14lr4dD+kzUUC3IHPyLA4GPo+RQnkeCugYpnF4/QANHe
         rTkNbR2Qg/4sfH61UN3dbZdIcjjSGWfJ6N3q54j8r8XYAap/gLWqw0kPS/4gzlj6mU7c
         ahuBBmJVHnIpLgg75nIzFEqf5BJC+k6FDkrPM=
Received: by 10.101.146.39 with SMTP id y39mr6818112ann.126.1273207923466;
        Thu, 06 May 2010 21:52:03 -0700 (PDT)
Received: from localhost.localdomain ([222.30.37.37])
        by mx.google.com with ESMTPS id z7sm16467405ani.9.2010.05.06.21.52.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 May 2010 21:52:02 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146519>

Both `-M` and `-C` have default values and the <num> argument
the last `-C` option takes effect.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 Documentation/blame-options.txt |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index d820569..16e3c68 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -90,9 +90,9 @@ of lines before or after the line given by <start>.
 	running extra passes of inspection.
 +
 <num> is optional but it is the lower bound on the number of
-alphanumeric characters that git must detect as moving
+alphanumeric characters that git must detect as moving/copying
 within a file for it to associate those lines with the parent
-commit.
+commit. The default value is 20.
 
 -C|<num>|::
 	In addition to `-M`, detect lines moved or copied from other
@@ -105,9 +105,11 @@ commit.
 	looks for copies from other files in any commit.
 +
 <num> is optional but it is the lower bound on the number of
-alphanumeric characters that git must detect as moving
+alphanumeric characters that git must detect as moving/copying
 between files for it to associate those lines with the parent
-commit.
+commit. And the default value is 40. If there are more than one
+`-C` options given, the <num> argument of the last `-C` will
+take effect.
 
 -h::
 --help::
-- 
1.6.0.4
