From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Fix settings in default_user_config template
Date: Fri, 17 Apr 2015 10:55:16 -0400
Message-ID: <20150417145516.GB2421@peff.net>
References: <1429282210-38538-1-git-send-email-oherrala@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ossi Herrala <oherrala@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 17 16:55:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yj7g4-0002bo-Bo
	for gcvg-git-2@plane.gmane.org; Fri, 17 Apr 2015 16:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966699AbbDQOzW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2015 10:55:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:46732 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965075AbbDQOzU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2015 10:55:20 -0400
Received: (qmail 4303 invoked by uid 102); 17 Apr 2015 14:55:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Apr 2015 09:55:18 -0500
Received: (qmail 2602 invoked by uid 107); 17 Apr 2015 14:55:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Apr 2015 10:55:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Apr 2015 10:55:16 -0400
Content-Disposition: inline
In-Reply-To: <1429282210-38538-1-git-send-email-oherrala@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267361>

On Fri, Apr 17, 2015 at 05:50:10PM +0300, Ossi Herrala wrote:

> The name (not user) and email setting should be in config section
> "user" and not in "core" as documented in Documentation/config.txt.

<facepalm> Well, those probably weren't helping any new users, then,
were they? :)

> diff --git a/builtin/config.c b/builtin/config.c
> index d32c532..bfd3016 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -455,9 +455,9 @@ static char *default_user_config(void)
>  	struct strbuf buf = STRBUF_INIT;
>  	strbuf_addf(&buf,
>  		    _("# This is Git's per-user configuration file.\n"
> -		      "[core]\n"
> +		      "[user]\n"
>  		      "# Please adapt and uncomment the following lines:\n"
> -		      "#	user = %s\n"
> +		      "#	name = %s\n"
>  		      "#	email = %s\n"),

Looks obviously correct. Thanks for noticing.

-Peff
