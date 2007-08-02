From: Robert Schiele <rschiele@gmail.com>
Subject: [PATCH] the ar tool is called gar on some systems
Date: Thu, 2 Aug 2007 18:15:01 +0200
Message-ID: <20070802161501.GO29424@schiele.dyndns.org>
Reply-To: Robert Schiele <rschiele@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 02 18:15:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGdKt-0006po-T8
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 18:15:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757371AbXHBQPI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 12:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757191AbXHBQPH
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 12:15:07 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:30007 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755305AbXHBQPF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 12:15:05 -0400
Received: by nf-out-0910.google.com with SMTP id g13so150599nfb
        for <git@vger.kernel.org>; Thu, 02 Aug 2007 09:15:04 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent:from:reply-to;
        b=Ngm35vCmfripRlJIgI7XVwBB/hIwXw8e7YViTxgMhwZk1rOevXd/e0Eo6ouYPEIoB498OfbcYi4vSjdeo4sI5tutqQv8mFs7r8IJhzzilN5fAHa8AVwHDFVCFcM94IXac5/MntJEKOdOKjq2AZSdtXcxFpZUPQLLgvy0oUjjuYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent:from:reply-to;
        b=tc5jnyqtPv3BGF3/geCyOe7MqICJQzrLX072FQDt7lWBZPwFtljaYW/mLmzqbRjmUjpVM0q6CLvsmztuR9gN0SAWrPILvH8P0hThg2Xlv3HaXaJg9IBWXXsobzxB/l58yjDNLZRwkRbwDbR4VDLEJH8Db+y9P+ZMHJTFKdKI3L4=
Received: by 10.86.28.5 with SMTP id b5mr1510153fgb.1186071303983;
        Thu, 02 Aug 2007 09:15:03 -0700 (PDT)
Received: from sigkill.schiele.dyndns.org ( [87.178.91.135])
        by mx.google.com with ESMTPS id 28sm4315743fkx.2007.08.02.09.15.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Aug 2007 09:15:03 -0700 (PDT)
Received: by sigkill.schiele.dyndns.org (Postfix, from userid 1000)
	id 16309C1124B; Thu,  2 Aug 2007 18:15:01 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54568>

Some systems that have only installed the GNU toolchain (prefixed with "g")
do not provide "ar" but only "gar".  Make configure find this tool as well.

Signed-off-by: Robert Schiele <rschiele@gmail.com>
---
This is another trivial configure patch.  If you don't want to include it in
the upcomming release it is fine for me to delay it.  If you expect me to
resubmit after the release, drop me a note.

 configure.ac |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/configure.ac b/configure.ac
index 84fd7f1..ed7cc89 100644
--- a/configure.ac
+++ b/configure.ac
@@ -104,7 +104,7 @@ AC_MSG_NOTICE([CHECKS for programs])
 #
 AC_PROG_CC([cc gcc])
 #AC_PROG_INSTALL		# needs install-sh or install.sh in sources
-AC_CHECK_TOOL(AR, ar, :)
+AC_CHECK_TOOLS(AR, [gar ar], :)
 AC_CHECK_PROGS(TAR, [gtar tar])
 # TCLTK_PATH will be set to some value if we want Tcl/Tk
 # or will be empty otherwise.
-- 
1.5.2.3
