From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] rebase --no-verify
Date: Mon, 6 Oct 2008 09:14:24 -0700
Message-ID: <20081006161424.GE8203@spearce.org>
References: <20081005222654.6117@nanako3.lavabit.com> <b19eae4e0810021710v14a3901an1f793de00c439ba1@mail.gmail.com> <20081006141429.6117@nanako3.lavabit.com> <20081006143028.GC7684@spearce.org> <20081006160716.GC14479@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Mon Oct 06 18:17:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmskB-0002DP-Gq
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 18:15:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752501AbYJFQOZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 12:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752503AbYJFQOZ
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 12:14:25 -0400
Received: from george.spearce.org ([209.20.77.23]:47376 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752297AbYJFQOY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 12:14:24 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 1891C3835F; Mon,  6 Oct 2008 16:14:24 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20081006160716.GC14479@leksak.fem-net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97601>

Stephan Beyer <s-beyer@gmx.net> wrote:
> Shawn O. Pearce wrote:
> > >     It probably is better to fix "rebase -i" to share more code with the main
> > >     "rebase" script to avoid duplicated run-pre-rebase-hook function, but it
> > >     is beyond what I can do right now.  Perhaps people more smart and
> > >     beautiful than me can help (^_^;)
> > 
> > True.  But its already a mess.  git-sequencer is probably the
> > right approach to merge it all together.
> 
> Hmm, I don't think I like the pre-rebase hook in sequencer. The user
> scripts (git-rebase--interactive.sh and git-rebase.sh) should run them;
> that's ok.

Sorry, my remark wasn't about the rebase hook as much as it was
that there is a good chunk of code duplicated between the two
rebase implementations and all of them were implemented through
git-sequencer its likely they could all collapse into a single
common "git rebase" wrapper script which just sets up the call
to git-sequencer.

So yea, I do agree, the pre-rebase hook should be in rebase, not
git-sequencer, but git-sequencer probably offers a great way to
get the different rebase implementations combined together.
 
> I think, for the moment it is ok to have the code duplicated.  After
> sequencer has merged into master[1], I will probably take a look at
> merging git-rebase.sh and git-rebase--interactive.sh if somebody
> else is interested in it and if there is a good way to achieve that.

Yup, exactly my thoughts.  I just didn't express them well.

-- 
Shawn.
