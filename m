From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCH] Collocate strings to simplify translation
Date: Thu, 24 May 2012 10:32:31 +0200
Message-ID: <4FBDF21F.1010807@in.waw.pl>
References: <1337845288-7656-1-git-send-email-vfr@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Thu May 24 10:33:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXTTi-0003Q6-0X
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 10:33:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754029Ab2EXIco (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 04:32:44 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:37374 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754005Ab2EXIcj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 04:32:39 -0400
Received: from fizdyn1.fuw.edu.pl ([193.0.80.98] helo=[10.34.1.62])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SXTTJ-0007qZ-2X; Thu, 24 May 2012 10:32:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.3) Gecko/20120329 Icedove/10.0.3
In-Reply-To: <1337845288-7656-1-git-send-email-vfr@lyx.org>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198362>

On 05/24/2012 09:41 AM, Vincent van Ravesteijn wrote:
> The translation of 'Untracked' and 'Ignored' might depend on the following
> word. To help the translator, this patch collocates the term 'files'.
> 
> Signed-off-by: Vincent van Ravesteijn <vfr@lyx.org>
> ---
>  wt-status.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/wt-status.c b/wt-status.c
> index dd6d8c4..9b65a8c 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -185,7 +185,7 @@ static void wt_status_print_other_header(struct wt_status *s,
>  					 const char *how)
>  {
>  	const char *c = color(WT_STATUS_HEADER, s);
> -	status_printf_ln(s, c, _("%s files:"), what);
> +	status_printf_ln(s, c, _("%s:"), what);
How can "%s:" be translated? _() should be removed here.

>  	if (!advice_status_hints)
>  		return;
>  	status_printf_ln(s, c, _("  (use \"git %s <file>...\" to include in what will be committed)"), how);
> @@ -766,9 +766,9 @@ void wt_status_print(struct wt_status *s)
>  		wt_status_print_submodule_summary(s, 1);  /* unstaged */
>  	}
>  	if (s->show_untracked_files) {
> -		wt_status_print_other(s, &s->untracked, _("Untracked"), "add");
> +		wt_status_print_other(s, &s->untracked, _("Untracked files"), "add");
>  		if (s->show_ignored_files)
> -			wt_status_print_other(s, &s->ignored, _("Ignored"), "add -f");
> +			wt_status_print_other(s, &s->ignored, _("Ignored files"), "add -f");
This part is looks sensible.

>  	} else if (s->commitable)
>  		status_printf_ln(s, GIT_COLOR_NORMAL, _("Untracked files not listed%s"),
>  			advice_status_hints

Zbyszek
