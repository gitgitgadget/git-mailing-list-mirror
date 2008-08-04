From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] bash completion: Add completion for 'git grep'
Date: Mon, 4 Aug 2008 07:53:03 -0700
Message-ID: <20080804145303.GE27666@spearce.org>
References: <1217638593-57321-1-git-send-email-lee.marlow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Lee Marlow <lee.marlow@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 04 16:54:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQ1Rp-0008Ar-4a
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 16:54:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754540AbYHDOxH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 10:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754499AbYHDOxG
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 10:53:06 -0400
Received: from george.spearce.org ([209.20.77.23]:38624 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753297AbYHDOxF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 10:53:05 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id E6C4C38419; Mon,  4 Aug 2008 14:53:03 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1217638593-57321-1-git-send-email-lee.marlow@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91367>

Lee Marlow <lee.marlow@gmail.com> wrote:
> Added completions for all long options specified in the docs
> 	--cached
> 	--text --ignore-case --word-regexp --invert-match
> 	--full-name
> 	--extended-regexp --basic-regexp --fixed-strings
> 	--files-with-matches --name-only
> 	--files-without-match
> 	--count
> 	--and --or --not --all-match
> 
> Signed-off-by: Lee Marlow <lee.marlow@gmail.com>

Acked-by: Shawn O. Pearce <spearce@spearce.org>

This is the "first patch" which has the doubledash test.  As you
pointed out, its better because it stops completion of long options
after the --.

> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 30d8701..b28ac10 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -796,6 +796,29 @@ _git_gc ()
>  	COMPREPLY=()
>  }
>  
> +_git_grep ()
> +{
> +	__git_has_doubledash && return
> +
> +	local cur="${COMP_WORDS[COMP_CWORD]}"
> +	case "$cur" in
> +	--*)
> +		__gitcomp "
> +			--cached
> +			--text --ignore-case --word-regexp --invert-match
> +			--full-name
> +			--extended-regexp --basic-regexp --fixed-strings
> +			--files-with-matches --name-only
> +			--files-without-match
> +			--count
> +			--and --or --not --all-match
> +			"
> +		return
> +		;;
> +	esac
> +	COMPREPLY=()
> +}
> +
>  _git_help ()
>  {
>  	local cur="${COMP_WORDS[COMP_CWORD]}"
> @@ -1486,6 +1509,7 @@ _git ()
>  	fetch)       _git_fetch ;;
>  	format-patch) _git_format_patch ;;
>  	gc)          _git_gc ;;
> +	grep)        _git_grep ;;
>  	help)        _git_help ;;
>  	log)         _git_log ;;
>  	ls-remote)   _git_ls_remote ;;
> -- 

-- 
Shawn.
