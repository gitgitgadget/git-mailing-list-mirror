From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Allow abbreviations in the first refspec to be merged
Date: Fri, 28 Sep 2007 19:38:50 -0400
Message-ID: <20070928233850.GY3099@spearce.org>
References: <Pine.LNX.4.64.0709281932550.5926@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Sep 29 01:39:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbPQF-0004n2-I5
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 01:39:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbXI1Xi4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 19:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbXI1Xi4
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 19:38:56 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:54993 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbXI1Xi4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 19:38:56 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IbPQa-0008DC-85; Fri, 28 Sep 2007 19:39:24 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E4F1420FBAE; Fri, 28 Sep 2007 19:38:50 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0709281932550.5926@iabervon.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59432>

Daniel Barkalow <barkalow@iabervon.org> wrote:
> The config item for a refspec side and the ref name that it matches
> aren't necessarily character-for-character identical.
[snip]
> diff --git a/builtin-fetch.c b/builtin-fetch.c
> index 2f639cc..ac68ff5 100644
> --- a/builtin-fetch.c
> +++ b/builtin-fetch.c
> @@ -102,7 +102,7 @@ static struct ref *get_ref_map(struct transport *transport,
>  				    remote->fetch[i].dst[0])
>  					*autotags = 1;
>  				if (!i && !has_merge && ref_map &&
> -				    !strcmp(remote->fetch[0].src, ref_map->name))
> +				    !remote->fetch[0].pattern)
>  					ref_map->merge = 1;
>  			}
>  			if (has_merge)

Ooooooooooooh.  Of course.  That makes perfect sense now that I
see your explanation and patch.  Thanks for fixing that!  :-)

-- 
Shawn.
