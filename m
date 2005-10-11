From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] cg-tag - add support for longer commit messages
Date: Wed, 12 Oct 2005 01:39:40 +0200
Message-ID: <20051011233940.GJ30889@pasky.or.cz>
References: <11289987493327-git-send-email-martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 12 01:41:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPTiq-0002tD-1F
	for gcvg-git@gmane.org; Wed, 12 Oct 2005 01:39:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbVJKXjt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Oct 2005 19:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbVJKXjt
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Oct 2005 19:39:49 -0400
Received: from w241.dkm.cz ([62.24.88.241]:2025 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932363AbVJKXjs (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Oct 2005 19:39:48 -0400
Received: (qmail 16878 invoked by uid 2001); 12 Oct 2005 01:39:40 +0200
To: Martin Langhoff <martin@catalyst.net.nz>
Content-Disposition: inline
In-Reply-To: <11289987493327-git-send-email-martin@catalyst.net.nz>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9991>

Dear diary, on Tue, Oct 11, 2005 at 04:45:49AM CEST, I got a letter
where Martin Langhoff <martin@catalyst.net.nz> told me that...
> Added an -m switch that points to a filename which contains a (potentially
> long) tag message.
> 
> Bugs: Could alternatively be implemented via STDIN.

Hmm. Well, the '-d' option is silly and that's really what should read
as '-m', to keep it the same as cg-commit. Actually, I'd like to have it
as similar as possible, so it would be ideal to have cg-tag do something
like

	if got_argument '-e'; then
		if tty -s; then
			throw_together_some_CG:_stuff
			$EDITOR
			parse_the_CG:_stuff
		else
			cat >>logmsg
		fi
	fi

to keep it symmetric to cg-commit (except that it won't require the
message if you don't bother to pass it anything). Well, I guess the CG:
stuff parsing is lower priority (and would require some factoring out of
the common code from cg-commit), so I'll do the simple part soon
(today or on Thursday) if noone does it first. *hint* *hint* ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
