From: =?UTF-8?q?Ville=20Skytt=C3=A4?= <ville.skytta@iki.fi>
Subject: [PATCH] completion: complete --move for git branch
Date: Mon,  6 Jun 2016 16:16:11 +0300
Message-ID: <1465218971-14118-1-git-send-email-ville.skytta@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 15:16:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9uOF-0005Et-Tu
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 15:16:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbcFFNQQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jun 2016 09:16:16 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34086 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203AbcFFNQP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 09:16:15 -0400
Received: by mail-lf0-f65.google.com with SMTP id k192so4943657lfb.1
        for <git@vger.kernel.org>; Mon, 06 Jun 2016 06:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FFEWctGiUx3Wdjeaz1QhjTAxxyiKOaLxqYYjrVIyOrI=;
        b=lNPIbRGXhQ2fPYW9Q5i6zobHL80XCd2kzPN/0IkLcjZpecjGIn48NsMD9AMfPC/bjW
         is0xTCuTzTyXbRBpMZvfugWzqqplid+vaSzsaUh88IdvBdAmCX2OUHr0I2Z94YPiBOcG
         Td0VYALJ9Wh4Z4AmqHMHZYDPuFav/zN0C0MzIISDp7a2OmgxeNRnxv2ZomtNYqXB+8mD
         5ST1iYQl1CFUDzA8fAWzLbGlf/e0/wihf2/EmP9AAxj5O7lKX6dwwg4uq5scCgKbxasP
         SvcL0K9BRXITOKPXS4DrdZqZz04dSW/BBGn2CpJ90FRyyXJXpJYIKupXz5Yfp4n4HkWd
         UXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=FFEWctGiUx3Wdjeaz1QhjTAxxyiKOaLxqYYjrVIyOrI=;
        b=Mqas9CQPoX1Skep4kBEHRx3A4w7O6f+oio7bMTbjhAjWpkQVYqB/5vnUuEG8ArsHNY
         Kl4D3fJXWAnzjkOk73oLgsq2dFujcRKszu4CM7iKV1/haL/vQ35SBWp9Qfj/zizCOfVB
         fRUQ38iKLEELt5ntnxXZJNSiEzUyFfHJFGiI+rxZ92WS5e0W+sKYXIahsUo8imq87H92
         OCVKcmxJZTT7l6AjTy+aRVuNxER5ZoGnEaORDmVfl4P5xIyDQIDE/ktbyGyoFos83Yb1
         oRWxYE3Rodne0p3DDRxznFdbmKgA835Yvb8CG6YiZ71V+YJi7Zp6xflGBz50MbTYE8S9
         o9oA==
X-Gm-Message-State: ALyK8tJ/ge0fyJEyPZmDZLT9okLdh3PBhSuUSk+UT6CcEwMZagNUfEE1ouY6JvhlPKIlRg==
X-Received: by 10.25.168.9 with SMTP id r9mr1096834lfe.18.1465218973329;
        Mon, 06 Jun 2016 06:16:13 -0700 (PDT)
Received: from viper.dy.fi (dtpyyyyyyyyyyyyyb45ky-3.rev.dnainternet.fi. [2001:14ba:8300::1:c650])
        by smtp.gmail.com with ESMTPSA id 1sm1800886ljf.5.2016.06.06.06.16.12
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jun 2016 06:16:12 -0700 (PDT)
X-Mailer: git-send-email 2.5.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296504>

Signed-off-by: Ville Skytt=C3=A4 <ville.skytta@iki.fi>
---
 contrib/completion/git-completion.bash | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 3402475..6918cc8 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -964,8 +964,8 @@ _git_branch ()
 	while [ $c -lt $cword ]; do
 		i=3D"${words[c]}"
 		case "$i" in
-		-d|-m)	only_local_ref=3D"y" ;;
-		-r)	has_r=3D"y" ;;
+		-d|-m|--move)	only_local_ref=3D"y" ;;
+		-r)		has_r=3D"y" ;;
 		esac
 		((c++))
 	done
@@ -979,7 +979,7 @@ _git_branch ()
 			--color --no-color --verbose --abbrev=3D --no-abbrev
 			--track --no-track --contains --merged --no-merged
 			--set-upstream-to=3D --edit-description --list
-			--unset-upstream
+			--unset-upstream --move
 			"
 		;;
 	*)
--=20
2.5.5
