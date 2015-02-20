From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/2] nd/slim-index-pack-memory-usage updates
Date: Fri, 20 Feb 2015 08:58:06 +0700
Message-ID: <1424397488-22169-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, msporleder@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 20 02:58:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOcrC-0001OG-8P
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 02:58:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753417AbbBTB6B convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Feb 2015 20:58:01 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:41657 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752711AbbBTB6A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2015 20:58:00 -0500
Received: by padfb1 with SMTP id fb1so4182615pad.8
        for <git@vger.kernel.org>; Thu, 19 Feb 2015 17:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=PGqJFv332/RPe53xFtVYUlQ6M3+GJBDJ1eJEvUu/XSc=;
        b=n5Fa07Y+VvW2Ja+oOT36m4n4lxthkBBZCfcxJXb4VKOw+OXWYaLqko/f8sFgfDz95C
         q7JZjHrB3pko5/Cw4jchtkezVlo3Cg0vy2Qp0+nbxaXgy0R1V1LSmay+wJyik6/PVno3
         ZOIOPK3osqxhTAcS7MBanUoGK31dGFN0OT/qYeFvPJ2MmyjYEBUwcazZfp6tZID3l+LR
         UW6GVU3pLKopgIPNWF28x21F0dueFoXgZfVcl1Hb3AGgwE/62fF9qIwG4y2UNbSA/5wV
         57l3/48G9zOT2crsuIlq45jTuieQFc54akzkKDc/qaDH/oor5vAhFrt4vnH8x8ZpLSOz
         cB9Q==
X-Received: by 10.66.222.135 with SMTP id qm7mr12798195pac.38.1424397479897;
        Thu, 19 Feb 2015 17:57:59 -0800 (PST)
Received: from lanh ([115.73.216.113])
        by mx.google.com with ESMTPSA id g7sm13104456pdm.4.2015.02.19.17.57.56
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Feb 2015 17:57:59 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 20 Feb 2015 08:58:19 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264126>

Compared to 'pu', the first patch is unchanged, except the commit
message. The second patch has __attribute((packed)) removed because it
causes problems on some ARM systems. x86 people who want to save more
memory just have to put it back by themselves.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
  index-pack: reduce object_entry size to save memory
  index-pack: kill union delta_base to save memory

 builtin/index-pack.c | 290 +++++++++++++++++++++++++++++++------------=
--------
 1 file changed, 179 insertions(+), 111 deletions(-)

--=20
2.3.0.rc1.137.g477eb31
