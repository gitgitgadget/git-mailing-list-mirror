From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 5/5] Makefile: drop dependency on $(wildcard */*.h)
Date: Sat, 23 Jan 2010 08:45:52 -0600
Message-ID: <20100123144552.GF11903@progeny.tock>
References: <20100123144201.GA11903@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 23 15:45:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYhFK-0002Y2-GI
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 15:45:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755552Ab0AWOpt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 09:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755541Ab0AWOpt
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 09:45:49 -0500
Received: from mail-iw0-f186.google.com ([209.85.223.186]:38148 "EHLO
	mail-iw0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753765Ab0AWOps (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 09:45:48 -0500
Received: by iwn16 with SMTP id 16so927454iwn.33
        for <git@vger.kernel.org>; Sat, 23 Jan 2010 06:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=C8EiwuXc+uKWp5cMHTEjBUFGitse0tX8hJ7E/p27QNo=;
        b=VhqPw4mpJYh5yJGScOj4VAzlJxct1yzo5pj5NewKdkWgAZTCw+VaqsSAhyMH92rwJl
         2W+ALlWTozJBVCwiEndD6a7TdK8B/WhRNAG42TN+R8eTfY1Ti5hQhXDce40T6jLaV5yy
         BeTaUdGSm/61/ciJOfrbp5yIOzKHISKL0Xrps=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ff2jWG/fBiVgGIUT/PNwXZXRZ02+4MSVleL18edBjlttOgKwICAYag7RSlqmb+Y2zp
         aPBw5lmzJSZQuTBHDcwAwDaUwwDXUi/lnqWCN79Aw8tqmbaDWdkBAkmPQ5k9rQSPPUCP
         VxbooSPQk0qRBHrLLBhNa2PHgTa6w4mzX+dSA=
Received: by 10.231.170.136 with SMTP id d8mr3414935ibz.17.1264257948320;
        Sat, 23 Jan 2010 06:45:48 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm2828808iwn.3.2010.01.23.06.45.47
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 23 Jan 2010 06:45:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100123144201.GA11903@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137847>

The files this pulls in are already pulled in by other dependency
rules (some recently added).

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index eb225c6..d6ebc9d 100644
--- a/Makefile
+++ b/Makefile
@@ -1655,7 +1655,7 @@ git-remote-curl$X: remote-curl.o http.o http-walker.o $(GITLIBS)
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
 $(LIB_OBJS) $(BUILTIN_OBJS) $(TEST_OBJS): $(LIB_H)
-$(patsubst git-%$X,%.o,$(PROGRAMS)) git.o: $(LIB_H) $(wildcard */*.h)
+$(patsubst git-%$X,%.o,$(PROGRAMS)) git.o: $(LIB_H)
 builtin-branch.o builtin-checkout.o builtin-clone.o builtin-reset.o branch.o: branch.h
 builtin-bundle.o bundle.o transport.o: bundle.h
 builtin-bisect--helper.o builtin-rev-list.o bisect.o: bisect.h
-- 
1.6.6.rc2
