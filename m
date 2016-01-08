From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 10/10] t/t9001-send-email.sh: get rid of unnecessary backquotes
Date: Fri,  8 Jan 2016 12:06:28 +0100
Message-ID: <1452251188-12939-11-git-send-email-gitter.spiros@gmail.com>
References: <1452251188-12939-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 08 12:07:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHUse-0002wj-KU
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 12:06:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754751AbcAHLGq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2016 06:06:46 -0500
Received: from mail-pa0-f68.google.com ([209.85.220.68]:32879 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673AbcAHLGm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2016 06:06:42 -0500
Received: by mail-pa0-f68.google.com with SMTP id pv5so22446786pac.0
        for <git@vger.kernel.org>; Fri, 08 Jan 2016 03:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Qoa65kGUo0m9sJvhA+ZSdjVJJvYKYhL73aj+fctt99E=;
        b=md9s3OcPtnwHVseAvQV2pfUt9JWwUscUAMW7II+PpqAYqDe077yZFO3tfwcKu1Q8AM
         r3QaKFZwix+CYsnNWxkc7PVdOiqiB6P5/+lW+GBgCvfyMp2iJJGLqFOSaQ6FeffKxsHx
         H6DXw4ZzSdZqs6uP1LRUkKuBFTG1/LeUB+o82//e6/r8R9eWIiTLm2mYIVnDvUo2BABn
         Tzm6NNi2vsJAL05fX07dhZaclUgetfZmMM2twxhBrZWZdEfM4sBdh9EzYrSJjVCZUiyG
         Vnof6eNico8H6dH1Rly7uU3hjnJmg+MLcfI4XBwMW4RmDzSqNruhwFeJjtN0ZAXzGzrx
         hUmA==
X-Received: by 10.66.237.35 with SMTP id uz3mr157770163pac.96.1452251201794;
        Fri, 08 Jan 2016 03:06:41 -0800 (PST)
Received: from ubuntu14.nephoscale.com (static-67.207.195.141.nephosdns.com. [67.207.195.141])
        by smtp.gmail.com with ESMTPSA id fi16sm93143771pac.12.2016.01.08.03.06.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Jan 2016 03:06:41 -0800 (PST)
X-Mailer: git-send-email 2.3.3.GIT
In-Reply-To: <1452251188-12939-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283543>

Instead of making the shell expand 00* and invoke 'echo' with it,
and then capturing its output as command substitution, just use
the result of expanding 00* directly.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 t/t9001-send-email.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 05949a1..bcbed38 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1488,7 +1488,7 @@ test_cover_addresses () {
 	clean_fake_sendmail &&
 	rm -fr outdir &&
 	git format-patch --cover-letter -2 -o outdir &&
-	cover=`echo outdir/0000-*.patch` &&
+	cover="outdir/0000-*.patch" &&
 	mv $cover cover-to-edit.patch &&
 	perl -pe "s/^From:/$header: extra\@address.com\nFrom:/" cover-to-edit.patch >"$cover" &&
 	git send-email \
-- 
2.3.3.GIT
