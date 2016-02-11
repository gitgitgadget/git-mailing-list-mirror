From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 15/22] merge-recursive.c: use the FORMATPRINTF macro to declare the gcc function attribute 'format printf'
Date: Thu, 11 Feb 2016 12:38:52 +0000
Message-ID: <1455194339-859-16-git-send-email-gitter.spiros@gmail.com>
References: <1455194339-859-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 13:40:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTqXY-0008U2-BX
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 13:40:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753110AbcBKMj7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 07:39:59 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33728 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbcBKMja (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 07:39:30 -0500
Received: by mail-wm0-f66.google.com with SMTP id c200so10464176wme.0
        for <git@vger.kernel.org>; Thu, 11 Feb 2016 04:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RwsN2NQz8Nv5bXRqg1RpLiTF9E0Ox5lTBzQkwll2Zo8=;
        b=pGBIiTesxouimQEpXAeGkcXNKlqPbI0ouPjLZZAHDUYzvrPTeTghMUl827s3vc8FgV
         4kHrBtdp2CDEMMqv00VnKqV/53IdPmmXe/lIzgC7d6ZVlicff8WT7eyCaqFUQtWG1m7L
         fAtBQCCO56F2BfRaQKOgIgtTd1OknzJ3Wh/Yp3I1a0O5PpFTW3FuqKqbViMahRPtmZXL
         dwvOJn14RH9+7UAO4WQ1pqnlk7FOSAq2f1o5c0rXebgkcwjBM7vFvqe9quPWD4RAyBXl
         O40rNyWQykniPe23Hobc6VxNWRpUSwek048S4BntqFW3aN6Nr2avxILzQsmTDbhW+mqC
         IDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RwsN2NQz8Nv5bXRqg1RpLiTF9E0Ox5lTBzQkwll2Zo8=;
        b=kh+l6NxEp/b1dM4bu7xisSot+Bs+PxNJ7k7SKMFM/hSGLXuo3CQ2AYQS4sDAHaz/f2
         EiV2w4wgWjvAuNZQVo8wqjz86n6EOP7Vw0h818qM5QLGgsJC/E4DUijD1iqJXFwHzmxx
         xNZe6B0HNhAblqite/91Y46gRIT/hP+fuhlpWzsr/1zYwnKD2ZWx2DIwfXiItTqchQ7G
         SELKrpIfV/9dxOJgsdHkAtP/CzKaeBUZWfV4UC9KZmNt/Zv2xm2mNNZ2xKb/PxduMaji
         sM/Gq8CwfUUWyx7hPvawHS82CxLzTTehgRS56Mbhx0r6Dw514obsvFKC9ZshPpyrnV7Y
         amcA==
X-Gm-Message-State: AG10YOSlb0oeB3ji7TW/xJ5sS18Ypmq2QfWPc6IOcKa8r+KctyMazqFmZ8apDqz3WKOerQ==
X-Received: by 10.28.148.130 with SMTP id w124mr17741617wmd.71.1455194369441;
        Thu, 11 Feb 2016 04:39:29 -0800 (PST)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([40.113.119.92])
        by smtp.gmail.com with ESMTPSA id gt7sm7457368wjc.1.2016.02.11.04.39.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Feb 2016 04:39:28 -0800 (PST)
X-Mailer: git-send-email 2.7.0.327.gff4ea60.dirty
In-Reply-To: <1455194339-859-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285972>

Use the new FORMATPRINTF macro (in git-compat-util.h) to declare the gcc function
attribute 'format printf'

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 merge-recursive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 8eabde2..891d909 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -156,7 +156,7 @@ static void flush_output(struct merge_options *o)
 	}
 }
 
-__attribute__((format (printf, 3, 4)))
+FORMATPRINTF(3,4)
 static void output(struct merge_options *o, int v, const char *fmt, ...)
 {
 	va_list ap;
-- 
2.5.0
