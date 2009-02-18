From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v2 2/2] bash completion: only show 'log --merge' if
	merging
Date: Wed, 18 Feb 2009 09:05:18 -0800
Message-ID: <20090218170518.GD22848@spearce.org>
References: <adf1fd3d0902150156w67a16e6fp3c946446c5ae2bfd@mail.gmail.com> <bc66ec312ad33c4a7c9580ba4ade75c5998443d7.1234801852.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Santi =?iso-8859-1?Q?B=E9jar?= <santi@agolina.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Feb 18 18:07:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZpss-0004sI-K3
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 18:06:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753320AbZBRRFV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 12:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752296AbZBRRFU
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 12:05:20 -0500
Received: from george.spearce.org ([209.20.77.23]:54138 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753202AbZBRRFT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 12:05:19 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 7E99A381FF; Wed, 18 Feb 2009 17:05:18 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <bc66ec312ad33c4a7c9580ba4ade75c5998443d7.1234801852.git.trast@student.ethz.ch>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110559>

Thomas Rast <trast@student.ethz.ch> wrote:
> The gitk completion only shows --merge if MERGE_HEAD is present.
> Do it the same way for git-log completion.
> 
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
>  contrib/completion/git-completion.bash |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)

Both patches,

Acked-by: Shawn O. Pearce <spearce@spearce.org>
 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index a5b3bf3..489951b 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1003,6 +1003,11 @@ _git_log ()
>  	__git_has_doubledash && return
>  
>  	local cur="${COMP_WORDS[COMP_CWORD]}"
> +	local g="$(git rev-parse --git-dir 2>/dev/null)"
> +	local merge=""
> +	if [ -f $g/MERGE_HEAD ]; then
> +		merge="--merge"
> +	fi
>  	case "$cur" in
>  	--pretty=*)
>  		__gitcomp "$__git_log_pretty_formats
> @@ -1030,7 +1035,7 @@ _git_log ()
>  			--decorate
>  			--walk-reflogs
>  			--parents --children
> -			--merge
> +			$merge
>  			$__git_diff_common_options
>  			--pickaxe-all --pickaxe-regex
>  			"
> -- 
> 1.6.2.rc0.328.g2c702
> 

-- 
Shawn.
