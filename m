From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add new git-graph command
Date: Tue, 1 Apr 2008 01:02:29 -0400
Message-ID: <20080401050229.GA23876@coredump.intra.peff.net>
References: <20080330195840.GA8695@adamsimpkins.net> <200803312017.28354.tlikonen@iki.fi> <9b3e2dc20803312105i1f890784v29928321e3e51374@mail.gmail.com> <200804010729.51202.tlikonen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stephen Sinclair <radarsat1@gmail.com>, git@vger.kernel.org,
	Adam Simpkins <adam@adamsimpkins.net>
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Tue Apr 01 07:03:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgYeT-0007fx-2f
	for gcvg-git-2@gmane.org; Tue, 01 Apr 2008 07:03:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbYDAFCd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2008 01:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750868AbYDAFCd
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Apr 2008 01:02:33 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4007 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750748AbYDAFCd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2008 01:02:33 -0400
Received: (qmail 29887 invoked by uid 111); 1 Apr 2008 05:02:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 01 Apr 2008 01:02:30 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Apr 2008 01:02:29 -0400
Content-Disposition: inline
In-Reply-To: <200804010729.51202.tlikonen@iki.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78628>

On Tue, Apr 01, 2008 at 07:29:51AM +0300, Teemu Likonen wrote:

> Adam's 'git graph' is a way of viewing log (in terminal environment), it 
> looks very similar to 'git log --pretty=oneline' and it accepts very 
> much the same command line options. That's why I see 'git log' being 
> logical place for such functionality.

Adam suggested that it may be possible to abstract the graphing API so
that it can be called progressively. I would love to see:

  git log --pretty=format:'%g %h %s'

where %g would be "the graph lines for this commit." But maybe that is
not workable since the graph may take multiple lines to show.

> Actually, to me it would be more logical if 'git whatchanged' was 'git 
> log --changed' or '--verbose / -v' something.

How about:

  git log --raw --full-history --always

which is identical. Though in most cases, one would be happy with "git
log --raw". I think whatchanged really only exists separately because it
predates the merging of many of the revision-walking commands.

-Peff
