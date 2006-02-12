From: Junio C Hamano <junkio@cox.net>
Subject: Re: Configuration file musings
Date: Sun, 12 Feb 2006 10:56:52 -0800
Message-ID: <7v4q34be2z.fsf@assigned-by-dhcp.cox.net>
References: <slrnduuf08.518.mdw@metalzone.distorted.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 12 19:56:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8MP4-0002G6-5Z
	for gcvg-git@gmane.org; Sun, 12 Feb 2006 19:56:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbWBLS4z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Feb 2006 13:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbWBLS4z
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Feb 2006 13:56:55 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:12206 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750831AbWBLS4y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2006 13:56:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060212185525.UCTX6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 12 Feb 2006 13:55:25 -0500
To: Mark Wooding <mdw@distorted.org.uk>
In-Reply-To: <slrnduuf08.518.mdw@metalzone.distorted.org.uk> (Mark Wooding's
	message of "Sun, 12 Feb 2006 13:45:44 +0000 (UTC)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16011>

Mark Wooding <mdw@distorted.org.uk> writes:

> Having thought about things a bit, I've reached the conclusion that the
> configuration file $GIT_DIR/config is trying to hold (at least) three
> entirely different kinds of configuration.

Yes.  I've been somewhat bothered by that, but I did not ramble
on it too much because I could not say what exactly is _wrong_
to have these things in the same file.

Except perhaps that pure user configuration could be further
split out from per-repository user configuration to .gitconfig
under $HOME or something like that.  The former is things like
"I am Junio C Hamano no matter which project I work on" the
latter is for example "The e-mail address I use for this project
is <junkio@cox>".  But once we start dealing with more than one
configuration file, you need one file taking precedence over the
other and it appeared there is no single _right_ order.  The
above identity case is an example that it is better to make the
config in repository to override $HOME one, but if you think
long enough I am sure you can come up with an example that you
would want to override repository one from $HOME one.
