From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv3 2/3] t0022: replace non-portable literal CR
Date: Mon, 25 Jan 2010 16:33:58 -0800
Message-ID: <1264466039-22431-3-git-send-email-bebarino@gmail.com>
References: <1264466039-22431-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Eric Blake <ebb9@byu.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 26 01:34:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZZOA-0003ys-4H
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 01:34:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751866Ab0AZAeO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 19:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751514Ab0AZAeO
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 19:34:14 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:60933 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104Ab0AZAeJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 19:34:09 -0500
Received: by ywh6 with SMTP id 6so3634047ywh.4
        for <git@vger.kernel.org>; Mon, 25 Jan 2010 16:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=md/pwA+QDyity2D5HRP/XqwYm3zAeQqorzAkIFxns+Y=;
        b=iAnCfF3nAL1UQoCzwAu5Km5aXl+Jb68eGFRSh16/3t+1QCqTS2V88iHFGigsTOC5Dt
         x7UAMHgoFMwOWCZ6b34S4dpgAFPFWL2pCQysFtQflPMEUI9UjmAgitxwo/hr6K7vI9Ss
         gNEMmdkFlMggpikWmv57j7V2+f9qZDGdM6vv8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=AkYRz2nbsszljQM7D0M6XL9/R4WwIbVs4/M2EZdxYj15RIY4Oat490C8YX4lYy/+fK
         sJ4B6S+MiwnJWw7W2DJ0mXJvwiZHXMu2Cmiz+he98KaMrNJi5os6Jo/H/+Q0i5/t0eaY
         gfi3b27IoqnM44KETcH36/0k+3+/GKrfAqKJY=
Received: by 10.151.29.2 with SMTP id g2mr9486333ybj.261.1264466048386;
        Mon, 25 Jan 2010 16:34:08 -0800 (PST)
Received: from localhost (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 6sm1846219yxg.30.2010.01.25.16.34.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 Jan 2010 16:34:07 -0800 (PST)
X-Mailer: git-send-email 1.7.0.rc0
In-Reply-To: <1264466039-22431-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138013>

We shouldn't have literal CR's in tests as they aren't portable.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

Hopefully this isn't botched over the wire.

 t/t0022-crlf-rename.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t0022-crlf-rename.sh b/t/t0022-crlf-rename.sh
index f1e1d48..7af3fbc 100755
--- a/t/t0022-crlf-rename.sh
+++ b/t/t0022-crlf-rename.sh
@@ -12,7 +12,7 @@ test_expect_success setup '
 	test_tick &&
 	git commit -m Initial &&
 
-	sed -e "s/\$/
/" "$TEST_DIRECTORY"/t0022-crlf-rename.sh >elpmas &&
+	append_cr <"$TEST_DIRECTORY"/t0022-crlf-rename.sh >elpmas &&
 	git add elpmas &&
 	rm -f sample &&
 
-- 
1.7.0.rc0
