From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/2] t1501: avoid bashisms
Date: Sat, 25 Dec 2010 20:57:36 +0700
Message-ID: <1293285457-11915-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michel Briand <michelbriand@free.fr>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 25 14:59:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PWUeF-0006Ft-Kz
	for gcvg-git-2@lo.gmane.org; Sat, 25 Dec 2010 14:59:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356Ab0LYN66 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Dec 2010 08:58:58 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:56100 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171Ab0LYN66 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Dec 2010 08:58:58 -0500
Received: by pwj3 with SMTP id 3so715962pwj.19
        for <git@vger.kernel.org>; Sat, 25 Dec 2010 05:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=neaFjGbk0S31UKAe7Usox4VlvdT7fPWeWlb5wB+TCTM=;
        b=UEZkn9jd+KjJEbcdKjbp9+ya5UecVXHQLcOPf6x+LFBe2ojGqOI6uw7k28p1X9/yhc
         1K/jlhCpsFG5MLR5r+hf5anoqBEsIF+Vl4DcJj2+uvQ3pCIiZXrFGUy5iquIFvhMw5cW
         yarmbv5R8EXor77Pfl374nzif9tSqpL8gMK2c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=BcIz5bIy2hMRcg12q8lbV/ydUAz/K1TqO4ax2iUANR5DCrBfDnpjX/L3AzWc7LwNAy
         v/fMhOk6IzrHP/EvpZOKuXF3geoGGtA5/qKEqQ+29LW3fiLAlbbCwih2J/2/iWh/+M0q
         V4jSSreOCRWZ/8AhSH3baLUUqRk0Q/JOEUWq4=
Received: by 10.143.157.8 with SMTP id j8mr8335641wfo.98.1293285537543;
        Sat, 25 Dec 2010 05:58:57 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.248.124])
        by mx.google.com with ESMTPS id e14sm14114460wfg.20.2010.12.25.05.58.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 25 Dec 2010 05:58:56 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 25 Dec 2010 20:57:37 +0700
X-Mailer: git-send-email 1.7.3.4.878.g439c7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164177>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1501-worktree.sh |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
index 2c8f01f..488160e 100755
--- a/t/t1501-worktree.sh
+++ b/t/t1501-worktree.sh
@@ -322,7 +322,10 @@ test_expect_success 'git grep' '
 test_expect_success 'git commit' '
 	(
 		cd repo.git &&
-		GIT_DIR=3D. GIT_WORK_TREE=3Dwork git commit -a -m done
+		GIT_DIR=3D. &&
+		GIT_WORK_TREE=3Dwork &&
+		export GIT_DIR GIT_WORK_TREE &&
+		git commit -a -m done
 	)
 '
=20
--=20
1.7.3.4.878.g439c7
