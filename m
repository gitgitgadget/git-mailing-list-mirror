From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 2/2] t/t7508-status.sh: use test_i18ncmp
Date: Sat,  5 Nov 2011 17:28:43 +0000
Message-ID: <1320514123-18842-3-git-send-email-avarab@gmail.com>
References: <1320514123-18842-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jon Seymour <jon.seymour@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 05 18:29:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMk3L-00066P-29
	for gcvg-git-2@lo.gmane.org; Sat, 05 Nov 2011 18:29:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753951Ab1KER3D convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Nov 2011 13:29:03 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55354 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753895Ab1KER3C (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2011 13:29:02 -0400
Received: by mail-fx0-f46.google.com with SMTP id o14so3682311faa.19
        for <git@vger.kernel.org>; Sat, 05 Nov 2011 10:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=gKci7T5UUPTtopGF9QYnwNnn9jcb59uqJ28VuDMz090=;
        b=axmXSczuQIjKNAxDI9NMoAmCx2pc+OgZQp4zxZ14fxhj8Le9ixHOXPcP0Oz6J9jzuY
         n7KUa+nDnALX33kOgTd2SPu9MORUPgA1Q1L4CH6tWQ+5Oicw5SJ1mp4BEylfOiqfcdrA
         AFs0zdSVP0of1ID5y3VjtE7Zm/ezUU36bbPJ0=
Received: by 10.223.6.15 with SMTP id 15mr33228580fax.4.1320514141198;
        Sat, 05 Nov 2011 10:29:01 -0700 (PDT)
Received: from w.nix.is (w.nix.is. [188.40.98.140])
        by mx.google.com with ESMTPS id w11sm22575710fad.7.2011.11.05.10.29.00
        (version=SSLv3 cipher=OTHER);
        Sat, 05 Nov 2011 10:29:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1320514123-18842-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184867>

Change a i18n-specific comparison in t/t7508-status.sh to use
test_i18ncmp instead. This was introduced in v1.7.6.3~11^2 and has
been broken under GETTEXT_POISON=3DYesPlease since.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t7508-status.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 905255a..fc57b13 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -189,7 +189,7 @@ test_expect_success 'status with gitignore' '
 	#	untracked
 	EOF
 	git status --ignored >output &&
-	test_cmp expect output
+	test_i18ncmp expect output
 '
=20
 test_expect_success 'status with gitignore (nothing untracked)' '
@@ -247,7 +247,7 @@ test_expect_success 'status with gitignore (nothing=
 untracked)' '
 	#	untracked
 	EOF
 	git status --ignored >output &&
-	test_cmp expect output
+	test_i18ncmp expect output
 '
=20
 rm -f .gitignore
--=20
1.7.7
