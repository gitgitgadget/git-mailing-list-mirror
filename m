From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 2/2] sh-setup: explicitly mark CR as a field separator
Date: Sun, 25 Oct 2015 15:10:25 +0100 (CET)
Message-ID: <2b089201404299257f23b3931499ea16202f0f65.1445782122.git.johannes.schindelin@gmx.de>
References: <cover.1445777347.git.johannes.schindelin@gmx.de> <cover.1445782122.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Chad Boles <chadbo@microsoft.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Philip Oakley <philipoakley@iee.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 25 15:10:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqM0S-0004wS-RI
	for gcvg-git-2@plane.gmane.org; Sun, 25 Oct 2015 15:10:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752526AbbJYOKd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2015 10:10:33 -0400
Received: from mout.gmx.net ([212.227.15.19]:50410 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752509AbbJYOKb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2015 10:10:31 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx001) with ESMTPSA (Nemesis) id 0MbfnB-1a742Z38kP-00J5g7;
 Sun, 25 Oct 2015 15:10:26 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <cover.1445782122.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:w7v6/gRlwxLoNi9ulPOsuivf3IkwBpb1LGqzXMe2DtxCvl5BoOm
 Dm3sCAjO0LwoHHsSGxqyeSemoZ7pNBllr6i2xaai1iUY7ypsuOVnm/WI8SPe4e36+JvRJQk
 DRhh/GFz3D7QgVYPRdSD5mwLwUNxJtx1H3u49VODK9QI4d8UYWVa/Tcrg5FgtTvA5bNH+PA
 Y2SP40miUyLzjR8j1ZeJQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5FIqXm45sxI=:qtrLj3YHPivsIE5Q8Ot5K2
 d14ShWxB5UoC1v2xbrMcM3pm2Wl4hLKVHn2w64uGBuiq0Zn1vrPTcQJjiuWazHtB35yRbl41I
 6qlfAKmPmP+lRVULiJebjpr/6/JjxwHi5timAHJ4u33mhQBLkC1Rk7+MyQtvJFXLZMI6XVp5F
 6N96SutiTfYDGy7oUv4kgdWMZQsQp0RIFkTRpfwBDkVlegzbgtimZ08vhweiarv4wnk0RwB5K
 8bGgQwp26VxgtHyRXQ9HOw5Ucj0ZdFr4yH1mlmlr91l+0h3ElAvNwI/lAuKOZImGbiN7a6fMR
 980JLt9wL5W1HPcFgqkwotkaX0gA+BsaTUofjgHfzdp9geutpSoRcnl+dHMQrJDjIy4rQcx5S
 BsHiNlcI2SA/Gp+bNxBzajHW8+mkMSw0V4OEhdI+p510WIMTDofMRo6OPZn92FyC28xmO8iaS
 HyVrRM2KJjWJJ9aQtnpd4yDy9N6r1i5szhjIdZiqQCONK46pPqS2+beQonpaknfo4/zmYSU4C
 mt6/xn++43EaZZ7SoN49Iq392F6YwUlw3EbQhC3S+GwndpEAGDzlPWnYR85qOfvZrT3L8M4/d
 MfQdu2I55TntMZFqniAQTiFvpFtJl+rq/yRhc32mAzEeJgdBV0nw0G/92ocKdISsyO35v6780
 9lXw3IARC2TW/177SoEoHgUz+Ab1ysPuur+GfQOoWk9GyokStB03luX12fMdQnH6Fh02DDLjf
 RxePV+eU2cMadMheO7qOal80Nzo++swu7sPV30Jn7/oX3s7zG5+5d6xxqlNS2OwbGDKp3xf0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280152>

This is the correct thing to do, really: we already specify LF as
field separator.

Incidentally, this fixes the problem interactive rebase has when the
editor wants to save text with CR/LF line endings, as WordPad does
in Windows 10.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-sh-setup.sh               | 4 ++--
 t/t3404-rebase-interactive.sh | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 4691fbc..e34673d 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -11,9 +11,9 @@ unset CDPATH
 
 # Similarly for IFS, but some shells (e.g. FreeBSD 7.2) are buggy and
 # do not equate an unset IFS with IFS with the default, so here is
-# an explicit SP HT LF.
+# an explicit SP HT LF CR.
 IFS=' 	
-'
+'"$(printf '\r')"
 
 git_broken_path_fix () {
 	case ":$PATH:" in
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 5dfa16a..98eb49a 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1261,7 +1261,7 @@ test_expect_success 'static check of bad SHA-1' '
 	test E = $(git cat-file commit HEAD | sed -ne \$p)
 '
 
-test_expect_failure 'editor saves as CR/LF' '
+test_expect_success 'editor saves as CR/LF' '
 	git checkout -b with-crlf &&
 	write_script add-crs.sh <<-\EOF &&
 	sed -e "s/\$/Q/" <"$1" | tr Q "\\015" >"$1".new &&
-- 
2.1.4
