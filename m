From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 1/2] Demonstrate rebase fails when the editor saves with
 CR/LF
Date: Sun, 25 Oct 2015 15:10:19 +0100 (CET)
Message-ID: <90f2eabb6968d9b2fe650d67662ec613a86011cb.1445782122.git.johannes.schindelin@gmx.de>
References: <cover.1445777347.git.johannes.schindelin@gmx.de> <cover.1445782122.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Chad Boles <chadbo@microsoft.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Philip Oakley <philipoakley@iee.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 25 15:10:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqM0K-0004iX-7t
	for gcvg-git-2@plane.gmane.org; Sun, 25 Oct 2015 15:10:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752517AbbJYOKX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2015 10:10:23 -0400
Received: from mout.gmx.net ([212.227.17.21]:51515 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751395AbbJYOKV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2015 10:10:21 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx101) with ESMTPSA (Nemesis) id 0MXUmw-1a2v3C0f7W-00WYXH;
 Sun, 25 Oct 2015 15:10:20 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <cover.1445782122.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:NUYr5u98jXRRmR17TGYT86DpspcSunI8i2rbHVb2gqbM8ddeU1K
 NMVzqgeqi57MesclN+bWoG+aReWyEapGORDlS3g2kUeX4CmLE8jFg4g+7Cuuv3cv7i9h/1K
 VH9/IrPX8YxFLFUVAG/JOFQYkYicjw2vapJz9qun8TI97o1ar2z2063Zj9b+zYTer6MLMc0
 y3bFM0XgYwUWc8kvIOuSw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3xiRIWXC9Ik=:wU18DhGN+UwOW7LwjLLpMb
 Yfpj6i/aOBexy6nuSq8xXosnCTFiDN/Iv3SgZExGmI603TzQcnjxYBaLVeRSGKbbJoaNZKUkr
 U9Uuz1qWODsicDOZiAJOTtyNOpcPgKZmzPfBSz7kmzNOfM1YVcSQR3YFA1Woxe9hkWKMU6g6f
 M+bXRzs5IfbXWwYmnDIgMNn86GR/Xods/TxN/tspU5F1rLYwZj7GdVs9V83E9AaWsPxubFf+m
 DzJJQwXO0wKAZ1KlP14M5ERV/zBYHb6OxeUOuLJdjJACzU0qC9ixaolU5PmCm1Zu67DNpo00f
 J4KFAf9pEchp7TxOR4qNbhl+fYN0UWxD6WS17Y5obGVT3GaFvcg4IzLfHoZ4b1P70QM6J73K1
 XN4xIaJC2icmgjZBc66mYz4eCLqDR6C01ARWB15l1AjqytipiYs5pIydYe2ryWU5s0f/fIPhZ
 6kP1WKJV8dVP0BfhjNBlcFNmMe5sf2EiiFB05OsQTODPq52xcfpiU7wGOazsi983QdRnBkolI
 DLjKoEcacVYGl9peavB+nLSfxWAWuXwWShIxa9zpXg/oGW394XFVF2k/yxB4HUlVQUqib0wsT
 BZMFpv43MBWVgCRDKipgooexrpikbreFRsUistyQVKojkZUgAftZR73qL+4ir3UB7Y7Z8KJ+8
 SQITytpMZq7OFeoTBsUcOqKx0FpBC3ioPi2OXD0U6QiL1Oo04QxjWfKyxTXkbx6v1Zr7PRoKS
 LHlbXHH5y+z8l7qiQ8S7XnKRs44XUYE3b2x1eE4ba7LifMxAD0C9YlmNa8TyLvq8+pWmrbRe 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280150>

Based on a bug report by Chad Boles.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3404-rebase-interactive.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 3de0b1d..5dfa16a 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1261,4 +1261,16 @@ test_expect_success 'static check of bad SHA-1' '
 	test E = $(git cat-file commit HEAD | sed -ne \$p)
 '
 
+test_expect_failure 'editor saves as CR/LF' '
+	git checkout -b with-crlf &&
+	write_script add-crs.sh <<-\EOF &&
+	sed -e "s/\$/Q/" <"$1" | tr Q "\\015" >"$1".new &&
+	mv -f "$1".new "$1"
+	EOF
+	(
+		test_set_editor "$(pwd)/add-crs.sh" &&
+		git rebase -i HEAD^
+	)
+'
+
 test_done
-- 
2.1.4
