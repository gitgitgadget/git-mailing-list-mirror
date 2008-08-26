From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] bash completion: Hide more plumbing commands
Date: Tue, 26 Aug 2008 10:24:10 -0700
Message-ID: <20080826172410.GJ26523@spearce.org>
References: <20080826171012.GO10360@machine.or.cz> <20080826171144.21328.82727.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, andi@firstfloor.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Aug 26 19:25:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY2ID-0002Xp-1H
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 19:25:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756599AbYHZRYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 13:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753489AbYHZRYM
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 13:24:12 -0400
Received: from george.spearce.org ([209.20.77.23]:58797 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754664AbYHZRYM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 13:24:12 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 0A48738375; Tue, 26 Aug 2008 17:24:10 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080826171144.21328.82727.stgit@localhost>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93773>

Petr Baudis <pasky@suse.cz> wrote:
> git <tab><tab> still shows way too many commands, some of them
> are clearly plumbing. This patch hides the plumbing commands
> liberally (that is, in special cases, users still might want to
> call one of the hidden commands, a *normal* workflow should never
> involve these, though - and if it does, we have a UI problem anyway).
> 
> Signed-off-by: Petr Baudis <pasky@suse.cz>

Acked-by: Shawn O. Pearce <spearce@spearce.org>

Though I use git ls-remote at least once every other day to see
what branches are available on my egit/spearce.git fork.  Its ok,
I guess I can type a few extra characters...

> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 89858c2..773d64b 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -386,7 +386,9 @@ __git_porcelain_commands ()
>  		cat-file)         : plumbing;;
>  		check-attr)       : plumbing;;
>  		check-ref-format) : plumbing;;
> +		checkout-index)   : plumbing;;
>  		commit-tree)      : plumbing;;
> +		count-objects)    : plumbing;;
>  		cvsexportcommit)  : export;;
>  		cvsimport)        : import;;
>  		cvsserver)        : daemon;;
> @@ -395,6 +397,7 @@ __git_porcelain_commands ()
>  		diff-index)       : plumbing;;
>  		diff-tree)        : plumbing;;
>  		fast-import)      : import;;
> +		fast-export)      : export;;
>  		fsck-objects)     : plumbing;;
>  		fetch-pack)       : plumbing;;
>  		fmt-merge-msg)    : plumbing;;
> @@ -404,6 +407,10 @@ __git_porcelain_commands ()
>  		index-pack)       : plumbing;;
>  		init-db)          : deprecated;;
>  		local-fetch)      : plumbing;;
> +		lost-found)       : deprecated;;
> +		ls-files)         : plumbing;;
> +		ls-remote)        : plumbing;;
> +		ls-tree)          : plumbing;;
>  		mailinfo)         : plumbing;;
>  		mailsplit)        : plumbing;;
>  		merge-*)          : plumbing;;
> @@ -428,6 +435,7 @@ __git_porcelain_commands ()
>  		runstatus)        : plumbing;;
>  		sh-setup)         : internal;;
>  		shell)            : daemon;;
> +		show-ref)         : plumbing;;
>  		send-pack)        : plumbing;;
>  		show-index)       : plumbing;;
>  		ssh-*)            : transport;;
> @@ -442,6 +450,8 @@ __git_porcelain_commands ()
>  		upload-archive)   : plumbing;;
>  		upload-pack)      : plumbing;;
>  		write-tree)       : plumbing;;
> +		var)              : plumbing;;
> +		verify-pack)      : plumbing;;
>  		verify-tag)       : plumbing;;
>  		*) echo $i;;
>  		esac

-- 
Shawn.
