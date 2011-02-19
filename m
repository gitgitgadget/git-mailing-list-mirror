From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 58/72] gettextize: git-status "renamed: " message
Date: Sat, 19 Feb 2011 19:24:41 +0000
Message-ID: <1298143495-3681-59-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:29:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsUa-0003dU-5C
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:29:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756340Ab1BST3P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:29:15 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:56673 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756157Ab1BST2P (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:28:15 -0500
Received: by mail-ew0-f46.google.com with SMTP id 5so1970368ewy.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=yfAwdEwovh3isajYQzdKKa1zJlLr5X//VVE20SeaFD4=;
        b=G5UEm0urr+CA3r7vnx9KfmDWr4l3LdtTsjp7M1S+Wf9xspO8YoSvaqcRd9uqjka+cx
         DirfKZp9GVTLT/GAz5orwhzqaRJvS17rUjmtAG+95u+OGPhGkVgkjbFCh+0NCayYiTS0
         5xjUDW/C1BAkAt84OopzWimndUsz12XT+vrEk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=HgShJnqKmzMa4n89/KT+mDYKny4yIoZOT8WijVoR9xQG63sVbheAQyKKVvoQgw1IGq
         yMZL2g3HTqkg6Y5gBUnenCFC5vmhHM++YmThsYeE0XZHUks3JM1lEaxm+6E7Eki7YHzz
         vRLcaydeOaHB6Sdkn8gJbUU65zgt1+sKbYXIg=
Received: by 10.14.53.65 with SMTP id f41mr2413512eec.41.1298143695183;
        Sat, 19 Feb 2011 11:28:15 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.28.14
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:28:14 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167353>

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
index 71bac83..d42c077 100755
--- a/t/t4001-diff-rename.sh
+++ b/t/t4001-diff-rename.sh
@@ -64,7 +64,7 @@ test_expect_success \
     'validate the output.' \
     'compare_diff_patch current expected'
=20
-test_expect_success 'favour same basenames over different ones' '
+test_expect_success NO_GETTEXT_POISON 'favour same basenames over diff=
erent ones' '
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
+test_expect_success NO_GETTEXT_POISON  'favour same basenames even wit=
h minor differences' '
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
