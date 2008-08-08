From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH] tests: use $TEST_DIRECTORY to refer to the t/ directory
Date: Fri, 8 Aug 2008 16:40:07 +0200
Message-ID: <20080808144007.GA12098@leksak.fem-net>
References: <alpine.DEB.1.00.0808080752210.9611@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.DEB.1.00.0808080754230.9611@pacific.mpi-cbg.de.mpi-cbg.de> <489BF95F.1070000@lsrfire.ath.cx> <7vprojgbbu.fsf@gitster.siamese.dyndns.org> <7vod43etuw.fsf_-_@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0808081232210.9611@pacific.mpi-cbg.de.mpi-cbg.de> <7vmyjndc2c.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 08 16:41:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRT9b-0005PF-GQ
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 16:41:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752092AbYHHOkM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 10:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752082AbYHHOkM
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 10:40:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:55906 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752002AbYHHOkK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 10:40:10 -0400
Received: (qmail invoked by alias); 08 Aug 2008 14:40:08 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp026) with SMTP; 08 Aug 2008 16:40:08 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/jp7RORzfjI17cxeJDppmrapsGc8tBij3XKz7fdT
	LYlQG6qGN+ZMXB
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KRT8R-0005jn-2V; Fri, 08 Aug 2008 16:40:07 +0200
Content-Disposition: inline
In-Reply-To: <7vmyjndc2c.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91674>

Hi,

Junio C Hamano wrote:
> Hint, hint...

I've taken only a short look, and:

	$ GIT_TEST_HTTPD=1 ./t5540-http-push.sh
	* skipping test, web server setup failed
	* passed all 0 test(s)

after the following change, it became:

	$ GIT_TEST_HTTPD=1 ./t5540-http-push.sh
	*   ok 1: setup remote repository
	*   ok 2: clone remote repository
	*   still broken 3: push to remote repository
	*   still broken 4: create and delete remote branch
	* still have 2 known breakage(s)
	* passed all remaining 2 test(s)

Regards.

--snip--

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index dc473df..6ac312b 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -14,7 +14,7 @@ fi
 LIB_HTTPD_PATH=${LIB_HTTPD_PATH-'/usr/sbin/apache2'}
 LIB_HTTPD_PORT=${LIB_HTTPD_PORT-'8111'}
 
-TEST_PATH="$PWD"/../lib-httpd
+TEST_PATH="$TEST_DIRECTORY"/lib-httpd
 HTTPD_ROOT_PATH="$PWD"/httpd
 HTTPD_DOCUMENT_ROOT_PATH=$HTTPD_ROOT_PATH/www
 
-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
