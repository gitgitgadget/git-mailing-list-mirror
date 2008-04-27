From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] bash: Add completion for gitk --merge
Date: Sun, 27 Apr 2008 13:19:56 -0400
Message-ID: <20080427171956.GK29771@spearce.org>
References: <20080427041816.GH29771@spearce.org> <1209310510-7201-1-git-send-email-richard.quirk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Richard Quirk <richard.quirk@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 27 19:20:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqAYU-0001cK-1m
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 19:20:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755522AbYD0RUB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 13:20:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755523AbYD0RUB
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 13:20:01 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:42706 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754949AbYD0RUA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 13:20:00 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JqAXX-0003WA-LS; Sun, 27 Apr 2008 13:19:51 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 344C220FBAE; Sun, 27 Apr 2008 13:19:56 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1209310510-7201-1-git-send-email-richard.quirk@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80456>

Richard Quirk <richard.quirk@gmail.com> wrote:
> Option is only completed when .git/MERGE_HEAD is present.
> 
> Signed-off-by: Richard Quirk <richard.quirk@gmail.com>

Thanks for fixing the unnecessary local and resubmitting.

Acked-by: Shawn O. Pearce <spearce@spearce.org>

> ---
>  contrib/completion/git-completion.bash |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 665a895..23db664 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1346,9 +1346,14 @@ _git ()
>  _gitk ()
>  {
>  	local cur="${COMP_WORDS[COMP_CWORD]}"
> +	local g="$(git rev-parse --git-dir 2>/dev/null)"
> +	local merge=""
> +	if [ -f $g/MERGE_HEAD ]; then
> +		merge="--merge"
> +	fi
>  	case "$cur" in
>  	--*)
> -		__gitcomp "--not --all"
> +		__gitcomp "--not --all $merge"
>  		return
>  		;;
>  	esac
> -- 
> 1.5.5.1.79.g57cf
> 

-- 
Shawn.
