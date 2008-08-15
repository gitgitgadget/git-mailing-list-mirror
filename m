From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/2] bash completion: Add completion for 'git mergetool'
Date: Thu, 14 Aug 2008 17:05:41 -0700
Message-ID: <20080815000541.GE3782@spearce.org>
References: <1218753671-58099-1-git-send-email-lee.marlow@gmail.com> <1218753671-58099-2-git-send-email-lee.marlow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Lee Marlow <lee.marlow@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 15 02:06:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTmq5-0004oh-61
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 02:06:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751901AbYHOAFm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 20:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751818AbYHOAFm
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 20:05:42 -0400
Received: from george.spearce.org ([209.20.77.23]:48520 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379AbYHOAFm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 20:05:42 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 9E41638375; Fri, 15 Aug 2008 00:05:41 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1218753671-58099-2-git-send-email-lee.marlow@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92444>

Lee Marlow <lee.marlow@gmail.com> wrote:
> The --tool= long option can be completed with
> 	kdiff3 tkdiff meld xxdiff emerge
> 	vimdiff gvimdiff ecmerge opendiff
> 
> Signed-off-by: Lee Marlow <lee.marlow@gmail.com>

Acked-by: Shawn O. Pearce <spearce@spearce.org>

... for both patches in this series.  But this is new functionality
so it probably won't be in 1.6.0; its too late in that release cycle.

> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 78189c1..4089670 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1001,6 +1001,25 @@ _git_merge ()
>  	__gitcomp "$(__git_refs)"
>  }
>  
> +_git_mergetool ()
> +{
> +	local cur="${COMP_WORDS[COMP_CWORD]}"
> +	case "$cur" in
> +	--tool=*)
> +		__gitcomp "
> +			kdiff3 tkdiff meld xxdiff emerge
> +			vimdiff gvimdiff ecmerge opendiff
> +			" "" "${cur##--tool=}"
> +		return
> +		;;
> +	--*)
> +		__gitcomp "--tool="
> +		return
> +		;;
> +	esac
> +	COMPREPLY=()
> +}
> +
>  _git_merge_base ()
>  {
>  	__gitcomp "$(__git_refs)"
> @@ -1650,6 +1669,7 @@ _git ()
>  	ls-remote)   _git_ls_remote ;;
>  	ls-tree)     _git_ls_tree ;;
>  	merge)       _git_merge;;
> +	mergetool)   _git_mergetool;;
>  	merge-base)  _git_merge_base ;;
>  	mv)          _git_mv ;;
>  	name-rev)    _git_name_rev ;;

-- 
Shawn.
