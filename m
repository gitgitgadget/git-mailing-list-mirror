From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] Documentation: update git-pull.txt for clone's new default behavior
Date: Sun, 31 Dec 2006 23:53:53 -0800 (PST)
Message-ID: <452383.57759.qm@web31813.mail.mud.yahoo.com>
References: <20070101054536.GG15537@fieldses.org>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 01 08:54:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1Hzb-00007H-0j
	for gcvg-git@gmane.org; Mon, 01 Jan 2007 08:53:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932943AbXAAHxy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Jan 2007 02:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933247AbXAAHxy
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jan 2007 02:53:54 -0500
Received: from web31813.mail.mud.yahoo.com ([68.142.207.76]:35002 "HELO
	web31813.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932943AbXAAHxy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Jan 2007 02:53:54 -0500
Received: (qmail 59708 invoked by uid 60001); 1 Jan 2007 07:53:53 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=C06s1MUld84britBrDsuvKkEaTYxfHeeiWw9FINTUKGINUmm64lkGhKeeXolnjKtvks53pgiWM+dWMPw7oD9/mXaTwQ6Hd7hN4EORD7pVBkkH6u0KwWAoOUlrsBs1V0F2g0xj761QaPawjLNK0GC90rzQ0fT2Gl8z0KtzM9A+/A=;
X-YMail-OSG: v4KzNwwVM1nbilRQri106BW67lcnJHlmMdL4xpGSoOpJkS9Tn.IDB0AnxJIRiwMrq7QEeVhLb39t4hT_YVPzZvklxJo3N2jbw7sk56bbIVKAR9n._BK7AdBvKQDY9gXbQ6htr.d.CM8iuNJdaHvtXlI68nnAgtZaCfUkHCSpzhoVRaWXmsjblVH_
Received: from [71.84.31.238] by web31813.mail.mud.yahoo.com via HTTP; Sun, 31 Dec 2006 23:53:53 PST
To: "J. Bruce Fields" <bfields@fieldses.org>
In-Reply-To: <20070101054536.GG15537@fieldses.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35730>

--- "J. Bruce Fields" <bfields@fieldses.org> wrote:
> On Sun, Dec 31, 2006 at 09:13:49PM -0800, Luben Tuikov wrote:
> > Yes, but I don't want to just type "git-pull", I want to explicitly
> > type "git-pull parent" and depending in which branch I'm at, "parent"
> > would have identical meaning but would merge a different branch... because
> > I'm in a different branch...
> 
> Wouldn't it do what you want if by default "git branch new" and "git
> checkout -b new" set branch.* options that pointed at the "parent"
> branch?

Technically yes.  Presentationally no.

> The only reason I can see to require the extra bit of syntax ("git-pull
> parent" instead of "git-pull") is if for the same branch you expect to
> sometimes pull from one source and sometimes from another, and the pulls
> from those various sources are common enough that it's worth defining
> some shortcuts for more than one of them.

Exactly.

> I can imagine sometimes doing that.  (E.g. if you pull into your master
> branch from upstream and from local topic branches.)  But in that case
> having to give the remote and branch name explicitly doesn't seem so
> bad.

Basically I want to _name_ the dependency, instead of having it be
implicit.  One can extend that dependency, in more complicated
topic branch relationship, where for example, C extends B, B extends
A, A extends master, but B' also extends A, consider B' a "version"
of the extension which B implements.  This is of course a trivial
example and more complicated ones exist.

Naming the dependency would give git greater coverage when it needs
to implement complicated source development environments and code
relationship. IOW, it is the way to go.  Having a single implicit
dependency is just a crutch, half-way there.

Or, one can look at it in a different way, extending the
remote/ functionality as is, but instead of being remote-pulls-
into-local, extending for local pulls into local.

I.e. the remote relationship is named,  I'd like to extend
this locally as well.

Consider the examples of "branch.<name>.<symbolic_ref>.{fetch, merge}"
I gave in a previous email in this thread.

     Luben
