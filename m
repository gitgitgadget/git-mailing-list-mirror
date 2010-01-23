From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/5] Makefile: clean up http-walker.o dependency rules
Date: Sat, 23 Jan 2010 08:45:11 -0600
Message-ID: <20100123144510.GE11903@progeny.tock>
References: <20100123144201.GA11903@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 23 15:45:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYhEf-0002Fj-QI
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 15:45:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755526Ab0AWOpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 09:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755441Ab0AWOpI
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 09:45:08 -0500
Received: from mail-iw0-f186.google.com ([209.85.223.186]:45694 "EHLO
	mail-iw0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755437Ab0AWOpH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 09:45:07 -0500
Received: by mail-iw0-f186.google.com with SMTP id 16so927041iwn.33
        for <git@vger.kernel.org>; Sat, 23 Jan 2010 06:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=yXsdnLj/9iXda4rTPH0kvWYPc/KCW6tL2vlq3ev4i8s=;
        b=J0id6IyVwYefQMbnYfC7aAXEU3j5RLVax11Dh8hCxBW5sBD3+h6aGJ0rwnWIWKvMZk
         krBlbQLlxkimM0O6oxDAItuG84WGKK9YJzvQIQSr6ySz9+7FC2W3lUI2YngMkQCrjakl
         FpoGhBrUl1y0YijlUUvt2c3hqcpdr+Jh73Eyo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=wyp5DxbJfWW734LKGsF2s2N6/tdbzUjTGH1JcMxHZPkFKGwnAoBuhkDqnoTQi1ols9
         u40XzOwiBdIetC9l6wxyzX1UhPpZEoxbSPOXW9S4iqOWf6iXMmcavpWAfnW9i22GwJ0v
         4sllYM+R4gJjCcFx77bxiOggnydI3+0NVpYRY=
Received: by 10.231.147.149 with SMTP id l21mr323545ibv.0.1264257907270;
        Sat, 23 Jan 2010 06:45:07 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm2814793iwn.8.2010.01.23.06.45.06
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 23 Jan 2010 06:45:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100123144201.GA11903@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137846>

http-walker.o depends on http.h twice: once in the rule listing
files that use http.h, and again in the rule explaining how to
build it.  Messy.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 7da52a3..eb225c6 100644
--- a/Makefile
+++ b/Makefile
@@ -1628,7 +1628,7 @@ http.o: http.c GIT-CFLAGS
 	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) -DGIT_USER_AGENT='"git/$(GIT_VERSION)"' $<
 
 ifdef NO_EXPAT
-http-walker.o: http-walker.c http.h GIT-CFLAGS
+http-walker.o: http-walker.c GIT-CFLAGS
 	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) -DNO_EXPAT $<
 endif
 
-- 
1.6.6.rc2
