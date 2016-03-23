From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 02/21] t1430: clean up broken refs/tags/shadow
Date: Wed, 23 Mar 2016 11:04:19 +0100
Message-ID: <64ee96b13ea182ef851c809d4abd1fc292bd12b2.1458723959.git.mhagger@alum.mit.edu>
References: <cover.1458723959.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 11:14:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aifmG-0000gX-PX
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 11:12:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754662AbcCWKMX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 06:12:23 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:49377 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752037AbcCWKMV (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2016 06:12:21 -0400
X-AuditID: 1207440c-98bff700000008b4-9b-56f26a42310d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id E7.D9.02228.24A62F65; Wed, 23 Mar 2016 06:04:50 -0400 (EDT)
Received: from michael.fritz.box (p548D66C6.dip0.t-ipconnect.de [84.141.102.198])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u2NA4g17018017
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 23 Mar 2016 06:04:49 -0400
X-Mailer: git-send-email 2.8.0.rc3
In-Reply-To: <cover.1458723959.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsUixO6iqOuU9SnM4PZpaYuuK91MFg29V5gt
	bq+Yz2zRPeUto8WPlh5mi5lXrR3YPP6+/8DksXPWXXaPZ717GD0uXlL22L90G5vH501yAWxR
	3DZJiSVlwZnpefp2CdwZuz80sRQ8Y624enUNewPjB5YuRk4OCQETiVf/X7F2MXJxCAlsZZR4
	1XYByjnJJLHn+yJmkCo2AV2JRT3NTCC2iICaxMS2QywgRcwCCxglNi5eDFTEwSEsYCexYFUm
	SA2LgKrE9odfwOp5BaIkPn5ZzQSxTUliw4MLYDangIXEyZNLGUFsIQFzie0P1jJNYORZwMiw
	ilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXUC83s0QvNaV0EyMknHh2MH5bJ3OIUYCDUYmHV+LM
	xzAh1sSy4srcQ4ySHExKorzngz6FCfEl5adUZiQWZ8QXleakFh9ilOBgVhLhbc4EyvGmJFZW
	pRblw6SkOViUxHlVl6j7CQmkJ5akZqemFqQWwWRlODiUJHjbQRoFi1LTUyvSMnNKENJMHJwg
	w7mkRIpT81JSixJLSzLiQTEQXwyMApAUD9DeVrC9xQWJuUBRiNZTjLocC37cXsskxJKXn5cq
	Jc7rDVIkAFKUUZoHtwKWPF4xigN9LMy7EqSKB5h44Ca9AlrCBLRkoQ/YkpJEhJRUA6OaT+CT
	joQJivoF7SyPnz8W5e7a0XFGrdXy0FO7rpJJYrU828Q9p/fHSvR0epusWssgz3L4988ls/rf
	G5zR+5/MUiZuJd/07O0ejWM7TvUKRzsWz39vxVpod6xq9u3NAXF35C4kzliwPlLj 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289616>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t1430-bad-ref-name.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
index 005e2b1..cb815ab 100755
--- a/t/t1430-bad-ref-name.sh
+++ b/t/t1430-bad-ref-name.sh
@@ -148,7 +148,7 @@ test_expect_success 'rev-parse skips symref pointing to broken name' '
 	git branch shadow one &&
 	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
 	git symbolic-ref refs/tags/shadow refs/heads/broken...ref &&
-
+	test_when_finished "rm -f .git/refs/tags/shadow" &&
 	git rev-parse --verify one >expect &&
 	git rev-parse --verify shadow >actual 2>err &&
 	test_cmp expect actual &&
-- 
2.8.0.rc3
