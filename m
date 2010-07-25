From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] git-read-tree.txt: acknowledge the directory matching bug in sparse checkout
Date: Sun, 25 Jul 2010 16:30:32 +0700
Message-ID: <1280050232-22230-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 25 14:27:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Od0IE-0006Ji-S2
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 14:26:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752957Ab0GYM0x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jul 2010 08:26:53 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:33004 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752684Ab0GYM0w (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 08:26:52 -0400
Received: by pzk26 with SMTP id 26so697325pzk.19
        for <git@vger.kernel.org>; Sun, 25 Jul 2010 05:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=Xp6p2zJpVlZO/vVYFQvgxO9lt/UtrZ401Dsw/vPzxYw=;
        b=eMrHnHlGPslVuaJXXAAbUG30VvucmbGS1qw/s+BakjyWxb43cxsNGEDkUX3lbOIDKW
         eng1HXFH2ixBJWupcbvFvSk7iXYlap4UIOjkdKiPWZE/6KqUEGRJykFFt0FOb9GtkakD
         BYAVPMOzQ38qIr3P4yl3nghYpQ+gFJWEAd50g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=oYQ/T+D2sQ5ZsKW02a/JvZFkCUTNE/ThiEqZOm9hv3QrKIdbsdw9kQQoGxYhGYCFlp
         fwJA1NWWhWlczIdYnt+4cND1rWzDuSNWvXZ0WP505XlIecc60b04zTh8+l8u5XK2r2+7
         LBE6RZL43/WA2Rsa4MBZKzLjgf7FNt7s42Kt8=
Received: by 10.142.171.9 with SMTP id t9mr7283530wfe.318.1280060812495;
        Sun, 25 Jul 2010 05:26:52 -0700 (PDT)
Received: from dektop ([121.91.36.254])
        by mx.google.com with ESMTPS id c16sm2797113rvn.1.2010.07.25.05.26.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Jul 2010 05:26:52 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Sun, 25 Jul 2010 16:30:42 +0700
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151735>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-read-tree.txt |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-t=
ree.txt
index f6037c4..2e78da4 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -412,6 +412,13 @@ turn `core.sparseCheckout` on in order to have spa=
rse checkout
 support.
=20
=20
+BUGS
+----
+In order to match a directory with $GIT_DIR/info/sparse-checkout,
+trailing slash must be used. The form without trailing slash, while
+works with .gitignore, does not work with sparse checkout.
+
+
 SEE ALSO
 --------
 linkgit:git-write-tree[1]; linkgit:git-ls-files[1];
--=20
1.7.1.rc1.69.g24c2f7
