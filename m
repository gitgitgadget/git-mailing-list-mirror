From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 03/13] gettextize: git-clone "Cloning into" message
Date: Wed,  1 Sep 2010 20:43:55 +0000
Message-ID: <1283373845-2022-4-git-send-email-avarab@gmail.com>
References: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 01 22:45:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OquBR-000790-5C
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 22:45:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754110Ab0IAUof convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Sep 2010 16:44:35 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:34335 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753713Ab0IAUoe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Sep 2010 16:44:34 -0400
Received: by wyb35 with SMTP id 35so9681721wyb.19
        for <git@vger.kernel.org>; Wed, 01 Sep 2010 13:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=vFHNGcZnESxr5QGd5lhOPMBQQhS5U+oeOLXCC5F6JRk=;
        b=pAvI2YG6JJh7+l5bI4Cgc4t/x8JXoRQOPRBkv0r6Zb+S+me8CHyCF01VmAKoHwDxDt
         cM2KNIeDDSTWD/AEB05yduCyMu7D+PGVojykQHSLvaQfYtjNXJbFmBAH9zEJG8oG+Su6
         xJMm7m/gv3gs1Wze1lAlKRCOkiKM36nXSjH7w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=cDfBS2QGd4t1W1MyWYGFLu6G68K0JbHy9DyjI5e+v9eGYvAJ+Dd0obpulrMgiFk7Qz
         U12Hdud+ycaewqanYWPCVzcR3nS9Y6sazqt4gwneBc3S7eovoqGOvngDxFRODkB+Lmeq
         XWk1kdpDNNbmcSUjYJOFrwP7e8zb2YnfwfFfU=
Received: by 10.216.158.140 with SMTP id q12mr762195wek.14.1283373872949;
        Wed, 01 Sep 2010 13:44:32 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id v11sm6461150weq.16.2010.09.01.13.44.31
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Sep 2010 13:44:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.579.g2183d
In-Reply-To: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155080>

Split up the "Cloning into %s" and "Cloning into bare repository %s"
messages to make them easier to translate.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/clone.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 0b595ba..d1cf6dd 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -466,8 +466,10 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
 	set_git_dir(make_absolute_path(git_dir));
=20
 	if (0 <=3D option_verbosity)
-		printf("Cloning into %s%s...\n",
-		       option_bare ? "bare repository " : "", dir);
+		if (option_bare)
+			printf(_("Cloning into bare repository %s"), dir);
+		else
+			printf(_("Cloning into %s"), dir);
 	init_db(option_template, INIT_DB_QUIET);
=20
 	/*
--=20
1.7.2.2.579.g2183d
