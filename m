From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFD] what should "git push remote.host:path" do?
Date: Thu, 12 Jan 2006 10:53:42 -0800
Message-ID: <7vbqyhp9ah.fsf@assigned-by-dhcp.cox.net>
References: <7vslrtq05h.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0601121006040.3535@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nick Hengeveld <nickh@reactrix.com>
X-From: git-owner@vger.kernel.org Thu Jan 12 19:54:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ex7a0-00058f-8N
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 19:53:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbWALSxp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 13:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932665AbWALSxp
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 13:53:45 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:3055 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932465AbWALSxo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2006 13:53:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060112185348.TAKZ25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 12 Jan 2006 13:53:48 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601121006040.3535@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 12 Jan 2006 10:10:31 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14577>

Linus Torvalds <torvalds@osdl.org> writes:

> Well, especially if you want to use "git push" to basically back up your 
> own repo, you do want the "--all" flag. Otherwise you will then forget to 
> add a branch name to every remotes file whenyou create a new branch.

Sorry, I was unclear in my original message, but I meant to
require at least one refspec to be given to the command.  Ways
to give refspec to the command are:

 (1) give one or more from the command line
 (2) give --all from the command line
 (3) give none from the command line, but in this case you need
     at least one "Push:" the "remotes" file you use.

We already have --all, but your "git push --tags $remote" makes
sense.  For backups, "only matching things" is not good enough,
and we need --all.
