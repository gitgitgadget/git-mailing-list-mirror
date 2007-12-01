From: Pascal Obry <pascal.obry@gmail.com>
Subject: [PATCH] Set OLD_ICONV on Cygwin.
Date: Sat,  1 Dec 2007 10:49:22 +0100
Message-ID: <1196502562-1052-1-git-send-email-pascal@obry.net>
Cc: Pascal Obry <pascal@obry.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 01 10:49:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyOyv-0002TL-Jr
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 10:49:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbXLAJtb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2007 04:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbXLAJtb
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Dec 2007 04:49:31 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:17446 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059AbXLAJt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2007 04:49:29 -0500
Received: by nf-out-0910.google.com with SMTP id g13so2405759nfb
        for <git@vger.kernel.org>; Sat, 01 Dec 2007 01:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:cc:subject:date:message-id:x-mailer:from;
        bh=d8dcAl4Inwb1NZQLp0pFFuUUCnNqFR1DbdFvicU26l8=;
        b=WxPc+CheLA0p+jlV9u6FyJyKruSJFlFNnPiYqZpLbgX5bbdorjoEqA//4tswlN8nTnRnXSj3dvarrUhU6jA4z5gSsXJkueSG5bw+eghExEgplmqZfW8stppYyPO6ElX4Fn6H3UfbYDvQP2z0VKBbFH4Ju8rMbfTdeV4CLz/i940=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:to:cc:subject:date:message-id:x-mailer:from;
        b=LWUEd3IvFBqYAYHiO5Wmkuqgq2pLYbmRyBfUSqR9oG78/zgfZqtYvrL80ny8vorgC74s9wwfVyuwaRErw3NOJmeGg9FiGtYZP+kaWnR/rmgN2QnHHV5gPX4u5i3O7DhtfQv9bGzc6dALw3FEQvHgrkYAFpxFMqRjtl6T3zwYl4A=
Received: by 10.78.81.20 with SMTP id e20mr3913686hub.1196502568022;
        Sat, 01 Dec 2007 01:49:28 -0800 (PST)
Received: from pascal.obry@gmail.com ( [82.124.248.33])
        by mx.google.com with ESMTPS id g1sm19390339muf.2007.12.01.01.49.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 01 Dec 2007 01:49:27 -0800 (PST)
Received: by pascal.obry@gmail.com (sSMTP sendmail emulation); Sat, 01 Dec 2007 10:49:22 +0100
X-Mailer: git-send-email 1.5.3.6.985.g65c6a4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66708>

Cygwin still has old definition for the iconv() second
parameter. This patch fixes the last warning on Cygwin.
This has been tested with Cygwin 1.5.24.

Signed-off-by: Pascal Obry <pascal@obry.net>
---
 Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index e869b85..fa3398c 100644
--- a/Makefile
+++ b/Makefile
@@ -446,6 +446,7 @@ ifeq ($(uname_O),Cygwin)
 	NEEDS_LIBICONV = YesPlease
 	NO_FAST_WORKING_DIRECTORY = UnfortunatelyYes
 	NO_TRUSTABLE_FILEMODE = UnfortunatelyYes
+	OLD_ICONV = UnfortunatelyYes
 	# There are conflicting reports about this.
 	# On some boxes NO_MMAP is needed, and not so elsewhere.
 	# Try commenting this out if you suspect MMAP is more efficient
-- 
1.5.3.6.985.g65c6a4
