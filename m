From: Jeff King <peff@peff.net>
Subject: Re: Proposal: create meaningful aliases for git reset's
 hard/soft/mixed
Date: Tue, 18 Dec 2012 11:30:57 -0500
Message-ID: <20121218163057.GB20122@sigill.intra.peff.net>
References: <CAGK7Mr4GZq5eXn4OB+B0ZborX-OVoXiWU8Lo1XM5LRZDuRe1YA@mail.gmail.com>
 <7vlir6brjw.fsf@alter.siamese.dyndns.org>
 <CANiSa6h3Qf=6hw6fzHVw=CeuhnNeq+cuEvwwmVhUaSOcVgCSBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Philippe Vaucher <philippe.vaucher@gmail.com>,
	git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 17:31:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tl04c-0005Oo-5V
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 17:31:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109Ab2LRQbA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2012 11:31:00 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:57681 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755211Ab2LRQa7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 11:30:59 -0500
Received: (qmail 18918 invoked by uid 107); 18 Dec 2012 16:32:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 18 Dec 2012 11:32:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Dec 2012 11:30:57 -0500
Content-Disposition: inline
In-Reply-To: <CANiSa6h3Qf=6hw6fzHVw=CeuhnNeq+cuEvwwmVhUaSOcVgCSBA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211758>

On Mon, Dec 17, 2012 at 10:34:07PM -0800, Martin von Zweigbergk wrote:

> On Wed, Nov 23, 2011 at 10:51 AM, Junio C Hamano <gitster@pobox.com> wrote:
> >
> > I am guilty of introducing "git reset --soft HEAD^" before I invented
> > "commit --amend" during v1.3.0 timeframe to solve the issue "soft" reset
> > originally wanted to.
> 
> I do use "commit --amend" a lot, but I still appreciate having "reset
> --soft". For example, to squash the last few commits:
> 
> git reset --soft HEAD^^^ && git commit --amend

Me too. Another one I use is:

  $ hack hack hack
  $ git commit -m wip
  $ git checkout something-else
  ... time passes ...
  $ git checkout orig-branch
  $ git reset --soft HEAD^
  $ hack hack hack
  $ git diff
  $ git add -p
  $ git commit

which ends up with the same history as "commit --amend", but in between
the reset and the commit, the bogus WIP commit is thrown away entirely.
And things like "diff" and "add -p" do what you want, instead of showing
your progress on top of the WIP.

-Peff
