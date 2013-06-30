From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 3/4] completion: add completer for rev-parse
Date: Sun, 30 Jun 2013 13:14:36 +0200
Message-ID: <20130630111436.GB2294@goldbirke>
References: <1372429088-385-1-git-send-email-artagnon@gmail.com>
 <1372429088-385-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 30 13:14:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtFad-00033r-Uk
	for gcvg-git-2@plane.gmane.org; Sun, 30 Jun 2013 13:14:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322Ab3F3LOk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Jun 2013 07:14:40 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:62690 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230Ab3F3LOj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jun 2013 07:14:39 -0400
Received: from localhost6.localdomain6 (f051032128.adsl.alicedsl.de [78.51.32.128])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0LoMUn-1UIFwC1sBV-00gq0n; Sun, 30 Jun 2013 13:14:37 +0200
Content-Disposition: inline
In-Reply-To: <1372429088-385-4-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:3DHHsWhbt+eBWDqUAKtHWo7mpxGQIH/jH2ZdyzqlRSo
 haHVctVw3NCLgw1lccV6Kaug4QCTHj/+XwK+vbnQr5h0tuuHAI
 F5pJIMPylA7mAfkEtbcGhcB8MccCcnWVZKqo0ttFyMJE7LQ5CK
 Grt6JmQWSTMX7gC1sfAruJQaZNGDOgu8ERv+M+ogNefkkWFnAu
 wU+2WlQ+ZWeJOe94/MS+oCpPS5Ec+44nl/rUOXOAy8H0hkTb9Q
 SJaOubzaOjQHGDQjzFDqJJibi+fKYy883tsdEoJzUt8zgmNI9o
 BEQPwVEpqbhlLC0JJSS9wp/h4HneVuLsxgruFAXgFVYaw4eSCs
 k0T1z5iiW+zzLwWajjLY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229271>

On Fri, Jun 28, 2013 at 07:48:07PM +0530, Ramkumar Ramachandra wrote:
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 278018f..f2959a7 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2247,6 +2247,20 @@ _git_reset ()
>  	__gitcomp_nl "$(__git_refs)"
>  }
>  
> +_git_rev_parse ()
> +{
> +	case "$cur" in
> +	--*)
> +		__gitcomp "
> +			--short --show-toplevel --is-inside-work-tree
> +			--symbolic-full-name --verify
> +			"

In the completion script we support porcelain commands.  I'm not sure
about 'git rev-parse', but I think it's more plumbing than porcelain.
However, I think the same about 'git ls-tree' and 'git reflog', too,
yet we have support for them in the completion script.

Either way, why these five options?  'git rev-parse' has a lot more
options than that.


> +               return
> +               ;;
> +	esac
> +	__gitcomp_nl "$(__git_refs)"
> +}
> +
>  _git_revert ()
>  {
>  	case "$cur" in
> -- 
> 1.8.3.1.585.g9832cb9
> 
