From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] rebase -i: correctly remember --root flag across
	--continue
Date: Mon, 26 Jan 2009 16:09:42 -0500
Message-ID: <20090126210942.GH27604@coredump.intra.peff.net>
References: <7vtz7ma9z1.fsf@gitster.siamese.dyndns.org> <1232960722-17480-1-git-send-email-trast@student.ethz.ch> <7veiyp4w2m.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 26 22:12:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRYk7-0006UP-GD
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 22:11:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753454AbZAZVJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 16:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752215AbZAZVJp
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 16:09:45 -0500
Received: from peff.net ([208.65.91.99]:56284 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752719AbZAZVJo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 16:09:44 -0500
Received: (qmail 6635 invoked by uid 107); 26 Jan 2009 21:09:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 26 Jan 2009 16:09:52 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Jan 2009 16:09:42 -0500
Content-Disposition: inline
In-Reply-To: <7veiyp4w2m.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107277>

On Mon, Jan 26, 2009 at 01:05:37PM -0800, Junio C Hamano wrote:

> > +test_expect_success 'rebase -i --root with conflict (first part)' '
> > +	git checkout -b conflict2 other &&
> > +	GIT_EDITOR=: test_must_fail git rebase -i --root --onto master &&
> > +	git ls-files -u | grep "B$"
> > +'
> 
> Maybe I am misrecalling things but didn't we have reports from people on
> some platforms that single-shot exporting of the environment like this one
> does not work for them?

I don't think you are misrecalling. The problem is with one-shot
variables and functional calls. See 09b78bc1.

-Peff
