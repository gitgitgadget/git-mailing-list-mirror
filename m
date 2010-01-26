From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 04/12] Makefile: clean up http-walker.o dependency rules
Date: Tue, 26 Jan 2010 09:46:37 -0600
Message-ID: <20100126154637.GE4895@progeny.tock>
References: <20100123144201.GA11903@progeny.tock>
 <7v3a1u6bfz.fsf@alter.siamese.dyndns.org>
 <20100126154357.GA4895@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 26 16:46:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZncu-0001Sa-7v
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 16:46:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754559Ab0AZPql (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 10:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754526Ab0AZPql
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 10:46:41 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:53998 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753129Ab0AZPqk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 10:46:40 -0500
Received: by mail-yx0-f187.google.com with SMTP id 17so3732834yxe.33
        for <git@vger.kernel.org>; Tue, 26 Jan 2010 07:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=AfGmVJt73LR31lKFFXF1GVa+BWb23rx2CDo3bMpd9Bc=;
        b=qpQhnH9WZD8AywCJFC54gy1pBLOmPMwWWr/B1P0pu1nPu8rgx9gG3aD6oVeKRfTSvz
         RHGV6BLy/zJkXko/c9HD2n1bLxoIWf0PAwq3BK/R8QGdukSVOWmecEysMVniVdPeoY4i
         qPK5JxrLtufRtOLUuifgMcDvZWGutJHLrhH3U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=BL56wCfbAc/CuJZpD4qwBbZodPmcrvT7KZvDAZuKXPy2lElYQMa5finIZQoujzpstd
         M0JPL1umnnxurDsCOPZmfNqw1IP5LklWaDWIqj+ZQmKFa08dZ733aNDV7SQP9mHx4/fx
         SiPTwpqIuNIxDGoHFB9Pk67fOWOW7EqZJDDMU=
Received: by 10.91.27.2 with SMTP id e2mr1339949agj.32.1264520795610;
        Tue, 26 Jan 2010 07:46:35 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 4sm2073385yxd.34.2010.01.26.07.46.34
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 26 Jan 2010 07:46:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100126154357.GA4895@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138045>

http-walker.o depends on http.h twice: once in the rule listing
files that use http.h, and again in the rule explaining how to
build it.  Messy.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 8cf6383..593801a 100644
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
1.6.6
