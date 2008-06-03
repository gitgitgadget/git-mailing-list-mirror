From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] describe match pattern for soft tags too
Date: Tue, 3 Jun 2008 18:48:39 -0400
Message-ID: <20080603224839.GO12896@spearce.org>
References: <alpine.LNX.1.10.0806031957360.3605@pollux>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael Dressel <MichaelTiloDressel@t-online.de>
X-From: git-owner@vger.kernel.org Wed Jun 04 00:49:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3fJt-0005qQ-ST
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 00:49:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753457AbYFCWsn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 18:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753412AbYFCWsn
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 18:48:43 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:54458 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753205AbYFCWsm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 18:48:42 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1K3fIt-0000Y7-MJ; Tue, 03 Jun 2008 18:48:31 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9041420FBAE; Tue,  3 Jun 2008 18:48:39 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.10.0806031957360.3605@pollux>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83722>

Michael Dressel <MichaelTiloDressel@t-online.de> wrote:
> 
> So far git describe --match <pattern> would apply the <pattern> only
> to tag objects not to soft tags. This change make describe apply
> the <pattern> to soft tags too.

Whoops.

Signed-off-by tag?

Assuming you supply Junio an SBO tag,

Acked-by: Shawn O. Pearce <spearce@spearce.org>

> ---
>  builtin-describe.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin-describe.c b/builtin-describe.c
> index df554b3..a1b8251 100644
> --- a/builtin-describe.c
> +++ b/builtin-describe.c
> @@ -82,10 +82,10 @@ static int get_name(const char *path, const unsigned 
> char *sha1, int flag, void
>  	if (might_be_tag) {
>  		if (is_tag) {
>  			prio = 2;
> -			if (pattern && fnmatch(pattern, path + 10, 0))
> -				prio = 0;
>  		} else
>  			prio = 1;
> +		if (pattern && fnmatch(pattern, path + 10, 0))
> +			prio = 0;
>  	}
>  	else
>  		prio = 0;

-- 
Shawn.
