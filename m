From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: [PATCH 2/2] Add rule install-html to install html files to $(html_dir)
Date: Tue, 5 Jun 2007 18:29:25 +0000
Message-ID: <20070605182925.GA8429@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 05 20:29:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hvdmp-0006Tz-69
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 20:29:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755380AbXFES3g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 14:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754628AbXFES3g
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 14:29:36 -0400
Received: from wx-out-0506.google.com ([66.249.82.236]:30987 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755380AbXFES3f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 14:29:35 -0400
Received: by wx-out-0506.google.com with SMTP id t15so1557862wxc
        for <git@vger.kernel.org>; Tue, 05 Jun 2007 11:29:34 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=EuLBVPOat0XIbGxp+WYx2Hhmwnszq3PJgtTIAk2Cx66ExuYw3a+6V+f78B6OthfTx5Efy9N2uI62Ibv6w9YNTX8Duxbh2rJnfASm6sIMCnXLQ2GyNir4E0tdiWDHhXfqRPPhGXLozUmEtc/DVFnjjB0Z9dt5iqafO6uBQNMMp0U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=qUAZUjDOSJ/6aHq/Uv05tsHWrQyyUvh5xRmRrSx7u6lNW6B222vnS/BmwmVOO8MyEBRsQpHLUWEPaFBEzLVCP2S+ZDvCMtziNAbY4N393nSze8Vi3n/AZiIvEiFSN+QYR1JKGRkWn1EPvBNg5fLw5zedUMUSjHL1FnVXbOx4mmk=
Received: by 10.90.63.16 with SMTP id l16mr5422375aga.1181068174760;
        Tue, 05 Jun 2007 11:29:34 -0700 (PDT)
Received: from pclouds@gmail.com ( [66.129.232.2])
        by mx.google.com with ESMTP id 38sm2675761agd.2007.06.05.11.29.34;
        Tue, 05 Jun 2007 11:29:34 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue,  5 Jun 2007 18:29:25 +0000
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49216>


Signed-off-by: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
---

Now you can make install; make -C Documentation install-html
and enjoy git-help --html


 Documentation/Makefile |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 9cef480..7a5e5d3 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -71,6 +71,9 @@ install: man
 	$(INSTALL) -m644 $(DOC_MAN5) $(DESTDIR)$(man5dir)
 	$(INSTALL) -m644 $(DOC_MAN7) $(DESTDIR)$(man7dir)
 
+install-html: html
+	$(INSTALL) -d -m755 $(DESTDIR)$(html_dir)
+	$(INSTALL) -m644 *.html $(DESTDIR)$(html_dir)
 
 ../GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
 	$(MAKE) -C ../ GIT-VERSION-FILE
-- 
1.5.0.7
