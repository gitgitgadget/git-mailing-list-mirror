From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git gui: Possible to see which commands are executed?
Date: Tue, 20 May 2008 16:17:22 -0400
Message-ID: <20080520201722.GF29038@spearce.org>
References: <48301B17.30309@dirk.my1.cc> <20080519022125.GV29038@spearce.org> <4833206E.1080300@dirk.my1.cc> <20080520194403.GC29038@spearce.org> <bd6139dc0805201305k61807561k8026b4c6509e4041@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dirk =?utf-8?Q?S=C3=BCsserott?= <newsletter@dirk.my1.cc>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Tue May 20 22:18:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyYHw-0000Lt-Ad
	for gcvg-git-2@gmane.org; Tue, 20 May 2008 22:18:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759516AbYETURb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2008 16:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758403AbYETURb
	(ORCPT <rfc822;git-outgoing>); Tue, 20 May 2008 16:17:31 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:39144 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757297AbYETURa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2008 16:17:30 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JyYGq-0000LY-C8; Tue, 20 May 2008 16:17:16 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 39EB720FBAE; Tue, 20 May 2008 16:17:23 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <bd6139dc0805201305k61807561k8026b4c6509e4041@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82497>

Sverre Rabbelier <alturin@gmail.com> wrote:
> On Tue, May 20, 2008 at 9:44 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> > Junio defers almost all git-gui things to me, as I am the current
> > maintainer of git-gui.  You are right, it doesn't really hurt to
> > include it, and now that it is written, the hard part is already
> > done.  I'll apply it to my main git-gui tree and ask Junio to
> > include it in a future version of Git.
> 
> Hmmm, maybe you should include in big red letters that the output from
> --trace in no way or form represents commands that a user should use
> daily?

Yea, probably.

> I can hear the questions on #git already "I don't understand,
> I've used git-gui for months now, but the command it tells me to use
> make no sense!".

Yup.  Or even worse, a user thinking that the best way to create a
new commit on the command line is the ugly sequence of:

	git-write-tree
	git-commit-tree ... -p ... <msg
	git-update-ref HEAD ...

Gee, that's like Git on the day when it became self-hosting and
Linus created commit e83c5163316f89bfbde7d9ab23ca2e25604af290
('Initial revision of "git", the information manager from hell').

> Even better of course would be to not only print the plumbing commands
> but also the porcelain commands!

That is probably difficult.  Some of the code internally is more
about stringing the right sequence of plumbing together than it
is about a particular user action.  I think it would take a bit of
work to make it do this, and I just don't see a reason to do it.

CVS clients that show CVS commands can easily do so, because they
are directly executing the commands they show you.  This is likely
also true of SVN commands.  But git-gui on Git, that's a whole
different animal.

-- 
Shawn.
