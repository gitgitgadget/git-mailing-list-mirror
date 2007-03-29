From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: [PATCH] Eliminate checks of user-specified Tcl/Tk interpreter.
Date: Thu, 29 Mar 2007 14:06:48 +0400
Message-ID: <20070329100648.GN59098@codelabs.ru>
References: <7vps6um8wv.fsf@assigned-by-dhcp.cox.net> <20070328091209.GQ14837@codelabs.ru> <7vps6tf8te.fsf@assigned-by-dhcp.cox.net> <20070329074424.GD59098@codelabs.ru> <7vwt107a3g.fsf@assigned-by-dhcp.cox.net> <20070329082908.GH59098@codelabs.ru> <7v7it04fbo.fsf@assigned-by-dhcp.cox.net> <20070329085834.GJ59098@codelabs.ru> <20070329091239.GA8905@hermes> <20070329100602.GM59098@codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: Junio C Hamano <junkio@cox.net>, Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Tom Prince <tom.prince@ualberta.net>
X-From: git-owner@vger.kernel.org Thu Mar 29 12:07:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWrX2-0008RI-8w
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 12:07:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934079AbXC2KG5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 06:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934240AbXC2KG5
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 06:06:57 -0400
Received: from pobox.codelabs.ru ([144.206.177.45]:56597 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934079AbXC2KGy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 06:06:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=one; d=codelabs.ru;
	h=Received:Date:From:To:Cc:Message-ID:References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:Sender:X-Spam-Status:Subject;
	b=guTfKXKnLAwey1295SdALuUizYGwb+PuaFL1bies+3wq8iZ22oO4EqyUKbJd4edlH3SwDpgKeYox6qMJG75SFBqs8MJ30kOZofCgu6UiSqxEOmwGoMyToQLW6y5alHFshWSzALEa1mTwf7cjxW6fkNwKp+7dX/m299Dhlz3Xqcs=;
Received: from codelabs.ru (pobox.codelabs.ru [144.206.177.45])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1HWrWv-000Dvg-6R; Thu, 29 Mar 2007 14:06:53 +0400
Content-Disposition: inline
In-Reply-To: <20070329100602.GM59098@codelabs.ru>
X-Spam-Status: No, score=-2.0 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_50
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43424>

Do not make the checks on the Tcl/Tk interpreter passed by
'--with-tcltk=/path/to/wish' configure option: user is free to pass
anything.

Signed-off-by: Eygene Ryabinkin <rea-git@codelabs.ru>
---
 configure.ac |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 43a6769..50d2b85 100644
--- a/configure.ac
+++ b/configure.ac
@@ -102,8 +102,6 @@ if test -z "$NO_TCLTK"; then
   elif test "$with_tcltk" = "yes"; then
   # Tcl/Tk check requested.
     AC_CHECK_PROGS(TCLTK_PATH, [wish], )
-  elif ! test -x "$with_tcltk"; then
-    AC_MSG_ERROR([Tcl/Tk interpreter was not found in $with_tcltk])
   else
     AC_MSG_RESULT([Using Tcl/Tk interpreter $with_tcltk])
     TCLTK_PATH="$with_tcltk"
-- 
1.5.0.3-dirty
