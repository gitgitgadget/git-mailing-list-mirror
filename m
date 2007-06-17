From: Daniel Barkalow <barkalow@iabervon.org>
Subject: t5515 in general
Date: Sun, 17 Jun 2007 02:06:51 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0706170034540.4740@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 17 08:07:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hznue-0002kr-9b
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 08:07:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755743AbXFQGGx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jun 2007 02:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755397AbXFQGGx
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jun 2007 02:06:53 -0400
Received: from iabervon.org ([66.92.72.58]:3971 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751493AbXFQGGw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jun 2007 02:06:52 -0400
Received: (qmail 1137 invoked by uid 1000); 17 Jun 2007 06:06:51 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Jun 2007 06:06:51 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50334>

It looks to me like t5515 enshrines a number of infelicities in the 
current fetch code. For example, if you have a branch configuration which 
specifies a remote that's configured through a branches/* file, and you 
have a merge setting for the branch, it's ignored, and we test that it's 
ignored with a whole bunch of tests. I think that the behavior here should 
either be unspecified, or we should make it more generally consistant 
(i.e., if you specify any "merge" items, this overrides the default of 
using the first refspec, even if the first refspec is implicit in the fact 
that you're using a branches/* file, which automatically only has the 
configured refspec refs/heads/master:). Or leave it unspecified and 
untested, since neither option is actually useful.

This makes me think that a lot of t5515 was done by putting together a 
bunch of configurations and automatically making tests for them without 
checking whether the current behaviour is actually something we want, or 
whether the configuration even could do anything sensible in the first 
place. So it might be worth going through that set and eliminating 
anything not actually predicted by the documentation.

	-Daniel
*This .sig left intentionally blank*
