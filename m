From: Junio C Hamano <junkio@cox.net>
Subject: Re: Make "git clone" less of a deathly quiet experience
Date: Fri, 10 Feb 2006 21:48:55 -0800
Message-ID: <7vwtg2o37c.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602102018250.3691@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Feb 11 06:49:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7ncz-00016X-Cd
	for gcvg-git@gmane.org; Sat, 11 Feb 2006 06:49:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbWBKFs6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Feb 2006 00:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWBKFs6
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Feb 2006 00:48:58 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:59091 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751205AbWBKFs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2006 00:48:58 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060211054747.KNPC15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 11 Feb 2006 00:47:47 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602102018250.3691@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 10 Feb 2006 20:31:09 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15929>

Linus Torvalds <torvalds@osdl.org> writes:

> Anyway, _something_ like this is definitely needed. It could certainly be 
> better (if it showed the same kind of thing that git-unpack-objects did, 
> that would be much nicer, but would require parsing the object stream as 
> it comes in). But this is  big step forward, I think.
>
> Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> ---
>
> Comments? Hate-mail? Improvements?

It probably should default to quiet if (!isatty(1)).

The real improvement, independent of this client-side patch,
would be to reuse recently generated packs, but that needs
writable cache directory on the server side.  Another thing that
I stumbled upon last time I tried it was that it did not look
totally trivial to modify the csum-file interface so that I can
splice the output from it into two different destinations (one
to cachefile, the other to the consumer).
