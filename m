From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 4/6] explain expected exit code
Date: Wed,  4 Jan 2012 16:55:37 +0100
Message-ID: <1325692539-26748-5-git-send-email-drizzd@aon.at>
References: <7v8vlovavj.fsf@alter.siamese.dyndns.org>
 <1325692539-26748-1-git-send-email-drizzd@aon.at>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 04 17:04:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiTK3-0001tT-8W
	for gcvg-git-2@lo.gmane.org; Wed, 04 Jan 2012 17:04:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756195Ab2ADQEK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jan 2012 11:04:10 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:8356 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755462Ab2ADQEE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jan 2012 11:04:04 -0500
Received: from localhost (unknown [80.123.242.182])
	by bsmtp.bon.at (Postfix) with ESMTP id 8E50CCDF95;
	Wed,  4 Jan 2012 17:04:56 +0100 (CET)
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1325692539-26748-1-git-send-email-drizzd@aon.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187926>

---
 t/lib-daemon.sh |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/t/lib-daemon.sh b/t/lib-daemon.sh
index 5edced5..4701124 100644
--- a/t/lib-daemon.sh
+++ b/t/lib-daemon.sh
@@ -62,6 +62,10 @@ stop_daemon() {
 	kill_children "$DAEMON_PID"
 	wait "$DAEMON_PID"
 	ret=$?
+	#
+	# We signal TERM=15 to the child and expect the parent to
+	# exit with 143 = 128+15.
+	#
 	if test $ret -ne 143
 	then
 		error "git daemon exited with status: $ret"
-- 
1.7.8
