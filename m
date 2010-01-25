From: Greg Price <price@MIT.EDU>
Subject: [PATCH 5/6] t/lib-rebase.sh: pass through ref commands
Date: Sun, 24 Jan 2010 21:26:25 -0500
Message-ID: <f4dd1c56260f7fe4750779769ecc349e206b0f01.1309133817.git.greg@quora.com>
References: <cover.1309133817.git.greg@quora.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 27 02:42:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QazuP-0006H7-TB
	for gcvg-git-2@lo.gmane.org; Mon, 27 Jun 2011 02:42:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755314Ab1F0AkG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jun 2011 20:40:06 -0400
Received: from DMZ-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.37]:44236 "EHLO
	dmz-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755406Ab1F0AkC (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jun 2011 20:40:02 -0400
X-AuditID: 12074425-b7b82ae000000a2a-74-4e07d00b001c
Received: from mailhub-auth-1.mit.edu ( [18.9.21.35])
	by dmz-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 0B.01.02602.B00D70E4; Sun, 26 Jun 2011 20:34:19 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-1.mit.edu (8.13.8/8.9.2) with ESMTP id p5R0YtJb003495;
	Sun, 26 Jun 2011 20:34:55 -0400
Received: from localhost (DR-WILY.MIT.EDU [18.181.0.233])
	(authenticated bits=0)
        (User authenticated as price@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id p5R0YsZw019043;
	Sun, 26 Jun 2011 20:34:54 -0400 (EDT)
In-Reply-To: <cover.1309133817.git.greg@quora.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixCmqrMt9gd3P4OVKSYuuK91MFg29V5gd
	mDwuXlL2+LxJLoApissmJTUnsyy1SN8ugStj7vUfzAV/mCtu7pnC3sA4kbmLkZNDQsBE4nfz
	Y1YIW0ziwr31bCC2kMA+RokHJ7y6GLmA7A2MEpdmLmCBcL4wSix49oUJokpd4mbbIUYIW0di
	W/N0dgjbSuLyg9/MELahxJOjd8DivAIhEnfmLwMaxMHBKWAk8bJRAabk/oUmsMVsAgoSP+av
	A2sVEVCTmNh2iAXEZhYQl1g39zzYGBYBVYmpR66BxYUF7CU2tx9jnMAouICRYRWjbEpulW5u
	YmZOcWqybnFyYl5eapGuhV5uZoleakrpJkZQyLG7qO5gnHBI6RCjAAejEg/vwwR2PyHWxLLi
	ytxDjJIcTEqivKLngUJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeN+FAeV4UxIrq1KL8mFS0hws
	SuK8Id7/fYUE0hNLUrNTUwtSi2CyMhwcShK8QSBDBYtS01Mr0jJzShDSTBycIMN5gIaHgtTw
	Fhck5hZnpkPkTzEqSonzZoIkBEASGaV5cL2wlPCKURzoFWHeNpAqHmA6get+BTSYCWhw32U2
	kMEliQgpqQZGpplTpugtCxA4XfpJuCvv2rb6OfYyzAsOhz+65iLFrsG6vV0x1Xdy09a1T9+9
	dHvCrZgkUdz69uzDikXxC09yXPy2PoCl1rb6h+CBrltv7i2+ylGi3X4k61T59fyzS8q339ef
	xaxvvphFc5eo3eN5F1pz2nLPs++4ujTmYMyq6etZjvbcLYxxUGIpzkg01GIuKk4E 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176344>

Signed-off-by: Greg Price <price@mit.edu>
---
 t/lib-rebase.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index 6ccf797..656e4b6 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -54,7 +54,7 @@ for line in $FAKE_LINES; do
 	">")
 		echo >> "$1";;
 	*)
-		sed -n "${line}s/^pick/$action/p" < "$1".tmp >> "$1"
+		sed -n "${line}{s/^pick/$action/p; /^ref/p}" < "$1".tmp >> "$1"
 		action=pick;;
 	esac
 done
-- 
1.7.5.4
