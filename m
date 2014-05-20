From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 17/19] t/t5538-push-shallow.sh: convert test -a/-o to && and ||
Date: Tue, 20 May 2014 06:50:30 -0700
Message-ID: <1400593832-6510-18-git-send-email-gitter.spiros@gmail.com>
References: <1400593832-6510-1-git-send-email-gitter.spiros@gmail.com>
Cc: jrnieder@gmail.com, Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 20 15:51:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmkRi-0000Bh-GZ
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 15:51:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753646AbaETNu5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 09:50:57 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:44867 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753610AbaETNu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 09:50:56 -0400
Received: by mail-pb0-f53.google.com with SMTP id md12so343300pbc.12
        for <git@vger.kernel.org>; Tue, 20 May 2014 06:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cAMHDUQXI44/0+yknu7zJ1hKEuuXeIFYmdvhYWPCGB4=;
        b=C6wmzGbEeTgb4ZGQ12qcgc0gNI2mXKLy2bdf9m/aUJ70RDNECsjqiFcibedMjMxZc3
         Ku6C1r1XOCiELOX2Fh69+a2IDNb2dV7CHs/txTR0vodQXfFrIY4qhFoY7NsW04JwVKO9
         8daqt7gTbM+cagwp5RpIdn1uMBjd1RM7LwenKP09v9Tq/2cFPb/N54ouexR6iDuVZH3C
         KpQTGD6SfpX5QBcZn5XvgO4cO2RCFKPp6E5VLyVk8tTT6T6CRMjlQTMbz1mJmB9gjoXO
         Pw06ei8satFmiQXaIKhCSBRzXgu86/xfUvqD5u6oiNuEOX1gF5gK3UnpEHUMYZNDnZFO
         3zRQ==
X-Received: by 10.66.191.9 with SMTP id gu9mr50506845pac.27.1400593855497;
        Tue, 20 May 2014 06:50:55 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id oe4sm3317286pbb.33.2014.05.20.06.50.54
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 20 May 2014 06:50:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1400593832-6510-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249673>

The interaction with unary operators and operator precedence
for && and || are better known than -a and -o, and for that
reason we prefer them. Replace all existing instances
of -a and -o to save readers from the burden of thinking
about such things.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 t/t5538-push-shallow.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5538-push-shallow.sh b/t/t5538-push-shallow.sh
index 8e54ac5..63d9ca9 100755
--- a/t/t5538-push-shallow.sh
+++ b/t/t5538-push-shallow.sh
@@ -121,7 +121,7 @@ EOF
 	)
 '
 
-if test -n "$NO_CURL" -o -z "$GIT_TEST_HTTPD"; then
+if test -n "$NO_CURL" || test -z "$GIT_TEST_HTTPD"; then
 	say 'skipping remaining tests, git built without http support'
 	test_done
 fi
-- 
1.7.10.4
