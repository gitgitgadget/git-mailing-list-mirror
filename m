From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] checkout: no progress messages if !isatty(2).
Date: Thu, 24 May 2012 14:34:57 -0400
Message-ID: <20120524183457.GA11841@sigill.intra.peff.net>
References: <20120524061000.GA14035@sigill.intra.peff.net>
 <1337839944-4651-1-git-send-email-apenwarr@gmail.com>
 <7vy5ohwhy7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 24 20:35:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXcsP-0005gT-8Z
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 20:35:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758857Ab2EXSfB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 14:35:01 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53927
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754494Ab2EXSe7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 14:34:59 -0400
Received: (qmail 30397 invoked by uid 107); 24 May 2012 18:35:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 May 2012 14:35:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 May 2012 14:34:57 -0400
Content-Disposition: inline
In-Reply-To: <7vy5ohwhy7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198405>

On Thu, May 24, 2012 at 11:29:52AM -0700, Junio C Hamano wrote:

> I do not seem to find a sane justification for
> 
> 	git $cmd --progress 2>output
> 
> use case and I do not immediately see how that "output" file can be
> useful.  But we've allowed it for a long time, so probably this version is
> safer.  Besides, it is more explicit.

Actually, I ran across a case of this just recently. If you are writing
a graphical interface that wraps git, scraping "--progress" output from
a pipe is the only way you can provide a progress meter within your
interface. That is what the "GitHub for {Mac,Windows}" interfaces do
(they also use libgit2 where possible, but it is far from feature
complete).

-Peff
