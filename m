From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 39/73] gettextize: git-log "--OPT does not make sense" messages
Date: Tue, 22 Feb 2011 23:41:58 +0000
Message-ID: <1298418152-27789-40-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:44:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1uJ-0008HI-Qd
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:44:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755529Ab1BVXoU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:44:20 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:51284 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755228Ab1BVXoL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:44:11 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3867040bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=V7MK0yGiSZvWNbjfS0uBFPV8UOPmH1GVf7rf3tccnQE=;
        b=v9siiDD2GdPWx2y/gTBL8pA9/eOHurP4f1FdCx3zM/5zB+ebZOBXCCyoCw97hG/xG3
         z8GoALcKhjVsSoQRhtqBrs7J98DpESldSMIhRgSMz+VWgHMgX3istP2/xq+EXQBnQ7jM
         IAvpaZjFKwkA1bcHoS4GAo+JKQvtSjf77ZHUw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=qTW9XizVuwiWPvVTagv9v+he0XK80EczhCLWC+oYQU/G9zmf67WZgC8W90vJSNDsrI
         0UO6/WGxZGMR8DjNSu7rOZUg62XWCDGfi3NHfyMLRtmRfKS0GA70hD1ls/pc0EoO96gY
         8vvrcKa5TKFtKpH2zycR+F9SUIbeNWUFjAdS8=
Received: by 10.204.117.77 with SMTP id p13mr3070258bkq.19.1298418250479;
        Tue, 22 Feb 2011 15:44:10 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.44.09
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:44:10 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167602>

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
index 027c13d..a46d888 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -614,7 +614,7 @@ echo "fatal: --name-only does not make sense" > exp=
ect.name-only
 echo "fatal: --name-status does not make sense" > expect.name-status
 echo "fatal: --check does not make sense" > expect.check
=20
-test_expect_success 'options no longer allowed for format-patch' '
+test_expect_success C_LOCALE_OUTPUT 'options no longer allowed for for=
mat-patch' '
 	test_must_fail git format-patch --name-only 2> output &&
 	test_cmp expect.name-only output &&
 	test_must_fail git format-patch --name-status 2> output &&
--=20
1.7.2.3
