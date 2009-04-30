From: Michael Hendricks <michael@ndrix.org>
Subject: detecting cycles in Git's commit graph
Date: Thu, 30 Apr 2009 13:18:57 -0600
Message-ID: <20090430191857.GA55192@ginosko.grantstreet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 30 21:19:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lzbmw-0004Lp-Ii
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 21:19:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018AbZD3TTM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2009 15:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751868AbZD3TTK
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 15:19:10 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:47609 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751758AbZD3TTJ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Apr 2009 15:19:09 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id F05F83289C3
	for <git@vger.kernel.org>; Thu, 30 Apr 2009 15:19:08 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 30 Apr 2009 15:19:09 -0400
X-Sasl-enc: 4guTVjaaGXGem/cApkYScJtL/KODl0QRcIE15prtHB0x 1241119148
Received: from ginosko.ndrix.org (unknown [166.230.131.80])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9C12A2754F
	for <git@vger.kernel.org>; Thu, 30 Apr 2009 15:19:08 -0400 (EDT)
Received: by ginosko.ndrix.org (Postfix, from userid 501)
	id 920711636873; Thu, 30 Apr 2009 13:18:57 -0600 (MDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118038>

Are there any tools for detecting cycles in the commit graph which
have been caused by grafts?  I thought 'git fsck' might do it, but it
doesn't seem to.

While importing some historic code into a new Git repository, my
import scripts accidentally created a cycle in the commit graph by
using grafts.  Essentially, I had commits like:

    A -- B -- C

I accidentally created a graft marking commit C as commit B's second
parent.  There were 15,000 grafts so it took me a while to track down
the one causing the cycle.  The initial symptom was that 'git log
--graph B' produced no output.

I wasn't able to find any existing tools to locate these kinds of
faulty grafts.

Thanks for any pointers.

-- 
Michael
