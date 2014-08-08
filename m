From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 8/8] mv: combine two if(s)
Date: Fri,  8 Aug 2014 20:11:02 +0700
Message-ID: <1407503462-32632-9-git-send-email-pclouds@gmail.com>
References: <1407503462-32632-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 08 15:11:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFjxb-0001DN-F9
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 15:11:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756731AbaHHNLu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Aug 2014 09:11:50 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:61569 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756641AbaHHNLu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2014 09:11:50 -0400
Received: by mail-pa0-f47.google.com with SMTP id kx10so7172856pab.6
        for <git@vger.kernel.org>; Fri, 08 Aug 2014 06:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=nh5IF0q1bpB4KusgtvXctIxjd8hKtVeEln2vXenDkVk=;
        b=m3Ju1Q0HAvFcVCNJE8jE6KCn8vU/yHdVJZSKRpAar6i87d5/URW4Sv8OlakaSnWD9/
         3KadRiLjXPV507jiNOAg9CvLfHbc4WA594rM7Bkwox3HGhqjS7GN4cwT4DJ4mQhEwH6D
         WX30uT+4rW5uVgNB/51KpxIFJDaAW2V/UatVmkrj4Ls21CotzBUuWKhN1fAilc9DJGpx
         QLwPsFVb2rhinwIAZFRdPD0PHnPU4IppVnIEAdBb8uRXeNxNZJOxXsqjaoSSPVgkLAdJ
         ugDGIySoYZpcgQ639HnIAbeH7WFF2WUCZ3ZuuAKiNi/vqv+CQj6HQTVuriZ8FppalNyL
         w+HA==
X-Received: by 10.66.254.198 with SMTP id ak6mr943617pad.156.1407503509763;
        Fri, 08 Aug 2014 06:11:49 -0700 (PDT)
Received: from lanh ([115.73.206.39])
        by mx.google.com with ESMTPSA id jb5sm2982494pbd.73.2014.08.08.06.11.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Aug 2014 06:11:49 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 08 Aug 2014 20:11:52 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1407503462-32632-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255014>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/mv.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index a2e33b5..4eb420b 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -276,10 +276,9 @@ int cmd_mv(int argc, const char **argv, const char=
 *prefix)
 	if (gitmodules_modified)
 		stage_updated_gitmodules();
=20
-	if (active_cache_changed) {
-		if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
+	if (active_cache_changed &&
+	    write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 			die(_("Unable to write new index file"));
-	}
=20
 	return 0;
 }
--=20
2.1.0.rc0.78.gc0d8480
