From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT v2 04/29] Allow "guilt import-commit" to run from a dir
 which contains spaces.
Date: Tue, 13 May 2014 17:06:44 -0400
Message-ID: <20140513210644.GD4791@meili.valhalla.31bits.net>
References: <1400013065-27919-1-git-send-email-cederp@opera.com>
 <1400013065-27919-5-git-send-email-cederp@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Tue May 13 23:06:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkJuM-0004yA-Co
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 23:06:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753245AbaEMVGj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 17:06:39 -0400
Received: from josefsipek.net ([64.9.206.49]:1582 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752329AbaEMVGi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 17:06:38 -0400
Received: from meili.valhalla.31bits.net (c-98-209-117-250.hsd1.mi.comcast.net [98.209.117.250])
	by josefsipek.net (Postfix) with ESMTPSA id 776EE55654;
	Tue, 13 May 2014 17:06:37 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1400013065-27919-5-git-send-email-cederp@opera.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248854>

Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>

On Tue, May 13, 2014 at 10:30:40PM +0200, Per Cederqvist wrote:
> Signed-off-by: Per Cederqvist <cederp@opera.com>
> ---
>  guilt-import-commit | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/guilt-import-commit b/guilt-import-commit
> index 20dcee2..f14647c 100755
> --- a/guilt-import-commit
> +++ b/guilt-import-commit
> @@ -23,7 +23,7 @@ if ! must_commit_first; then
>  fi
>  
>  disp "About to begin conversion..." >&2
> -disp "Current head: `cat $GIT_DIR/refs/heads/\`git_branch\``" >&2
> +disp "Current head: `git rev-parse \`git_branch\``" >&2
>  
>  for rev in `git rev-list $rhash`; do
>  	s=`git log --pretty=oneline -1 $rev | cut -c 42-`
> @@ -46,7 +46,7 @@ for rev in `git rev-list $rhash`; do
>  		do_make_header $rev
>  		echo ""
>  		git diff --binary $rev^..$rev
> -	) > $GUILT_DIR/$branch/$fname
> +	) > "$GUILT_DIR/$branch/$fname"
>  
>  	# FIXME: grab the GIT_AUTHOR_DATE from the commit object and set the
>  	# timestamp on the patch
> @@ -68,6 +68,6 @@ for rev in `git rev-list $rhash`; do
>  done
>  
>  disp "Done." >&2
> -disp "Current head: `cat $GIT_DIR/refs/heads/\`git_branch\``" >&2
> +disp "Current head: `git rev-parse \`git_branch\``" >&2
>  
>  }
> -- 
> 1.8.3.1
> 

-- 
Once you have their hardware. Never give it back.
(The First Rule of Hardware Acquisition)
