From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] fix display overlap between remote and local progress
Date: Sun, 04 Nov 2007 20:07:29 -0500 (EST)
Message-ID: <alpine.LFD.0.9999.0711041955400.21255@xanadu.home>
References: <alpine.LFD.0.9999.0711032328490.21255@xanadu.home>
 <Pine.LNX.4.64.0711041331520.4362@racer.site>
 <alpine.LFD.0.9999.0711041610520.21255@xanadu.home>
 <7v4pg1sj1r.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 02:07:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoqRN-0006P9-Tv
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 02:07:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754192AbXKEBHb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 20:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753754AbXKEBHb
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 20:07:31 -0500
Received: from relais.videotron.ca ([24.201.245.36]:46057 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753168AbXKEBHa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 20:07:30 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JR0007AADSHUF10@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 04 Nov 2007 20:07:30 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7v4pg1sj1r.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63465>

On Sun, 4 Nov 2007, Junio C Hamano wrote:

> The compiler at k.org complains of "\e" being non ISO-C, though.

Bummer.

...

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
diff --git a/sideband.c b/sideband.c
index 58edea6..756bbc2 100644
--- a/sideband.c
+++ b/sideband.c
@@ -13,7 +13,7 @@
  */
 
 #define PREFIX "remote:"
-#define SUFFIX "\e[K"  /* change to "        " if ANSI sequences don't work */
+#define SUFFIX "\033[K"  /* change to "        " if ANSI sequences don't work */
 
 int recv_sideband(const char *me, int in_stream, int out, int err)
 {
