From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC v3 5/7] Makefile: Override --keyword= for all languages
Date: Tue,  1 Jun 2010 23:39:55 +0000
Message-ID: <1275435597-4017-6-git-send-email-avarab@gmail.com>
References: <1275173125-21010-1-git-send-email-avarab@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Jeff Epler <jepler@unpythonic.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 02 01:40:49 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJb4j-0006At-CM
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 01:40:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757502Ab0FAXk2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 19:40:28 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33347 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757460Ab0FAXkY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 19:40:24 -0400
Received: by mail-fx0-f46.google.com with SMTP id 8so1461027fxm.19
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 16:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=z2gPYCLtgO4+N85/10GEY6XpOxYaRtI2pPIbvQ5orSE=;
        b=V6F2cMjEAqywBy/PrZ159roRHdNpngk2XJDCECmPVqOP+bdonKzgFa/RidlMlXyJNJ
         q8fA3CPzF4Cef6xY+xc92oMwNZZItYbJoASRqNLdD6OLoBg7GRzgXyI10DUoLDu9WuzR
         sNzdskeCtEu8mQ1yRfRFtyvy+hrQQfDiHqspg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=I2J+T8t8h5i/Hpv7ECOOiGlfOdveJ4Et9PH8Aio+BDiyNJ4EOv5NkxrMbHh/cAagEj
         tpysE2uB0S4ipTRh7zf77D1OHBajtonB8AkJ71msrtbE3Q8il7t0i/q3VZqdhDKPVOex
         g4SKD5xh/rRY+z7iQFxQkFnXBVYz4GVgEDIg8=
Received: by 10.223.6.152 with SMTP id 24mr7875753faz.25.1275435622180;
        Tue, 01 Jun 2010 16:40:22 -0700 (PDT)
Received: from localhost.localdomain (dslb-188-098-088-194.pools.arcor-ip.net [188.98.88.194])
        by mx.google.com with ESMTPS id z12sm49391227fah.9.2010.06.01.16.40.20
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 01 Jun 2010 16:40:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.248.gb7713.dirty
In-Reply-To: <1275173125-21010-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148170>

By default xgettext will supply a default list of keywords depending
on the --language parameter. Disable this in favor of supplying a list
of keywords manually.

This reduced the surface area for potential bugs.
---
 Makefile |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 40eb1a2..62b8279 100644
--- a/Makefile
+++ b/Makefile
@@ -1884,9 +1884,9 @@ cscope:
 	$(FIND) . -name '*.[hcS]' -print | xargs cscope -b
 
 pot:
-	$(XGETTEXT) --keyword=_ --output=po/git.pot --language=C $(C_OBJ:o=c)
-	$(XGETTEXT) --join-existing --output=po/git.pot --language=Shell $(SCRIPT_SH)
-	$(XGETTEXT) --join-existing --output=po/git.pot --language=Perl $(SCRIPT_PERL)
+	$(XGETTEXT) --keyword= --keyword=_ --output=po/git.pot --language=C $(C_OBJ:o=c)
+	$(XGETTEXT) --join-existing --keyword= --keyword=gettext --output=po/git.pot --language=Shell $(SCRIPT_SH)
+	$(XGETTEXT) --join-existing --keyword= --keyword=gettext --output=po/git.pot --language=Perl $(SCRIPT_PERL)
 
 POFILES := $(wildcard po/*.po)
 MOFILES := $(patsubst po/%.po,share/locale/%/LC_MESSAGES/git.mo,$(POFILES))
-- 
1.7.1.248.gb7713.dirty
