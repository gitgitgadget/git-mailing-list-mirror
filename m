From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 06/12] Makefile: transport.o depends on branch.h now
Date: Tue, 26 Jan 2010 09:47:25 -0600
Message-ID: <20100126154725.GG4895@progeny.tock>
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
X-From: git-owner@vger.kernel.org Tue Jan 26 16:47:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZnde-0001kp-Bu
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 16:47:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754572Ab0AZPr3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 10:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754569Ab0AZPr3
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 10:47:29 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:53880 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754526Ab0AZPr3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 10:47:29 -0500
Received: by yxe17 with SMTP id 17so3733956yxe.33
        for <git@vger.kernel.org>; Tue, 26 Jan 2010 07:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=XS5SIrWJkUMN2LAXHbyVjtHMq8oGB5zs8XLtODhk5pM=;
        b=VJsOFT6ZhAsIo7WCdcJdiLw9KYGlj9LSc2g0S3XzOOQsZF6scLqgN1eVis6M01ibm4
         pyR4VFwo7rQetaw3kZ0oRglxBQxYR5d6DHyP29uJ7slpam929WYMyLHStAAiZwlePwfo
         expqVk6nA7yWhuWFGI6AdyO0IpH1sKl4x/gS8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=XBiPG8Vta46RrNRTOjKN+WAWL++mmZkUNeVNRwAFtEihE9yHud3SRw1W83couyhZFN
         P72Z8VYq4YrHX7Zddgw84SOkqdAgkqCBXNn9zcmqNasLOSV9/UaWS6Ci8lbkgxB2l7AX
         JRF8yi8M4M8LuCwVdK1wOwYeVco8E3NTKg71Q=
Received: by 10.150.81.5 with SMTP id e5mr265179ybb.158.1264520844170;
        Tue, 26 Jan 2010 07:47:24 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 34sm2057206yxf.11.2010.01.26.07.47.23
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 26 Jan 2010 07:47:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100126154357.GA4895@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138047>

Since commit e9fcd1e2 (Add push --set-upstream, 2010-01-16),
transport.c uses branch.h.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 59a46e2..5678991 100644
--- a/Makefile
+++ b/Makefile
@@ -1719,7 +1719,7 @@ $(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o $(GITLIBS)
 
 $(LIB_OBJS) $(BUILTIN_OBJS): $(LIB_H)
 $(patsubst git-%$X,%.o,$(PROGRAMS)) $(TEST_OBJS) git.o: $(LIB_H)
-builtin-branch.o builtin-checkout.o builtin-clone.o builtin-reset.o branch.o: branch.h
+builtin-branch.o builtin-checkout.o builtin-clone.o builtin-reset.o branch.o transport.o: branch.h
 builtin-bundle.o bundle.o transport.o: bundle.h
 builtin-bisect--helper.o builtin-rev-list.o bisect.o: bisect.h
 builtin-clone.o builtin-fetch-pack.o transport.o: fetch-pack.h
-- 
1.6.6
