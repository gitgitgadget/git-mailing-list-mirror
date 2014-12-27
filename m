From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 0/3] some attr optimizations
Date: Sun, 28 Dec 2014 06:39:45 +0700
Message-ID: <1419723588-13236-1-git-send-email-pclouds@gmail.com>
References: <1418133205-18213-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 28 00:29:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y50nL-00022i-5M
	for gcvg-git-2@plane.gmane.org; Sun, 28 Dec 2014 00:29:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751548AbaL0X3L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Dec 2014 18:29:11 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:62751 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026AbaL0X3J (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Dec 2014 18:29:09 -0500
Received: by mail-pa0-f49.google.com with SMTP id eu11so15060370pac.22
        for <git@vger.kernel.org>; Sat, 27 Dec 2014 15:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=fmxKJ1oHPYTVcDgW8B8iZ1mVSzVPYMi92p8PjCyDd/8=;
        b=ft1Ci+veA6rSFB5yTQBfj7qdgNHjqoNp59sU9a3Xg1frsa15wcdb/FoRtcl3D6nxrE
         p/g9LEE5HbOj0sCOpJXhbwQt8U95tF9diOCZZbVdczeW7ip7yHC3imjs0ZevGBK4Emcs
         kWTDRNkKWvtd83Hh43VYrUT8IozeCn6yICOt2S3AjYe7a6RB8WeXFX/3YmCBH/kYJmX2
         2LsxCPRhYvE3MJdnki0vYN7d2g7vOOITTK64bYcUSlJ4a+qbMD4Xj1/gQLGBqQDvSK5g
         zDTlc5MX1P2E4+fXakcYpM+VzVk85Bp4YcOp4Z1WoFFCiCqNTf/bBUBjKIxJNDAH1Ipw
         vlSw==
X-Received: by 10.70.95.133 with SMTP id dk5mr46855854pdb.98.1419722948501;
        Sat, 27 Dec 2014 15:29:08 -0800 (PST)
Received: from lanh ([115.73.209.146])
        by mx.google.com with ESMTPSA id b11sm31699658pdl.56.2014.12.27.15.29.05
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Dec 2014 15:29:07 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 28 Dec 2014 06:40:01 +0700
X-Mailer: git-send-email 2.2.0.84.ge9c7a8a
In-Reply-To: <1418133205-18213-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261842>

v2 updates 01/03 (rename the local var to avoid shadowing instead) and
merges 02/04 and 04/04 to 03/03.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (3):
  attr.c: rename arg name attr_nr to avoid shadowing the global one
  attr: do not attempt to expand when we know it's not a macro
  attr: avoid heavy work when we know the specified attr is not defined

 attr.c | 47 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 10 deletions(-)

--=20
2.2.0.84.ge9c7a8a
