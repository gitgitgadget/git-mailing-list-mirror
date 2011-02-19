From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 36/72] gettextize: git-grep "--open-files-in-pager" message
Date: Sat, 19 Feb 2011 19:24:19 +0000
Message-ID: <1298143495-3681-37-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:28:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsTn-0003Eb-6L
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:28:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756082Ab1BST2D convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:28:03 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:60431 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755983Ab1BST15 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:27:57 -0500
Received: by mail-ew0-f46.google.com with SMTP id 5so1970440ewy.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=yZ7B279ryHwYcDKhFTCg5JQlT6p1ZM3ciIdwfVDArR4=;
        b=wrjAlLclTkcQf3E69tl57bYAEwrvsHApTDtFktwPX3PMd0fcyPLd36asmoJyQ/A/Sx
         j8GVj10de79m0dldK5/4FCpARcAeMyEDVRtpVDqk/W/ClJYGAJg+RqupSoCqH08/HkU0
         +ywhBHvtck1ahRkRMhN7Uu3mT5jQqQLMQTNKw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=BkvEM88cY1XTlGxfQQy+IYPi6CkGlIiON0N2ml9xCyTSxas6SB4FPg2Pk5sgDhF1XS
         wpxtgWhuQRocziyaGoj/uuS8tOOk2TDePb9dUFOid3tfUAqyAvN8UylNBTGAEpOxf5oq
         vp2dk9+9fxy8IVvarMPtK+B8F1oAjWTPFmfVU=
Received: by 10.213.96.203 with SMTP id i11mr190773ebn.66.1298143676171;
        Sat, 19 Feb 2011 11:27:56 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.27.55
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:27:55 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167343>

Gettextize the "--open-files-in-pager only works on the worktree"
message. A test in t7811-grep-open.sh explicitly checked for this
message. Change it to skip under GETTEXT_POISON=3DYesPlease.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/grep.c       |    2 +-
 t/t7811-grep-open.sh |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index d35b76c..dfc32fb 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1061,7 +1061,7 @@ int cmd_grep(int argc, const char **argv, const c=
har *prefix)
 	}
=20
 	if (show_in_pager && (cached || list.nr))
-		die("--open-files-in-pager only works on the worktree");
+		die(_("--open-files-in-pager only works on the worktree"));
=20
 	if (show_in_pager && opt.pattern_list && !opt.pattern_list->next) {
 		const char *pager =3D path_list.items[0].string;
diff --git a/t/t7811-grep-open.sh b/t/t7811-grep-open.sh
index 568a6f2..3aa544c 100755
--- a/t/t7811-grep-open.sh
+++ b/t/t7811-grep-open.sh
@@ -61,7 +61,7 @@ test_expect_success SIMPLEPAGER 'git grep -O' '
 	test_cmp empty out
 '
=20
-test_expect_success 'git grep -O --cached' '
+test_expect_success NO_GETTEXT_POISON 'git grep -O --cached' '
 	test_must_fail git grep --cached -O GREP_PATTERN >out 2>msg &&
 	grep open-files-in-pager msg
 '
--=20
1.7.2.3
