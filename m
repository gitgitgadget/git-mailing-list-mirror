From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v4 1/2] Demonstrate rebase fails when the editor saves with
 CR/LF
Date: Wed, 28 Oct 2015 15:54:21 +0100 (CET)
Message-ID: <3d37a1348065d5902c829481db2124a52be0ca1a.1446043983.git.johannes.schindelin@gmx.de>
References: <cover.1445939154.git.johannes.schindelin@gmx.de> <cover.1446043983.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Chad Boles <chadbo@microsoft.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Philip Oakley <philipoakley@iee.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 15:54:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrS7j-0006wS-QE
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 15:54:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755977AbbJ1Oym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 10:54:42 -0400
Received: from mout.gmx.net ([212.227.15.19]:55741 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751280AbbJ1Oyk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 10:54:40 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx002) with ESMTPSA (Nemesis) id 0MJSLz-1ZuUFh1ubz-0033bR;
 Wed, 28 Oct 2015 15:54:22 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <cover.1446043983.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:aSLxheYKGDy/y1C/Sq05dUYI61xVmr7vEc7Vs6z4xkusJl8VVlI
 ha4hzGBaUe3Lc7oApjbV01LesvhEprYS3BGoBP0YleHF0EavxMoZsB7yYKy5FaI6ZfUtRu9
 XnB/C3Fgu70lhvnr9fH7t+4uIZMDxHwQ1agqLvljrizsDqUuF1CwoERX59qJcOHCcA36dHk
 L37jYDprDd9BdySgK24VA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:muAvacG/P6A=:NbS0GdTdCkNvZj2q36s95m
 UYu8nu91poWjuVjBw6669pAIX0XRcxvGa7Li7LVfLOXPp4SoIIcY2rJBZCtotH/MpucJAmhCE
 FzZMNmHNT24xCbBN3c2kP+NvlpSeou75dCFo/n/YEpq6IILkJ5IBkIgqJj/REt9wP0Ov6t658
 z1pSlBMkZB1qMR0rbdXZuAGn7iCEZxGuv9e7fI3NB7yZIFXmhcKAVfwuWOnVgajb0TK2Zlr57
 XRv3II65Dc6vEbTnLfoamS6GvtBtUijN7r7ZuvoNYlcCAEFBYbINSq4SVM+lno7qLx5v0WVwH
 2TsmJZfeafn7O07YCaSH9n2IxaoJ/iLn0YaEMIg5/fGGPB3ExAZrWorONSSrwu/VeJNIOFYkt
 RzP2ZzKNnmCRvJLrf4iCPSuUBtgFcyVCqN6HZHd6cnlXaXV88TmTjSLvrP4nWyd5pExu2k11Y
 WNfZL62Okiy7HgOr362oPnPbCGslcgE2JEK3X1VSmVcFPosXrj+BfyORZ6qrSKAg8SzL3zSI0
 ct8uoSGS9ldQDSSqiIHjCbMfQkS6VyQ1yFX/N1Dz9+YPGMpAEMKRdQ1JP3425P1x78c9Jk1CP
 guP8bWOR6BrzRzmbsDs34nERVJM4pvrQspHrEC8dDy9Nl2f42Qov/Sqk6MKmcaue2gsDzHlu9
 mEHFsMb8brzsxxWJ8y6dEgtSihjFPsDLoxpIWvr7pMG2IjHosLJEyJ6Wbd5CcGTsPsP1aY7t2
 5kphcSB732MRxk8ETOQsKPZ3tnY6OgbICd3+DXGITNdAmNIxkzfM9JDCdNl4yEmsVLnr3Adj 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280368>

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
