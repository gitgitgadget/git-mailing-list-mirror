From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 01/10] gitweb: Make .error style generic
Date: Sat, 25 Jul 2009 00:44:01 +0200
Message-ID: <1248475450-5668-2-git-send-email-jnareb@gmail.com>
References: <1248475450-5668-1-git-send-email-jnareb@gmail.com>
Cc: Petr Baudis <pasky@suse.cz>, Fredrik Kuivinen <frekui@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Luben Tuikov <ltuikov@yahoo.com>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 25 00:40:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUTRL-0006AU-5p
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 00:40:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754879AbZGXWk1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 18:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754876AbZGXWk1
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 18:40:27 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:65108 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751786AbZGXWk0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 18:40:26 -0400
Received: by fxm18 with SMTP id 18so1686930fxm.37
        for <git@vger.kernel.org>; Fri, 24 Jul 2009 15:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc
         :subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Hq/mSGPJCAWgBSqyRTvDA+WiynWAHLg4Xss9z0AgobE=;
        b=uGieexVyCcbwEsDQNV/G249g0TY9KlAqfuVTMFE7JXUJRI8YBVChYSWWZSvzFaHjgu
         rq/Y5iEQin1QHKWfnY3dDAUJDQg868F4maSUFnN/36WQ5sXQdXXUltVUsmRPoSiiyP6A
         9RMQs3qO2VO7uH/p5ZwpKVp54bYiHCOE/vjqU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=vxYWXfKsDqNWOEQhwEDWTnckanvIPYWYU1pAhy9NmWlhHsp4Fy1teVIFV7Or9u5ZNX
         4DrfJHqUoosAP98OsFNw6Pysz1W4hmDdiMPUZWrmj9gI++KY3B1bs287clf80HqXTB9/
         tNDmBP2jTkWeYJNsB7k+fNx629lpEgZT3mxNk=
Received: by 10.103.247.17 with SMTP id z17mr1994342mur.84.1248475225956;
        Fri, 24 Jul 2009 15:40:25 -0700 (PDT)
Received: from localhost.localdomain (abwq33.neoplus.adsl.tpnet.pl [83.8.240.33])
        by mx.google.com with ESMTPS id e9sm14720324muf.2.2009.07.24.15.40.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Jul 2009 15:40:24 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n6OMjr2I005725;
	Sat, 25 Jul 2009 00:45:58 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n6OMjRqb005713;
	Sat, 25 Jul 2009 00:45:27 +0200
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1248475450-5668-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123958>

Style for td.error was introduced in 1f1ab5f (gitweb: style done with
stylesheet, 2006-06-20) to replace inline style for errors in old
multi-column "git annotate" based 'blame' view.  This view was then
since removed (replaced by "git-blame" based 'blame' view, with fewer
colums), making this style unused.

Make this style more generic by replacing td.error with .error to make
it apply to any element.  It will be used in 'blame_incremental' view
to show error messages.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
It is, as you can see, very simple change.  It makes it easier to
reuse currently "dead" style; unused after removing old git_blame by
Rafael Garcia-Suarez in 3a5b919 (gitweb: remove git_blame and rename
git_blame2 to git_blame, 2008-06-06).

 gitweb/gitweb.css |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index d05bc37..70b7c2f 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -262,7 +262,7 @@ td.sha1 {
 	font-family: monospace;
 }
 
-td.error {
+.error {
 	color: red;
 	background-color: yellow;
 }
-- 
1.6.3.3
