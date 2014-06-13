From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 31/32] t2104: make sure split index mode is off for the version test
Date: Fri, 13 Jun 2014 19:19:50 +0700
Message-ID: <1402661991-14977-32-git-send-email-pclouds@gmail.com>
References: <1402661991-14977-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 14:23:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvQVg-000556-0T
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 14:23:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752628AbaFMMXD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jun 2014 08:23:03 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:47055 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752581AbaFMMXB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 08:23:01 -0400
Received: by mail-pa0-f47.google.com with SMTP id fa1so2104927pad.20
        for <git@vger.kernel.org>; Fri, 13 Jun 2014 05:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=X+wiaHNE2IODf14Vvqw8U3x6NZiOwtzRblA9yXNxmcQ=;
        b=GvPcppo6pKsSVXrXyLm5nlmwzuyroYrE1Aa1cyvnNCJbyyWMJi6BYaOGpz5/IwLLBO
         XVTjBniKyx3r8BF2BIpmGUhG5DnPOL2Bd+MmjmLK6l+v4sSxCuU3BHyha0AzQ8EvmuXs
         6I4GYoFL2iub/Q2FAYd9itNYU7OXU8LXQN0WaMlnpAErCyQC4AibV6YGWvdqSiwv3YYj
         LcQ+gLDc7HkXtX1xHxAn5m683TUQKX92f8B0n5dsn89FDgQO//+uMu5ha2myXoVy3IYK
         q9eo231jaXRD70WeROmSLXzcbiU2QKB95LAN9stMudtk/J68K6j0ykIfCKVebdA0pvdq
         IwkA==
X-Received: by 10.66.146.170 with SMTP id td10mr2867453pab.105.1402662181135;
        Fri, 13 Jun 2014 05:23:01 -0700 (PDT)
Received: from lanh ([115.73.228.145])
        by mx.google.com with ESMTPSA id iq10sm3415015pbc.14.2014.06.13.05.22.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jun 2014 05:23:00 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 13 Jun 2014 19:23:01 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1402661991-14977-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251588>

Version tests only make sense when all entries are in the same file,
so we can see if version is downgraded to 2 if 3 is not required.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t2104-update-index-skip-worktree.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/t2104-update-index-skip-worktree.sh b/t/t2104-update-ind=
ex-skip-worktree.sh
index 29c1fb1..cc830da 100755
--- a/t/t2104-update-index-skip-worktree.sh
+++ b/t/t2104-update-index-skip-worktree.sh
@@ -7,6 +7,8 @@ test_description=3D'skip-worktree bit test'
=20
 . ./test-lib.sh
=20
+sane_unset GIT_TEST_SPLIT_INDEX
+
 test_set_index_version 3
=20
 cat >expect.full <<EOF
--=20
1.9.1.346.ga2b5940
