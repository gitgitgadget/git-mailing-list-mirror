From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] environment.c: add GIT_NAMESPACE to local_repo_env
Date: Tue, 21 Oct 2014 07:27:33 +0700
Message-ID: <1413851253-22642-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 21 02:28:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XgNIt-0007hN-SG
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 02:28:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753385AbaJUA1z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Oct 2014 20:27:55 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:34264 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752673AbaJUA1y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2014 20:27:54 -0400
Received: by mail-pd0-f169.google.com with SMTP id w10so148577pde.28
        for <git@vger.kernel.org>; Mon, 20 Oct 2014 17:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=XIaJX1tAMsmTxJ+mGGtRhwhAydW4nz1Yp+Xe9l80BPw=;
        b=tLjmc4NUSMfyh6xL7wB1AdMFc7IurXbXv41F+BqH7meAU77Rg6fI4halOeYlsklwU1
         Je19v/sHMDJ5fKC2eOWfX315UCu8938BrSKz0ICNfUogjxOY+7WbLcmQK+JMAIvINfnF
         PbXTgTwlT+IX38u1bgwUUL2oLTVlTcgRMKJY95c/gGqX5rLd5O1Y9zLuP9/8hVZYbjtS
         UQjNEn/Xw8ePKop6PnSFzNEunII/boljsoiKpu/Poi+n4RBYEaq0tStK6GyEX8jsn/A0
         O3o0soK4ebHXmoS0AKCay7xLZUU/OvI4OtkCjepEJyXZoA7OMptSQxZ4NrPcNmvewnNX
         uTZg==
X-Received: by 10.70.37.236 with SMTP id b12mr30519313pdk.75.1413851274303;
        Mon, 20 Oct 2014 17:27:54 -0700 (PDT)
Received: from duynguyen-vnpc.dek-tpc.internal ([14.161.14.94])
        by mx.google.com with ESMTPSA id i10sm10229387pdr.21.2014.10.20.17.27.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Oct 2014 17:27:53 -0700 (PDT)
X-Mailer: git-send-email 2.0.2.841.g8f98430
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This environment variable is added in a1bea2c (ref namespaces:
infrastructure - 2011-07-05). This is clearly repo specific setting
and should not be propagated to subprograms.

In practice, this is not a problem because GIT_NAMESPACE seems
designed for use on the server side and while submodule traversal
stuff happens on the client side.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 .. looks like the right thing to do..

 environment.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/environment.c b/environment.c
index 565f652..16628d3 100644
--- a/environment.c
+++ b/environment.c
@@ -100,6 +100,7 @@ const char * const local_repo_env[] =3D {
 	NO_REPLACE_OBJECTS_ENVIRONMENT,
 	GIT_PREFIX_ENVIRONMENT,
 	GIT_SHALLOW_FILE_ENVIRONMENT,
+	GIT_NAMESPACE_ENVIRONMENT,
 	NULL
 };
=20
--=20
2.0.2.841.g8f98430
