From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 26/48] i18n: git-submodule "[...] path is ignored" message
Date: Sun,  8 May 2011 12:20:58 +0000
Message-ID: <1304857280-14773-27-git-send-email-avarab@gmail.com>
References: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 14:23:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ31g-0004kb-Mj
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 14:23:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754199Ab1EHMXw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 08:23:52 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:58758 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753216Ab1EHMXt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 08:23:49 -0400
Received: by ewy4 with SMTP id 4so1327254ewy.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 05:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=ITDevt4BaVBnYWOFLr16QO+CebFBSTzE5HjMrFmFi28=;
        b=WRn+1NwtajFn3L5ysQkb9u8Vqx4xSoN0S7TDCa8nWH7MAsV1P0E9elYX8hNM/bG4Ek
         qkn2i/ooEb4ckrYyCAta4eiR9jRxc7Ad1k/5DOBWqfjTsSNIn4g/OxwARkKNYcfHd2ld
         jGGOEmjSwIeNs1aHeLnY26ZYlHazmaNFZx2Wg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=P1p8FVUxDavIJkvckSWdHMVezFHKcq+OI/vGRttlGbxC3sKrY16p8+C+W7PuLsrmTJ
         15EozjDt1QC9jbBwoo4AilypZm/Jwj7h7nsl0cIQA2cSWfCsOmDIvnLOu4Womam5n58Z
         /EHD51uJ4b2JhRqw+VSj+mLrhivEmrAYhXXaQ=
Received: by 10.213.102.147 with SMTP id g19mr1897541ebo.71.1304857317556;
        Sun, 08 May 2011 05:21:57 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id n55sm2690046een.2.2011.05.08.05.21.56
        (version=SSLv3 cipher=OTHER);
        Sun, 08 May 2011 05:21:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173152>

Gettextize the "The following path is ignored" message. This is
explicitly tested for so we need to skip a portion of a test with
test_i18ncmp.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-submodule.sh           |    6 +++---
 t/t7400-submodule-basic.sh |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index be63bc2..ca33125 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -223,9 +223,9 @@ cmd_add()
=20
 	if test -z "$force" && ! git add --dry-run --ignore-missing "$path" >=
 /dev/null 2>&1
 	then
-		echo >&2 "The following path is ignored by one of your .gitignore fi=
les:" &&
-		echo >&2 $path &&
-		echo >&2 "Use -f if you really want to add it."
+		echo >&2 "$(eval_gettext "The following path is ignored by one of yo=
ur .gitignore files:
+\$path
+Use -f if you really want to add it.")"
 		exit 1
 	fi
=20
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 874279e..ea3b445 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -99,7 +99,7 @@ test_expect_success 'submodule add to .gitignored pat=
h fails' '
 		git add --force .gitignore &&
 		git commit -m"Ignore everything" &&
 		! git submodule add "$submodurl" submod >actual 2>&1 &&
-		test_cmp expect actual
+		test_i18ncmp expect actual
 	)
 '
=20
--=20
1.7.4.4
