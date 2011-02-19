From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 54/72] gettextize: git-status "nothing to commit" messages
Date: Sat, 19 Feb 2011 19:24:37 +0000
Message-ID: <1298143495-3681-55-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:30:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsVI-00042j-4j
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:30:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092Ab1BST3h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:29:37 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:60199 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756118Ab1BST2M (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:28:12 -0500
Received: by mail-ew0-f46.google.com with SMTP id 5so1970492ewy.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=zHF8MTAOE5UA1VxoJ0LDI/pVXP3cVEfqiMG1TnBXjyQ=;
        b=rzWvTSgzLQXqIMgkNB2LaT7FNYT0MViAudqm5tkasZUxCAq77Onk2SwchMte/73Atq
         whounNgPVyUWYnQyx2/WL+e0jl1qY3zwYKOSBUw7b7APOkMPBjsXgeE2cQVxfSz4JDSg
         /j7+t8GEodzVsrFNASpsVOXhXYlfK24QeoYQk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=J2tyc5AMxcR/DQtATD95zAa0ZvdCu2C4Q8miW49k3ewAUkxnW6iJjm8cIjXFvNocL3
         EsWBanOheaoWCSoSH+RqDfKwulVzui13UaargZPUE0ayFmK6sLBhXivsVMc99iYcPQqp
         6zDJuRUA+vZ9m5nHGiebvnGZ9JiWjGuKtRPrk=
Received: by 10.14.123.14 with SMTP id u14mr2436034eeh.39.1298143692194;
        Sat, 19 Feb 2011 11:28:12 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.28.11
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:28:11 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167363>

Gettextize the "nothing to commit" messages. Many tests explicitly
checked for this message. Change them to skip under
GETTEXT_POISON=3DYesPlease.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t7506-status-submodule.sh |    8 ++++----
 wt-status.c                 |   12 ++++++------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
index 74e0f6f..2347451 100755
--- a/t/t7506-status-submodule.sh
+++ b/t/t7506-status-submodule.sh
@@ -20,12 +20,12 @@ test_expect_success 'setup' '
 	git commit -m "Add submodule sub"
 '
=20
-test_expect_success 'status clean' '
+test_expect_success NO_GETTEXT_POISON 'status clean' '
 	git status >output &&
 	grep "nothing to commit" output
 '
=20
-test_expect_success 'commit --dry-run -a clean' '
+test_expect_success NO_GETTEXT_POISON 'commit --dry-run -a clean' '
 	test_must_fail git commit --dry-run -a >output &&
 	grep "nothing to commit" output
 '
@@ -177,12 +177,12 @@ test_expect_success 'rm submodule contents' '
 	rm -rf sub/* sub/.git
 '
=20
-test_expect_success 'status clean (empty submodule dir)' '
+test_expect_success NO_GETTEXT_POISON 'status clean (empty submodule d=
ir)' '
 	git status >output &&
 	grep "nothing to commit" output
 '
=20
-test_expect_success 'status -a clean (empty submodule dir)' '
+test_expect_success NO_GETTEXT_POISON 'status -a clean (empty submodul=
e dir)' '
 	test_must_fail git commit --dry-run -a >output &&
 	grep "nothing to commit" output
 '
diff --git a/wt-status.c b/wt-status.c
index f369eba..a975d07 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -689,14 +689,14 @@ void wt_status_print(struct wt_status *s)
 				advice_status_hints
 				? _(" (use \"git add\" to track)") : "");
 		else if (s->is_initial)
-			printf("nothing to commit%s\n", advice_status_hints
-				? " (create/copy files and use \"git add\" to track)" : "");
+			printf(_("nothing to commit%s\n"), advice_status_hints
+				? _(" (create/copy files and use \"git add\" to track)") : "");
 		else if (!s->show_untracked_files)
-			printf("nothing to commit%s\n", advice_status_hints
-				? " (use -u to show untracked files)" : "");
+			printf(_("nothing to commit%s\n"), advice_status_hints
+				? _(" (use -u to show untracked files)") : "");
 		else
-			printf("nothing to commit%s\n", advice_status_hints
-				? " (working directory clean)" : "");
+			printf(_("nothing to commit%s\n"), advice_status_hints
+				? _(" (working directory clean)") : "");
 	}
 }
=20
--=20
1.7.2.3
