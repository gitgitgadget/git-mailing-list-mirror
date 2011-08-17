From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] checkout-index: remove obsolete comment
Date: Wed, 17 Aug 2011 19:22:13 +0700
Message-ID: <1313583733-7514-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 17 14:27:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtfDY-0001mf-83
	for gcvg-git-2@lo.gmane.org; Wed, 17 Aug 2011 14:27:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753146Ab1HQM11 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Aug 2011 08:27:27 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:61207 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752238Ab1HQM10 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2011 08:27:26 -0400
Received: by gxk21 with SMTP id 21so682017gxk.19
        for <git@vger.kernel.org>; Wed, 17 Aug 2011 05:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=xu3nFpGiZC4JxRxU+LqZMJqrtud/OKDywQkmX7N6Nn0=;
        b=vyAW5a//cx+FihZQepHtNKJInOsToTcrQaoBlA8Mu9TWlx333zKuoUuB4e/8HZ5dyH
         LDM/ngad9VUxdNTQCFDCEF4zU8W7DxwgasuSZui0Fam8SxYuOoNLKlpdicRPIZfa1y/w
         Hj1DB74GbwaWPxMnd291pfsGGT1GRiWmU6H0s=
Received: by 10.142.250.34 with SMTP id x34mr445377wfh.160.1313584045509;
        Wed, 17 Aug 2011 05:27:25 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.228.117])
        by mx.google.com with ESMTPS id p7sm590995pbn.65.2011.08.17.05.27.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 17 Aug 2011 05:27:24 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 17 Aug 2011 19:22:14 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179510>

The first paragraph about flag order is no longer true and is
mentioned in git-checkout-index.txt. The rest is also mentioned in
git-checkout-index.txt.

Remove it and keep uptodate document in one place.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/checkout-index.c |   32 --------------------------------
 1 files changed, 0 insertions(+), 32 deletions(-)

diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index f1fec24..c16d82b 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -3,38 +3,6 @@
  *
  * Copyright (C) 2005 Linus Torvalds
  *
- * Careful: order of argument flags does matter. For example,
- *
- *	git checkout-index -a -f file.c
- *
- * Will first check out all files listed in the cache (but not
- * overwrite any old ones), and then force-checkout "file.c" a
- * second time (ie that one _will_ overwrite any old contents
- * with the same filename).
- *
- * Also, just doing "git checkout-index" does nothing. You probably
- * meant "git checkout-index -a". And if you want to force it, you
- * want "git checkout-index -f -a".
- *
- * Intuitiveness is not the goal here. Repeatability is. The
- * reason for the "no arguments means no work" thing is that
- * from scripts you are supposed to be able to do things like
- *
- *	find . -name '*.h' -print0 | xargs -0 git checkout-index -f --
- *
- * or:
- *
- *	find . -name '*.h' -print0 | git checkout-index -f -z --stdin
- *
- * which will force all existing *.h files to be replaced with
- * their cached copies. If an empty command line implied "all",
- * then this would force-refresh everything in the cache, which
- * was not the point.
- *
- * Oh, and the "--" is just a good idea when you know the rest
- * will be filenames. Just so that you wouldn't have a filename
- * of "-a" causing problems (not possible in the above example,
- * but get used to it in scripting!).
  */
 #include "builtin.h"
 #include "cache.h"
--=20
1.7.4.74.g639db
