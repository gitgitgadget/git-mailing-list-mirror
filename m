From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/4] Makefile: do not clean arm directory
Date: Sat, 28 Nov 2009 05:41:28 -0600
Message-ID: <20091128114128.GE10059@progeny.tock>
References: <20091128112546.GA10059@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 28 12:29:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NELUV-0003cI-5Z
	for gcvg-git-2@lo.gmane.org; Sat, 28 Nov 2009 12:29:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753621AbZK1L3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Nov 2009 06:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751937AbZK1L3M
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Nov 2009 06:29:12 -0500
Received: from mail-yx0-f188.google.com ([209.85.210.188]:54211 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812AbZK1L3L (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Nov 2009 06:29:11 -0500
Received: by yxe26 with SMTP id 26so1867009yxe.4
        for <git@vger.kernel.org>; Sat, 28 Nov 2009 03:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=cf3QSCyUCKPTdY56AphJ7bCQ0rrZ5Lby+pbQgBTYfmg=;
        b=pD6XL0B6j/8cZyGsRqgd3NJv7i0MD7dQC5/Y7bwh4ruoFEbobyV36f6MTzlzwT8W3o
         dVzSnsGojsiBLvYkVd1ENnyoHPuo27kMeZjg61rNpVKct3fMSfs6jCP2Tda+LkGI3o9J
         I/GfF7HDhW1okEDEp3sxbS9jGXRzQrvOBMrVI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=tSagOKadmbXZc+1/5fJuyeWuIiwX1mebbC0kbZ3hYhNHSA/GMZhdKJ4thDmxyz5qoV
         vLqDjkTp+U5mO0Hbka9KwzacFMCpH5lgXu+6FKTR47ccE7x0OJK5ArbfvKAie4L7Wo9p
         whO0ENM0qdl0RPTUS30Zmi5uhnrerpB+0zpy0=
Received: by 10.150.71.31 with SMTP id t31mr3412525yba.18.1259407757732;
        Sat, 28 Nov 2009 03:29:17 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 16sm231419gxk.7.2009.11.28.03.29.16
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 28 Nov 2009 03:29:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091128112546.GA10059@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133954>

The ARM SHA-1 implementation was removed by commit 30ae47b
(remove ARM and Mozilla SHA1 implementations, 2009-08-17).  Prune
its directory from the list of object files to delete in 'make
clean'.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
One could argue that this should be left in, to allow 'make
clean' to clean up after the old version in an upgrade.  But that
way lies long rules for clean that never get tested for their
intended purpose.

 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index cd210e3..47e1412 100644
--- a/Makefile
+++ b/Makefile
@@ -1833,7 +1833,7 @@ distclean: clean
 	$(RM) configure
 
 clean:
-	$(RM) *.o block-sha1/*.o arm/*.o ppc/*.o compat/*.o compat/*/*.o xdiff/*.o \
+	$(RM) *.o block-sha1/*.o ppc/*.o compat/*.o compat/*/*.o xdiff/*.o \
 		$(LIB_FILE) $(XDIFF_LIB)
 	$(RM) $(ALL_PROGRAMS) $(BUILT_INS) git$X
 	$(RM) $(TEST_PROGRAMS)
-- 
1.6.5.3
