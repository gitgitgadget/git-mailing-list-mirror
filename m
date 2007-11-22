From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/5] Colors for git-add--interactive
Date: Thu, 22 Nov 2007 06:57:28 -0500
Message-ID: <20071122115728.GD12913@sigill.intra.peff.net>
References: <20071017015152.GN13801@spearce.org> <20071022164048.71a3dceb@danzwell.com> <20071023042702.GB28312@coredump.intra.peff.net> <20071023035221.66ea537f@danzwell.com> <20071102224100.71665182@paradox.zwell.net> <20071104045735.GA12359@segfault.peff.net> <7v640ivagv.fsf@gitster.siamese.dyndns.org> <20071104054305.GA13929@sigill.intra.peff.net> <20071110180109.34febc3f@paradox.zwell.net> <20071122045437.46ee4638@paradox.zwell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Jakub Narebski <jnareb@gmail.com>
To: Dan Zwell <dzwell@zwell.net>
X-From: git-owner@vger.kernel.org Thu Nov 22 12:57:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvAgm-0002MW-TV
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 12:57:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752274AbXKVL5b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 06:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752224AbXKVL5b
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 06:57:31 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3681 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752002AbXKVL5a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 06:57:30 -0500
Received: (qmail 23060 invoked by uid 111); 22 Nov 2007 11:57:28 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 22 Nov 2007 06:57:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Nov 2007 06:57:28 -0500
Content-Disposition: inline
In-Reply-To: <20071122045437.46ee4638@paradox.zwell.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65810>

On Thu, Nov 22, 2007 at 04:54:37AM -0600, Dan Zwell wrote:

> - Does not always properly color the output of git-diff --cc, because
>   the diff-coloring regular expressions do not match every diff line.
>   I'm not sure that git-add--interactive normally gets used in the same
> situations as git-diff --cc. They don't seem to work well, together,
> from the little that I tested (without the color patches applied).
> There are a few solutions, but I haven't thought of one that's both
> reliable and clean. My impression is that diff --cc is called any time
> that HEAD has two parents. Is this correct?

I think the only time that git-add--interactive is likely to see a
combined diff is when you have unmerged entries in the index. Something
like:

  $ mkdir foo && cd foo && git init
  $ touch file && git add file && git commit -m added
  $ echo master >file && git commit -a -m master
  $ git checkout -b other HEAD^
  $ echo other >file && git commit -a -m other
  $ git merge master
  $ git diff

-Peff
