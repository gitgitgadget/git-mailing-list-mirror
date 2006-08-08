From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/4] autoconf: Error out on --without-shell and --without-perl
Date: Tue, 8 Aug 2006 18:36:21 +0200
Message-ID: <200608081836.21614.jnareb@gmail.com>
References: <200608081834.09271.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Aug 08 18:36:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAUYz-0002mT-KH
	for gcvg-git@gmane.org; Tue, 08 Aug 2006 18:36:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030191AbWHHQgN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Aug 2006 12:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030192AbWHHQgN
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Aug 2006 12:36:13 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:18806 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030191AbWHHQgN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Aug 2006 12:36:13 -0400
Received: by nf-out-0910.google.com with SMTP id q29so224148nfc
        for <git@vger.kernel.org>; Tue, 08 Aug 2006 09:36:11 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=OQ679AYWdJMrrXN4QKzvrVbTiLSd7LNCRaVt7GbKSKg823oSkHdzFfTMuAQTBwYqndMC8MdIfzrMuIjRa3kMsYl2Trxag2I12J+jzKMM3rP8uzTwaiCt+iJUODG46SMFZ2fBj2jjUDYX3Nl/g2VGOLXdwZzoZuVct1Ej7DcQwXQ=
Received: by 10.49.41.18 with SMTP id t18mr497838nfj;
        Tue, 08 Aug 2006 09:36:11 -0700 (PDT)
Received: from host-81-190-31-92.torun.mm.pl ( [81.190.31.92])
        by mx.gmail.com with ESMTP id i1sm980906nfe.2006.08.08.09.36.11;
        Tue, 08 Aug 2006 09:36:11 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608081834.09271.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25074>

Error out on --without-shell/--with-shell=no and
--without-perl/--with-perl=no instead of just warning
and continuing.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
It's a matter of taste (and not doing unexpected)

 configure.ac |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/configure.ac b/configure.ac
index e2da891..c2ddd9b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -37,7 +37,7 @@ # Used by GIT_ARG_SET_PATH(PROGRAM)
 AC_DEFUN([GIT_CONF_APPEND_PATH],
 [PROGRAM=m4_toupper($1); \
 if test "$withval" = "no"; then \
-	AC_MSG_WARN([You cannot use git without $1]); \
+	AC_MSG_ERROR([You cannot use git without $1]); \
 else \
 	if test "$withval" = "yes"; then \
 		AC_MSG_WARN([You should provide path for --with-$1=PATH]); \
-- 
1.4.1.1
