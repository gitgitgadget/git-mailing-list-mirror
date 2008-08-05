From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] perl/Makefile: handle paths with spaces in the NO_PERL_MAKEMAKER
 section
Date: Tue, 05 Aug 2008 18:23:08 -0500
Message-ID: <osgPH47FO7h-zLUMqwCv-i9BWln2-_AK5T6TI-5mLGFjwAhJ4Bg_lw@cipher.nrlssc.navy.mil>
References: <mLu74vNKfH1vFZlC7N_lRX3WekWReoVjWY42voUDUBUnAGVpDNYWndWqlaHoqVAkxOaCdYV6uDk@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 01:24:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQVtI-0006iN-S6
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 01:24:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757300AbYHEXX3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2008 19:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756259AbYHEXX3
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 19:23:29 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:59825 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756054AbYHEXX3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2008 19:23:29 -0400
Received: by mail.nrlssc.navy.mil id m75NN9pr028211; Tue, 5 Aug 2008 18:23:09 -0500
In-Reply-To: <mLu74vNKfH1vFZlC7N_lRX3WekWReoVjWY42voUDUBUnAGVpDNYWndWqlaHoqVAkxOaCdYV6uDk@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 05 Aug 2008 23:23:08.0896 (UTC) FILETIME=[38988E00:01C8F752]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91470>

Use double quotes to protect against paths which may contain spaces.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 perl/Makefile |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/perl/Makefile b/perl/Makefile
index b8547db..e3dd1a5 100644
--- a/perl/Makefile
+++ b/perl/Makefile
@@ -29,11 +29,11 @@ $(makfile): ../GIT-CFLAGS Makefile
 	'$(PERL_PATH_SQ)' -MError -e 'exit($$Error::VERSION < 0.15009)' || \
 	echo '	cp private-Error.pm blib/lib/Error.pm' >> $@
 	echo install: >> $@
-	echo '	mkdir -p $(instdir_SQ)' >> $@
-	echo '	$(RM) $(instdir_SQ)/Git.pm; cp Git.pm $(instdir_SQ)' >> $@
-	echo '	$(RM) $(instdir_SQ)/Error.pm' >> $@
+	echo '	mkdir -p "$(instdir_SQ)"' >> $@
+	echo '	$(RM) "$(instdir_SQ)/Git.pm"; cp Git.pm "$(instdir_SQ)"' >> $@
+	echo '	$(RM) "$(instdir_SQ)/Error.pm"' >> $@
 	'$(PERL_PATH_SQ)' -MError -e 'exit($$Error::VERSION < 0.15009)' || \
-	echo '	cp private-Error.pm $(instdir_SQ)/Error.pm' >> $@
+	echo '	cp private-Error.pm "$(instdir_SQ)/Error.pm"' >> $@
 	echo instlibdir: >> $@
 	echo '	echo $(instdir_SQ)' >> $@
 else
-- 
1.6.0.rc1.87.g56c9f.dirty
