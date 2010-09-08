From: ods15@ods15.dyndns.org
Subject: Re: [PATCH] Add explicit --src/dst-prefix to git-formt-patch in
 git-rebase.sh for the case of "diff.noprefix" in git-config
Date: Wed, 8 Sep 2010 23:31:06 +0300
Message-ID: <20100908203106.GD4610@crate15.ODS15-HOME>
References: <1283954045-8326-1-git-send-email-ods15@ods15.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 08 22:31:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtRIa-0004Li-Rk
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 22:31:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754954Ab0IHUbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Sep 2010 16:31:11 -0400
Received: from bzq-79-177-53-38.red.bezeqint.net ([79.177.53.38]:43318 "EHLO
	ods15.dyndns.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754180Ab0IHUbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Sep 2010 16:31:09 -0400
Received: from ods15 by ods15.dyndns.org with local (Exim 4.71)
	(envelope-from <ods15@ods15.dyndns.org>)
	id 1OtRIQ-0002RS-QJ
	for git@vger.kernel.org; Wed, 08 Sep 2010 23:31:06 +0300
Content-Disposition: inline
In-Reply-To: <1283954045-8326-1-git-send-email-ods15@ods15.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155813>

On Wed, Sep 08, 2010 at 04:54:05PM +0300, Oded Shimon wrote:
> ---
>  git-rebase.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/git-rebase.sh b/git-rebase.sh
> index 7508463..e83a0cf 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -565,7 +565,7 @@ fi
>  
>  if test -z "$do_merge"
>  then
> -	git format-patch -k --stdout --full-index --ignore-if-in-upstream \
> +	git format-patch -k --stdout --full-index --ignore-if-in-upstream --src-prefix=a/ --dst-prefix=b/ \
>  		--no-renames $root_flag "$revisions" |
>  	git am $git_am_opt --rebasing --resolvemsg="$RESOLVEMSG" &&
>  	move_to_original_branch

Hi.

I may have rudely just sent a patch without explaining anything, I thought 
the patch was self explanitory. I'm not sure on the expected procedure 
here for sending patches.

When using "git rebase", when "diff.noprefix" is set to true in 
git-config, then all the rebases mess up because they get the directory 
path wrong.

As far as I can tell, my patch fixes this, with no side-effects that I can 
think of.

Can anyone comment on the patch? Can it be pushed upstream?

- ods15
