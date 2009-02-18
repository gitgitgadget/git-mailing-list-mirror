From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 3/3] git-gui: define correct GIT_DIR for gitk
Date: Wed, 18 Feb 2009 09:22:52 -0800
Message-ID: <20090218172252.GG22848@spearce.org>
References: <1234144850-2903-1-git-send-email-giuseppe.bilotta@gmail.com> <1234144850-2903-4-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 18:24:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZq9m-0004i1-1y
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 18:24:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752918AbZBRRWy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 12:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752654AbZBRRWx
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 12:22:53 -0500
Received: from george.spearce.org ([209.20.77.23]:58433 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752768AbZBRRWx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 12:22:53 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 85FF4381FF; Wed, 18 Feb 2009 17:22:52 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1234144850-2903-4-git-send-email-giuseppe.bilotta@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110563>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> wrote:
> When invoking gitk, git-gui assumed that the worktree was the dirname of
> $_gitdir and that, by consequence, the git dir could be set to the tail of
> $_gitdir once we changed to the worktree root directory.
> 
> The assumption is no longer true since the previous commit introduced
> support for more generic worktree locations, so export a GIT_DIR
> environment variable set to the full, normalized path of $_gitdir
> instead.

Since this is a one line patch to fix a bug introduced by the prior
patch, I'd rather just see this squash into the prior patch.
 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
>  git-gui/git-gui.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
> index 94317c7..de3f29c 100755
> --- a/git-gui/git-gui.sh
> +++ b/git-gui/git-gui.sh
> @@ -1908,7 +1908,7 @@ proc do_gitk {revs} {
>  
>  		set pwd [pwd]
>  		cd $_gitworktree
> -		set env(GIT_DIR) [file tail [gitdir]]
> +		set env(GIT_DIR) [file normalize [gitdir]]
>  
>  		eval exec $cmd $revs &
>  
> -- 
> 1.6.2.rc0.173.g5e148
> 

-- 
Shawn.
