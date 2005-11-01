From: Petr Baudis <pasky@suse.cz>
Subject: Re: hgmq vs. StGIT
Date: Tue, 1 Nov 2005 11:10:04 +0100
Message-ID: <20051101101004.GD11618@pasky.or.cz>
References: <Pine.LNX.4.63.0510311111340.2916@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0510310804400.27915@g5.osdl.org> <20051031195010.GM11488@ca-server1.us.oracle.com> <7vr7a1e719.fsf@assigned-by-dhcp.cox.net> <20051031213616.GO11488@ca-server1.us.oracle.com> <7vk6ftcp0d.fsf@assigned-by-dhcp.cox.net> <20051031224246.GP11488@ca-server1.us.oracle.com> <20051101002554.GA7634@thunk.org> <20051101090804.GA11618@pasky.or.cz> <b0943d9e0511010123i1f9eb679w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Ts'o <tytso@mit.edu>,
	Joel Becker <Joel.Becker@oracle.com>,
	Junio C Hamano <junkio@cox.net>, mason@suse.com,
	git@vger.kernel.org, Chuck Lever <cel@citi.umich.edu>
X-From: git-owner@vger.kernel.org Tue Nov 01 11:11:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWt5n-0006Lq-NQ
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 11:10:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbVKAKKI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 05:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750703AbVKAKKI
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 05:10:08 -0500
Received: from w241.dkm.cz ([62.24.88.241]:23467 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750705AbVKAKKH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Nov 2005 05:10:07 -0500
Received: (qmail 4631 invoked by uid 2001); 1 Nov 2005 11:10:04 +0100
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <b0943d9e0511010123i1f9eb679w@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10930>

Dear diary, on Tue, Nov 01, 2005 at 10:23:55AM CET, I got a letter
where Catalin Marinas <catalin.marinas@gmail.com> told me that...
> On 01/11/05, Petr Baudis <pasky@suse.cz> wrote:
> > and the fact that I cannot version my changes to patches
> > - this is one advantage of having quilt stuff tracked by GIT, I think,
> > but that feels ugly.
> 
> That's not too far away. Chuck Lever has a patch (and there were some
> other discussions in the past) for tracking the history of a patch.
> Basically, there would be another commit object, not reachable from
> HEAD but only via an StGIT command, which would chain all the versions
> of a patch. You would be able to view them with gitk for example.

Perhaps you could emulate the topical branches - one patch == one head.
E.g. for patch foo-bar on branch 'master', you would create head
master/foo-bar, etc.

> My main issue was whether we should store every state resulted from a
> refresh  or use a separate command (somebody suggested 'freeze') to
> mark the states that should be preserved in the history. Chuck's patch
> implements the first. The drawback is that a future 'stg prune'
> command would not be able to remove the history and some states of the
> patch might not be useful (there are times when I do a refresh only to
> pop the patch and modify a different one, without any logical meaning
> for the state of the patch).

I'd prefer the snapshotting being done in refresh anyway. Perhaps you
would be asked for log message when you refresh by default, but when you
refresh -n or something, only a temporary commit would be created and
next refresh would mutate it instead of creating another commit.

Anyway, "freeze" is confusing. Perhaps "snapshot" if anything...

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
