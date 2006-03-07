From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] ls-tree: add --abbrev[=<n>] option
Date: Tue, 07 Mar 2006 09:56:24 -0800
Message-ID: <7vzmk2jfzr.fsf@assigned-by-dhcp.cox.net>
References: <20060307135202.GA17891@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 07 18:56:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGgQD-0003cE-GC
	for gcvg-git@gmane.org; Tue, 07 Mar 2006 18:56:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbWCGR40 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Mar 2006 12:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbWCGR40
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Mar 2006 12:56:26 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:48349 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751424AbWCGR4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Mar 2006 12:56:25 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060307175450.FUYA20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 7 Mar 2006 12:54:50 -0500
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <20060307135202.GA17891@localdomain> (Eric Wong's message of
	"Tue, 7 Mar 2006 05:52:02 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17343>

Output from ls-tree and ls-files -s are primarily for script
consumption.  diff-raw output which already has abbrev is also
primarily for scripts, but we have an excuse there that human
eyes can spot differences easier in abbreviated form and two
values on the same row being different is the only information
we are conveying in "git whatchanged" default output, and not
abbreviating the object names makes pathnames pushed to far
right of the display which will be chopped by "less -S".

So I am not quite sure if I should take this, and a subsequent
one you would probably send for ls-files ;-).

Care to point out a use case I might have missed that this is
useful?  I've never done ls-tree to be read by _me_ (not by
script) unless I am debugging ls-tree itself.

Although I doubt this adds much practical value, this might make
things consistent, which by itself might be a reason to do this,
though.
