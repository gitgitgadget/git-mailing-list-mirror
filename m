From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-add--interactive.perl: Permit word-based diff
Date: Tue, 18 Jun 2013 02:31:46 -0400
Message-ID: <20130618063144.GA6276@sigill.intra.peff.net>
References: <CAMNuMARruu+1=kny=g5O1MoxCXuoT3BHdSEEPSqvyn2t2JsAYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Mark Abraham <mark.j.abraham@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 08:31:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UopSM-0002T9-8k
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 08:31:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752523Ab3FRGbu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 02:31:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:34651 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752759Ab3FRGbt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 02:31:49 -0400
Received: (qmail 24201 invoked by uid 102); 18 Jun 2013 06:32:46 -0000
Received: from mobile-032-141-227-127.mycingular.net (HELO sigill.intra.peff.net) (32.141.227.127)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 18 Jun 2013 01:32:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Jun 2013 02:31:46 -0400
Content-Disposition: inline
In-Reply-To: <CAMNuMARruu+1=kny=g5O1MoxCXuoT3BHdSEEPSqvyn2t2JsAYg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228159>

On Sat, Jun 15, 2013 at 04:01:04PM +0200, Mark Abraham wrote:

> Controlled by new configuration option
> "color.word-diff-in-interactive-add". There is no existing support for
> "git add" to pass a command-line option like "--word-diff=color" to
> git-add--interactive.perl, so a configuration option is the only
> lightweight solution.
> 
> With this feature, the added or deleted form of a hunk can be empty,
> so made some necessary checks for $_ being defined.

Hmm. We can't apply a word-diff, so presumably your "permit" here is
just for the display, replacing the colorized bits. And that looks like
what your patch does.

Note that the number of lines in your --word-diff=color hunk and the
actual diff will not necessarily be the same.  What happens if I split a
hunk with your patch?

-Peff
