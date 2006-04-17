From: "Serge E. Hallyn" <serue@us.ibm.com>
Subject: [PATCH 4/7] cleanups: Remove impossible case in quote.c
Date: Mon, 17 Apr 2006 10:14:48 -0500 (CDT)
Message-ID: <20060417151448.0EE0F19B911@sergelap.hallyn.com>
References: <20060417145148.2F3CB19C90D@sergelap.hallyn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Apr 17 17:15:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVVRJ-0006b0-QZ
	for gcvg-git@gmane.org; Mon, 17 Apr 2006 17:14:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbWDQPOw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Apr 2006 11:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWDQPOv
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Apr 2006 11:14:51 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:56232 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751090AbWDQPOt
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Apr 2006 11:14:49 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e31.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k3HFEnqC024293
	for <git@vger.kernel.org>; Mon, 17 Apr 2006 11:14:49 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k3HFIBb9184510
	for <git@vger.kernel.org>; Mon, 17 Apr 2006 09:18:11 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k3HFEmre019195
	for <git@vger.kernel.org>; Mon, 17 Apr 2006 09:14:48 -0600
Received: from sergelap.hallyn.com ([9.49.218.134])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id k3HFEmho019162
	for <git@vger.kernel.org>; Mon, 17 Apr 2006 09:14:48 -0600
Received: by sergelap.hallyn.com (Postfix, from userid 1000)
	id 0EE0F19B911; Mon, 17 Apr 2006 10:14:48 -0500 (CDT)
To: git@vger.kernel.org
Content-Disposition: inline
X-Mutt-Fcc: =SENT
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18827>

The switch is inside an if statement which is false if
the character is ' '.  Either the if should be <=' '
instead of <' ', or the case should be removed as it could
be misleading.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>

---

 quote.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

86bdfea7f2e88ed01869f370574420a6de3359d7
diff --git a/quote.c b/quote.c
index 7218a70..06792d4 100644
--- a/quote.c
+++ b/quote.c
@@ -144,8 +144,6 @@ static int quote_c_style_counted(const c
 
 			case '\\': /* fallthru */
 			case '"': EMITQ(); break;
-			case ' ':
-				break;
 			default:
 				/* octal */
 				EMITQ();
-- 
1.2.5
