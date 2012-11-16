From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v2 1/6] completion: add comment for test_completion()
Date: Fri, 16 Nov 2012 21:54:57 +0100
Message-ID: <20121116205457.GY12052@goldbirke>
References: <1352644558-9410-1-git-send-email-felipe.contreras@gmail.com>
 <1352644558-9410-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 16 21:55:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZSwv-0001SK-Mp
	for gcvg-git-2@plane.gmane.org; Fri, 16 Nov 2012 21:55:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753092Ab2KPUz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2012 15:55:27 -0500
Received: from moutng.kundenserver.de ([212.227.17.8]:56470 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353Ab2KPUz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2012 15:55:27 -0500
Received: from localhost6.localdomain6 (p5B130644.dip0.t-ipconnect.de [91.19.6.68])
	by mrelayeu.kundenserver.de (node=mrbap4) with ESMTP (Nemesis)
	id 0LilsT-1T1VEd002H-00d2An; Fri, 16 Nov 2012 21:54:58 +0100
Content-Disposition: inline
In-Reply-To: <1352644558-9410-2-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:29a53GVBGaopGUgxCViXQXcnYMMih+Vd0CO/5zIFTZB
 1dLK6xU7jJvUuvZShvkHwJzFPbXmEG0bhTlfWU6Ys2e46M0tBd
 UC2l5mhMvd9KWjgwcdmbzWPf2OYJP/6MH1dywjkjbYLhY/0r3M
 uw8Sz53w7rsWwEMtlTxEU/f/msOXhvMUeK6+i1xL1CoIbfN8v4
 23BP1ApQmDP1PFESihJfomd5kOeIDH/nmY/C+FQQS6wElDD6Ci
 Vp6tg4IaxEFXDgO6ZkvvuIsicrzHLpsTMH3x/qUJDFG1YQLGSZ
 a+4mpe4zD+f/Rmp0kCjbmMIAG+kt0xnvE6PCGQlLnP3/XcGiNn
 afw9oPxLJelZBU2egUKMM73gGdaB5bZTXaKKAaCL3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209908>

On Sun, Nov 11, 2012 at 03:35:53PM +0100, Felipe Contreras wrote:
> So that it's easier to understand what it does.
> 
> Also, make sure we pass only the first argument for completion.
> Shouldn't cause any functional changes because run_completion only
> checks $1.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  t/t9902-completion.sh | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index cbd0fb6..5c06709 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -54,10 +54,14 @@ run_completion ()
>  	__git_wrap__git_main && print_comp
>  }
>  
> +# Test high-level completion
> +# Arguments are:
> +# 1: typed text so far (cur)

Bash manuals calls this the current command line or words in the
current command line.  I'm not sure what you mean with '(cur)' here.
The variable $cur in the completion script (or in bash-completion in
general) is something completely different.

> +# 2: expected completion
>  test_completion ()
>  {
>  	test $# -gt 1 && echo "$2" > expected
> -	run_completion "$@" &&
> +	run_completion "$1" &&
>  	test_cmp expected out
>  }
>  
> -- 
> 1.8.0
