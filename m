From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Anybody using git-send-pack?
Date: Mon, 23 Apr 2007 13:29:43 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0704231321550.28708@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 23 19:29:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg2MH-0001Lc-68
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 19:29:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751672AbXDWR3q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 13:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753820AbXDWR3p
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 13:29:45 -0400
Received: from iabervon.org ([66.92.72.58]:2377 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751672AbXDWR3o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 13:29:44 -0400
Received: (qmail 7067 invoked by uid 1000); 23 Apr 2007 17:29:43 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 23 Apr 2007 17:29:43 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45341>

In order to make git-push update refs/remotes to reflect the change caused 
to the remote (without requiring a fetch after the push), I'm finding it 
necessary to mess with the interface between git-push and git-send-pack. I 
think the easiest thing would be just to pull send-pack into push, rather 
than execing another program (now that git-push is also in C).

The question is whether I should write a builtin-send-pack.c that lets 
people call send-pack directly, or get rid of it entirely in favor of 
always going though git-push. The only reason I can see to call send-pack 
directly is that git-push currently loses "verbose" in calling it, which 
should probably just be fixed.

Is cogito still using it, perhaps? Is that still an issue?

	-Daniel
*This .sig left intentionally blank*
