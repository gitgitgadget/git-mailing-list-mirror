From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix cg-commit -p to not touch the working tree
Date: Sun, 11 Feb 2007 20:25:37 -0800
Message-ID: <7v8xf4atoe.fsf@assigned-by-dhcp.cox.net>
References: <20070212031923.D20B913A382@magnus.utsl.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Sam Vilain <sam.vilain@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Mon Feb 12 05:25:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGSl4-0000hb-2u
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 05:25:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932942AbXBLEZj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 23:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932944AbXBLEZj
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 23:25:39 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:36294 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932942AbXBLEZi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 23:25:38 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070212042539.ENQU22948.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sun, 11 Feb 2007 23:25:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id NURe1W0061kojtg0000000; Sun, 11 Feb 2007 23:25:38 -0500
In-Reply-To: <20070212031923.D20B913A382@magnus.utsl.gen.nz> (Sam Vilain's
	message of "Mon, 12 Feb 2007 16:14:31 +1300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39359>

Sam Vilain <sam.vilain@catalyst.net.nz> writes:

> Previously, the working tree state was modified with `patch', which
> was a fragile operation.  Do everything with `git-apply --cached
> --index' instead.

I do not use Cogito so I do not know what behaviour is wanted
here, but '--cached --index' is same as saying just '--cached'
as far as I know.  It will patch against the index and should
not touch working tree.  If the original used 'patch' to apply,
I suspect it wanted to touch the working tree (and possibly, it
wanted to leave the index alone?), so --cached might be
completely wrong thing to use here?
