From: Bryan Larsen <bryan@larsen.st>
Subject: CURL_MULTI doesn't work on Mac OS X darwinports
Date: Sun, 18 Feb 2007 15:11:51 -0500
Message-ID: <45D8B307.4070003@larsen.st>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 18 21:11:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIsNG-0002st-Kj
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 21:11:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752006AbXBRULB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Feb 2007 15:11:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752008AbXBRULB
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Feb 2007 15:11:01 -0500
Received: from nz-out-0506.google.com ([64.233.162.224]:1930 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006AbXBRULA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Feb 2007 15:11:00 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1491117nze
        for <git@vger.kernel.org>; Sun, 18 Feb 2007 12:10:59 -0800 (PST)
Received: by 10.64.10.2 with SMTP id 2mr2358632qbj.1171829459366;
        Sun, 18 Feb 2007 12:10:59 -0800 (PST)
Received: from ?192.168.1.91? ( [206.248.190.98])
        by mx.google.com with ESMTP id e18sm1032878qbe.2007.02.18.12.10.58;
        Sun, 18 Feb 2007 12:10:58 -0800 (PST)
User-Agent: Thunderbird 1.5.0.9 (X11/20070103)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40085>

CURL_MULTI causes a segfault on Mac OS X Darwin with MacPorts.  Disable.

From: Bryan Larsen <bryan@larsen.st>
---

  http.h |    2 ++
  1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/http.h b/http.h
index 324fcf4..60100a3 100644
--- a/http.h
+++ b/http.h
@@ -6,10 +6,12 @@
  #include <curl/curl.h>
  #include <curl/easy.h>

+#ifndef __DARWIN_UNIX03
  #if LIBCURL_VERSION_NUM >= 0x070908
  #define USE_CURL_MULTI
  #define DEFAULT_MAX_REQUESTS 5
  #endif
+#endif

  #if LIBCURL_VERSION_NUM < 0x070704
  #define curl_global_cleanup() do { /* nothing */ } while(0)
