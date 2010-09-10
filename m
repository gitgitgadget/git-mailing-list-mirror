From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 4/5] gettext docs: the git-sh-i18n.sh Shell interface
Date: Fri, 10 Sep 2010 19:35:52 +0000
Message-ID: <1284147353-18000-5-git-send-email-avarab@gmail.com>
References: <AANLkTikdHZFmXAdABvS9hPXtbXNJU5NdCOrw5_KP73bX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 10 21:36:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ou9Oo-0006Xz-1b
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 21:36:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754637Ab0IJTgV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Sep 2010 15:36:21 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:64843 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753049Ab0IJTgU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Sep 2010 15:36:20 -0400
Received: by wwb13 with SMTP id 13so237333wwb.1
        for <git@vger.kernel.org>; Fri, 10 Sep 2010 12:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=wQMcnT8DmWsTqnxA6WzzWjCdqOGCUytExURDtchLA7k=;
        b=nPOOwKHnP6bOal44ftkxmT6xSF4d8112fU/nQkeZDF3QFar+u/bZSJEmi85ipdgoJg
         a05aRwQrLfIIHdWlE48CHBYoINr3vBFvwohvaq19OQuFy/jZKZxkaqW+4tJ4WUKiy8TC
         OHRiGA/Ajn0WU9QgH6KxxDXVS9iXxu3He4BWg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=b76UgiOatXzjOUeo0TwmPJmqDw/V5Rw4ke5Mup5Log8IhDuPvkvmofzXX7pBZugS6O
         0Nql0C5AUtvj9YAtPnwb2XOGtP6xpkv4Wi4RWW9fto33ELjestkczNUpliHrtDrxLPe4
         OZhe0ZF/vMRshdMjO2Dq452jOJRHekfILvVKo=
Received: by 10.227.129.7 with SMTP id m7mr555381wbs.44.1284147378110;
        Fri, 10 Sep 2010 12:36:18 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id a1sm2534921wbb.8.2010.09.10.12.36.16
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 10 Sep 2010 12:36:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
In-Reply-To: <AANLkTikdHZFmXAdABvS9hPXtbXNJU5NdCOrw5_KP73bX@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155963>

Change po/README's "Marking strings for translation" section so that
it covers the git-sh-i18n.sh Shell interface.

The existing documentation in git-sh-i18n.sh has been moved to the
README file, to avoid them drifting in apart..

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-sh-i18n.sh |   16 ++--------------
 po/README      |   23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/git-sh-i18n.sh b/git-sh-i18n.sh
index b8b645a..f8dd43a 100644
--- a/git-sh-i18n.sh
+++ b/git-sh-i18n.sh
@@ -2,20 +2,8 @@
 #
 # Copyright (c) 2010 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
 #
-# This is Git's interface to gettext.sh. Use it right after
-# git-sh-setup as:
-#
-#   . git-sh-setup
-#   . git-sh-i18n
-#
-#   # For constant interface messages:
-#   gettext "A message for the user"; echo
-#
-#   # To interpolate variables:
-#   details=3D"oh noes"
-#   eval_gettext "An error occured: \$details"; echo
-#
-# See "info '(gettext)sh'" for the full manual.
+# This is Git's interface to gettext.sh. See po/README for usage
+# instructions.
=20
 # Export the TEXTDOMAIN* data that we need for Git
 TEXTDOMAIN=3Dgit
diff --git a/po/README b/po/README
index ac12637..513cf32 100644
--- a/po/README
+++ b/po/README
@@ -155,3 +155,26 @@ C:
     Here _() couldn't have statically determined what the translation
     string will be, but since it was already marked for translation
     with N_() the look-up in the message catalog will succeed.
+
+Shell:
+
+ - The Git gettext shell interface is just a wrapper for
+   gettext.sh. Import it right after git-sh-setup like this:
+
+       . git-sh-setup
+       . git-sh-i18n
+
+   And then use the gettext or eval_gettext functions:
+
+       # For constant interface messages:
+       gettext "A message for the user"; echo
+
+       # To interpolate variables:
+       details=3D"oh noes"
+       eval_gettext "An error occured: \$details"; echo
+
+   More documentation about the interface is available in the GNU info
+   page: `info '(gettext)sh'`. Looking at git-am.sh (the first shell
+   command to be translated) for examples is also useful:
+
+       git log --reverse -p --grep=3Dgettextize git-am.sh
--=20
1.7.2.3.313.gcd15
