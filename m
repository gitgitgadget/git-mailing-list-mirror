From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/3] git-remote-mediawiki build: make 'install' command
 configurable
Date: Mon, 11 Nov 2013 12:45:50 -0800
Message-ID: <20131111204550.GO10302@google.com>
References: <20131109022239.GI10302@google.com>
 <vpqli0xstcw.fsf@anie.imag.fr>
 <20131111204504.GM10302@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thorsten Glaser <t.glaser@tarent.de>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Nov 11 21:45:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VfyMw-00075w-9X
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 21:45:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752458Ab3KKUpz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 15:45:55 -0500
Received: from mail-pd0-f179.google.com ([209.85.192.179]:36472 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752466Ab3KKUpy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 15:45:54 -0500
Received: by mail-pd0-f179.google.com with SMTP id y10so5657213pdj.24
        for <git@vger.kernel.org>; Mon, 11 Nov 2013 12:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=KNNrEBr65jxAUR3Hg2Qy1HosR5Gv7podfv8KepxGMdY=;
        b=dBVw/Gp32v6Xo9cPhOO6pO7wxbE9LNfgCl9JRoP8UHEQr8Y/YSUv8o53GgM6+7U7x1
         Wk7h13ntPNLrObLTFe2GptVLtKO9ZWbl4Nn/FTpcXha8FiUvVskLa2aOocPosYAD4UWK
         Aq5aTOTq0mYm3m829TVKsEoXRWLRVHMTJYtT58CEQAA5lHzKZOcD/TyyOPz5xhc2RqRA
         IsN7iWwfHWcgpjhfw/J1YDv/R0khMYs+Vsbb/RhM/jHdBq2OYnld6okhIf0kf2508s1o
         Lt165uKwiwRCxbbEUQiA3Uel1wF24nr/hV4LwzRJbGskc+rzAWnCDQI2v+LVLQ6zXeiV
         LT3A==
X-Received: by 10.68.230.228 with SMTP id tb4mr9008934pbc.108.1384202753394;
        Mon, 11 Nov 2013 12:45:53 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id dq3sm32756292pbc.35.2013.11.11.12.45.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 11 Nov 2013 12:45:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131111204504.GM10302@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237648>

On some machines, the most usable 'install' tool is named
'ginstall'.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 contrib/mw-to-git/Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/contrib/mw-to-git/Makefile b/contrib/mw-to-git/Makefile
index ee78fda..e685dad 100644
--- a/contrib/mw-to-git/Makefile
+++ b/contrib/mw-to-git/Makefile
@@ -18,6 +18,8 @@ SCRIPT_PERL+=git-mw.perl
 GIT_ROOT_DIR=../..
 HERE=contrib/mw-to-git/
 
+INSTALL = install
+
 SCRIPT_PERL_FULL=$(patsubst %,$(HERE)/%,$(SCRIPT_PERL))
 INSTLIBDIR=$(shell $(MAKE) -C $(GIT_ROOT_DIR)/perl \
                 -s --no-print-directory instlibdir)
@@ -30,8 +32,8 @@ test: all
 check: perlcritic test
 
 install_pm:
-	install -d -m 755 $(DESTDIR)$(INSTLIBDIR)/Git
-	install -m 644 $(GIT_MEDIAWIKI_PM) \
+	$(INSTALL) -d -m 755 $(DESTDIR)$(INSTLIBDIR)/Git
+	$(INSTALL) -m 644 $(GIT_MEDIAWIKI_PM) \
 		$(DESTDIR)$(INSTLIBDIR)/$(GIT_MEDIAWIKI_PM)
 
 build:
-- 
1.8.4.1
