From: Junio C Hamano <junkio@cox.net>
Subject: Re: How to commit removed file?
Date: Tue, 02 Jan 2007 22:51:55 -0800
Message-ID: <7vhcv8r4ac.fsf@assigned-by-dhcp.cox.net>
References: <7vfyatt8di.fsf@assigned-by-dhcp.cox.net>
	<20070103060640.GD20259@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 03 07:52:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1zyj-00086e-9J
	for gcvg-git@gmane.org; Wed, 03 Jan 2007 07:52:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754556AbXACGv6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Jan 2007 01:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754670AbXACGv6
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 01:51:58 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:42249 "EHLO
	fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754556AbXACGv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 01:51:57 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070103065156.XGKY16632.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>;
          Wed, 3 Jan 2007 01:51:56 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 6WsA1W00A1kojtg0000000; Wed, 03 Jan 2007 01:52:11 -0500
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
In-Reply-To: <20070103060640.GD20259@mellanox.co.il> (Michael S. Tsirkin's
	message of "Wed, 3 Jan 2007 08:06:40 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35845>

"Michael S. Tsirkin" <mst@mellanox.co.il> writes:

> But won't the same problem appear with
>
> rm file
> git-update-index file
> git-commit file

If you do index manipulation yourself using update-index, do not
jump the index at the commit time using "git commit file..."
syntax; the sole purpose of that misfeature is to handhold
CVS-braindamaged people who want to make per-path partial
commits.

We bend backwards to allow index-jumping for most cases in
git-commit, and you found that "most" is not "all".  That's a
great news.

I am not interested to make it "all" myself -- if somebody else
does it, that is fine, though ;-).
