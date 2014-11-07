From: ockham@raz.or.at
Subject: Re: [PATCH] sparse: suppress an "using sizeof on a function"
 warning
Date: Fri, 07 Nov 2014 21:01:50 +0100
Message-ID: <20141107210150.Horde.XRUyBUv4Cn9UXSUur_a0avA@webmail.domainplanet.at>
References: <545CCE23.5080507@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Fri Nov 07 21:02:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XmpjM-0001eR-HX
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 21:02:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752718AbaKGUB4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 15:01:56 -0500
Received: from mhub.vim.at ([92.43.99.100]:46702 "EHLO mhub.vim.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751569AbaKGUB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 15:01:56 -0500
Received: from smtp.vim.at (smtp.vim.at [92.43.99.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mhub.vim.at (Postfix) with ESMTPS id 1A6BAF046FF;
	Fri,  7 Nov 2014 21:01:51 +0100 (CET)
Received: from webmail.vim.at (unknown [92.43.96.107])
	by smtp.vim.at (Postfix) with ESMTP id 090E8C1B0A;
	Fri,  7 Nov 2014 21:02:42 +0100 (CET)
Received: by webmail.vim.at (Postfix, from userid 33)
	id E08778A07B; Fri,  7 Nov 2014 21:01:50 +0100 (CET)
Received: from 213-33-0-57.adsl.highway.telekom.at
 (213-33-0-57.adsl.highway.telekom.at [213.33.0.57]) by
 webmail.domainplanet.at (Horde Framework) with HTTP; Fri, 07 Nov 2014
 21:01:50 +0100
In-Reply-To: <545CCE23.5080507@ramsay1.demon.co.uk>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.14)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Zitat von Ramsay Jones <ramsay@ramsay1.demon.co.uk>:

> Commit d57da44b1 ("imap-send: use libcurl for implementation",
> 06-11-2014) updates the implementation of the imap-send command
> to make use of libcurl's high(er)-level API functions.
>
> In doing so, this introduces a sparse warning about "using sizeof
> on a function". In order to suppress the warning, we use the same
> solution used in commit 9371322a6 ("sparse: suppress some "using
> sizeof on a function" warnings", 06-10-2013) which solved exactly
> this problem for the other commands using libcurl.
>
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
>
> Hi Bernhard,
>
> If you need to re-roll your 'br/imap-send-via-libcurl' branch, could
> you please squash this into your patch.
>
> Thanks!

Hi Ramsay,

and thanks for your fix! TBH, I didn't even notice that my patch had  
already been committed and instead posted a refined version earlier  
today [1] (which unfortunately didn't contain your fix, either).

Not sure how to proceed. Maybe Junio can enlighten?

Regards
Bernhard

[1] http://www.mail-archive.com/git@vger.kernel.org/msg60576.html

> ATB,
> Ramsay Jones
>
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 1ded274..0fc2790 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1930,7 +1930,7 @@ gettext.sp gettext.s gettext.o: GIT-PREFIX
>  gettext.sp gettext.s gettext.o: EXTRA_CPPFLAGS = \
>  	-DGIT_LOCALE_PATH='"$(localedir_SQ)"'
>
> -http-push.sp http.sp http-walker.sp remote-curl.sp: SPARSE_FLAGS += \
> +http-push.sp http.sp http-walker.sp remote-curl.sp imap-send.sp:  
> SPARSE_FLAGS += \
>  	-DCURL_DISABLE_TYPECHECK
>
>  ifdef NO_EXPAT
> --
> 2.1.0
