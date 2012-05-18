From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v1] Documentation: git-rev-parse: clarify that --git-dir does not necessarily show relative paths
Date: Fri, 18 May 2012 19:23:24 +1000
Message-ID: <1337333004-23164-1-git-send-email-jon.seymour@gmail.com>
References: <20120517182304.GA14367@burratino>
Cc: gitster@pobox.com, jrnieder@gmail.com, pclouds@gmail.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 18 11:23:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVJPT-0008Vb-Ji
	for gcvg-git-2@plane.gmane.org; Fri, 18 May 2012 11:23:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762234Ab2ERJXj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 May 2012 05:23:39 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:59361 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760021Ab2ERJXi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2012 05:23:38 -0400
Received: by pbbrp8 with SMTP id rp8so3709135pbb.19
        for <git@vger.kernel.org>; Fri, 18 May 2012 02:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=tGVD2zitVLNWE5wgOOJMxmRBOL85JloeEpJFs6ZwPuY=;
        b=qfna99m3UkiiWEd30IHNMWDujQHsQTaeoiwnUiXCPNVFHUjzuNbD8BuwaIrjbk8Oqw
         ysrOo5iy8QZW7DHsdtoeq1BHIyJY27eBTGu3PtL22RwSn35XHWPdAitf+FchHhz5p83Z
         uFL5kR9282Km49W8GFOlxlQLZZ8trzZ1uOnR/kWvrvbqzmGumOtSOTOaVRzpsAIfWf+K
         3Wlb79yP54bOxbZ9AHJ5j6uWGMhDgigGS2G+wzKeEbgmQdkbfvHVuZ+CC73EMLUuttdf
         AGOHy3RTFStsjJQnKw4uvjNTlVsLqIvjvt54N9VpHuFiXbgdfnE8BB63fbt817JsyXxa
         yW5w==
Received: by 10.68.217.132 with SMTP id oy4mr37600789pbc.4.1337333017694;
        Fri, 18 May 2012 02:23:37 -0700 (PDT)
Received: from ubuntu.au.ibm.com ([119.225.135.179])
        by mx.google.com with ESMTPS id pu5sm12208919pbc.28.2012.05.18.02.23.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 May 2012 02:23:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.1.514.ge33c7ea
In-Reply-To: <20120517182304.GA14367@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197944>

The previous documentation was misleading because it lead the reader to believe
that --git-dir would always show a relative path when, in fact, the actual
behaviour does not guarantee this.

Rather, it was intended that the advice be given that if a relative path
is shown, then the path is relative to the current working directory and not some
other directory (for example, the root of the working tree).

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 Documentation/git-rev-parse.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index f63b81a..4cc3e95 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -137,7 +137,8 @@ shown.  If the pattern does not contain a globbing character (`?`,
 
 --git-dir::
 	Show `$GIT_DIR` if defined. Otherwise show the path to
-	the .git directory, relative to the current directory.
+	the .git directory. The path shown, when relative, is
+	relative to the current working directory.
 +
 If `$GIT_DIR` is not defined and the current directory
 is not detected to lie in a git repository or work tree
-- 
1.7.10.1.514.ge33c7ea
