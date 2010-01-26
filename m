From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 05/12] Makefile: drop dependency on $(wildcard */*.h)
Date: Tue, 26 Jan 2010 09:46:59 -0600
Message-ID: <20100126154659.GF4895@progeny.tock>
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
X-From: git-owner@vger.kernel.org Tue Jan 26 16:47:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZndL-0001dc-LL
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 16:47:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754560Ab0AZPrK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 10:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754526Ab0AZPrJ
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 10:47:09 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:58340 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754194Ab0AZPrF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 10:47:05 -0500
Received: by ywh6 with SMTP id 6so4134685ywh.4
        for <git@vger.kernel.org>; Tue, 26 Jan 2010 07:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=xzYXVg68VhAgE4lpy6JSR0Zq2Oko5o68oW3MDyEhe6A=;
        b=W1kpWeSEhGmkGbLCgb6+UB76E9/sKya6Z0yGKy6SNk6h+cC3y7Yez3WOI9gUqF65F5
         eHolrNwyQ/1MiFk37Go7PMuf7DA1V765hxtoeZF7Nr0Amar3xi9xBfJ1os7rCEsgmYmx
         NfZ+FQ5EN7/5PYw0ar0n5WA5vLcSguywpiYcE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=TD57VIi7e57nj4oDcggXsPMqp+mjK8xrS1w4hDx4Ml1GBi5PzKwu+APO4hWNGuh/+L
         SZW2e9q6QgzIuzbSmirG26Sm573iIZ/hN5URAIQ4BiHBQad/Qn/XbXnr3FT2CanDyHfo
         z8uxDcd3uv2Ro2ziBCl9/zbFiYbzsxo38cL+o=
Received: by 10.150.55.37 with SMTP id d37mr10717668yba.38.1264520818000;
        Tue, 26 Jan 2010 07:46:58 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 8sm2061882yxg.24.2010.01.26.07.46.56
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 26 Jan 2010 07:46:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100126154357.GA4895@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138046>

The files this pulls in are already pulled in by other dependency
rules (some recently added).

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 593801a..98810b2 100644
--- a/Makefile
+++ b/Makefile
@@ -1655,7 +1655,7 @@ git-remote-curl$X: remote-curl.o http.o http-walker.o $(GITLIBS)
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
 $(LIB_OBJS) $(BUILTIN_OBJS): $(LIB_H)
-$(patsubst git-%$X,%.o,$(PROGRAMS)) $(TEST_OBJS) git.o: $(LIB_H) $(wildcard */*.h)
+$(patsubst git-%$X,%.o,$(PROGRAMS)) $(TEST_OBJS) git.o: $(LIB_H)
 builtin-branch.o builtin-checkout.o builtin-clone.o builtin-reset.o branch.o: branch.h
 builtin-bundle.o bundle.o transport.o: bundle.h
 builtin-bisect--helper.o builtin-rev-list.o bisect.o: bisect.h
-- 
1.6.6
