From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 07/48] i18n: git-am cannot_fallback messages
Date: Sun,  8 May 2011 12:20:39 +0000
Message-ID: <1304857280-14773-8-git-send-email-avarab@gmail.com>
References: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 14:22:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ302-0003rg-VY
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 14:22:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753451Ab1EHMVq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 08:21:46 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:37472 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753098Ab1EHMVh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 08:21:37 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1325598eyx.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 05:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=qpGfx4PLLOhYp4n+s0/pQiFlJncCnbJtEQvCH2YALPU=;
        b=hvW7SAGd0KMYe1T26zOC0X90LucxmYUD7D4hSX5CDrKgZGb0QDmdnE7Ey72h8zqL7Y
         aq5NjTLosIIm3uKluPXhHjEX7KH2mBScG3+3NgLG7/B8tgTeGWqTrGMZOOugsK5pDms6
         9tddL+nyrI24jkaxLp5BikamKG9yUVxb92zJY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=NpbzFCZqGp1POlPQzZrzq+YKR+l0WdOEEUjsPeqrphHAAfejmTY63eDUK/7Elr4Et3
         9N4Fltdaf4AfszFePeZyQw4w+cAD6gOuw0QkvBeR+oD+mtWAtbHxKGaqkn3AhDKKzY1h
         RamTMIgV0+qHpt2Qar9+j193YvnqBK8j5JO9E=
Received: by 10.14.17.70 with SMTP id i46mr2609533eei.116.1304857296880;
        Sun, 08 May 2011 05:21:36 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id n55sm2690046een.2.2011.05.08.05.21.35
        (version=SSLv3 cipher=OTHER);
        Sun, 08 May 2011 05:21:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173110>

Translate messages with gettext(1) before they're passed to the
cannot_fallback function, just like we handle the die function.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-am.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index cbd48a9..5c06eda 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -130,7 +130,7 @@ fall_back_3way () {
 	"$dotest/patch" &&
     GIT_INDEX_FILE=3D"$dotest/patch-merge-tmp-index" \
     git write-tree >"$dotest/patch-merge-base+" ||
-    cannot_fallback "Repository lacks necessary blobs to fall back on =
3-way merge."
+    cannot_fallback "$(gettext "Repository lacks necessary blobs to fa=
ll back on 3-way merge.")"
=20
     say Using index info to reconstruct a base tree...
     if GIT_INDEX_FILE=3D"$dotest/patch-merge-tmp-index" \
@@ -139,8 +139,8 @@ fall_back_3way () {
 	mv "$dotest/patch-merge-base+" "$dotest/patch-merge-base"
 	mv "$dotest/patch-merge-tmp-index" "$dotest/patch-merge-index"
     else
-        cannot_fallback "Did you hand edit your patch?
-It does not apply to blobs recorded in its index."
+        cannot_fallback "$(gettext "Did you hand edit your patch?
+It does not apply to blobs recorded in its index.")"
     fi
=20
     test -f "$dotest/patch-merge-index" &&
--=20
1.7.4.4
