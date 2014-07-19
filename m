From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 2/4] completion: complete "unstuck" `git push --recurse-submodules`
Date: Sat, 19 Jul 2014 13:37:26 +0200
Message-ID: <53CA5876.40007@kdbg.org>
References: <e9576136c09dbf65c5e614f9272d2c2afa96f5b6.1405763157.git.john@keeping.me.uk> <a3317a7692675483f60ee10ff98e1e95a3dc4b5a.1405763157.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 19 13:37:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8SxK-0008Lc-Bd
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jul 2014 13:37:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761582AbaGSLha (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2014 07:37:30 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:50209 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1761022AbaGSLh3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2014 07:37:29 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 80F31130055;
	Sat, 19 Jul 2014 13:37:27 +0200 (CEST)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 8B74A19F470;
	Sat, 19 Jul 2014 13:37:26 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <a3317a7692675483f60ee10ff98e1e95a3dc4b5a.1405763157.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253875>

Am 19.07.2014 11:45, schrieb John Keeping:
> Since the argument to `--recurse-submodules` is mandatory, it does not
> need to be stuck to the option with `=`.
> 
> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---
>  contrib/completion/git-completion.bash | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index d0b2895..06211a6 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1624,6 +1624,10 @@ __git_push_recurse_submodules="check on-demand"
>  _git_push ()
>  {
>  	case "$prev" in
> +	--recurse_submodules)

This would need a dash, not an underscore.

> +		__gitcomp "$__git_push_recurse_submodules"
> +		return
> +		;;
>  	--repo)
>  		__gitcomp_nl "$(__git_remotes)"
>  		return
> 
