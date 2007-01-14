From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/4] Use binary searching on large buckets in git-describe.
Date: Sun, 14 Jan 2007 11:11:05 -0800
Message-ID: <7v3b6dh19y.fsf@assigned-by-dhcp.cox.net>
References: <8e29bab8b4b9f53cbdc85e6e783bf3b5d3787f0f.1168727248.git.spearce@spearce.org>
	<20070113222900.GC18011@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 15 20:11:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6W2A-0000Hd-TD
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:54:14 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6V7q-0003eK-UT
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:56:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751619AbXANTLI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Jan 2007 14:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751620AbXANTLI
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jan 2007 14:11:08 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:59512 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751619AbXANTLH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jan 2007 14:11:07 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070114191106.GJG29122.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>;
          Sun, 14 Jan 2007 14:11:06 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id B7BN1W00H1kojtg0000000; Sun, 14 Jan 2007 14:11:22 -0500
To: "Shawn O. Pearce" <spearce@spearce.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36868>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> If a project has a really huge number of tags (such as several
> thousand tags) then we are likely to have nearly a hundred tags in
> some buckets.  Scanning those buckets as linked lists could take
> a large amount of time if done repeatedly during history traversal.

I think this is a good idea -- but would you still need the 256
buckets if you do this?
