From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 3/3] fetch: elaborate --depth action
Date: Fri, 11 Jan 2013 16:05:48 +0700
Message-ID: <1357895148-30909-3-git-send-email-pclouds@gmail.com>
References: <1357875005-21956-1-git-send-email-pclouds@gmail.com>
 <1357895148-30909-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <stefanbeller@googlemail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	schlotter@users.sourceforge.net, Ralf.Wildenhues@gmx.de,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 11 10:06:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtaZB-0000lh-9g
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 10:06:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755375Ab3AKJF6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Jan 2013 04:05:58 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:59025 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754429Ab3AKJF5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 04:05:57 -0500
Received: by mail-pa0-f50.google.com with SMTP id hz10so900949pad.37
        for <git@vger.kernel.org>; Fri, 11 Jan 2013 01:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=DKfx7mQT79BqdSfs/8us3bzWrsR3pHAdPtk8dirEofM=;
        b=F0MlptzlJ5wF+ymNL4ICMzd9+/ULSAEukUuYH7xk9j5NX3YeF3jDHB/7SQKQL/AVKq
         XTcBMG8NJ9AlyRoCzrUVlHX97aFcP3cCyQ/8Q7OmiFOT8uq7ulxvY2MdlPdB34LQ7YqX
         kjKGIcYKG83qHzybUDX+okTiLdy5y027uX1zMyvdcmHJbkQ51eJkOrpQdU1AeaXCd2Fg
         NeW9TmwJ/RVXspW9LZaJkC1iOaCuVtoekuzSfI4UZNx6VTkvs5M0L8ptbpbGvqwqqNt6
         kSaByJE4lOk8VTcQk+n7ZQijbrvIWbNxBGbXJYGKci4hHugHwVniFvozXgGQFUUH3B9h
         pblg==
X-Received: by 10.68.235.2 with SMTP id ui2mr226071641pbc.163.1357895157040;
        Fri, 11 Jan 2013 01:05:57 -0800 (PST)
Received: from lanh ([115.74.46.148])
        by mx.google.com with ESMTPS id pm8sm2451973pbb.29.2013.01.11.01.05.52
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jan 2013 01:05:56 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 11 Jan 2013 16:06:10 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1357895148-30909-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213187>

--depth is explained as deepen, but the way it's applied, it can
shorten the history as well. Keen users may have noticed the
implication by the phrase "the specified number of commits from the
tip of each remote branch". Put "shorten" in the description to make
it clearer.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/fetch-options.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-opti=
ons.txt
index 8a0449c..fb92b02 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -8,7 +8,7 @@
 	option old data in `.git/FETCH_HEAD` will be overwritten.
=20
 --depth=3D<depth>::
-	Deepen the history of a 'shallow' repository created by
+	Deepen or shorten the history of a 'shallow' repository created by
 	`git clone` with `--depth=3D<depth>` option (see linkgit:git-clone[1]=
)
 	to the specified number of commits from the tip of each remote
 	branch history. Tags for the deepened commits are not fetched.
--=20
1.8.0.rc2.23.g1fb49df
