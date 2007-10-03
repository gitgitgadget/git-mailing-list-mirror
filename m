From: Robert Schiele <rschiele@gmail.com>
Subject: [PATCH] the ar tool is called gar on some systems
Date: Wed, 3 Oct 2007 03:49:34 +0200
Message-ID: <20071003014934.GF20753@schiele.dyndns.org>
Reply-To: Robert Schiele <rschiele@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 03 03:49:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IctMx-0002Vc-Ax
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 03:49:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753796AbXJCBtj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 21:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753472AbXJCBtj
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 21:49:39 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:63471 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753328AbXJCBti (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 21:49:38 -0400
Received: by ug-out-1314.google.com with SMTP id z38so43263ugc
        for <git@vger.kernel.org>; Tue, 02 Oct 2007 18:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent:from:reply-to;
        bh=SFv6JhJY/3nYGBFvhBonIZhDFvTgfJVvw2F3yD8Qi+M=;
        b=DkCwBYHLSKE8QGjDfSyNyQcYHSyTD7vabGNivlTmI8AyfYy+0T1eAJQl5Difgpu8UaoT3eFl7/5LyZ4HhyidiAzjo4/+WTzRTbvNOyRku9pxM22DuH9VK7BwdbLqMNU4Y5IuRSOSCBSmftA3O6/e3/MhFxD3CmvCBWVSFZNvCcc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent:from:reply-to;
        b=eYWR/Vdr32+wK3Er9uUO6w+i8EORFYLA3kmnpQBwA4BHoPBnEDnRpN4iNzZ5BEcvp6GlMWhF0m2w1DsS89mVVtC1/LublscG4s8867XG9GHJKI6qU/RlrAi+gfJUz9O3X5k0mJqye6k4EQAKsgjc4+N0y5yUS1rbtdOcblA68+g=
Received: by 10.66.237.9 with SMTP id k9mr1878351ugh.1191376176880;
        Tue, 02 Oct 2007 18:49:36 -0700 (PDT)
Received: from sigkill.schiele.dyndns.org ( [87.178.79.133])
        by mx.google.com with ESMTPS id g1sm9567026muf.2007.10.02.18.49.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 02 Oct 2007 18:49:36 -0700 (PDT)
Received: by sigkill.schiele.dyndns.org (Postfix, from userid 1000)
	id 8CA7A985458; Wed,  3 Oct 2007 03:49:34 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59768>

Some systems that have only installed the GNU toolchain (prefixed with "g")
do not provide "ar" but only "gar".  Make configure find this tool as well.

Signed-off-by: Robert Schiele <rschiele@gmail.com>
---
I sent that some weeks ago but it seems it got lost.

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
