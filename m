From: Mike Hommey <mh@glandium.org>
Subject: Re: [OT] perhaps we want to support copied-context diff output
Date: Sat, 8 Dec 2007 09:53:02 +0100
Organization: glandium.org
Message-ID: <20071208085302.GA13432@glandium.org>
References: <alpine.LFD.0.99999.0712072357050.555@xanadu.home> <7vmyslwqdr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org,
	Jon Smirl <jonsmirl@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 08 09:53:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0vR9-0006oQ-U9
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 09:53:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757302AbXLHIxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 03:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754864AbXLHIxI
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 03:53:08 -0500
Received: from smtp23.orange.fr ([193.252.22.30]:27004 "EHLO smtp23.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757325AbXLHIxG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 03:53:06 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2337.orange.fr (SMTP Server) with ESMTP id 804931C0008B
	for <git@vger.kernel.org>; Sat,  8 Dec 2007 09:53:03 +0100 (CET)
Received: from namakemono.glandium.org (APuteaux-153-1-79-219.w81-249.abo.wanadoo.fr [81.249.109.219])
	by mwinf2337.orange.fr (SMTP Server) with ESMTP id 602A51C0008A;
	Sat,  8 Dec 2007 09:53:03 +0100 (CET)
X-ME-UUID: 20071208085303394.602A51C0008A@mwinf2337.orange.fr
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1J0vQk-0003dC-NB; Sat, 08 Dec 2007 09:53:02 +0100
Content-Disposition: inline
In-Reply-To: <7vmyslwqdr.fsf@gitster.siamese.dyndns.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67531>

> Perhaps we may want to add "diff -c" (copied context) output format as
> an option, which may be easier to read.

Or maybe use the patience diff.

On a testcase I had a few months ago, patience diff would give:
@@ -42,11 +42,10 @@

 include $(DEPTH)/config/autoconf.mk

+EXTRA_COMPONENTS = nsKillAll.js
+
 include $(topsrcdir)/config/rules.mk

-libs::
-       $(INSTALL) $(srcdir)/nsKillAll.js $(DIST)/bin/components
-
 clean::
        rm -f $(DIST)/bin/components/nsKillAll.js

Where "normal" diff would give:
@@ -42,10 +42,9 @@

 include $(DEPTH)/config/autoconf.mk

-include $(topsrcdir)/config/rules.mk
+EXTRA_COMPONENTS = nsKillAll.js

-libs::
-       $(INSTALL) $(srcdir)/nsKillAll.js $(DIST)/bin/components
+include $(topsrcdir)/config/rules.mk

 clean::
        rm -f $(DIST)/bin/components/nsKillAll.js

git outputs the same as the normal diff, bzr and svn seem to use the
patience diff. Mercurial outputs almost the same as bzr and svn:
@@ -42,10 +42,9 @@

 include $(DEPTH)/config/autoconf.mk

+EXTRA_COMPONENTS = nsKillAll.js
+
 include $(topsrcdir)/config/rules.mk
-
-libs::
-       $(INSTALL) $(srcdir)/nsKillAll.js $(DIST)/bin/components

 clean::
        rm -f $(DIST)/bin/components/nsKillAll.js

Mike
