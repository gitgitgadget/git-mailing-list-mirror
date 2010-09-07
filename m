From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 16/20] gettextize: git-am cannot_fallback messages
Date: Tue,  7 Sep 2010 16:48:30 +0000
Message-ID: <1283878113-19533-7-git-send-email-avarab@gmail.com>
References: <1283877955-19105-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 07 18:51:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ot1OB-0004K7-Vy
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 18:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217Ab0IGQt5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Sep 2010 12:49:57 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:65530 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932081Ab0IGQty (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 12:49:54 -0400
Received: by mail-wy0-f174.google.com with SMTP id 22so4443062wyf.19
        for <git@vger.kernel.org>; Tue, 07 Sep 2010 09:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=35XvMOEkg6upOE5YduGA+mytJQD2WWhrjWZXy9KpJ3Y=;
        b=Eax+nvCUwV1wZ3aKsf2GFpSeC2I5FdMCLgq17dxy07ZSwQkxrcdc61KBokayvcuKJc
         ilcxq2G+xn7tXYeMKGDwEYV+Yu/ZTeoQgTqZ9KNSshD0ZmOkh9Akc0C7r0wCKqh+sS+4
         fLR64sc7qqgiKIOoPE7pEmuKjIvZnZJzHw9Gc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ml9eaHsNKxohW30SUVKK5s/MSmT2pNU147XaexBQhqAYZOjqke2vNMKvmtYWGDx4Wc
         rZnuyCKkL4S577u5Eiddz7gXEwD7TcVas7jiJEBhmAft49DJqdo0JYBq/tXNSX3HE/+T
         R+5HkODKtKdffBIMZPAhys8eAydUnPdSBExDo=
Received: by 10.227.155.193 with SMTP id t1mr131596wbw.40.1283878193413;
        Tue, 07 Sep 2010 09:49:53 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id k46sm4304936weq.34.2010.09.07.09.49.49
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 07 Sep 2010 09:49:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
In-Reply-To: <1283877955-19105-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155725>

Translate messages with gettext(1) before they're passed to the
cannot_fallback function, just like we handle the die function.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-am.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 4bee325..8e894e5 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -108,7 +108,7 @@ fall_back_3way () {
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
@@ -117,8 +117,8 @@ fall_back_3way () {
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
1.7.2.3.313.gcd15
