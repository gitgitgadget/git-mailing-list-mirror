From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 1/2] Demonstrate rebase fails when the editor saves with
 CR/LF
Date: Tue, 27 Oct 2015 10:47:16 +0100 (CET)
Message-ID: <3d37a1348065d5902c829481db2124a52be0ca1a.1445939154.git.johannes.schindelin@gmx.de>
References: <cover.1445782122.git.johannes.schindelin@gmx.de> <cover.1445939154.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Chad Boles <chadbo@microsoft.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Philip Oakley <philipoakley@iee.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 10:47:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zr0r5-0000ow-8P
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 10:47:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754076AbbJ0Jrn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 05:47:43 -0400
Received: from mout.gmx.net ([212.227.17.20]:60483 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752920AbbJ0Jrm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 05:47:42 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx101) with ESMTPSA (Nemesis) id 0MKLeM-1ZpMx8410Y-001fg6;
 Tue, 27 Oct 2015 10:47:17 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <cover.1445939154.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:eIwic3CX8sGDA775bMTQWmFvPbd2Xxftif7RzwwjQPukGhaBFd3
 JtnPA9xrnxlQWLYSj2qdgEWQmqofqMWIiHO6FNq7tOgXfNaYRMswo8vLK70BXzG1tqfN2rp
 GkYzWIYFHwihWSVycn41hqf2NxnbnrvvvAV9OAjrZgfda8g0k53afDcO1t5G31g3N08h/h7
 rkNpHfHC3PsbUXTGItbVA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0o09txhnOxk=:duMdgAqj4efaQM26PWM4aF
 qR1+aGs/Xa16LPgxpJTwcdHkrDe00mAt/1X6dcmgEwBDcz5mCgvLe718ASc9ah/e6AcY1cxED
 9d3YVv/uHgvVHAVZajbJV9qzdrLRY0b//zdThqkSc05JTIWv84yYOsRmhXKcUKqtx0AicbQZR
 O8KF546i9D8FCiOBRIEbpKMsg8WoIl9PoMjpNQbys65sTIMNkd8oJg7KlAC/6b6bQBCQWm2zN
 mQTS6J0xVUoquSxZbt8cXF41CFIpLD3rvc8b/VCYc9CW50FMNOAKhjYaYC31Xiojl8OjvRlSP
 +0WVlK3VcqRdgI0FjnqRQBj3lDX7GnCq8u7yRWB/fE187aa6BZqwIFmTXBHOa8S5/8ZyY516k
 VEreGI01i8GWlXiJjyBO3TSn3S7TcskDo4kfYaS3Swnl7rN7KJYxRoIpaF93WdomIuw43mgEf
 9Aamfy6d1STbSiPbqoIl82EGi6y9eMN39jPG3jEwgZfL6N/K0JM2lDccEonC9K6f+Nps82xNE
 ZZI0bC3r1iX/CrH5BQxUGQgug+g7XrUPJxGp1lJ9Pzqw6itib97uuS7oTTSFQh2c0QyZ/gkMC
 Lx9TeBnt7O1Be5ji91swR3Ecb/j1yA3Vu2dDDMefASJVfSO5Do1UAC52ybtkeaHnPjHpp5nm0
 Kx332/asjlxtXnW/QuFur0dMtgdH62JBCFXABf1zkkujLpD9+IP44CiiB6F3jMhSjCEAH/VNP
 EOh+tZVLs1r+voINyHyQIKqF22V9tyDol3IpZH/cj1bl0QPHSamErgPnHvi+3ZewHs8me+XO 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280254>

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
