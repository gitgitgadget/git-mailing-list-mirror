From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v2 2/2] bash completion: Support "divergence from
	upstream" warnings in __git_ps1
Date: Mon, 14 Jun 2010 14:36:33 +0200
Message-ID: <20100614123633.GN4640@neumann>
References: <cover.1276336602.git.trast@student.ethz.ch>
	<93842467ca22405712cab23a9b3920c106df0f17.1276336602.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Sayers <andrew-git@pileofstuff.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	John Tapsell <johnflux@gmail.com>,
	Steven Michalske <smichalske@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jun 14 14:43:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OO913-00077V-PA
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 14:43:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936Ab0FNMno (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jun 2010 08:43:44 -0400
Received: from [141.21.7.5] ([141.21.7.5]:54862 "EHLO exchange.fzi.de"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750760Ab0FNMnn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 08:43:43 -0400
X-Greylist: delayed 368 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Jun 2010 08:43:43 EDT
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
	 Mon, 14 Jun 2010 14:36:33 +0200
Content-Disposition: inline
In-Reply-To: <93842467ca22405712cab23a9b3920c106df0f17.1276336602.git.trast@student.ethz.ch>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 14 Jun 2010 12:36:33.0243 (UTC) FILETIME=[38A832B0:01CB0BBE]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149091>

Hi,

On Sat, Jun 12, 2010 at 11:59:11AM +0200, Thomas Rast wrote:
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 57245a8..a6cb435 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -42,6 +42,17 @@
>  #       set GIT_PS1_SHOWUNTRACKEDFILES to a nonempty value. If there're
>  #       untracked files, then a '%' will be shown next to the branch name.
>  #
> +#       If you would like to see the difference between HEAD and its upstream,
> +#       set GIT_PS1_SHOWUPSTREAM to one of the following:
> +#           git          use @{upstream}
> +#           svn          attempt to DWIM svn upstream for normal and --stdlayout
> +#           ref <ref>    unconditionally use <ref>
> +#           eval <code>  evaluate <code> which should print the commit to use
> +#       Any other value DWIMs either svn or git, preferring svn if configured.

Something like this should go in there somewhere:

  The bash.showUpstream config variable can be used to override the 
  value of GIT_PS1_SHOWUPSTREAM on a per-repository basis.

> +#
> +#       The difference will be shown as, e.g., "u+7-5" meaning that you are 7
> +#       commits ahead of and 5 commits behind the upstream.
> +#
>  # To submit patches:
>  #
>  #    *) Read Documentation/SubmittingPatches
