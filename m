From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 06/19] contrib/examples/git-resolve.sh: convert test -a/-o to && and ||
Date: Tue, 20 May 2014 06:50:19 -0700
Message-ID: <1400593832-6510-7-git-send-email-gitter.spiros@gmail.com>
References: <1400593832-6510-1-git-send-email-gitter.spiros@gmail.com>
Cc: jrnieder@gmail.com, Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 20 15:51:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmkRf-0000Bh-Ly
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 15:51:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753563AbaETNuq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 09:50:46 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:48341 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753546AbaETNup (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 09:50:45 -0400
Received: by mail-pb0-f42.google.com with SMTP id md12so342417pbc.15
        for <git@vger.kernel.org>; Tue, 20 May 2014 06:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ANQJSUVhk8bumyCjk3cBO3PDRzLgyPdcDaWJf0sgQ40=;
        b=l0r2NZx0l444wInDsgzUx6p+8x8IFUNeL5L7y6hfmoW9DfDKgtHHuR6EutswUh5eTE
         QZnaKU5Kt6nbeD3cCMOmb4EUh4g7IcVNQUW1WGCoAPflK+sw7cc6PuWyuDynVObfFmP1
         2u9IDet/bu21JZRcgDr5BCnm497l7TQyPKInc32C15HRCblUzoFClqSU2TCvQ/uIkYio
         USWkUgIgN64bvnbSv5Dszgt4qzVlc1FW/rJWcFvNKGhwqMqu3+JsegqAlSXIwiBXfnjL
         CenFUeaW9eN4JOU/XvMwh701P7OFk2V8rP3S/qaDICrI66ByQhnOqI893w/gMmtvKCAi
         /W1g==
X-Received: by 10.68.143.231 with SMTP id sh7mr50311253pbb.7.1400593845186;
        Tue, 20 May 2014 06:50:45 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id oe4sm3317286pbb.33.2014.05.20.06.50.44
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 20 May 2014 06:50:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1400593832-6510-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249665>

The interaction with unary operators and operator precedence
for && and || are better known than -a and -o, and for that
reason we prefer them. Replace all existing instances
of -a and -o to save readers from the burden of thinking
about such things.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 contrib/examples/git-resolve.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/examples/git-resolve.sh b/contrib/examples/git-resolve.sh
index 48d0fc9..70fdc27 100755
--- a/contrib/examples/git-resolve.sh
+++ b/contrib/examples/git-resolve.sh
@@ -76,7 +76,7 @@ case "$common" in
 			2>/dev/null || continue
 		# Count the paths that are unmerged.
 		cnt=$(GIT_INDEX_FILE=$G git ls-files --unmerged | wc -l)
-		if test $best_cnt -le 0 -o $cnt -le $best_cnt
+		if test $best_cnt -le 0 || test $cnt -le $best_cnt
 		then
 			best=$c
 			best_cnt=$cnt
-- 
1.7.10.4
