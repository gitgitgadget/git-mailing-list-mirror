From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 11/16] pack-objects: add --subtree (for pushing)
Date: Sat, 31 Jul 2010 23:18:20 +0700
Message-ID: <1280593105-22015-12-git-send-email-pclouds@gmail.com>
References: <1280593105-22015-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 01 04:39:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfOSP-00035v-2x
	for gcvg-git-2@lo.gmane.org; Sun, 01 Aug 2010 04:39:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755408Ab0HACjM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Jul 2010 22:39:12 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:42790 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753090Ab0HACjK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jul 2010 22:39:10 -0400
Received: by mail-pw0-f46.google.com with SMTP id 5so977126pwi.19
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 19:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=XUQ4Aq7O4TpP1AxSAjZj6hsOQh7Zmsu6mC3koClpQt0=;
        b=VgLel4NKAmZKAGrDjQuuouLQnqStScVJa1OpunlAwvGcoyFeXFmiy3X26jKaDSrTMC
         4MwdJak8c81a3/tbU3ebntMOGaEoLS37mMjd5slqXSJunpehs5JLg6mfS2O5gjTy1VSY
         /MEQi48sT1puqi5rqZvTJNPSexbWptdYJLChg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Ryk4R3+GHAI919WUmzres8kuPExsBT4Sj8YkXGPZ0SVpg1ZFKbRc3esv+lAVi95rkp
         aEDJsFIIxqMvxoY4SiClF8mcUyICgfk/vpGqhKP/wRdzP4Beolfuk395YPW0SG9x9njt
         3ekpQlNcanJFLuw3ua8iOeMCOb1n/jkdZ1gvw=
Received: by 10.142.207.9 with SMTP id e9mr3621175wfg.111.1280630350133;
        Sat, 31 Jul 2010 19:39:10 -0700 (PDT)
Received: from dektop ([119.12.238.118])
        by mx.google.com with ESMTPS id f2sm5246421wfp.23.2010.07.31.19.39.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 31 Jul 2010 19:39:09 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Sat, 31 Jul 2010 23:20:03 +0700
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1280593105-22015-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152358>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/pack-objects.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 0e81673..5d7b277 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2277,6 +2277,10 @@ int cmd_pack_objects(int argc, const char **argv=
, const char *prefix)
 			grafts_replace_parents =3D 0;
 			continue;
 		}
+		if (!prefixcmp(arg, "--subtree=3D")) {
+			core_subtree =3D arg + 10;
+			continue;
+		}
 		usage(pack_usage);
 	}
=20
--=20
1.7.1.rc1.69.g24c2f7
