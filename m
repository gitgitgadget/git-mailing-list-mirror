From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add the possibility to specify a default help format
Date: Wed, 6 Jun 2012 09:53:53 -0400
Message-ID: <20120606135353.GD2597@sigill.intra.peff.net>
References: <1338987397-7376-1-git-send-email-vfr@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Wed Jun 06 15:54:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScGgS-0002v4-AB
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 15:54:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753488Ab2FFNx4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jun 2012 09:53:56 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:44994
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752529Ab2FFNx4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2012 09:53:56 -0400
Received: (qmail 2389 invoked by uid 107); 6 Jun 2012 13:53:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Jun 2012 09:53:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Jun 2012 09:53:53 -0400
Content-Disposition: inline
In-Reply-To: <1338987397-7376-1-git-send-email-vfr@lyx.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199333>

On Wed, Jun 06, 2012 at 12:56:37PM +0000, Vincent van Ravesteijn wrote:

> At the moment, the default help format (i.e. the format that is chosen if
> 'git help xxx' is called without a help format parameter) is defined by
> the switch to be 'man'. However, on different platforms the preferred
> format might differ. For example, on Windows there is no man viewer, so we
> would prefer html.
> 
> This patch adds the possibility to choose a default help format on
> compilation by defining DEFAULT_HELP_FORMAT. If it is not specified the
> default is still 'man'.

Makes sense to me.

> ---
>  builtin/help.c |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)

Should there be some minor infrastructure in the Makefile so you can do:

  make DEFAULT_HELP_FORMAT=man

rather than:

  make CFLAGS='-DDEFAULT_HELP_FORMAT=\"man\"'

(and the Makefile would be a good place to advertise this build knob,
too)?

-Peff
