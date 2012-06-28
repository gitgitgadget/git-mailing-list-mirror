From: Chris Webb <chris@arachsys.com>
Subject: Re: [PATCH 2/3] Allow help.htmlpath to be an http: URL
Date: Thu, 28 Jun 2012 07:56:23 +0100
Message-ID: <20120628065623.GB1742@arachsys.com>
References: <7vwr2s5f9v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 28 08:56:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sk8eY-0005GS-NS
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jun 2012 08:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403Ab2F1G4a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jun 2012 02:56:30 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:49802 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932355Ab2F1G43 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2012 02:56:29 -0400
Received: from [81.2.114.212] (helo=arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.72)
	(envelope-from <chris@arachsys.com>)
	id 1Sk8eR-0005XI-BA; Thu, 28 Jun 2012 07:56:27 +0100
Content-Disposition: inline
In-Reply-To: <7vwr2s5f9v.fsf@alter.siamese.dyndns.org>
 <20120627225248.GB27566@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200776>

Jeff King <peff@peff.net> writes:

> On Wed, Jun 27, 2012 at 11:19:39PM +0100, Chris Webb wrote:
> 
> > How about only testing for a git documentation directory if both
> > help.htmlpath isn't set (so we're using the compiled-in version) and the
> > compiled-in version doesn't contain ://?
> 
> That just seems needlessly complex. Why not just check for "://" and be
> done?
[...]
> So one solution would be to simply remove the check entirely. It was a
> slight nicety in some situations, but expanding the definition of the
> HTML path to include full URLs means we can no longer accurately
> determine what exists and what does not. So we can just stop trying and
> let the browser handle it completely.

Junio C Hamano <gitster@pobox.com> writes:

> This, and "://", both sound sensible.

I have no real preference between any of the suggestions so far: they'd all
be completely fine with me. Peff's :// test for a URL is much better than my
http: prefix, so should replace the latter if we need a test at all, but
apart from that I don't mind at all.

Okay, I'll re-send now the :// version I did in response to Peff's first
email purely on the basis that it doesn't change the behaviour at all for
existing users who don't set htmlpath at all, plus it's already sat in my
reflog!

However, if you'd both prefer a version in which I just take the check out
altogether, let me know and I'll spin that instead.

Cheers,

Chris.
