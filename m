From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Calling ssh from git-gui
Date: Wed, 3 Sep 2008 10:15:43 -0700
Message-ID: <20080903171543.GC28315@spearce.org>
References: <20080903165455.GU10544@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Sep 03 19:17:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kavyv-0006FV-Dv
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 19:17:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752394AbYICRPp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 13:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752342AbYICRPp
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 13:15:45 -0400
Received: from george.spearce.org ([209.20.77.23]:57337 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754320AbYICRPo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 13:15:44 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 94CF338375; Wed,  3 Sep 2008 17:15:43 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080903165455.GU10544@machine.or.cz>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94819>

Petr Baudis <pasky@suse.cz> wrote:
> 
>   I'm quite at loss by now searching for a reasonable solution for
> invoking ssh (either directly or through git fetch/git push) from
> git-gui, which is very problematic right now - doubly so when
> considering both UNIX and Win32.
> 
>   There are several scenarios to consider:
> 
>   (i) SSH to known host with key managed by a running agent.
>   (ii) SSH to host without agent running or without keys set up.
>   (iii) SSH to unknown host (unregistered fingerprint).
> 
>   Currently, (i) is the only scenario git-gui can handle, [...]
> 
>   Handling (ii) and (iii) unfortunately turned out to be very tricky.

And that is why it doesn't handle (ii) or (iii) at the present time,
and unless I am given a nice patch series for any git-gui related
parts of this, why it will continue to remain that way for quite
some time.

Its annoying, and people complain about it, but I know of no good
solution here, and neither it seems does anyone else.  :-|

At prior day-job I had a customized git-gui starting an rxvt on
Cygwin to run some in-house command line scripts, which in turn
called git fetch and git push.  These worked just fine obviously in
an rxvt, it was a full tty that SSH could interact with the user on.

Damn annoying for git-gui to be invoking a new terminal window, but
maybe that's what we have to do.  Be nice though if the window only
was opened because we couldn't do "git ls-remote url" but its hard
to tell "hanging because SSH needs the user" and "hanging because
the network is a 2400 baud modem".

-- 
Shawn.
