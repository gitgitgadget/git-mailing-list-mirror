From: Daniel Barkalow <barkalow@iabervon.org>
Subject: cvsserver bug
Date: Wed, 11 Apr 2007 12:10:24 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0704111158220.27922@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martyn Smith <martyn@catalyst.net.nz>,
	Martin Langhoff <martin@catalyst.net.nz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 11 18:10:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbfOv-0007Az-BG
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 18:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753050AbXDKQK0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 12:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753221AbXDKQK0
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 12:10:26 -0400
Received: from iabervon.org ([66.92.72.58]:2154 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753050AbXDKQKZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 12:10:25 -0400
Received: (qmail 2373 invoked by uid 1000); 11 Apr 2007 16:10:24 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Apr 2007 16:10:24 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44244>

It seems like git-cvsserver doesn't know the CVS special case that, if the 
client has removed the file from the working directory (but not called 
"cvs remove"), this means to revert it to the server's version. I think 
that the condition around line 843 needs to exclude this case, and it 
needs to get to line 892 instead, but I can't even fake perl to fix it.

	-Daniel
*This .sig left intentionally blank*
