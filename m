From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [ANNOUNCE] tig-0.10
Date: Mon, 17 Mar 2008 12:28:25 +0100
Message-ID: <20080317112825.GA12798@diku.dk>
References: <20080317020304.GA19249@diku.dk> <7vr6e9bvuu.fsf@gitster.siamese.dyndns.org> <20080317102318.GA6830@diku.dk> <7vlk4hbp64.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 12:29:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbDWq-0007oF-Ss
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 12:29:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754155AbYCQL2j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2008 07:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754092AbYCQL2j
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 07:28:39 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:52650 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753565AbYCQL2i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2008 07:28:38 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 463EA770005;
	Mon, 17 Mar 2008 12:28:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zppQ+h87AJW6; Mon, 17 Mar 2008 12:28:26 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 079BB52C319;
	Mon, 17 Mar 2008 12:28:26 +0100 (CET)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 3DA866DF845; Mon, 17 Mar 2008 12:27:34 +0100 (CET)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id E40AF1DC4B7; Mon, 17 Mar 2008 12:28:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vlk4hbp64.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77427>

Junio C Hamano <gitster@pobox.com> wrote Mon, Mar 17, 2008:
> Jonas Fonseca <fonseca@diku.dk> writes:
> > I am not sure I understand. As far as I know, tig does not require
> > autoreconf unless you have cloned the repository and want to bootstrap
> > the configure script.
> 
> Yeah, but that was exactly what your announcement suggested to.  Show
> Tarball and Gitfeed alternatives to a git person, who already has a clone
> of the project, and guess which one he would go ;-).
> 
> Also INSTALL file begins with:
> 
> [...]

Ok, I will try to make it more clear that usage of configure (and
autoreconf) is optional.

> By the way, it would be nice if someday I can get tig work with CJK.
> Perhaps I need to tweak something in ncurses?

I will make it a priority to fix this shortcoming. Until then you can
improve the situation by linking with the ncursesw library. At least the
diff view and names in the commit listing will be properly displayed.

diff --git a/Makefile b/Makefile
index 575c5bf..e57ae6a 100644
--- a/Makefile
+++ b/Makefile
@@ -32,7 +32,7 @@ RPM_VERLIST = $(filter-out g% dirty,$(subst -, ,$(VERSION))) 0
 RPM_VERSION = $(word 1,$(RPM_VERLIST))
 RPM_RELEASE = $(word 2,$(RPM_VERLIST))$(if $(WTDIRTY),.dirty)
 
-LDLIBS ?= -lcurses
+LDLIBS ?= -lncursesw
 CFLAGS ?= -Wall -O2
 DFLAGS	= -g -DDEBUG -Werror
 PROGS	= tig

-- 
Jonas Fonseca
