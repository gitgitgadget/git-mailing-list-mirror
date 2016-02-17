From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/3] fix "v"iew subcommand in "git am -i"
Date: Wed, 17 Feb 2016 14:19:24 -0500
Message-ID: <20160217191923.GA16265@sigill.intra.peff.net>
References: <1455664017-27588-1-git-send-email-gitster@pobox.com>
 <1455736516-13466-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 20:19:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aW7dT-0004t6-Cf
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 20:19:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030464AbcBQTT3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 14:19:29 -0500
Received: from cloud.peff.net ([50.56.180.127]:44305 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965172AbcBQTT1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 14:19:27 -0500
Received: (qmail 4667 invoked by uid 102); 17 Feb 2016 19:19:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 Feb 2016 14:19:26 -0500
Received: (qmail 11052 invoked by uid 107); 17 Feb 2016 19:19:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 Feb 2016 14:19:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Feb 2016 14:19:24 -0500
Content-Disposition: inline
In-Reply-To: <1455736516-13466-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286539>

On Wed, Feb 17, 2016 at 11:15:13AM -0800, Junio C Hamano wrote:

> So the first patch in this series factors out a helper function to
> let the caller run the pager the right way.  They make the third
> patch to fix the breakage in "am" trivial.  Compared to v1, the
> helper was much simplified with help by Peff: it always and only
> takes child-process and the pager command string.  The caller can
> append extra command line arguments after the helper returns if it
> wants to.
> 
> Junio C Hamano (3):
>   pager: lose a separate argv[]
>   pager: factor out a helper to prepare a child process to run the pager
>   am -i: fix "v"iew
> 
>  builtin/am.c |  2 +-
>  cache.h      |  3 +++
>  pager.c      | 19 +++++++++++--------
>  3 files changed, 15 insertions(+), 9 deletions(-)

The whole thing looks good to me.

-Peff
