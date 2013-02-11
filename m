From: Matt Kraai <kraai@ftbfs.org>
Subject: [PATCH] Include xmlparse.h instead of expat.h on QNX
Date: Mon, 11 Feb 2013 12:59:55 -0800
Message-ID: <1360616395-18912-1-git-send-email-kraai@ftbfs.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matt Kraai <matt.kraai@amo.abbott.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 11 22:01:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U50VF-00082C-A1
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 22:01:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514Ab3BKVA6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 16:00:58 -0500
Received: from kvm.ftbfs.org ([46.22.115.26]:57385 "EHLO kvm.ftbfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932510Ab3BKVA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 16:00:57 -0500
Received: from kraai by kvm.ftbfs.org with local (Exim 4.72)
	(envelope-from <kraai@ftbfs.org>)
	id 1U50Ug-0004vi-Mw; Mon, 11 Feb 2013 13:00:54 -0800
X-Mailer: git-send-email 1.7.2.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216087>

From: Matt Kraai <matt.kraai@amo.abbott.com>

QNX 6.3.2 through 6.5.0 include Expat 1.1, which provides xmlparse.h
instead of expat.h, so include the former on QNX systems.

Signed-off-by: Matt Kraai <matt.kraai@amo.abbott.com>
---
 http-push.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/http-push.c b/http-push.c
index 9923441..55c575e 100644
--- a/http-push.c
+++ b/http-push.c
@@ -11,7 +11,11 @@
 #include "list-objects.h"
 #include "sigchain.h"
 
+#ifndef __QNX__
 #include <expat.h>
+#else
+#include <xmlparse.h>
+#endif
 
 static const char http_push_usage[] =
 "git http-push [--all] [--dry-run] [--force] [--verbose] <remote> [<head>...]\n";
-- 
1.8.1.2.547.g7ce9def
