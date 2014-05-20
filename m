From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 05/19] contrib/examples/git-repack.sh: convert test -a/-o to && and ||
Date: Tue, 20 May 2014 06:50:18 -0700
Message-ID: <1400593832-6510-6-git-send-email-gitter.spiros@gmail.com>
References: <1400593832-6510-1-git-send-email-gitter.spiros@gmail.com>
Cc: jrnieder@gmail.com, Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 20 15:51:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmkSA-0000rx-HB
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 15:51:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753723AbaETNve (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 09:51:34 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:61049 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753545AbaETNuo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 09:50:44 -0400
Received: by mail-pa0-f53.google.com with SMTP id kp14so337323pab.40
        for <git@vger.kernel.org>; Tue, 20 May 2014 06:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R9KyoV8i+AkkmWB0n6I/FTTKKM71dZqBjquFP6XDQYc=;
        b=tuaB3kphot+m4srm634FITpRAqfUeY56nXoJTg/y4wd8M+5jSvRB4iwT41gYUwRaIv
         nzx2MsJ58nLAVQB3hgUyIDxxA24Si862P8m7pFv9NcLXEOVaVK13gW+SL3OL+j+2sVc4
         mZ2DEpC8aZ+YEsZNpX7Tit/1mzQgQiajWynMjMRoasqQb9FBrFnsK+p3kGjquG+aKpah
         fnDlaVva46lLGzgyQhUkPNxrEHJIu2NUJuMGcoTJd6ccl7y+4+i7lvPxA+yHEBHaPLst
         wAFTuTwQbGx9Un6A2Ac3bbQhVrdclW6A4gjsubxm61k4oUtHVc1dF2GsU/LJ0ijCEECe
         d0Tg==
X-Received: by 10.66.188.5 with SMTP id fw5mr50097532pac.63.1400593844209;
        Tue, 20 May 2014 06:50:44 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id oe4sm3317286pbb.33.2014.05.20.06.50.43
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 20 May 2014 06:50:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1400593832-6510-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249679>

The interaction with unary operators and operator precedence
for && and || are better known than -a and -o, and for that
reason we prefer them. Replace all existing instances
of -a and -o to save readers from the burden of thinking
about such things.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 contrib/examples/git-repack.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/examples/git-repack.sh b/contrib/examples/git-repack.sh
index f312405..96e3fed 100755
--- a/contrib/examples/git-repack.sh
+++ b/contrib/examples/git-repack.sh
@@ -76,8 +76,8 @@ case ",$all_into_one," in
 				existing="$existing $e"
 			fi
 		done
-		if test -n "$existing" -a -n "$unpack_unreachable" -a \
-			-n "$remove_redundant"
+		if test -n "$existing" && test -n "$unpack_unreachable" && \
+			test -n "$remove_redundant"
 		then
 			# This may have arbitrary user arguments, so we
 			# have to protect it against whitespace splitting
-- 
1.7.10.4
