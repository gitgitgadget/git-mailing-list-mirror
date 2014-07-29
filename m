From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 7/8] checkout: prefix --to argument properly when cwd is moved
Date: Tue, 29 Jul 2014 20:50:30 +0700
Message-ID: <1406641831-2390-8-git-send-email-pclouds@gmail.com>
References: <1406115795-24082-1-git-send-email-pclouds@gmail.com>
 <1406641831-2390-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	git@drmicha.warpmail.net,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 15:53:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XC7qD-0005qw-EG
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 15:53:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753830AbaG2NxN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jul 2014 09:53:13 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:49002 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345AbaG2NxK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 09:53:10 -0400
Received: by mail-pd0-f169.google.com with SMTP id y10so11743952pdj.28
        for <git@vger.kernel.org>; Tue, 29 Jul 2014 06:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=aeaemtB680Wv793U62x6W7RrgZx9fia1TWctZrHJ4eg=;
        b=OaiPMmGLa3464s2owBHnickIsug1nyh3QV5wXDeCQdqJ96g2DXJSJGOK9XSCg48YA+
         LGY+B0q2/UrCLzR4GL+5i6ZPg2gjEbHIct+EuMuydeJcLs8zpXV8OcrHYD6VMr83Gqn0
         wpnb8dIh8niQSKS3tnaCUkgMYuKqeRDVx+4il3rxTGtibId7It2EkHRBn+8986mLKISF
         B7fXqzTE2oK98Th2gyXK4AfuN1IXzQV+ZzRZV1ugnCi5lhVVbtSRdsNjk6CaLNAXUAPQ
         xLvI2FEHlZ9W5Lt2x0/WHoxSihRIO9pFVzjxpEZSXMFV8FsT0XLFtkzm1maH3Zdjxqu/
         BtYw==
X-Received: by 10.69.20.11 with SMTP id gy11mr2345633pbd.28.1406641990511;
        Tue, 29 Jul 2014 06:53:10 -0700 (PDT)
Received: from lanh ([115.73.243.195])
        by mx.google.com with ESMTPSA id bp4sm29070722pdb.24.2014.07.29.06.53.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jul 2014 06:53:09 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 29 Jul 2014 20:53:13 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1406641831-2390-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254440>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/checkout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 173aab1..4fbb9c1 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1342,7 +1342,7 @@ int cmd_checkout(int argc, const char **argv, con=
st char *prefix)
 			 N_("do not limit pathspecs to sparse entries only")),
 		OPT_HIDDEN_BOOL(0, "guess", &dwim_new_local_branch,
 				N_("second guess 'git checkout no-such-branch'")),
-		OPT_STRING(0, "to", &opts.new_worktree, N_("path"),
+		OPT_FILENAME(0, "to", &opts.new_worktree,
 			   N_("check a branch out in a separate working directory")),
 		OPT_END(),
 	};
--=20
2.1.0.rc0.78.gc0d8480
