From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 2/2] Add a regression test for 'git remote add <existing>
 <same-url>'
Date: Mon, 22 Dec 2014 18:06:54 +0100 (CET)
Message-ID: <05b1bc322b77418442d504402132a244216a4e3c.1419267895.git.johannes.schindelin@gmx.de>
References: <20141216021900.50095.24877@random.io> <cover.1419267895.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: anapsix@random.io, git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Dec 22 18:07:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y36Rv-0003sU-Sp
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 18:07:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755467AbaLVRHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 12:07:05 -0500
Received: from mout.gmx.net ([212.227.15.19]:49680 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755451AbaLVRHB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 12:07:01 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0MNq8p-1XxKkf2TBD-007XJe;
 Mon, 22 Dec 2014 18:06:54 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <cover.1419267895.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:8yEjCnuBlaPX3rOX6EMr8P1QY0WNlvvjvejEo32P3IT5zhxDeUg
 6ze83gy22Yvw8xKZbZ77BxOFvZ6jM5s+8hDbn9zYSEYosxSVgSV2p8OgAGfMlcXsAMrlUwY
 MhyRIVX1DmMnAjk+lCoyM8uJCOfSJb5UYX/xnZW6wAlpgKIJA67zitZJxh3wEJNTjui+E63
 hXlxCWQzX663OKkSrik4w==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261652>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5505-remote.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index ac79dd9..17c6330 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -1113,4 +1113,9 @@ test_extra_arg set-url origin newurl oldurl
 # prune takes any number of args
 # update takes any number of args
 
+test_expect_success 'add remote matching the "insteadOf" URL' '
+	git config url.xyz@example.com.insteadOf backup &&
+	git remote add backup xyz@example.com
+'
+
 test_done
-- 
2.0.0.rc3.9669.g840d1f9
