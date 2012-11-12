From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] gitweb: git_summary - show $project in title
Date: Mon, 12 Nov 2012 18:25:14 -0500
Message-ID: <20121112232513.GF10531@sigill.intra.peff.net>
References: <1352611258-11450-1-git-send-email-xypron.glpk@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Henrich Schuchardt <xypron.glpk@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 13 00:25:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TY3Nl-0007QR-AT
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 00:25:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753405Ab2KLXZT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 18:25:19 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45193 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752267Ab2KLXZS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 18:25:18 -0500
Received: (qmail 15791 invoked by uid 107); 12 Nov 2012 23:26:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Nov 2012 18:26:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2012 18:25:14 -0500
Content-Disposition: inline
In-Reply-To: <1352611258-11450-1-git-send-email-xypron.glpk@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209545>

On Sun, Nov 11, 2012 at 06:20:58AM +0100, Henrich Schuchardt wrote:

> Gitweb pages are structured by divs of class title with grey background.
> The shortlog, and the log page show the project name as the first title.
> Page summary only shows an empty grey box above the project details.
> This provides an inconstent user experience.
> 
> This patch adds the missing project title.
> 
> Signed-off-by: Henrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  gitweb/gitweb.perl |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 10ed9e5..3e1c452 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -6451,7 +6451,7 @@ sub git_summary {
>  	git_header_html();
>  	git_print_page_nav('summary','', $head);
>  
> -	print "<div class=\"title\">&nbsp;</div>\n";
> +	print "<div class=\"title\">$project</div>\n";

I do not have any opinion on whether the intent of the change is good or
not, but shouldn't $project be run through esc_html() here?

-Peff
