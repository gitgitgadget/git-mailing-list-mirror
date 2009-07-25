From: Mattias Nissler <mattias.nissler@gmx.de>
Subject: Re: [ANNOUNCE] GIT 1.6.4-rc2
Date: Sat, 25 Jul 2009 15:39:24 +0200
Message-ID: <1248529164.4593.8.camel@kea>
References: <7vd47r298e.fsf@alter.siamese.dyndns.org>
	 <20090724093847.GA20338@dcvr.yhbt.net>
	 <7vk51ykm42.fsf@alter.siamese.dyndns.org>
	 <20090725103821.GA13534@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Jul 25 15:39:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUhTN-0005cT-8f
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 15:39:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752926AbZGYNj2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 09:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752911AbZGYNj2
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 09:39:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:58858 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752877AbZGYNj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 09:39:27 -0400
Received: (qmail invoked by alias); 25 Jul 2009 13:39:26 -0000
Received: from d187074.adsl.hansenet.de (EHLO [192.168.1.50]) [80.171.187.74]
  by mail.gmx.net (mp054) with SMTP; 25 Jul 2009 15:39:26 +0200
X-Authenticated: #429267
X-Provags-ID: V01U2FsdGVkX1+nGmV8xUCnRi58x5Cgdp716Bc0LKFD5QCJwRvOwO
	wq+aUxy/vdLo12
In-Reply-To: <20090725103821.GA13534@dcvr.yhbt.net>
X-Mailer: Evolution 2.26.2 
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124005>

On Sat, 2009-07-25 at 03:38 -0700, Eric Wong wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
> > Eric Wong <normalperson@yhbt.net> writes:
> > > Junio C Hamano <gitster@pobox.com> wrote:
> > >>  * git-svn updates, including a new --authors-prog option to map author
> > >>    names by invoking an external program, 'git svn reset' to unwind
> > >>    'git svn fetch', support for more than one branches, etc.
> > >
> > > I completely forgot the implications of a change made in commit
> > > 0b2af457a49e3b00d47d556d5301934d27909db8.  This change probably doesn't
> > > affect a lot of repos out there, but --minimize-url is no longer the
> > > default for new imports.
> 
> > > Let me know if the above made sense, it's late and I nodded off
> > > several times while writing this.
> > 
> > Your description makes sense, and I suspect that the old default may be
> > easier to work with.
> 
> Yes.  I think the old default makes more sense, so I'll be reverting
> back to it.  However, I'll make it possible to override from the
> command-line.

Maybe we should rather try to detect whether we have read access to the
repository root and adjust behaviour accordingly? Or at least print a
warning when cloning restricted multi-branch repos, since this just
fails silently (doesn't pick up any branches) when you have minimize_url
enabled.

Mattias
