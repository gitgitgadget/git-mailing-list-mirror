From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v6 12/32] commit: use SEQ_DIR instead of hardcoding "sequencer"
Date: Wed,  9 Jul 2014 14:32:57 +0700
Message-ID: <1404891197-18067-13-git-send-email-pclouds@gmail.com>
References: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 09 09:34:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4mOi-0003Ww-CV
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 09:34:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754800AbaGIHec convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jul 2014 03:34:32 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:64658 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754753AbaGIHeb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 03:34:31 -0400
Received: by mail-pa0-f54.google.com with SMTP id et14so8678935pad.41
        for <git@vger.kernel.org>; Wed, 09 Jul 2014 00:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=7/MF20xXNRneucSzhmd9d2voKB2r9HXXFOWe680apKU=;
        b=0nkeEHpyaSaRR7ydcXsqnwtC76FpM98K8+mQQA5a1YoMd48OLVJm1s5LTmoBhUIgZL
         FBkc4GZWjbzyIUkMq0dgqPqGynJkoIQhJW65vugr98wq73CJbFxVOUwp2bVLWquFlg+4
         AAxXmhTUgX1QcRCH418iPHgdNfJAJjuQ/YX+mktVg8RUPCjzgnYseRpKhP79kycWcUfH
         sjccKinSoq8KXUVuRPIoaM475ZTX0ythuMk1W4U0vzsILqDeORC76F/BOAFmKqdx4Wbs
         WggCAeSkgyHFJ80h6gntT05EHW564EYT8+jY/Rz0njbO4WaSoos9N+ydZ1tL1tE2pJ2q
         mKVg==
X-Received: by 10.68.211.195 with SMTP id ne3mr13945432pbc.121.1404891271194;
        Wed, 09 Jul 2014 00:34:31 -0700 (PDT)
Received: from lanh ([115.73.209.165])
        by mx.google.com with ESMTPSA id kh7sm144463472pad.8.2014.07.09.00.34.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jul 2014 00:34:30 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 09 Jul 2014 14:34:28 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253087>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/commit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 84cec9a..9f2aba3 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -156,7 +156,7 @@ static void determine_whence(struct wt_status *s)
 		whence =3D FROM_MERGE;
 	else if (file_exists(git_path("CHERRY_PICK_HEAD"))) {
 		whence =3D FROM_CHERRY_PICK;
-		if (file_exists(git_path("sequencer")))
+		if (file_exists(git_path(SEQ_DIR)))
 			sequencer_in_use =3D 1;
 	}
 	else
--=20
1.9.1.346.ga2b5940
