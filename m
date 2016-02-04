From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 1/3] filter-branch: fix style of $((...) construct
Date: Thu, 4 Feb 2016 13:02:00 +0100 (CET)
Message-ID: <98c202fa82ce99367da1d616ca02cc7b48d1e04e.1454587284.git.johannes.schindelin@gmx.de>
References: <cover.1454587284.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Elia Pinto <gitter.spiros@gmail.com>,
	Gabor Bernat <gabor.bernat@gravityrd.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 13:02:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRIc7-0007At-Kv
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 13:02:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756189AbcBDMCQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 07:02:16 -0500
Received: from mout.gmx.net ([212.227.17.22]:55692 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753977AbcBDMCP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 07:02:15 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Lr32V-1ZmzuL2jnH-00eeIH; Thu, 04 Feb 2016 13:02:02
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1454587284.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:WdNTH4fv561LSWfrdkurQFkJMfelz+lZsN9ryozU+PTm1CiXKKK
 NC9c5NzyRWRZDOtm/NYuGOzAvJNXX00sMS9d4pZOwlyI+2MtIBLTbI9ZEsj99aKXVx+txsn
 smhQYMMc0bDEGXIwz5zvynfEnPCEZgTjfZuz7mz02Gi0Zka9kjE7HIdi+2Fn43ByB+wVU4c
 Sfb2IzoWymeg7R0CB3BhQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ma1C4y03QRw=:sBjrT+2dyDG6BnaZ4sOvXm
 xyKSR7plJdIoNIVMmIDVB8Hdnxs46EtgYjT2uZIedz9H6ax5963MObIZFViC8XBR8L1Z7epL5
 1p/ov3tQSahJg/J7F94vD3gRImh9gRW2atXwlW+audLkA6Qgs1ppis+QcW6rrjSwBrVRAEHZ2
 7ybuuhxZeDng0K+lEWya+IjpPV4rezNpvAtVH+E88cZlKy2KNTwtLhlGO0dqru51w2K17dTlA
 rMJxpI2KCB+XmwD0rQsSC5NdCJda4e8S9jJk0TrSN/7GVoT+9oCyY8nnsqb2295IEGxNmKNcl
 3NGpL1g2Rp9Ei7BWDCkGw3FAcR0SMwgLEIrsUtgLVFD0Oda7Qi3Q+OIFyyGdF0YittbA7SmDy
 X5NraAYKt6C0B3Wlj0NDXVVSLfKLSUft7EKaglHwqPdDu3LqVLQRBjx2fLAd9TjGt5rkNhidd
 HXGKZ6azZQa2rO/wH5H8XkZHbxiSDBfj8N1mwTua/oDuRl7tpmuiywwvJP664XLjyukWU/cH2
 zSqohAytOTz2G/sVBefGr+5bYyKGWHJf3mkYfTm9k272kLbawRrgm/E/AyYXPVizPdfkWbpkX
 3svm8c4BkS0zMAwijYfqbFiv06uleqWDKw/Y9EjW+kYXlz9WqmRGy1T9I9ibCqNew1Tvi5ugo
 XmEhvpBB6TNiwEh4COHZOGGIl5LWw160VNvwhg4ueX8LiowF8kCd1td4IH5J64/ud47YzUhC+
 x6BHXW5u23PQAzyJspSHa8LkRhfz43xptIGPlbXqQDYZuvre0hGdqRzVUOKPxC+isIGhEieQ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 6a9d16a (filter-branch: add passed/remaining seconds on progress,
2015-09-07) we introduced a new style to write $((...) expressions: with
spaces in the arithmetic expression. We actually introduced *two* new
styles, even: some of the $((...)) expressions had spaces after the two
opening and before the two closing parentheses, but others did not.

There had been an arithmetic expression in that script, though, and it
matched the coding style of the rest of Git's source code: $((...))
expressions simply do not contain spaces.

Let's adjust the style to the previously existing code.

Cc: Gabor Bernat <gabor.bernat@gravityrd.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-filter-branch.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 86b2ff1..1067785 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -283,13 +283,13 @@ report_progress ()
 		count=$git_filter_branch__commit_count
 
 		now=$(date +%s)
-		elapsed=$(($now - $start_timestamp))
-		remaining=$(( ($commits - $count) * $elapsed / $count ))
+		elapsed=$(($now-$start_timestamp))
+		remaining=$((($commits-$count)*$elapsed/$count))
 		if test $elapsed -gt 0
 		then
-			next_sample_at=$(( ($elapsed + 1) * $count / $elapsed ))
+			next_sample_at=$((($elapsed+1)*$count/$elapsed))
 		else
-			next_sample_at=$(($next_sample_at + 1))
+			next_sample_at=$(($next_sample_at+1))
 		fi
 		progress=" ($elapsed seconds passed, remaining $remaining predicted)"
 	fi
-- 
2.7.0.windows.1.7.g55a05c8
