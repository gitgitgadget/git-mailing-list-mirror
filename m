From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC v4 5/7] Makefile: Override --keyword= for all languages
Date: Wed,  2 Jun 2010 01:06:02 +0000
Message-ID: <1275440764-26153-6-git-send-email-avarab@gmail.com>
References: <AANLkTimhxqGRPjYz-k5f-LTIk6KajEwUuGJWt-dAKZQT@mail.gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Jeff Epler <jepler@unpythonic.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 02 03:06:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJcPq-0004k8-Cm
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 03:06:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757506Ab0FBBGZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 21:06:25 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55589 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756443Ab0FBBGX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 21:06:23 -0400
Received: by mail-fx0-f46.google.com with SMTP id 8so1482447fxm.19
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 18:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=/EHhPL7/w3SnVBb0+E7qDdIiOtidVuXN/u+Ztts1MO8=;
        b=xp1Vqvl/hBi0htJtS2gcO1duzM/qlYPCw8e76mdqWBqbDf+fhTaF6CHKCiE6SbygXk
         cLrqdqY81rZFoqfj8WoA6VyWY6d6CCT6KTTahEcPnh8CMvI74dqs3zwZhv6OXCqqcFev
         XbPXMkNqINa3xoIvsbT+h010bXRvAlZwoKLU0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=IK0FhCO4QF6T0C0GrMTdbnL1w6x7Fyl/qXYkHNHWhlJkl7B4dEQ2bVIclTvU9C96Zs
         dZqRJNxJkuX7DIyX4aD/uzPfssN1LPbxjLM2kalRJiSyZngbVSk8lUg6hV229zQjy+U8
         C7OL3RcBHSYM8x3XU0YJYqTdKksKv4xXQ1kLE=
Received: by 10.223.68.131 with SMTP id v3mr7848828fai.82.1275440782746;
        Tue, 01 Jun 2010 18:06:22 -0700 (PDT)
Received: from localhost.localdomain (dslb-188-098-088-194.pools.arcor-ip.net [188.98.88.194])
        by mx.google.com with ESMTPS id 13sm49688716fad.7.2010.06.01.18.06.20
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 01 Jun 2010 18:06:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.251.gec7f5.dirty
In-Reply-To: <AANLkTimhxqGRPjYz-k5f-LTIk6KajEwUuGJWt-dAKZQT@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148185>

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
1.7.1.251.gec7f5.dirty
