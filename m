From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH] Fix linking with OpenSSL
Date: Fri, 5 May 2006 02:25:50 +0400
Message-ID: <20060504222550.GA7236@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri May 05 00:27:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbmIO-0006xX-7m
	for gcvg-git@gmane.org; Fri, 05 May 2006 00:27:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519AbWEDW1h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 May 2006 18:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751517AbWEDW1h
	(ORCPT <rfc822;git-outgoing>); Thu, 4 May 2006 18:27:37 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:8163 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750817AbWEDW1h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 May 2006 18:27:37 -0400
Received: by nf-out-0910.google.com with SMTP id b2so465037nfe
        for <git@vger.kernel.org>; Thu, 04 May 2006 15:27:35 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=gXBQzltnCoz+trITxX/2VSXHkhNevnAXtEqg8iqvdcVc8kRIdejYVDwWmfpkXD/i49fHQFaLxsG+P1sS6tqpu/bDu2dvK2Pnm59OSCgWiosw3/KCCNSkMk9+E6Hye6FHN/ZzIYmfRd7RFiBV2Mvplt8Sp7awQQR6vtbIkbHOJLk=
Received: by 10.49.80.7 with SMTP id h7mr1176065nfl;
        Thu, 04 May 2006 15:27:35 -0700 (PDT)
Received: from gmail.com ( [217.10.38.130])
        by mx.gmail.com with ESMTP id o9sm947142nfa.2006.05.04.15.27.34;
        Thu, 04 May 2006 15:27:35 -0700 (PDT)
Received: by gmail.com (nbSMTP-1.00) for uid 1000
	(using TLSv1/SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	adobriyan@gmail.com; Fri,  5 May 2006 02:25:52 +0400 (MSD)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19579>

For those who put it into interesting (read: default) place.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

--- a/Makefile
+++ b/Makefile
@@ -559,7 +559,7 @@ git-http-push$X: revision.o http.o http-
 
 git-rev-list$X: rev-list.o $(LIB_FILE)
 	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
-		$(LIBS) $(OPENSSL_LIBSSL)
+		$(LIBS) $(OPENSSL_LINK) $(OPENSSL_LIBSSL)
 
 init-db.o: init-db.c
 	$(CC) -c $(ALL_CFLAGS) \
