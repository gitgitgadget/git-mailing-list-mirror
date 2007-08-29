From: Petr Baudis <pasky@suse.cz>
Subject: Re: repo.or.cz wishes?
Date: Wed, 29 Aug 2007 11:58:18 +0200
Message-ID: <20070829095818.GG1219@pasky.or.cz>
References: <20070826235944.GM1219@pasky.or.cz> <Pine.LNX.4.64.0708270933450.28586@racer.site> <20070828041059.GK18160@spearce.org> <20070828111913.GA31120@thunk.org> <20070829041523.GS18160@spearce.org> <7vr6lnszay.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Theodore Tso <tytso@mit.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 29 11:58:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQKJi-0000vN-Cl
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 11:58:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759328AbXH2J6Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 05:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759101AbXH2J6W
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 05:58:22 -0400
Received: from w241.dkm.cz ([62.24.88.241]:44610 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758537AbXH2J6T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 05:58:19 -0400
Received: (qmail 945 invoked by uid 2001); 29 Aug 2007 11:58:18 +0200
Content-Disposition: inline
In-Reply-To: <7vr6lnszay.fsf@gitster.siamese.dyndns.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56923>

On Wed, Aug 29, 2007 at 07:08:21AM CEST, Junio C Hamano wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > Theodore Tso <tytso@mit.edu> wrote:
> >> On Tue, Aug 28, 2007 at 12:10:59AM -0400, Shawn O. Pearce wrote:
> >> > Its what happens when you use `git clone --shared A B` and the
> > ...
> >> This has been discussed before, and it wouldn't be *that* hard to have
> >> "git clone --shared" create a backpointer from B to A, so that
> >> "git-prune" could also search the B's refs and not prune anything that
> >> is in A which is reachable from heads in A and B.
> >
> > Not if I already have a pointer from B to A's refs.  repo.or.cz
> > also has this same pointer:
> >
> > 	git clone --shared A B
> > 	ln -s A/refs B/refs/forkee
> 
> Two things to watch out for are (1) packed refs won't be
> protected with this trick, and (2) symrefs in refs/ hierarchy
> will point at wrong place if you did this.  The latter hopefully
> won't be a problem because the trick being discussed is only to
> add reachability and not _using_ the borrowed refs for anything
> (iow, this makes B/refs/forkee/remote/origin/HEAD incorrectly
> point at refs/remotes/origin/master, but what it really should
> point at is B/refs/forkee/remote/origin/master).

BTW gitweb actually uses refs/forkee/ to add funny ref tags to commits,
which was completely unintended but is actually in the end quite handy
(though the tags should be modified to look less confusing).

-- 
				Petr "Pasky" Baudis
Early to rise and early to bed makes a male healthy and wealthy and dead.
                -- James Thurber
