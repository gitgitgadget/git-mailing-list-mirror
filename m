From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC] log doc: explain --encoding=none and default output
 encoding
Date: Fri, 2 Aug 2013 15:39:24 -0700
Message-ID: <20130802223924.GA7634@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 03 00:39:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5O0Y-0005Br-9R
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 00:39:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998Ab3HBWjd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Aug 2013 18:39:33 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:32924 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573Ab3HBWjd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Aug 2013 18:39:33 -0400
Received: by mail-pb0-f45.google.com with SMTP id mc17so1182894pbc.4
        for <git@vger.kernel.org>; Fri, 02 Aug 2013 15:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=dZozKIqyjW8QjJQOK1lc/8gxi1rOIEdk+AaibOf/O14=;
        b=gOaKvXea7P0x2l5ZakvLzMs8UdRGE7B/mX4K18XLGN24CKtcDsbY4sbMi+WeBaJxG3
         lEPfg1ROxJ3hYHpT31OFJYLM8g9Dpfw8JFWvy0KLWN25dUOwknR4cEWWJ3eBW7f2ZGXV
         M3vCrVHm4FyvqLZ83h+HP2Dipv76enC0pLHm5rhkI7sjcdbFYLlyyYFjU/AuUobXJ/vG
         3BSzsXnjt0tUyNS/SQas724OobCxxnfy2//1O+wbwahltGb6N+Bwad+rqVePpIR5Ilgl
         L8R4Xp3vqt26FEZz9kBFdMQWWaG5w019LyJSHnmS0vF0hdl68bblWUycpGqSdTH5nlpb
         cx1Q==
X-Received: by 10.68.252.71 with SMTP id zq7mr10156261pbc.85.1375483172535;
        Fri, 02 Aug 2013 15:39:32 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id s5sm9088185pbo.38.2013.08.02.15.39.30
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 02 Aug 2013 15:39:31 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231541>

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
I'm not thrilled with the wording.  This can probably be explained
more simply.  Ideas?

 Documentation/pretty-options.txt | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index 5e499421..e31fd494 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -32,8 +32,14 @@ people using 80-column terminals.
 	The commit objects record the encoding used for the log message
 	in their encoding header; this option can be used to tell the
 	command to re-code the commit log message in the encoding
-	preferred by the user.  For non plumbing commands this
-	defaults to UTF-8.
+	preferred by the user.  "--encoding=none" means to use the
+	raw log message without paying attention to its encoding header.
++
+For non plumbing commands, the output encoding defaults to the commit
+encoding (as set using the `i18n.commitEncoding` variable, or UTF-8
+by default).  This default can be overridden using the
+`i18n.logOutputEncoding` configuration item. See linkgit:git-config[1]
+for details.
 
 --notes[=<ref>]::
 	Show the notes (see linkgit:git-notes[1]) that annotate the
-- 
1.8.4.rc1
