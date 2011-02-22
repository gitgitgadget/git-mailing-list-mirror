From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 55/73] gettextize: git-status "nothing to commit" messages
Date: Tue, 22 Feb 2011 23:42:14 +0000
Message-ID: <1298418152-27789-56-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:46:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1w5-0000rs-GY
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:46:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755698Ab1BVXpm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:45:42 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:39375 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755443Ab1BVXo1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:44:27 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3866600bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=n4tVeJco3g5EOnP8oTBCIl/q3vr2nsqgg2MXoDGVfoY=;
        b=AEQsOO8+2teNnRPpAIy9j2n7xFv2L4JFNb1pKwEghuBp9IXniiLnDQ6KTghJXNb/PG
         2OmjjOMN66VBy+5SwtmlYzuAJXdJQJXtkpQ4dNW60+PNya7BdB7KUKyBL2IgcQ1uQaWP
         ffGCd9aknBdFMcHrC4ZmhXH08y3/foyvZ+ygs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=hEdYHSGSM6BGMX114malNuUQ9fQkkpyqjV5t5tEXiD8bFIOF95j3VodjOjXlmGX7ZT
         iYAmtcbmwA+ra8LkJC4TJyVx7ViopJSMu5YlX+LVwCVyjs8B5N9wRU7P3neoQ4JzzbUp
         r4KrSoJrlg3i8LeG7bRJBJFoxzAhli5aqMLDs=
Received: by 10.204.12.84 with SMTP id w20mr3052587bkw.43.1298418266917;
        Tue, 22 Feb 2011 15:44:26 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.44.26
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:44:26 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167635>

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
index fa473a0..c567332 100755
--- a/t/t7506-status-submodule.sh
+++ b/t/t7506-status-submodule.sh
@@ -20,12 +20,12 @@ test_expect_success 'setup' '
 	git commit -m "Add submodule sub"
 '
=20
-test_expect_success 'status clean' '
+test_expect_success C_LOCALE_OUTPUT 'status clean' '
 	git status >output &&
 	grep "nothing to commit" output
 '
=20
-test_expect_success 'commit --dry-run -a clean' '
+test_expect_success C_LOCALE_OUTPUT 'commit --dry-run -a clean' '
 	test_must_fail git commit --dry-run -a >output &&
 	grep "nothing to commit" output
 '
@@ -177,12 +177,12 @@ test_expect_success 'rm submodule contents' '
 	rm -rf sub/* sub/.git
 '
=20
-test_expect_success 'status clean (empty submodule dir)' '
+test_expect_success C_LOCALE_OUTPUT 'status clean (empty submodule dir=
)' '
 	git status >output &&
 	grep "nothing to commit" output
 '
=20
-test_expect_success 'status -a clean (empty submodule dir)' '
+test_expect_success C_LOCALE_OUTPUT 'status -a clean (empty submodule =
dir)' '
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
