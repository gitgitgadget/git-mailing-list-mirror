From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/5] t4001-diff-rename: wrap file creations in a test
Date: Wed, 24 Feb 2016 05:25:10 -0500
Message-ID: <20160224102510.GB21152@sigill.intra.peff.net>
References: <1456249498-3232-1-git-send-email-Matthieu.Moy@imag.fr>
 <1456249498-3232-3-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Feb 24 11:25:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYWdF-0007YH-L1
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 11:25:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755657AbcBXKZO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 05:25:14 -0500
Received: from cloud.peff.net ([50.56.180.127]:48193 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755646AbcBXKZM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 05:25:12 -0500
Received: (qmail 28077 invoked by uid 102); 24 Feb 2016 10:25:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Feb 2016 05:25:13 -0500
Received: (qmail 6891 invoked by uid 107); 24 Feb 2016 10:25:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Feb 2016 05:25:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Feb 2016 05:25:10 -0500
Content-Disposition: inline
In-Reply-To: <1456249498-3232-3-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287191>

On Tue, Feb 23, 2016 at 06:44:55PM +0100, Matthieu Moy wrote:

> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
>  t/t4001-diff-rename.sh | 38 +++++++++++++++++++++-----------------
>  1 file changed, 21 insertions(+), 17 deletions(-)
> 
> diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
> index 2f327b7..bfb364c 100755
> --- a/t/t4001-diff-rename.sh
> +++ b/t/t4001-diff-rename.sh
> @@ -9,7 +9,9 @@ test_description='Test rename detection in diff engine.
>  . ./test-lib.sh
>  . "$TEST_DIRECTORY"/diff-lib.sh
>  
> -echo >path0 'Line 1
> +test_expect_success 'setup' '
> +	cat >path0 <<\EOF &&
> +Line 1
>  Line 2
>  Line 3
>  Line 4

Should we use "<<-" here (and elsewhere) to indent the sample lines? It
makes your diff bigger, but I think the end result is much easier to
read.

-Peff
