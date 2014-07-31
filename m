From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 0/3] Keep .lock file paths absolute
Date: Thu, 31 Jul 2014 20:43:31 +0700
Message-ID: <1406814214-21725-1-git-send-email-pclouds@gmail.com>
References: <1405858399-23082-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, ramsay@ramsay1.demon.co.uk,
	yuelinho777@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 31 15:43:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCqdt-0004Oa-Eo
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 15:43:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbaGaNnc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Jul 2014 09:43:32 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:41703 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750702AbaGaNnb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 09:43:31 -0400
Received: by mail-pd0-f171.google.com with SMTP id z10so3511849pdj.30
        for <git@vger.kernel.org>; Thu, 31 Jul 2014 06:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=/rCslNI4IQeOK/LcpPxQAaUkp0L+6JTTJNUG6vIZ0Zg=;
        b=bHLzQsuc3AuEUeTwOigZeOjm41ycGtBQCCAHQkG2gi9GE0r3iV2yqRS8CuFwO3fjhm
         Xq1ApldmrF2TmnGHS3DP0z2zTX2w7xVkaS9qVTY9tZjUNR4rY7cBCRq38y5eMkF3mkhl
         QifhrJvZ2rkfOVaEIZIhXwSuab2iz0eHmVD/VAI2+83TVe7/JXRCaVyQ/Pii7lGDNXGT
         2DOfNARZVG6L5XlwHc1FfkpOFg32a8dS0bwf/GzK/vS2P8ecabP9/kv6DBju0wGtNIIi
         M6x+bQjCeC1se3no1yYjy9b47D/JClWT3E7Fii38i3b1cnPzauXvUkRrDmGaqQof81jc
         UMnQ==
X-Received: by 10.68.109.228 with SMTP id hv4mr4431686pbb.55.1406814211325;
        Thu, 31 Jul 2014 06:43:31 -0700 (PDT)
Received: from lanh ([115.73.244.27])
        by mx.google.com with ESMTPSA id fe8sm8403891pdb.16.2014.07.31.06.43.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jul 2014 06:43:30 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 31 Jul 2014 20:43:35 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1405858399-23082-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254570>

v3 requires rs/strbuf-getcwd, turns paths to absolute from the
beginning, and kills the last use of PATH_MAX in lockfile.c thanks to
strbuf_readlink().

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (3):
  lockfile.c: remove PATH_MAX limitation (except in resolve_symlink)
  lockfile.c: remove PATH_MAX limit in resolve_symlink()
  lockfile.c: store absolute path

 cache.h                       |  2 +-
 lockfile.c                    | 95 +++++++++++++++++++----------------=
--------
 t/t2107-update-index-basic.sh | 15 +++++++
 3 files changed, 58 insertions(+), 54 deletions(-)

--=20
2.1.0.rc0.78.gc0d8480
