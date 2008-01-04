From: Jeff King <peff@peff.net>
Subject: Re: [BUG] git-diff-* --color oddness
Date: Fri, 4 Jan 2008 03:28:42 -0500
Message-ID: <20080104082842.GA3300@coredump.intra.peff.net>
References: <20080104081429.GA30635@coredump.intra.peff.net> <7vejcym21q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, win@wincent.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 04 09:29:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAhvT-0006kG-8i
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 09:29:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753428AbYADI2p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 03:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753420AbYADI2p
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 03:28:45 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4696 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752577AbYADI2o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 03:28:44 -0500
Received: (qmail 15827 invoked by uid 111); 4 Jan 2008 08:28:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 04 Jan 2008 03:28:43 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Jan 2008 03:28:42 -0500
Content-Disposition: inline
In-Reply-To: <7vejcym21q.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69558>

On Fri, Jan 04, 2008 at 12:24:01AM -0800, Junio C Hamano wrote:

> > Ordinarily, I would say "nobody should use --color with diff-files". But
> > we do, in git-add--interactive (see Wincent's 4af756f3).
> 
> The plumbing deliberately not calling ui_config does not have
> anything to do with them supporting explicit --color options.

I'm not sure what you mean here. Are you saying that it is the desired
behavior for "git-diff --color" to use my color.diff.* variables, but
for "git-diff-files --color" not to?

I think that's insane, and it makes "git-add -i" depending on
git-diff-file's colorization wrong (since in other parts it uses the
color.diff.* variables).

Not to mention the other bug (that diff-files _does_ read the config,
just halfway through).

-Peff
