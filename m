From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: [PATCH] clarify -M without % symbol in diff-options
Date: Tue, 18 Dec 2012 09:45:21 +0530
Message-ID: <20121218041521.GA11616@sita-lt.atc.tcs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 18 05:16:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tkob4-0007kW-Dv
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 05:16:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753052Ab2LREPi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 23:15:38 -0500
Received: from mail-pb0-f42.google.com ([209.85.160.42]:36079 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752839Ab2LREPh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 23:15:37 -0500
X-Greylist: delayed 16395 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Dec 2012 23:15:37 EST
Received: by mail-pb0-f42.google.com with SMTP id rp2so117652pbb.29
        for <git@vger.kernel.org>; Mon, 17 Dec 2012 20:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        bh=POoc63SzPbdgs4CFowljJly2tINcGnXbVX+BCNIdA6I=;
        b=Dc/RyoQh3t4PdF2r1Jdvazk361YjFxqKsT9aU+7yvhjiDdpE3TeTADyi+KCuBgX8fP
         ssn2JEo0NGgyXTEo4lmp0GYrJGfc7sjQdLVXDbolFdZu28s7zelK6+b8ddCbzKgHDs6K
         Gw7QKIFiOaZHkoUVCfcKe+TMEXriKXrF1ceDX9dE3g97L0fuJv8o7mXred/Ax7a21mAC
         ae/NWO8BFcTWdPcFbBCWyiF0rafVPHt0Rq8Nxhr1EU1nMSqD4WL/4qyoQBv8iGVXTttj
         9Nbr7mokn97eKQZU0gI/8f99jhjEioRu5mpiIPIyPMisCRiY1LeOcppU+VQLgv8cXWNA
         tpaA==
X-Received: by 10.66.77.99 with SMTP id r3mr2945867paw.10.1355804136614;
        Mon, 17 Dec 2012 20:15:36 -0800 (PST)
Received: from sita-lt.atc.tcs.com (atcmail.atc.tcs.co.in. [203.200.212.145])
        by mx.google.com with ESMTPS id j1sm638736pax.10.2012.12.17.20.15.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 17 Dec 2012 20:15:35 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211734>

---
 Documentation/diff-options.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index f4f7e25..39f2c50 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -309,7 +309,11 @@ endif::git-log[]
 	index (i.e. amount of addition/deletions compared to the
 	file's size). For example, `-M90%` means git should consider a
 	delete/add pair to be a rename if more than 90% of the file
-	hasn't changed.
+	hasn't changed.  Without a `%` sign, the number is to be read as
+	a fraction, with a decimal point before it.  I.e., `-M5` becomes
+	0.5, and is thus the same as `-M50%`.  Similarly, `-M05` is
+	the same as `-M5%`.  To limit detection to exact renames, use
+	`-M100%`.
 
 -C[<n>]::
 --find-copies[=<n>]::
-- 
1.7.11.7
