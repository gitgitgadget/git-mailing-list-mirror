From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add missing semicolon to sed command.
Date: Sun, 19 Mar 2006 18:15:56 -0800
Message-ID: <7v1wwxn9nn.fsf@assigned-by-dhcp.cox.net>
References: <20060320001808.GB20765@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 20 03:16:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FL9wJ-0007be-1z
	for gcvg-git@gmane.org; Mon, 20 Mar 2006 03:16:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbWCTCP6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Mar 2006 21:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbWCTCP6
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Mar 2006 21:15:58 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:30454 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751178AbWCTCP6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Mar 2006 21:15:58 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060320021254.NTJA17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 19 Mar 2006 21:12:54 -0500
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060320001808.GB20765@spearce.org> (Shawn Pearce's message of
	"Sun, 19 Mar 2006 19:18:08 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17740>

Shawn Pearce <spearce@spearce.org> writes:

> generate-cmdlist.sh is giving errors messages from sed on Mac OS
> 10.4 due to a missing semicolon.

I'll take this patch for now, but I've heard a horror story that
some other vintage of sed apparently does not like multiple
commands separated by semicolons at all, and I've been training
myself to do this kind of thing always as multi-line sed script,
like this:

     sed -n '
     /NAME/,/git-'"$cmd"'/H
     ${
            x
            s/.*git-'"$cmd"' - \(.*\)/  {"'"$cmd"'", "\1"},/
	    p
     }' "Documentation/git-$cmd.txt"
