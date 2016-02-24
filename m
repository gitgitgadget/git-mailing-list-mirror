From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/5] Documentation/diff-config: fix description of
 diff.renames
Date: Wed, 24 Feb 2016 05:27:29 -0500
Message-ID: <20160224102729.GC21152@sigill.intra.peff.net>
References: <1456249498-3232-1-git-send-email-Matthieu.Moy@imag.fr>
 <1456249498-3232-2-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Feb 24 11:27:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYWfU-0000nM-ND
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 11:27:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755699AbcBXK1f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 05:27:35 -0500
Received: from cloud.peff.net ([50.56.180.127]:48199 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754472AbcBXK1c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 05:27:32 -0500
Received: (qmail 28171 invoked by uid 102); 24 Feb 2016 10:27:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Feb 2016 05:27:32 -0500
Received: (qmail 6946 invoked by uid 107); 24 Feb 2016 10:27:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Feb 2016 05:27:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Feb 2016 05:27:29 -0500
Content-Disposition: inline
In-Reply-To: <1456249498-3232-2-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287192>

On Tue, Feb 23, 2016 at 06:44:54PM +0100, Matthieu Moy wrote:

> The description was misleading, since "set to any boolean value" include
> "set to false", and diff.renames=false does not enable basic detection,
> but actually disables it.
> 
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
>  Documentation/diff-config.txt | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
> index 6eaa452..1acd203 100644
> --- a/Documentation/diff-config.txt
> +++ b/Documentation/diff-config.txt
> @@ -108,9 +108,10 @@ diff.renameLimit::
>  	detection; equivalent to the 'git diff' option '-l'.
>  
>  diff.renames::
> -	Tells Git to detect renames.  If set to any boolean value, it
> -	will enable basic rename detection.  If set to "copies" or
> -	"copy", it will detect copies, as well.
> +	Whether and how Git detects renames.  If set to "false",
> +	rename detection is disabled. If set to "true", basic rename
> +	detection is enable.  If set to "copies" or "copy", Git will
> +	detect copies, as well.  Defaults to false.

Looks OK to me. I thought we had "copies-harder" or something, but I
double-checked and we don't. I doubt anybody would want to set it
anyway, as it can be quite expensive.

-Peff
