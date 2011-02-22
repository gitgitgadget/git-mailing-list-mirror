From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 59/73] gettextize: git-status "renamed: " message
Date: Tue, 22 Feb 2011 23:42:18 +0000
Message-ID: <1298418152-27789-60-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:44:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1uM-0008HI-1a
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:44:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755576Ab1BVXod convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:44:33 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:39375 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755546Ab1BVXob (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:44:31 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3866600bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=ojKVCn80vnYKz/yXAs9dajz0ah9LhxY9VZIyFrgcI/Y=;
        b=GqpzV1VK+WcoevEOoWSfF5k23GbviaXcnCxzFjBkl/JUcrGUIr2GXN+hwPe0c/Okv5
         nubNNe9ufgX/6BtWbmcpkqVGGCRTJSRBrpEzTtEwMMY+pbEVWw3ONY/bl6qjPwqtX8kl
         JlHvA8TK5WcT4R+rL7t6Q8SKmHauc4BGq+PYA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=g6XPCrhSBFGf/vxC8c6ZbucSKukr+eIygcK1ES9alOhFJEFWs51K3fEX7dVYs7fLfQ
         b2SlDmO2bx2mj3aj9vhM8iPy3/dUiLqII+Cxx3Ibo7vCW64UUQ2TMOzPW2bwH8rnOYeL
         5tNK+WrOb3OYCdIJrrYPW0KThgorLfd/kJmQ8=
Received: by 10.204.22.10 with SMTP id l10mr1404654bkb.49.1298418270853;
        Tue, 22 Feb 2011 15:44:30 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.44.29
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:44:30 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167606>

Gettextize the "renamed: %s -> %s" message which appears as part of
git-status(1) output. Two tests in t4001-diff-rename.sh explicitly
checked for this message. Change them to skip under
GETTEXT_POISON=3DYesPlease.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t4001-diff-rename.sh |    4 ++--
 wt-status.c            |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
index 71bac83..cad8545 100755
--- a/t/t4001-diff-rename.sh
+++ b/t/t4001-diff-rename.sh
@@ -64,7 +64,7 @@ test_expect_success \
     'validate the output.' \
     'compare_diff_patch current expected'
=20
-test_expect_success 'favour same basenames over different ones' '
+test_expect_success C_LOCALE_OUTPUT 'favour same basenames over differ=
ent ones' '
 	cp path1 another-path &&
 	git add another-path &&
 	git commit -m 1 &&
@@ -73,7 +73,7 @@ test_expect_success 'favour same basenames over diffe=
rent ones' '
 	git mv another-path subdir/path1 &&
 	git status | grep "renamed: .*path1 -> subdir/path1"'
=20
-test_expect_success  'favour same basenames even with minor difference=
s' '
+test_expect_success C_LOCALE_OUTPUT  'favour same basenames even with =
minor differences' '
 	git show HEAD:path1 | sed "s/15/16/" > subdir/path1 &&
 	git status | grep "renamed: .*path1 -> subdir/path1"'
=20
diff --git a/wt-status.c b/wt-status.c
index ad6ef7a..ed6bedd 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -201,7 +201,7 @@ static void wt_status_print_change_data(struct wt_s=
tatus *s,
 		color_fprintf(s->fp, c, _("modified:   %s"), one);
 		break;
 	case DIFF_STATUS_RENAMED:
-		color_fprintf(s->fp, c, "renamed:    %s -> %s", one, two);
+		color_fprintf(s->fp, c, _("renamed:    %s -> %s"), one, two);
 		break;
 	case DIFF_STATUS_TYPE_CHANGED:
 		color_fprintf(s->fp, c, _("typechange: %s"), one);
--=20
1.7.2.3
