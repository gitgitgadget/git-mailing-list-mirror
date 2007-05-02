From: Petr Baudis <pasky@suse.cz>
Subject: Re: Git benchmarks at OpenOffice.org wiki
Date: Wed, 2 May 2007 18:15:15 +0200
Message-ID: <20070502161515.GC4489@pasky.or.cz>
References: <200705012346.14997.jnareb@gmail.com> <200705021624.25560.kendy@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	releases@openoffice.org
To: Jan Holesovsky <kendy@suse.cz>
X-From: git-owner@vger.kernel.org Wed May 02 18:15:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjHUB-0003Bd-Kf
	for gcvg-git@gmane.org; Wed, 02 May 2007 18:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993443AbXEBQPU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 May 2007 12:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993444AbXEBQPU
	(ORCPT <rfc822;git-outgoing>); Wed, 2 May 2007 12:15:20 -0400
Received: from w241.dkm.cz ([62.24.88.241]:36184 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2993443AbXEBQPS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2007 12:15:18 -0400
Received: (qmail 19437 invoked by uid 2001); 2 May 2007 18:15:15 +0200
Content-Disposition: inline
In-Reply-To: <200705021624.25560.kendy@suse.cz>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46030>

On Wed, May 02, 2007 at 04:24:24PM CEST, Jan Holesovsky wrote:
> > What might help here is splitting repository into current (e.g. from
> > OOo 2.0) and historical part,
> 
> No, I don't want this ;-)

Are you sure? Using the graft mechanism, Git can make this very easy and
almost transparent for the user - when he clones he gets no history but
he can use say some simple vendor-provided script to download the
historical packfile and graft it to the 'current' tree. After that, the
graft acts completely transparently and it 'seems' like the history
goes on continuously from OOo prehistory up to the latest commit.

Besides, in case you discover a year later that the conversion was
broken in some places etc., you can just fix this, re-run the conversion
and simply regraft your history to point at the 'new' historical commit,
without affecting your current development and commit ids at all. For
this reason alone, I'd seriously consider grafting history separately
when migrating any non-trivial project from other SCM to Git.

Then again, due to the sheer tree sizes etc., I'm not sure how much
would throwing the history away actually reduce the packfile size.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
