From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: rev-parse --show-cdup in .git
Date: Fri, 04 Dec 2009 16:45:50 +0100
Message-ID: <4B192EAE.8000806@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 04 16:47:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGaNF-0004NK-GF
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 16:47:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756765AbZLDPrA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 10:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756590AbZLDPq7
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 10:46:59 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:33320 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756546AbZLDPq7 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Dec 2009 10:46:59 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id C2D19C592A
	for <git@vger.kernel.org>; Fri,  4 Dec 2009 10:47:05 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 04 Dec 2009 10:47:05 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:subject:content-type:content-transfer-encoding; s=smtpout; bh=bIzVALuj2saHBQJMtr2F8bLVQCY=; b=F5mJiie+z2p//stQZCI3J6Gvo8m22+8rsJJkNWOGqOWQYTE2lWJJsJp34ef49nST2aj6yVQKvKCHRTtI2GoqtnVoDrY2czVxdyy0xDgNyIa10omWJbb6x0xbWzZz6wu/G/iw/nooxE55REcY6rcMRvJqhExnNmZd9xDAKXQoe2I=
X-Sasl-enc: IrXShvJRkyVbEUlEtcjCzhC9ayisQrLCgjLkJKkKmVNB 1259941625
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3B4404BC0F2
	for <git@vger.kernel.org>; Fri,  4 Dec 2009 10:47:05 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7pre) Gecko/20091204 Lightning/1.0b1pre Shredder/3.0.1pre
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134516>

I'm sure this was discussed somewhere, but I can't find it:

When called from within .git, git rev-parse --show-cdup returns nothing
rather than "..", not even an error code. Is this intended?

This is all the more disturbing since the cwd of hooks seems to be
GIT_DIR. Is that something one can rely upon? In that case one can
simply use ".." for cdup.

Michael

P.S.: The use case is a simple post-receive-hook that fast forwards a
checked out branch on receiving refs in refs/remotes/incoming/, but
needs to check the worktree against the index etc. 1.7.0 may be an
opportunity to encourage usage of this rather than restoring the old
behavior through options.
