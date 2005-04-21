From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: [PATCH] Missing linefeeds
Date: Thu, 21 Apr 2005 22:44:30 +1000 (EST)
Message-ID: <20050421124430.ACDC77F894@smurf.noris.de>
X-From: git-owner@vger.kernel.org Thu Apr 21 14:50:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOb7P-0002Dh-Ew
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 14:49:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbVDUMxj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 08:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbVDUMxj
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 08:53:39 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:7647 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S261340AbVDUMxi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 08:53:38 -0400
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1DObBJ-0004vi-Da
	for git@vger.kernel.org; Thu, 21 Apr 2005 14:53:28 +0200
Received: (nullmailer pid 1136 invoked by uid 501);
	Thu, 21 Apr 2005 12:53:19 -0000
Received: from [150.203.247.5] (helo=smurf.noris.de)
	by server.smurf.noris.de with esmtp (Exim 4.50)
	id 1DOb6J-0004m0-1I
	for smurf@smurf.noris.de; Thu, 21 Apr 2005 14:48:20 +0200
Received: by smurf.noris.de (Postfix, from userid 501)
	id ACDC77F894; Thu, 21 Apr 2005 22:44:30 +1000 (EST)
To: git@vger.kernel.org
X-Smurf-Spam-Score: -1.0 (-)
X-Smurf-Spam-Score: -1.6 (-)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch fixes die() and error() to print linefeeds after the message.

Signed-Off-By: Matthias Urlichs <smurf@smurf.noris.de>

--- 42a073eb6b5bb397a3e8768a032463a7fa02e6b9/usage.c  (mode:100644 sha1:e774d2ef32726af0707d817cdb63fc8751ddc9d8)
+++ 265515f9c4f089b1b61e9d2312c4b3babe189618/usage.c  (mode:100644 sha1:21715d88b1a82aa06a3914e3f0e69fb1b61cc442)
@@ -26,6 +26,7 @@
 	va_start(params, err);
 	report("fatal: ", err, params);
 	va_end(params);
+	fputs("\n", stderr);
 	exit(1);
 }
 
@@ -36,5 +37,6 @@
 	va_start(params, err);
 	report("error: ", err, params);
 	va_end(params);
+	fputs("\n", stderr);
 	return -1;
 }
