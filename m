From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 11/72] gettextize: git-add "pathspec [...] did not match" message
Date: Sat, 19 Feb 2011 19:23:54 +0000
Message-ID: <1298143495-3681-12-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:27:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsSj-0002hp-Lq
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:27:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755776Ab1BST1W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:27:22 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:40522 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755664Ab1BST1V (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:27:21 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so2347071eye.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=C23SO5nQHARVQDXv1mLplmJCN1YTHZihpql6TMgttVY=;
        b=O3h/TVzYHOIh7WLa+V7Icst3kTc2NHc3AkviwWmZqqjzZKJ8lhM9YjUMvLAb8V3p+x
         28UuocsqiAkavQGj8o9mW7omcoBcYFbSzsn8L+rSZXFaOkHPoagrpH+qMrHRsF3Ldhiz
         5JX/HFbnudzlT71SslQmQ9azMvNMwvrEJh+7c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=IV4X/474dh3PpXDWNFQuonkTe16L/E2GxEkzLE1G4sFWk/m1MAgEXtvqlPc49514J+
         DIr0hGsRMF1+expjY5GNE/nIklph8kmPz16SYfncPAYMdN0ZNG6qcI01R/Rx2qNbMZjk
         5N3yFq+TAS4A/MC3ShcUwvH176Wr4fIYeXZo4=
Received: by 10.213.35.147 with SMTP id p19mr2573344ebd.19.1298143640524;
        Sat, 19 Feb 2011 11:27:20 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.27.19
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:27:19 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167317>

Gettextize the "pathspec '%s' did not match any files" message. A test
in t3700-add.sh explicitly checked for this message. Change it to skip
under GETTEXT_POISON=3DYesPlease.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/add.c  |    2 +-
 t/t3700-add.sh |    6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index fe4ac49..b3640c5 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -451,7 +451,7 @@ int cmd_add(int argc, const char **argv, const char=
 *prefix)
 					if (excluded(&dir, pathspec[i], &dtype))
 						dir_add_ignored(&dir, pathspec[i], strlen(pathspec[i]));
 				} else
-					die("pathspec '%s' did not match any files",
+					die(_("pathspec '%s' did not match any files"),
 					    pathspec[i]);
 			}
 		}
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index d4fc563..9507191 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -269,7 +269,11 @@ test_expect_success 'git add --dry-run of existing=
 changed file' "
 test_expect_success 'git add --dry-run of non-existing file' "
 	echo ignored-file >>.gitignore &&
 	test_must_fail git add --dry-run track-this ignored-file >actual 2>&1=
 &&
-	echo \"fatal: pathspec 'ignored-file' did not match any files\" | tes=
t_cmp - actual
+	echo \"fatal: pathspec 'ignored-file' did not match any files\" >expe=
ct
+"
+
+test_expect_success NO_GETTEXT_POISON 'git add --dry-run of an existin=
g file output' "
+	test_cmp expect actual
 "
=20
 cat >expect.err <<\EOF
--=20
1.7.2.3
