From: Dennis Stosberg <dennis@stosberg.net>
Subject: [PATCH] Fix t8001-annotate and t8002-blame for ActiveState Perl
Date: Mon, 19 Jun 2006 21:40:37 +0200
Message-ID: <20060619194037.G41ac8efa@leonov.stosberg.net>
References: <20060618203321.G2e8b0080@leonov.stosberg.net> <7v3be218ri.fsf@assigned-by-dhcp.cox.net> <81b0412b0606190935g67581ebucf172acb36e53b02@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 19 21:41:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsPcE-0006r3-8C
	for gcvg-git@gmane.org; Mon, 19 Jun 2006 21:40:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbWFSTkp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Jun 2006 15:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964866AbWFSTko
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jun 2006 15:40:44 -0400
Received: from ncs.stosberg.net ([89.110.145.104]:40913 "EHLO ncs.stosberg.net")
	by vger.kernel.org with ESMTP id S964865AbWFSTko (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jun 2006 15:40:44 -0400
Received: from leonov.stosberg.net (p213.54.81.28.tisdip.tiscali.de [213.54.81.28])
	by ncs.stosberg.net (Postfix) with ESMTP id 92D33590C04C;
	Mon, 19 Jun 2006 21:40:30 +0200 (CEST)
Received: by leonov.stosberg.net (Postfix, from userid 500)
	id 3DF8510D415; Mon, 19 Jun 2006 21:40:38 +0200 (CEST)
To: Alex Riesen <raa.lkml@gmail.com>
Content-Disposition: inline
In-Reply-To: <81b0412b0606190935g67581ebucf172acb36e53b02@mail.gmail.com>
OpenPGP: id=1B2F2863BA13A814C3B133DACC2811F494951CAB; url=http://stosberg.net/dennis.asc
User-Agent: mutt-ng/devel-r802 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22134>

There seems to be at least one implementation of Perl which requires the
user to specify an extension for backup files.

Reported by Alex Riesen.

Signed-off-by: Dennis Stosberg <dennis@stosberg.net>
---

What system and what version of ActivePerl do you use?  I have just
tried ActivePerl 5.8.8 on Solaris and it does _not_ force the user
to make backups.

 t/annotate-tests.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index c04f0e1..03ed081 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -111,7 +111,7 @@ test_expect_success \
 
 test_expect_success \
     'some edit' \
-    'perl -pi -e "s/^1A.*\n$//; s/^3A/99/" file &&
+    'perl -p -i.orig -e "s/^1A.*\n$//; s/^3A/99/" file &&
     GIT_AUTHOR_NAME="D" git commit -a -m "edit"'
 
 test_expect_success \
-- 
1.4.0
