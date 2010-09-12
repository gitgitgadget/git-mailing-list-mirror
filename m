From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] Makefile: add CC to TRACK_CFLAGS
Date: Sun, 12 Sep 2010 22:37:45 +0000
Message-ID: <1284331065-3394-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 13 00:38:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OuvBp-0000Dm-2n
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 00:38:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754083Ab0ILWiN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Sep 2010 18:38:13 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40554 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753892Ab0ILWhx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Sep 2010 18:37:53 -0400
Received: by wyf22 with SMTP id 22so5465842wyf.19
        for <git@vger.kernel.org>; Sun, 12 Sep 2010 15:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=s9waxt6AIPiXi2gsmmIGBjNrJkbAeQH7c7NssWlPZxI=;
        b=ENNCjblkMuXwrG5bK3vceXkDRHqc3lvBvgCtMT97jq220C6YI+w9a8uuwOy3bbS9Z+
         gsBPS5g9NyFOisADOYRlYmJeTiuKfU6CBoEwzqlsCN5LBYeiV+XbiiF8852oa3t+mmRL
         K4xcwZDrR4K65sCdJkBefFzCXJ6iCfBGJFwug=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=i4FBBiWVygtZqQrH/wz8q9mL0KFZcN4qAs8XIgbhIEsJUEkUdxeYGUgJjXLOsk1y/6
         KvpsyEtIGnqEFjzduugkOKVlw3KF3ZGkfdg6zFD4ywEVBF+JT/JLa2FBqdNyzyvMp/sM
         ogX2hYz+N052YhqYflveRa3r6kycyN/cMUoiw=
Received: by 10.227.146.213 with SMTP id i21mr886860wbv.99.1284331071805;
        Sun, 12 Sep 2010 15:37:51 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e31sm4607450wbe.23.2010.09.12.15.37.50
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 12 Sep 2010 15:37:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156061>

Change the git make process so that everything's rebuilt if the CC is
changed. Before we wouldn't rebuilt if e.g. the CC variable was
changed from gcc to clang.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index c27e8bc..c46893a 100644
--- a/Makefile
+++ b/Makefile
@@ -1969,7 +1969,7 @@ cscope:
 	$(FIND) . -name '*.[hcS]' -print | xargs cscope -b
=20
 ### Detect prefix changes
-TRACK_CFLAGS =3D $(subst ','\'',$(ALL_CFLAGS)):\
+TRACK_CFLAGS =3D $(CC):$(subst ','\'',$(ALL_CFLAGS)):\
              $(bindir_SQ):$(gitexecdir_SQ):$(template_dir_SQ):$(prefix=
_SQ)
=20
 GIT-CFLAGS: FORCE
--=20
1.7.2.3.313.gcd15
