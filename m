From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/3] Remove more parsers
Date: Sun, 29 Jan 2006 12:26:59 -0800
Message-ID: <7vk6ciixv0.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0601291336420.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 29 21:27:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3J8m-0002hA-32
	for gcvg-git@gmane.org; Sun, 29 Jan 2006 21:27:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbWA2U1F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jan 2006 15:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWA2U1E
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jan 2006 15:27:04 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:53682 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751166AbWA2U1A (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jan 2006 15:27:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060129202359.KHTO20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 29 Jan 2006 15:23:59 -0500
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0601291336420.25300@iabervon.org> (Daniel
	Barkalow's message of "Sun, 29 Jan 2006 14:04:19 -0500 (EST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15242>

I do not have objections to git-tar-tree changes, but I am
hesitant to use the tree parser in diff-tree due to its memory
retention behaviour.  We already use the commit parser in
diff-tree but I think we currently do not ask for the tree part
of the object to be parsed.  I suspect this patch would badly
interact with long-running "diff-tree --stdin", which is the
workhorse of whatchanged.  I haven't benched it though, and I'd
be happy to see the impact is proven to be negligible.
