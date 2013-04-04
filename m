From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 4/4] remote-hg: fix hg-git test-case
Date: Thu,  4 Apr 2013 09:36:19 -0600
Message-ID: <1365089779-9726-5-git-send-email-felipe.contreras@gmail.com>
References: <1365089779-9726-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>, Antoine Pelisse <apelisse@gmail.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 04 17:38:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNmEp-0000m1-2I
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 17:38:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760835Ab3DDPhf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 11:37:35 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:37713 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760391Ab3DDPh3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 11:37:29 -0400
Received: by mail-oa0-f44.google.com with SMTP id h1so2925565oag.17
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 08:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=c6gEiEQnhj1kxPntiOSjOo+R+3vgpKubcj3VHEnYT1c=;
        b=vLf7+0XZ2jpLv5hFg9OYkGrTy7BlpAtLhWCrfqb9eWD3TXeB1enkQw4bDNTNSiju9a
         L+T4Svv1jBUZDmbc1YfDyEYVw+8PnwDqFankdWHQZ87Yy7VTqdO1nhP7O/2a6RaOsPW+
         MKtbJnQS/2hPdrw+DqIkVJMNHC7th0nckU+JuqCp7c/LxnDn+rcatuHCZFfiLWX5v0Rb
         ND1qBj6LvDOjrR+N0zNw7tKiw0ip+IibBl5E7gvm3fZIgmXYp+CIIJZiwTEua6TmPm61
         vOpHzwaYOyDZ0IcgNWvYnlLIO/JoCv9/qZUQSq8VBaeWp5hpqRkNB7vGK6SOquFVOpk3
         MSNA==
X-Received: by 10.60.169.237 with SMTP id ah13mr4598138oec.41.1365089849519;
        Thu, 04 Apr 2013 08:37:29 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id w10sm7148221oed.2.2013.04.04.08.37.27
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Apr 2013 08:37:28 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365089779-9726-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220022>

There was some lingering code that shouldn't have been there in the
first place.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-hg-hg-git.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/contrib/remote-helpers/test-hg-hg-git.sh b/contrib/remote-helpers/test-hg-hg-git.sh
index 7e3967f..3f253b7 100755
--- a/contrib/remote-helpers/test-hg-hg-git.sh
+++ b/contrib/remote-helpers/test-hg-hg-git.sh
@@ -140,7 +140,6 @@ test_expect_success 'executable bit' '
 		git_clone_$x hgrepo-$x gitrepo2-$x &&
 		git_log gitrepo2-$x > log-$x
 	done &&
-	cp -r log-* output-* /tmp/foo/ &&
 
 	test_cmp output-hg output-git &&
 	test_cmp log-hg log-git
-- 
1.8.2
