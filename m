From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/5] autoconf: Add -liconv to LIBS when NEEDS_LIBICONV
Date: Tue, 5 Sep 2006 00:55:52 +0200
Message-ID: <200609050055.52980.jnareb@gmail.com>
References: <200609050054.24279.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Sep 05 00:58:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKNOv-0007fJ-I5
	for gcvg-git@gmane.org; Tue, 05 Sep 2006 00:58:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbWIDW6f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Sep 2006 18:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbWIDW6e
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Sep 2006 18:58:34 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:3608 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751235AbWIDW6b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Sep 2006 18:58:31 -0400
Received: by nf-out-0910.google.com with SMTP id o25so1112901nfa
        for <git@vger.kernel.org>; Mon, 04 Sep 2006 15:58:31 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=MUCVkGZ5Vib+eUd+4BAKCYRHOXEpQaKqLFtP30E8gV/OkyoePLEEv2e9uwnTpbse4MAcq0b5ipUgrUSd34Rc7dJQ6AbUI3JkD1hotro9y8OvhJV5tVnE5+8Ul1EpUI6xfZC76lZqH6AuZyIpXBzrZhk3wWvKQyetGdj+GROrCj4=
Received: by 10.49.8.15 with SMTP id l15mr7179888nfi;
        Mon, 04 Sep 2006 15:58:30 -0700 (PDT)
Received: from host-81-190-21-28.torun.mm.pl ( [81.190.21.28])
        by mx.gmail.com with ESMTP id l38sm10135925nfc.2006.09.04.15.58.30;
        Mon, 04 Sep 2006 15:58:30 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200609050054.24279.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26443>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Just in case; it could matter for testing if iconv is properly
supported (NO_ICONV test).

 configure.ac |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/configure.ac b/configure.ac
index 36f9cd9..fc5b813 100644
--- a/configure.ac
+++ b/configure.ac
@@ -147,6 +147,7 @@ AC_CHECK_LIB([c], [iconv],
 [NEEDS_LIBICONV=],
 [NEEDS_LIBICONV=YesPlease])
 AC_SUBST(NEEDS_LIBICONV)
+test -n "$NEEDS_SOCKET" && LIBS="$LIBS -liconv"
 #
 # Define NEEDS_SOCKET if linking with libc is not enough (SunOS,
 # Patrick Mauritz).
-- 
1.4.1.1
