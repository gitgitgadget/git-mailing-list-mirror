From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 02/19] contrib/examples/git-clone.sh: convert test -a/-o to && and ||
Date: Tue, 20 May 2014 06:50:15 -0700
Message-ID: <1400593832-6510-3-git-send-email-gitter.spiros@gmail.com>
References: <1400593832-6510-1-git-send-email-gitter.spiros@gmail.com>
Cc: jrnieder@gmail.com, Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 20 15:51:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmkRe-0000Bh-IS
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 15:51:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753544AbaETNun (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 09:50:43 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:38754 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753456AbaETNul (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 09:50:41 -0400
Received: by mail-pa0-f44.google.com with SMTP id ld10so340565pab.31
        for <git@vger.kernel.org>; Tue, 20 May 2014 06:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jc7Ln0kFzj2MxDRuDmk0Opqnn1oOJjwPDn4SBbFAr2k=;
        b=q+uW0jqoJ+mmX7IZVYkgZCQZOWWHP6OhKviuvoCigV8ZyNqtnxGlhaCfjKIbBab23A
         83OTE1YEgVAFsgE//AT/Yd5nCXNRQ7IpFxQZHt0mFGdTByoz0Sgbev+CuN0o15yRL38x
         7fZm4hq+JI6zy2UsCOMSPOyyGQfnQ8zdCn+zAiQJvkFIvk2iu1kDX9RWc022j7urSAqe
         F89/9TIURWOuGQfDkYEmW7XFzAdjzTxHc+5fSwY9+u4fRGHz4j1iBUYE5cC3JRkFdP1r
         DkP3E3TTV9Op9zboPE//7WWOrAkf+uJ6BxbqGsQClEZNpRjMpqGY9HGL65YCz3unU39+
         0Kyg==
X-Received: by 10.68.103.165 with SMTP id fx5mr50915947pbb.118.1400593841355;
        Tue, 20 May 2014 06:50:41 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id oe4sm3317286pbb.33.2014.05.20.06.50.40
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 20 May 2014 06:50:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1400593832-6510-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249663>

The interaction with unary operators and operator precedence
for && and || are better known than -a and -o, and for that
reason we prefer them. Replace all existing instances
of -a and -o to save readers from the burden of thinking
about such things.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 contrib/examples/git-clone.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/examples/git-clone.sh b/contrib/examples/git-clone.sh
index b4c9376..08cf246 100755
--- a/contrib/examples/git-clone.sh
+++ b/contrib/examples/git-clone.sh
@@ -516,7 +516,7 @@ then
 
 	case "$no_checkout" in
 	'')
-		test "z$quiet" = z -a "z$no_progress" = z && v=-v || v=
+		test "z$quiet" = z && test "z$no_progress" = z && v=-v || v=
 		git read-tree -m -u $v HEAD HEAD
 	esac
 fi
-- 
1.7.10.4
