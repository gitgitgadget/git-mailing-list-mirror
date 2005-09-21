From: Junio C Hamano <junkio@cox.net>
Subject: Re: git/Documentation/Makefile - "install" doesn't depend on "all"
Date: Wed, 21 Sep 2005 11:36:25 -0700
Message-ID: <7vbr2mw9na.fsf@assigned-by-dhcp.cox.net>
References: <868xxq73az.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 21 20:38:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EI9SN-0006OP-Sv
	for gcvg-git@gmane.org; Wed, 21 Sep 2005 20:36:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbVIUSgb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 14:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbVIUSgb
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 14:36:31 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:7098 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751363AbVIUSga (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Sep 2005 14:36:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050921183628.UVFH27129.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 21 Sep 2005 14:36:28 -0400
To: merlyn@stonehenge.com (Randal L. Schwartz)
In-Reply-To: <868xxq73az.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "21 Sep 2005 10:12:36 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9068>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

> So, apparently, the manpages don't properly depend on the sources,
> or "install" doesn't properly depend on "all", or both.
>
> Therefore, broken.

Thanks for the patch.

------------
git diff
diff --git a/Documentation/Makefile b/Documentation/Makefile
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -44,7 +44,7 @@ man: man1 man7
 man1: $(DOC_MAN1)
 man7: $(DOC_MAN7)
 
-install:
+install: all
 	$(INSTALL) -d -m755 $(DESTDIR)/$(man1) $(DESTDIR)/$(man7)
 	$(INSTALL) $(DOC_MAN1) $(DESTDIR)/$(man1)
 	$(INSTALL) $(DOC_MAN7) $(DESTDIR)/$(man7)
