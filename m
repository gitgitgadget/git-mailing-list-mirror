From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 10/32] commit: use SEQ_DIR instead of hardcoding "sequencer"
Date: Sun, 28 Sep 2014 08:22:24 +0700
Message-ID: <1411867366-3821-11-git-send-email-pclouds@gmail.com>
References: <xmqqk34r9z3r.fsf@gitster.dls.corp.google.com>
 <1411867366-3821-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 28 03:23:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XY3DJ-0002Ji-JY
	for gcvg-git-2@plane.gmane.org; Sun, 28 Sep 2014 03:23:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753282AbaI1BXp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Sep 2014 21:23:45 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:35904 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183AbaI1BXp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Sep 2014 21:23:45 -0400
Received: by mail-pd0-f182.google.com with SMTP id y10so3306376pdj.13
        for <git@vger.kernel.org>; Sat, 27 Sep 2014 18:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=cmRumW3rep42ZAnurdabS/mMKhcqrvI5+KMKOgRCfPI=;
        b=yhanUXhmDLuEoH5t7xB2B8QZuvjcOMA36d8LWHDj6vVTzNUPxH1g/+GHhThdGVLZyx
         Jy75r2vvFD0Dw9Na0ws4aLzfTqbxKcWUA0IMu3U8NjNjCoOmMDJfZqa2U/OvpHgPk1jh
         Ya1zIZ74mrNEzcdODoeSYXgpGB2ZsjGHCHBKv4THMIsLWcei9r1vrkoXP266CDj5B7IY
         nKI2PBzApft9KMErKKPdWqFI98uvUwuc3Te8A2yCBZZ1ZfRQuQC9XFi29WrvVqhosVvW
         6nLHBrOCu9kDLwbrUj2V6LI9OROYm9GsWDjgWwtpj8RYhQeDqd5zfBpjVqp+Gqr1wXbW
         jOlw==
X-Received: by 10.66.191.7 with SMTP id gu7mr46559915pac.32.1411867424658;
        Sat, 27 Sep 2014 18:23:44 -0700 (PDT)
Received: from lanh ([115.73.212.224])
        by mx.google.com with ESMTPSA id wr3sm2556082pac.34.2014.09.27.18.23.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Sep 2014 18:23:43 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 28 Sep 2014 08:23:47 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1411867366-3821-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257569>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/commit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index b0fe784..08df727 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -169,7 +169,7 @@ static void determine_whence(struct wt_status *s)
 		whence =3D FROM_MERGE;
 	else if (file_exists(git_path("CHERRY_PICK_HEAD"))) {
 		whence =3D FROM_CHERRY_PICK;
-		if (file_exists(git_path("sequencer")))
+		if (file_exists(git_path(SEQ_DIR)))
 			sequencer_in_use =3D 1;
 	}
 	else
--=20
2.1.0.rc0.78.gc0d8480
