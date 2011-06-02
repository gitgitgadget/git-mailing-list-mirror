From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/2] gitweb: Describe CSSMIN and JSMIN in gitweb/INSTALL
Date: Thu,  2 Jun 2011 16:55:53 +0200
Message-ID: <1307026553-1181-3-git-send-email-jnareb@gmail.com>
References: <1307026553-1181-1-git-send-email-jnareb@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 02 17:05:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QS9Sy-0006Ry-9K
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 17:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516Ab1FBPFj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2011 11:05:39 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45369 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751131Ab1FBPFj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2011 11:05:39 -0400
Received: by fxm17 with SMTP id 17so754843fxm.19
        for <git@vger.kernel.org>; Thu, 02 Jun 2011 08:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=9mVoE+cM/ku1tqH/2KbrzGENhpzVv9LX/fNJhNEphdg=;
        b=VKhStyXpeGqxF2zSjnS2XOAkF4TfnEbl780CQYkoWhi7PK0hBmns1fWNeiFgBH+OjC
         gqaEQvgHan97r5SaUv2yDf1H6YDwEibu66CR4AHsR71enN3i3vYawzsZoPOI2L2eVgwC
         Lw00AnVRlqIG3OhxL550vclZEqBKvDRBZo7VQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=L1L7nyGV5CmPivanHY6W1BuAHhaXNL2AQWGypomflp6sOSTaEQcUJ7b80YR0JNKJK7
         o4ZFsX3B/H+ScGAv/X9vEy1P9AwW6qsrUbqtyo1p1ZnrLDqFyylH0DZgsrf/oj0szXyj
         Ng4mYNQJ3bZljRA+WPOu7Y8Rw4yy/IMJO5OIY=
Received: by 10.223.94.129 with SMTP id z1mr9219fam.144.1307026592851;
        Thu, 02 Jun 2011 07:56:32 -0700 (PDT)
Received: from localhost.localdomain (abvc230.neoplus.adsl.tpnet.pl [83.8.200.230])
        by mx.google.com with ESMTPS id c1sm204029faa.37.2011.06.02.07.56.31
        (version=SSLv3 cipher=OTHER);
        Thu, 02 Jun 2011 07:56:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.5
In-Reply-To: <1307026553-1181-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174956>

The build-time configuration variables JSMIN and CSSMIN were mentioned
only in Makefile; add their description to gitweb/INSTALL.

This required moving description of GITWEB_JS up, near GITWEB_CSS and
just introduced CSMIN and JSMIN.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/INSTALL |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/gitweb/INSTALL b/gitweb/INSTALL
index 32a52b7..2346aad 100644
--- a/gitweb/INSTALL
+++ b/gitweb/INSTALL
@@ -147,6 +147,19 @@ You can specify the following configuration variables when building GIT:
    the gitweb config file.  [Default: static/gitweb.css (or
    static/gitweb.min.css if the CSSMIN variable is defined / CSS minifier
    is used)]
+ * GITWEB_JS
+   Points to the location where you put gitweb.js on your web server
+   (or to be more generic URI of JavaScript code used by gitweb).
+   Relative to base URI of gitweb.  [Default: static/gitweb.js (or
+   static/gitweb.min.js if JSMIN build variable is defined / JavaScript
+   minifier is used)]
+ * CSSMIN, JSMIN
+   Invocation of a CSS minifier or a JavaScript minifier, respectively,
+   working as a filter (source on standard input, minified result on
+   standard output).  If set, it is used to generate a minified version of
+   'static/gitweb.css' or 'static/gitweb.js', respectively.  *Note* that
+   minified files would have *.min.css and *.min.js extension, which is
+   important if you also set GITWEB_CSS and/or GITWEB_JS.  [No default]
  * GITWEB_LOGO
    Points to the location where you put git-logo.png on your web server
    (or to be more generic URI of logo, 72x27 size, displayed in top right
@@ -158,12 +171,6 @@ You can specify the following configuration variables when building GIT:
    web browsers that support favicons (website icons) may display them
    in the browser's URL bar and next to site name in bookmarks).  Relative
    to base URI of gitweb.  [Default: static/git-favicon.png]
- * GITWEB_JS
-   Points to the location where you put gitweb.js on your web server
-   (or to be more generic URI of JavaScript code used by gitweb).
-   Relative to base URI of gitweb.  [Default: static/gitweb.js (or
-   static/gitweb.min.js if JSMIN build variable is defined / JavaScript
-   minifier is used)]
  * GITWEB_CONFIG
    This Perl file will be loaded using 'do' and can be used to override any
    of the options above as well as some other options -- see the "Runtime
-- 
1.7.5
