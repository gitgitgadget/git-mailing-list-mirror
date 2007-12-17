From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Have a flag to stop the option parsing at the first
 argument.
Date: Mon, 17 Dec 2007 10:34:20 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712171033550.9446@racer.site>
References: <20071217095014.GF7453@artemis.madism.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Wincent Colaiuta <win@wincent.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Dec 17 11:35:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4DJm-0005d2-Ju
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 11:35:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761671AbXLQKei (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 05:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761738AbXLQKei
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 05:34:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:35494 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761671AbXLQKeh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 05:34:37 -0500
Received: (qmail invoked by alias); 17 Dec 2007 10:34:34 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp007) with SMTP; 17 Dec 2007 11:34:34 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX191XFxQYdN1sOi+tU9fURC8p3R9hqI+M1BnqC6WI/
	gvcbEyikPek8Ag
X-X-Sender: gene099@racer.site
In-Reply-To: <20071217095014.GF7453@artemis.madism.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68532>

Hi,

On Mon, 17 Dec 2007, Pierre Habouzit wrote:

> diff --git a/parse-options.c b/parse-options.c
> index 7a08a0c..4f5c55e 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -229,6 +229,8 @@ int parse_options(int argc, const char **argv, const struct option *options,
>  		const char *arg = args.argv[0];
>  
>  		if (*arg != '-' || !arg[1]) {
> +			if (flags & PARSE_OPT_STOP_AT_ARG)
> +				break;
>  			argv[j++] = args.argv[0];
>  			continue;
>  		}
> diff --git a/parse-options.h b/parse-options.h
> index 102ac31..7c636b9 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -18,6 +18,7 @@ enum parse_opt_type {
>  
>  enum parse_opt_flags {
>  	PARSE_OPT_KEEP_DASHDASH = 1,
> +	PARSE_OPT_STOP_AT_ARG   = 2,
>  };
>  
>  enum parse_opt_option_flags {

Funny.  I already posted this:

http://repo.or.cz/w/git/dscho.git?a=commitdiff;h=504f763a28b3109fce258b36f9e94e7c54be6f3d

Ciao,
Dscho
