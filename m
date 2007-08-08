From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Submodules
Date: Wed, 08 Aug 2007 12:33:26 -0700
Message-ID: <7vhcn94y9l.fsf@assigned-by-dhcp.cox.net>
References: <a1bbc6950708071537xfa6b9a0ne8cf66e345fa31b4@mail.gmail.com>
	<Pine.LNX.4.64.0708072349400.14781@racer.site>
	<a1bbc6950708071631w5d232e92gd0fa27158b27b5c3@mail.gmail.com>
	<20070808104117.GK999MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Wed Aug 08 21:33:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIrHn-0000zK-0T
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 21:33:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761580AbXHHTd3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 15:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761552AbXHHTd3
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 15:33:29 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:41505 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761550AbXHHTd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 15:33:28 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070808193328.FTNM2095.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Wed, 8 Aug 2007 15:33:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ZXZS1X00E1kojtg0000000; Wed, 08 Aug 2007 15:33:27 -0400
In-Reply-To: <20070808104117.GK999MdfPADPa@greensroom.kotnet.org> (Sven
	Verdoolaege's message of "Wed, 08 Aug 2007 12:41:17 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55342>

There was a discussion about the semantics currently
implemented, as a subset of what we might want to eventually
have, and some recommended that we mention where things stand
now in the release notes.

How about this?

diff --git a/Documentation/RelNotes-1.5.3.txt b/Documentation/RelNotes-1.5.3.txt
index 21bb1fc..901f813 100644
--- a/Documentation/RelNotes-1.5.3.txt
+++ b/Documentation/RelNotes-1.5.3.txt
@@ -9,6 +9,19 @@ Updates since v1.5.2
 
 * The submodule support has Porcelain layer.
 
+  Note that the current submodule support is minimal and this is
+  deliberately so.  A design decision we made is that operations
+  at the supermodule level do not recurse into submodules by
+  default.  The expectation is that later we would add a
+  mechanism to tell git which submodules the user is interested
+  in, and this information might be used to determine the
+  recursive behaviour of certain commands (e.g. "git checkout"
+  and "git diff"), but currently we haven't agreed on what that
+  mechanism should look like.  Therefore, if you use submodules,
+  you would probably need "git submodule update" on the
+  submodules you care about after running a "git checkout" at
+  the supermodule level.
+
 * There are a handful pack-objects changes to help you cope better
   with repositories with pathologically large blobs in them.
 
