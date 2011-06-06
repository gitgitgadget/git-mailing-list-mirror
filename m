From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv3 2/5] gitweb: Describe CSSMIN and JSMIN in gitweb/INSTALL
Date: Mon,  6 Jun 2011 19:44:28 +0200
Message-ID: <1307382271-7677-3-git-send-email-jnareb@gmail.com>
References: <1307382271-7677-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>,
	Drew Northup <drew.northup@maine.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 19:56:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTe2e-0007hm-Td
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 19:56:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755948Ab1FFR4j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 13:56:39 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42767 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665Ab1FFR4i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 13:56:38 -0400
Received: by wya21 with SMTP id 21so2985094wya.19
        for <git@vger.kernel.org>; Mon, 06 Jun 2011 10:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=swWRSBRmzsibCJ5UFDNZzYrK9+eplnAIKvnFSY7jUVU=;
        b=ORcZGYcHmJMz//GwBxkJw/vh0cWClgv+XWJT0061Uya9+2CytVgt9M7IKyqDtpWG8w
         DbI35KoAqsh1jamSsD4nOB0ykG5Qkk6xK6Y3RWJQEUkq6ACgyBDYW/AhqaTYhiJ+it+F
         QWxfYaLfX9Fd74vqg3Hme/JyQR+WJpkmyYX0U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=PBX7TSxC/T1efdaQmh5HMgXWEJpyEX+SKv9K9oE7yJJFwmhvy+XXk5g9O8nPHaUjKu
         1GdYNbLIKvv5Km8HIRQKEtj1VDMQFCUC9CB6Id1wicmJwU/AuI4apwpxOiMcsGfomxdp
         NlJwUUOEqS1M4bc0S5jyZlBWcAmhZwYZQBevE=
Received: by 10.216.15.137 with SMTP id f9mr5075514wef.62.1307382997806;
        Mon, 06 Jun 2011 10:56:37 -0700 (PDT)
Received: from localhost.localdomain (abwr100.neoplus.adsl.tpnet.pl [83.8.241.100])
        by mx.google.com with ESMTPS id t79sm2440982weq.5.2011.06.06.10.56.35
        (version=SSLv3 cipher=OTHER);
        Mon, 06 Jun 2011 10:56:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.5
In-Reply-To: <1307382271-7677-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175142>

The build-time configuration variables JSMIN and CSSMIN were mentioned
only in Makefile; add their description to gitweb/INSTALL.

This required moving description of GITWEB_JS up, near GITWEB_CSS and
just introduced CSMIN and JSMIN.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
No differences from previous version.

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
