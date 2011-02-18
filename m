From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 7/3] Move test-sha1.sh to test-programs/
Date: Thu, 17 Feb 2011 22:52:29 -0600
Message-ID: <20110218045229.GH15643@elie>
References: <7vmxm4onwk.fsf@alter.siamese.dyndns.org>
 <1297304069-14764-1-git-send-email-pclouds@gmail.com>
 <20110218022701.GA23435@elie>
 <AANLkTik8wUrUnjTiUxUZbg3paaQEc7UERQ6J6jUzA2u5@mail.gmail.com>
 <20110218045139.GG15643@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 18 05:52:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqIKc-0001xD-V3
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 05:52:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755134Ab1BREwf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 23:52:35 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43401 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751888Ab1BREwd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 23:52:33 -0500
Received: by iyj8 with SMTP id 8so3128751iyj.19
        for <git@vger.kernel.org>; Thu, 17 Feb 2011 20:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=VzZL/zzgFBTf0J3nkCbUTdFmyp/5TvoQdIBEFcHUXyU=;
        b=LOnJLGugPwG8a19UYCx+QBmYqXsAIbzsZzGvEOtkn0UcgIFhegMpqNsHCoRkIjIE9w
         blotPq1gmBagTg6qokKWvLEw6E6brFtOk9t3JVzEpfBTzUJ2alxepgfYl688sPqMP3qB
         iUGGKCTBoKEHMSaVyziWruXA0KZtg14DsX/2o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Yy/doTsWk0sp8FHzL+z24bDwV8zLtrETuxF0+7uBQlQzT9R8WPP729XeqXEaRgn7KA
         c1cKJJAdeHm4tNj8C4H/SpAovuURBu6RahOLvlSYiL9HlMOK7cVWS8/tWf63EU8+uMvc
         K4L/hTpeGDc4fYiKl6om1c8B3YC0KGkk6tsO4=
Received: by 10.42.164.201 with SMTP id h9mr343822icy.283.1298004753106;
        Thu, 17 Feb 2011 20:52:33 -0800 (PST)
Received: from elie (adsl-69-209-72-148.dsl.chcgil.sbcglobal.net [69.209.72.148])
        by mx.google.com with ESMTPS id d21sm1349550ibg.15.2011.02.17.20.52.31
        (version=SSLv3 cipher=OTHER);
        Thu, 17 Feb 2011 20:52:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110218045139.GG15643@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167172>

Probably it should go in t/ as a new test but I am lazy.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile                                   |    2 +-
 test-sha1.sh => test-programs/test-sha1.sh |    0
 2 files changed, 1 insertions(+), 1 deletions(-)
 rename test-sha1.sh => test-programs/test-sha1.sh (100%)

diff --git a/Makefile b/Makefile
index 9ce9ccd..61981e5 100644
--- a/Makefile
+++ b/Makefile
@@ -2149,7 +2149,7 @@ test-%$X: test-programs/test-%.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(filter %.a,$^) $(LIBS)
 
 check-sha1:: test-sha1$X
-	./test-sha1.sh
+	test-programs/test-sha1.sh
 
 check: common-cmds.h
 	if sparse; \
diff --git a/test-sha1.sh b/test-programs/test-sha1.sh
similarity index 100%
rename from test-sha1.sh
rename to test-programs/test-sha1.sh
-- 
1.7.4.1
