From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 31/32] t2104: make sure split index mode is off for the version test
Date: Mon, 28 Apr 2014 17:55:52 +0700
Message-ID: <1398682553-11634-32-git-send-email-pclouds@gmail.com>
References: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 12:57:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WejFh-0004Ju-67
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 12:57:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbaD1K5W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2014 06:57:22 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:38447 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932070AbaD1K5S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 06:57:18 -0400
Received: by mail-pd0-f182.google.com with SMTP id v10so1322281pde.27
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 03:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=X+wiaHNE2IODf14Vvqw8U3x6NZiOwtzRblA9yXNxmcQ=;
        b=hTqrOXalHa4UF56ndv0hFqF9t1IQLozM2E8dClOVIMQSDJkjjQtAyQRxnIa5CoRau0
         w7A3rx6KRl1g13TcEpi/Ts2vg4rcXvBOApJoHYkzcjiNdW3qDuPv8ABVqCzoFVIK0oiG
         l/Z8sUTeHlDsbi4QGWDvWmkWhRuYekvsY3CffL5BmUfktAww1vEHRBdCYoWBTQwrHuLT
         5NVicCnQKaFSHsuME6sVKdy2IjhqHmQsB+sAbFA7J5ruUcK34ni+mW4hmDA+ls7tSyZB
         zPwj5EsU4sulcsTaDUYPNwLkkLKmOswYNmEQezBT6k6FuNJGWYTdchkEjCVsXzE0hFzV
         Mr0Q==
X-Received: by 10.68.196.226 with SMTP id ip2mr28059615pbc.106.1398682638270;
        Mon, 28 Apr 2014 03:57:18 -0700 (PDT)
Received: from lanh ([115.73.231.31])
        by mx.google.com with ESMTPSA id di3sm34249771pbc.11.2014.04.28.03.57.14
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 03:57:16 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 28 Apr 2014 17:58:45 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247294>

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
