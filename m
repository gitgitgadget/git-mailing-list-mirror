From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 13/19] t/t4102-apply-rename.sh: convert test -a/-o to && and ||
Date: Tue, 20 May 2014 06:50:26 -0700
Message-ID: <1400593832-6510-14-git-send-email-gitter.spiros@gmail.com>
References: <1400593832-6510-1-git-send-email-gitter.spiros@gmail.com>
Cc: jrnieder@gmail.com, Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 20 15:51:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmkRz-0000e3-7T
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 15:51:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753623AbaETNuy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 09:50:54 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:55038 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753571AbaETNuw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 09:50:52 -0400
Received: by mail-pd0-f175.google.com with SMTP id z10so335971pdj.34
        for <git@vger.kernel.org>; Tue, 20 May 2014 06:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Kfmy372U9WvJdWD46ro7bxtmUNQSogeO9O2ojOs3L9I=;
        b=sdLsYmNMkBXic5c/ZM5zrFEIAeQuRRmynGDtZVkGVlgwNaSmQuQgDxdTEvNB48EGYS
         fFJPMX2uQ+58etvOuiRSxO+rSuUB2S1lKZpr+Eovo4d2nNPMSXrQjhhvPVqM4wVPV6oi
         AqsQNej0UK6kbopJS5Qp8aQ5zO9G/pLAdjYD2La4B4hPJno9UPlKtge6/n7qJh3+blhR
         pMJzdS7hnAiBS/N9EbRZxoeueE0EPnBkFAx5CH9MiRqWpFQwIWqNjU0jFm/tWCMmXqBm
         DkuKxhjxYBGI8/bN1sHJ0lCGMiZmkwUhECC6Gii1jZhLsN1I50q68jpF9bd46VLuNo/2
         A66A==
X-Received: by 10.67.13.226 with SMTP id fb2mr51012907pad.146.1400593851701;
        Tue, 20 May 2014 06:50:51 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id oe4sm3317286pbb.33.2014.05.20.06.50.50
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 20 May 2014 06:50:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1400593832-6510-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249675>

The interaction with unary operators and operator precedence
for && and || are better known than -a and -o, and for that
reason we prefer them. Replace all existing instances
of -a and -o to save readers from the burden of thinking
about such things.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 t/t4102-apply-rename.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4102-apply-rename.sh b/t/t4102-apply-rename.sh
index 49e2d6c..fae3059 100755
--- a/t/t4102-apply-rename.sh
+++ b/t/t4102-apply-rename.sh
@@ -52,6 +52,6 @@ EOF
 
 test_expect_success 'apply copy' \
     'git apply --index --stat --summary --apply test-patch &&
-     test "$(cat bar)" = "This is bar" -a "$(cat foo)" = "This is foo"'
+     test "$(cat bar)" = "This is bar" && test "$(cat foo)" = "This is foo"'
 
 test_done
-- 
1.7.10.4
