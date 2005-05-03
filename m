From: Alex Riesen <fork0@users.sourceforge.net>
Subject: PATCH: diff-cache.c:51: `return' with a value, in function returning void
Date: Tue, 3 May 2005 21:56:01 +0200
Message-ID: <20050503195601.GA4165@steel.home>
Reply-To: Alex Riesen <fork0@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 21:55:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT3U8-0001Y6-Vv
	for gcvg-git@gmane.org; Tue, 03 May 2005 21:55:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbVECUBV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 16:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261666AbVECUBV
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 16:01:21 -0400
Received: from mx0.valuehost.ru ([217.112.42.6]:26638 "HELO mx0.valuehost.ru")
	by vger.kernel.org with SMTP id S261665AbVECUBO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2005 16:01:14 -0400
Received: (qmail 17174 invoked by uid 89); 4 May 2005 00:01:18 +0400
Received: from unknown (HELO tigra.home) (fork0@delphiplus.org@84.160.253.121)
  by mx0.valuehost.ru with SMTP; 4 May 2005 00:01:18 +0400
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1DT3Uv-0005Kj-00; Tue, 03 May 2005 21:56:01 +0200
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1DT3Uv-00015J-Jd; Tue, 03 May 2005 21:56:01 +0200
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

gcc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>' -o git-diff-cache diff-cache.c libgit.a -lz -lssl
diff-cache.c: In function `show_new_file':
diff-cache.c:51: warning: `return' with a value, in function returning void


--- cogito/diff-cache.c	2005-05-03 21:50:42.000000000 +0200
+++ cogito/diff-cache.c	2005-05-03 21:52:00.000000000 +0200
@@ -48,7 +48,6 @@ static void show_new_file(struct cache_e
 		return;
 
 	show_file("+", new, sha1, mode);
-	return 0;
 }
 
 static int show_modified(struct cache_entry *old, struct cache_entry *new)

