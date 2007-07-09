From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Make fetch-pack a builtin with an internal API
Date: Sun, 08 Jul 2007 22:39:41 -0700
Message-ID: <7vwsxaw2xu.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707090104120.6977@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Jul 09 07:39:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7lyM-0000ss-6x
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 07:39:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbXGIFjn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 01:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbXGIFjn
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 01:39:43 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:41008 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750AbXGIFjm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 01:39:42 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070709053941.BJYL19529.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Mon, 9 Jul 2007 01:39:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id MHfh1X00P1kojtg0000000; Mon, 09 Jul 2007 01:39:42 -0400
In-Reply-To: <Pine.LNX.4.64.0707090104120.6977@iabervon.org> (Daniel
	Barkalow's message of "Mon, 9 Jul 2007 01:10:16 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51956>

Are _identifiers with leading underscore Kosher thing to do, I
wonder...  We do have ones with trailing ones (mostly qsort
functions) and I think they are done that way for the sake of
standards conformance.

Gone is a "#if 0/#endif" which is good.

diff --git a/fetch-pack.h b/fetch-pack.h
new file mode 100644
index 0000000..2bd05a8
--- /dev/null
+++ b/fetch-pack.h
@@ -0,0 +1,16 @@
+#ifndef FETCH_PACK_API

We seem to say "#ifndef FETCH_PACK_H" in such a case, though.
Nobody seems to call setup_fetch_pack() yet.  How complete is
this patch meant to be?

The program is somehow much more pleasant to follow, even though
there is no fundamental change anywhere.
