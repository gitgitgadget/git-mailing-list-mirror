From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/3] Test environment of git-remote-mw
Date: Fri, 01 Jun 2012 11:21:58 +0200
Message-ID: <vpq7gvridzd.fsf@bauges.imag.fr>
References: <4FC64B0C.6070507@ensimag.imag.fr>
	<1338397492-13360-1-git-send-email-simon.cathebras@ensimag.imag.fr>
	<1338397492-13360-2-git-send-email-simon.cathebras@ensimag.imag.fr>
	<vpqzk8oq0oe.fsf@bauges.imag.fr> <4FC88310.2020103@ensimag.imag.fr>
	<vpqpq9jievq.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, charles.roussel@ensimag.imag.fr,
	Guillaume.Sasdy@ensimag.imag.fr, Julien.Khayat@ensimag.imag.fr,
	Simon.Perrat@ensimag.imag.fr,
	Charles Roussel <charles.roussel@ensimag.fr>,
	Guillaume Sasdy <guillaume.sasdy@gmail.com>
To: Simon.Cathebras@ensimag.imag.fr
X-From: git-owner@vger.kernel.org Fri Jun 01 11:22:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaO3i-0001vg-SM
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 11:22:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465Ab2FAJWK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jun 2012 05:22:10 -0400
Received: from mx1.imag.fr ([129.88.30.5]:33714 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756657Ab2FAJWI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2012 05:22:08 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q519Dabx017421
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 1 Jun 2012 11:13:36 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SaO3T-0005CU-Uq; Fri, 01 Jun 2012 11:21:59 +0200
In-Reply-To: <vpqpq9jievq.fsf@bauges.imag.fr> (Matthieu Moy's message of "Fri,
	01 Jun 2012 11:02:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 01 Jun 2012 11:13:37 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q519Dabx017421
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1339146818.69424@Osj39tT5AT/Z7VZIdxWEuA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198967>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> "Simon.Cathebras" <Simon.Cathebras@ensimag.imag.fr> writes:
>
>> On the other hand, considering the git-mediawiki is curently on
>> contrib branch, shall we move our test environement from git/t to
>> git/contrib/t ?
>
> If so, that would be to $git/contrib/mw-to-git/t/.
>
> I'm not sur what's best, depending on the future of the tool:
>
> If, once Git-MediaWiki is robust, well-tested, ... and enough people are
> interested, it may make sense to move Git-MediaWiki out of the contrib/
> directory, and integrate it as an official command (like git-svn for
> example). That would make the installation process seamless ("make
> install" would install git-remote-mediawiki like other commands, "make
> doc" would generate the doc, and so on), which would be nice for the
> user.

Here's another attempt to be nice to the user, without getting out of
the contrib/ directory. I suggest that you include it in your patch
serie, and build your stuff on top of it.

--------------- 8< ----------------- 8< ------------------------
From 25187a652abc0b546be2fb1afb707b32b9f1d4fc Mon Sep 17 00:00:00 2001
From: Matthieu Moy <Matthieu.Moy@imag.fr>
Date: Fri, 1 Jun 2012 11:18:20 +0200
Subject: [PATCH] git-remote-mediawiki: simple Makefile for simple
 installation

This allows the user to run "make check" to install the script in Git's
exec path, following the configuration (manual in config.mak, or through
autoconf).
---
 contrib/mw-to-git/Makefile | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 contrib/mw-to-git/Makefile

diff --git a/contrib/mw-to-git/Makefile b/contrib/mw-to-git/Makefile
new file mode 100644
index 0000000..99b7caa
--- /dev/null
+++ b/contrib/mw-to-git/Makefile
@@ -0,0 +1,29 @@
+-include ../../config.mak
+-include ../../config.mak.autogen
+
+ifndef PERL_PATH
+	PERL_PATH = /usr/bin/perl
+endif
+
+PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
+gitexecdir_SQ = $(subst ','\'',$(gitexecdir))
+
+SCRIPT=git-remote-mediawiki
+
+.PHONY: install help doc test
+help:
+	@echo 'This is the help target of the Makefile. Current configuration:'
+	@echo '  gitexecdir = $(gitexecdir_SQ)'
+	@echo '  PERL_PATH = $(PERL_PATH_SQ)'
+	@echo 'Run "$(MAKE) install" to install $(SCRIPT) in gitexecdir.'
+
+install:
+	sed -e '1s|#!.*/perl|#!$(PERL_PATH_SQ)|' $(SCRIPT) \
+            > '$(gitexecdir_SQ)/$(SCRIPT)'
+	chmod 755 '$(gitexecdir)/$(SCRIPT)'
+
+doc:
+	@echo 'Sorry, "make doc" is not implemented yet for $(SCRIPT)'
+
+test:
+	@echo 'Sorry, "make test" is not implemented yet for $(SCRIPT)'
-- 
1.7.10.2.817.g37218b0



-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
