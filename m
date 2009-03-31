From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 3/4] send-email: correct two tests which were going interactive
Date: Tue, 31 Mar 2009 12:22:13 -0400
Message-ID: <232681e20e15a61defb73a1645fd2c6b6aadd751.1238516122.git.jaysoffian@gmail.com>
References: <cover.1238516122.git.jaysoffian@gmail.com>
 <e439cc23328dc25d153baed21f6ad7d90106eb03.1238516122.git.jaysoffian@gmail.com>
 <77c8a8123cb66821775b03fa0f3d2744de82b79b.1238516122.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?q?Bj=C3=B6rn=20Steinbrink?= <B.Steinbrink@gmx.de>,
	=?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= <Uwe.Kleine-Koenig@digi.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 31 18:25:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Loglf-0007sD-WB
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 18:24:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761068AbZCaQXJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Mar 2009 12:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760694AbZCaQXH
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 12:23:07 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:35585 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760547AbZCaQXE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 12:23:04 -0400
Received: by mail-qy0-f118.google.com with SMTP id 16so4637386qyk.33
        for <git@vger.kernel.org>; Tue, 31 Mar 2009 09:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ECJJ7bpNvOUm6SKBklOm+8DWCz+yzEFP7L3/mnWgK5M=;
        b=BE0PmxRMoLN7E5pDW2ZI5Dqg1JDq5HZCy10y1JNngMIgd8/KJIjL4Dy+wUaykpZ82I
         RsQUgurfkfCHIS9ujlYq8davdO0ZXxnwivL0HVOZdJRZoare6V98hV5WI25bBUKismwP
         ZQBYlQZU4LOMlEaQK1zMpakin4mmXVy/ue+Kw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=TyyZa3o2IOxH19RdTEQSq54pBoynh1SlpM5JlAOhEdmY0tEzPpO2YpODgda65TFpYj
         1vBVpLo3l+1+nEvP4ur+ie0uBtkpL7f5if6X53jPNUQQAWQNb/kK+5z1bXCp2FeQLiVL
         +CHPrh/e7vQ4VgtcK51K0vmI6FdrkUVy1JFy0=
Received: by 10.224.67.7 with SMTP id p7mr8388046qai.267.1238516582526;
        Tue, 31 Mar 2009 09:23:02 -0700 (PDT)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id 2sm7432691qwi.23.2009.03.31.09.23.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 31 Mar 2009 09:23:02 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.427.g15408
In-Reply-To: <77c8a8123cb66821775b03fa0f3d2744de82b79b.1238516122.git.jaysoffian@gmail.com>
In-Reply-To: <cover.1238516122.git.jaysoffian@gmail.com>
References: <cover.1238516122.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115280>

Commit 67f1fe5 added two tests which went interactive under the
dash shell. This commit corrects the issue. Reported by
Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de>

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 t/t9001-send-email.sh |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 195ff8b..84238f7 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -478,7 +478,8 @@ test_expect_success 'confirm detects EOF (inform as=
sumes y)' '
 test_expect_success 'confirm detects EOF (auto causes failure)' '
 	CONFIRM=3D$(git config --get sendemail.confirm) &&
 	git config sendemail.confirm auto &&
-	GIT_SEND_EMAIL_NOTTY=3D1 \
+	GIT_SEND_EMAIL_NOTTY=3D1 &&
+	export GIT_SEND_EMAIL_NOTTY &&
 		test_must_fail git send-email \
 			--from=3D"Example <nobody@example.com>" \
 			--to=3Dnobody@example.com \
@@ -492,8 +493,9 @@ test_expect_success 'confirm detects EOF (auto caus=
es failure)' '
 test_expect_success 'confirm doesnt loop forever' '
 	CONFIRM=3D$(git config --get sendemail.confirm) &&
 	git config sendemail.confirm auto &&
-	yes "bogus" | GIT_SEND_EMAIL_NOTTY=3D1 \
-		test_must_fail git send-email \
+	GIT_SEND_EMAIL_NOTTY=3D1 &&
+	export GIT_SEND_EMAIL_NOTTY &&
+		yes "bogus" | test_must_fail git send-email \
 			--from=3D"Example <nobody@example.com>" \
 			--to=3Dnobody@example.com \
 			--smtp-server=3D"$(pwd)/fake.sendmail" \
--=20
1.6.2.1.427.g15408
