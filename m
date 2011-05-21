From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 07/48] i18n: git-am cannot_fallback messages
Date: Sat, 21 May 2011 18:43:48 +0000
Message-ID: <1306003469-22939-8-git-send-email-avarab@gmail.com>
References: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 20:45:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNrB6-0000JJ-4M
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 20:45:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756219Ab1EUSpQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2011 14:45:16 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:50211 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752916Ab1EUSpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 14:45:09 -0400
Received: by ewy4 with SMTP id 4so1451108ewy.19
        for <git@vger.kernel.org>; Sat, 21 May 2011 11:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=gSvF85l/5gQuP2TvSL+g9+yzHxvjJIWE6LQlVZamUcc=;
        b=iyzeDaPVOCHI8DGMg0d5+AeR93vRjB25OwLW53TUay/W3/441F6bW4yzwZ2r3XPlsP
         jI77PZOmepZ+zX/1fEA5lA1nYKZGNt9yyXSfRGKNHWNV9lYTNDGvW0zqTUcIe3kCRN5X
         KhND6wNcoxysYDZLVXu+7on6KSxB71wX9oh1g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=AMeL5kdzXSAOW4JWCheweoEDINlkpb60HyQe7Wjw78Ys6L4IjexgN2YNvGJVRZyth8
         tVWOgE8bHpiCtqQ+x/nOxJS7CJCQmlHIu8thcBr15KUHRiQsTP7/MINmDP3MgK7doFey
         eZB8BJGp5HS0MX0OcLLp6qHebF7gWeKEp5fKI=
Received: by 10.14.29.69 with SMTP id h45mr262207eea.158.1306003508487;
        Sat, 21 May 2011 11:45:08 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id y14sm1130434eeh.3.2011.05.21.11.45.07
        (version=SSLv3 cipher=OTHER);
        Sat, 21 May 2011 11:45:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174122>

Translate messages with gettext(1) before they're passed to the
cannot_fallback function, just like we handle the die function.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-am.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index b9ec69e..ac2d202 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -133,7 +133,7 @@ fall_back_3way () {
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
@@ -142,8 +142,8 @@ fall_back_3way () {
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
1.7.5.1
