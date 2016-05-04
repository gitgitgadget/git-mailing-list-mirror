From: Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH v2 1/3] config: describe 'pathname' value type
Date: Wed,  4 May 2016 11:42:13 -0700
Message-ID: <1462387335-57937-1-git-send-email-computersforpeace@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Brian Norris <computersforpeace@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 04 20:42:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay1lA-0000qE-2U
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 20:42:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752399AbcEDSmv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 14:42:51 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34262 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825AbcEDSmu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 14:42:50 -0400
Received: by mail-pa0-f53.google.com with SMTP id r5so27737682pag.1
        for <git@vger.kernel.org>; Wed, 04 May 2016 11:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=TDUNL1u3Cw647S76uFWXQaYHREcBGUTVJXeQCN8ZyrU=;
        b=YTLFDln00N5Gpzj9s3PJOLx20r1hcaVNEF8o6oVKeduz57j0nB9+Q2tJ3VDKJv970i
         P1se2D+OtKA/DJP4JXxj/b1tnTYQH8YWGjFOcuPOCYUD1cMgAXuQd0xSLBZWXSG6k+kh
         6yZW/tSMBN4dSZgjpQ5Km3851Pj/E9UPI8n7awaz0buFDXuInSGGQdDqCpcpHauCdL0q
         aTkTLHIabF49AdtiGzAQv4G1fzThOPFl9Og+shgCAM8RXdp5PXDxcLhEcMZlrBhsVsaM
         TMsPCUCBMKnsHrO4cRGRzArpGt0QjqridT9rEdlI3IRB3hPPGR3dIVDSFIMX4QWj5PWM
         N/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TDUNL1u3Cw647S76uFWXQaYHREcBGUTVJXeQCN8ZyrU=;
        b=CG2jV19Y9uOJ4HeS963W2JPgfLLEtt/U9mnNm7rx4crQVoSv616CvCEbIxaIdHvdFk
         PioLPy4IRxfnAY4/2POW73zHPBQzGfsFMtTdGaNwi0ZJ2izddzZKoLzEpVmuCtGecKfS
         hhEojb/G3QLjzEIJlIbUXpY31VQPeA5mV+cyv4g6axlOllNuBE55W/0PgLpFZnNS1/Yl
         VxaS2ulfuDg9Z3E+c3cOopgv3OMM0Fuqc2cgbAeu3Sv6jFJgBH4jUMf1SprRsRbSdrFu
         5rqQ59IQjgjuLYgRCUea3LVuGJuKxhco7Xors39yIpV0hiCOv+zPFRCdqQwRubJ/FBb+
         UnVQ==
X-Gm-Message-State: AOPr4FUF46ItSbHE9L+FPmd7Ms259NaKLnRX9eLJAWeITv0cKYhKmDUBNCUj1ozkPJqtFw==
X-Received: by 10.66.141.73 with SMTP id rm9mr14019077pab.84.1462387369668;
        Wed, 04 May 2016 11:42:49 -0700 (PDT)
Received: from ban.mtv.corp.google.com ([172.22.64.120])
        by smtp.gmail.com with ESMTPSA id k78sm7785955pfk.70.2016.05.04.11.42.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 May 2016 11:42:49 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293564>

From: Junio C Hamano <gitster@pobox.com>

We have a dedicated section for various value-types used in the
configuration variables already, because we needed to describe how
booleans and scaled integers can be spelled, and the pathname type
would fit there.

Adjust the description of `include.path`, `core.excludesFile`, and
`commit.template` variables to clarify that the variables are of this
type.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
v2: new

 Documentation/config.txt | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 42d2b50477b2..7264abf7f85e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -81,13 +81,16 @@ Includes
 
 You can include one config file from another by setting the special
 `include.path` variable to the name of the file to be included. The
+variable takes a pathname as its value, and is subject to tilde
+expansion.
+
+The
 included file is expanded immediately, as if its contents had been
 found at the location of the include directive. If the value of the
 `include.path` variable is a relative path, the path is considered to be
 relative to the configuration file in which the include directive was
-found. The value of `include.path` is subject to tilde expansion: `~/`
-is expanded to the value of `$HOME`, and `~user/` to the specified
-user's home directory. See below for examples.
+found.  See below for examples.
+
 
 Example
 ~~~~~~~
@@ -169,6 +172,13 @@ thing on the same output line (e.g. opening parenthesis before the
 list of branch names in `log --decorate` output) is set to be
 painted with `bold` or some other attribute.
 
+pathname::
+	A variable that takes a pathname value can be given a
+	string that begins with "`~/`" or "`~user/`", and the usual
+	tilde expansion happens to such a string: `~/`
+	is expanded to the value of `$HOME`, and `~user/` to the
+	specified user's home directory.
+
 
 Variables
 ~~~~~~~~~
@@ -593,11 +603,10 @@ be delta compressed, but larger binary media files won't be.
 Common unit suffixes of 'k', 'm', or 'g' are supported.
 
 core.excludesFile::
-	In addition to '.gitignore' (per-directory) and
-	'.git/info/exclude', Git looks into this file for patterns
-	of files which are not meant to be tracked.  "`~/`" is expanded
-	to the value of `$HOME` and "`~user/`" to the specified user's
-	home directory. Its default value is $XDG_CONFIG_HOME/git/ignore.
+	Specifies the pathname to the file that contains patterns to
+	describe paths that are not meant to be tracked, in addition
+	to '.gitignore' (per-directory) and '.git/info/exclude'.
+	Defaults to $XDG_CONFIG_HOME/git/ignore.
 	If $XDG_CONFIG_HOME is either not set or empty, $HOME/.config/git/ignore
 	is used instead. See linkgit:gitignore[5].
 
@@ -1106,9 +1115,8 @@ commit.status::
 	message.  Defaults to true.
 
 commit.template::
-	Specify a file to use as the template for new commit messages.
-	"`~/`" is expanded to the value of `$HOME` and "`~user/`" to the
-	specified user's home directory.
+	Specify the pathname of a file to use as the template for
+	new commit messages.
 
 credential.helper::
 	Specify an external helper to be called when a username or
-- 
2.8.0.rc3.226.g39d4020
