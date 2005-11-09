From: Petr Baudis <pasky@suse.cz>
Subject: Re: hgmq vs. StGIT
Date: Thu, 10 Nov 2005 00:32:55 +0100
Message-ID: <20051109233255.GI30496@pasky.or.cz>
References: <20051101002554.GA7634@thunk.org> <20051101090804.GA11618@pasky.or.cz> <b0943d9e0511010123i1f9eb679w@mail.gmail.com> <436787BD.9080705@citi.umich.edu> <20051101153650.GB26847@watt.suse.com> <b0943d9e0511010918ob2dbcfcv@mail.gmail.com> <20051101181352.GD26847@watt.suse.com> <b0943d9e0511011330v7045c568u@mail.gmail.com> <20051102154108.GM26847@watt.suse.com> <b0943d9e0511051223g74c2be43h@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Mason <mason@suse.com>, Chuck Lever <cel@citi.umich.edu>,
	Theodore Ts'o <tytso@mit.edu>,
	Joel Becker <Joel.Becker@oracle.com>,
	Junio C Hamano <junkio@cox.net>, pavel@ucw.cz,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 00:34:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZzR7-0002Fi-4k
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 00:33:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751579AbVKIXc6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 18:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030AbVKIXc6
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 18:32:58 -0500
Received: from w241.dkm.cz ([62.24.88.241]:23458 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750705AbVKIXc5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Nov 2005 18:32:57 -0500
Received: (qmail 11805 invoked by uid 2001); 10 Nov 2005 00:32:55 +0100
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <b0943d9e0511051223g74c2be43h@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11439>

Dear diary, on Sat, Nov 05, 2005 at 09:23:33PM CET, I got a letter
where Catalin Marinas <catalin.marinas@gmail.com> said that...
> I would like to have a way of checking the changes to individual
> patches, just to be able to go back if some changes broke it.

Yes, that would be nice to have as well (although in general I lean to
recording the whole stack now). Model scenario:

A night city, the snow slowly falling. Approaching the roofs covered in
white and illuminated by the yellow street lighting, dark windows - but
one dimly glowing, a computer screen inside. Close-up on a hacker:
$EDITOR opened, lost deep in hack mode, fingers dancing over the
keyboard.  Dreamy-monumental music in the background.

StGIT user, only part of the patches in stack, and the rest depends on
the one currently edited, and I want to record my work on this one.
I can either:

(i) Just keep per-patch history only.

(ii) Keep _both_ per-patch and per-stack history (since I don't want to
record the stack when I have to keep some patches out of it - the
history would look like randomly removing and adding tons of patches,
and jumping around would be difficult because of this too).

(iii) Keep per-patchlist history - do not actually record only our
current stack, but all the patches StGIT knows about. The patches
depending on the one currently being changed will not be in consistent
state, but that's tough. Actually, this seems to be the most viable
strategy. One question is whether to record if some patch is actually
applied right now or not (I'd say don't record it since you again have
the "bouncing problem" otherwise).

Ideas?

> It's also useful to have some kind of revision control for the whole
> stack, but this can be achieved with tags at the moment.

Yes, now let's sequence the tags... ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
