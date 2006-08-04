From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/5] autoconf: Set NEEDS_LIBICONV unconditionally if there is no iconv in libc
Date: Fri, 4 Aug 2006 23:28:11 +0200
Message-ID: <200608042328.12607.jnareb@gmail.com>
References: <200608042333.19011.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Aug 04 23:41:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G97PN-0005gS-JG
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 23:40:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161494AbWHDVke (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 17:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161497AbWHDVke
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 17:40:34 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:14256 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161494AbWHDVkd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Aug 2006 17:40:33 -0400
Received: by nf-out-0910.google.com with SMTP id k26so30462nfc
        for <git@vger.kernel.org>; Fri, 04 Aug 2006 14:40:32 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=mrVoc7XSl8jwDS/VWPUvPB7+SHoIsBYwLRH4fWnjZIjQ4o6y99OBkagl8Kir/rRUc9yAPpacyQJk5kXpI9bGDhlp732MM/O4PfWFL0jnI5bArEHufskiai45Vy8ggeZHcM1+AwuJFypPKbe0+lAkhpXIoFvzhiNjTUcoGipmegk=
Received: by 10.48.162.15 with SMTP id k15mr6032253nfe;
        Fri, 04 Aug 2006 14:40:32 -0700 (PDT)
Received: from host-81-190-31-92.torun.mm.pl ( [81.190.31.92])
        by mx.gmail.com with ESMTP id r34sm1038674nfc.2006.08.04.14.40.31;
        Fri, 04 Aug 2006 14:40:32 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608042333.19011.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24843>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 configure.ac |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 5926f3c..61c9fa3 100644
--- a/configure.ac
+++ b/configure.ac
@@ -172,8 +172,7 @@ AC_CHECK_LIB([expat], [XML_ParserCreate]
 #
 # Define NEEDS_LIBICONV if linking with libc is not enough (Darwin).
 AC_CHECK_LIB([c], [iconv],[],
-[AC_CHECK_LIB([iconv],[iconv],
- [GIT_CONF_APPEND_LINE(NEEDS_LIBICONV=YesPlease)],[])])
+[GIT_CONF_APPEND_LINE(NEEDS_LIBICONV=YesPlease)])
 #
 # Define NEEDS_SOCKET if linking with libc is not enough (SunOS,
 # Patrick Mauritz).
-- 
1.4.1.1
