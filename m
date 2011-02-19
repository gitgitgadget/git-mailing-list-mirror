From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 38/72] gettextize: git-log "--OPT does not make sense" messages
Date: Sat, 19 Feb 2011 19:24:21 +0000
Message-ID: <1298143495-3681-39-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:30:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsVM-00042j-Sh
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:30:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756406Ab1BSTaD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:30:03 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:40522 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755503Ab1BST16 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:27:58 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so2347071eye.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=nd4kmbluvD+lmdds+GlKtOMt341qSckQmsQI5Z46y1s=;
        b=wjmu3FEANueV4n/HBfYll2dE8fCi52soxDOQCeRRS5+wXsgbzGfga2knSV76k3VBdp
         o5cyIl25/gr2rddhfrFdPtNCoYloaMNZyNP9/FFqWqID5PObYe6i0y5W5cL3zu8ca0QR
         xVV88HAam5J+U3/9HxFNsJxVKcSSuu0oXRb9k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=x1k7mNT0MXgEG/hqEff41AZbrmx6tdc7fccC/4GhwcFLhxcBNH+W8xtRvgCg4FjHST
         jH7wU5cirqNdTgDzoOZph9ZoBU+cLzIYnVy6kfSqFiYLq+Olj0RS8Q2Y4Ny7kiQZUijU
         UtJ3pN1TlWEY4m0Mvan4+u8Ku5A+4gAi2AGPU=
Received: by 10.213.9.14 with SMTP id j14mr2226764ebj.71.1298143678261;
        Sat, 19 Feb 2011 11:27:58 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.27.57
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:27:57 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167371>

Gettextize the "--name-only/--name-status/--check does not make sense"
messages. A test in t4014-format-patch.sh explicitly checked for these
messages. Change them to skip under GETTEXT_POISON=3DYesPlease.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/log.c           |    6 +++---
 t/t4014-format-patch.sh |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index b36a01e..853f5d0 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1136,11 +1136,11 @@ int cmd_format_patch(int argc, const char **arg=
v, const char *prefix)
 		die (_("unrecognized argument: %s"), argv[1]);
=20
 	if (rev.diffopt.output_format & DIFF_FORMAT_NAME)
-		die("--name-only does not make sense");
+		die(_("--name-only does not make sense"));
 	if (rev.diffopt.output_format & DIFF_FORMAT_NAME_STATUS)
-		die("--name-status does not make sense");
+		die(_("--name-status does not make sense"));
 	if (rev.diffopt.output_format & DIFF_FORMAT_CHECKDIFF)
-		die("--check does not make sense");
+		die(_("--check does not make sense"));
=20
 	if (!use_patch_format &&
 		(!rev.diffopt.output_format ||
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 027c13d..3b182f5 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -614,7 +614,7 @@ echo "fatal: --name-only does not make sense" > exp=
ect.name-only
 echo "fatal: --name-status does not make sense" > expect.name-status
 echo "fatal: --check does not make sense" > expect.check
=20
-test_expect_success 'options no longer allowed for format-patch' '
+test_expect_success NO_GETTEXT_POISON 'options no longer allowed for f=
ormat-patch' '
 	test_must_fail git format-patch --name-only 2> output &&
 	test_cmp expect.name-only output &&
 	test_must_fail git format-patch --name-status 2> output &&
--=20
1.7.2.3
