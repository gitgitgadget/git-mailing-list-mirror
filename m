From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH 12/20] alias: trivial style fix
Date: Sat, 12 Oct 2013 10:55:51 +0200
Message-ID: <52590E97.6060308@googlemail.com>
References: <1381561636-20717-1-git-send-email-felipe.contreras@gmail.com> <1381561636-20717-18-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 10:55:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUuz6-000531-Sl
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 10:55:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752204Ab3JLIzg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 04:55:36 -0400
Received: from mail-ee0-f50.google.com ([74.125.83.50]:56609 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865Ab3JLIze (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 04:55:34 -0400
Received: by mail-ee0-f50.google.com with SMTP id d51so2364697eek.9
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 01:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=FNqvewGbjM0LdUJtRv0syu4OL1Ksg6aml1nyq/dKPgQ=;
        b=Id5md/GkJHOhzSukFXuH3NSE5e2itBtIjk9VxdB5aK7+PVk5SOuvxCzrUqPJYIu3Wn
         PGKf1KDASmc3WIbQbY5iRVAwQ+3qg6vlD8nPscZxsb+21diLzp24FYr+Pd+XEq9TWg6m
         8kcUM5TyC1q3iHHCG2ysNOx88ufqtj4DRjZv1yb5l4jbZyAP33e61rM86dA1kZ9jVCiu
         TDM+obJ/0aQeJQE+TR9fXmhqiqdScoqdmuVKI0lE5FHyMaNOD0Tdz0SGLFYBkKlLs46X
         g2wKDRyhiSbaVHc44qt415MUFFgLAckN7cFaCScLJ1aSlmH0b7n66w8CaXIy60V41UxC
         9XGw==
X-Received: by 10.15.54.199 with SMTP id t47mr36346917eew.46.1381568133263;
        Sat, 12 Oct 2013 01:55:33 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id m54sm125030430eex.2.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 01:55:32 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <1381561636-20717-18-git-send-email-felipe.contreras@gmail.com>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236042>

On 10/12/2013 09:07 AM, Felipe Contreras wrote:
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Not sure if it's worth by a newcomer. ;)

Reviewed-by:  Stefan Beller <stefanbeller@googlemail.com>

> ---
>  alias.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/alias.c b/alias.c
> index eb9f08b..9938f03 100644
> --- a/alias.c
> +++ b/alias.c
> @@ -5,7 +5,7 @@ static char *alias_val;
>  
>  static int alias_lookup_cb(const char *k, const char *v, void *cb)
>  {
> -	if (!prefixcmp(k, "alias.") && !strcmp(k+6, alias_key)) {
> +	if (!prefixcmp(k, "alias.") && !strcmp(k + 6, alias_key)) {
>  		if (!v)
>  			return config_error_nonbool(k);
>  		alias_val = xstrdup(v);
> @@ -34,7 +34,7 @@ int split_cmdline(char *cmdline, const char ***argv)
>  	int src, dst, count = 0, size = 16;
>  	char quoted = 0;
>  
> -	*argv = xmalloc(sizeof(char *) * size);
> +	*argv = xmalloc(sizeof(**argv) * size);
>  
>  	/* split alias_string */
>  	(*argv)[count++] = cmdline;
> @@ -45,7 +45,7 @@ int split_cmdline(char *cmdline, const char ***argv)
>  			while (cmdline[++src]
>  					&& isspace(cmdline[src]))
>  				; /* skip */
> -			ALLOC_GROW(*argv, count+1, size);
> +			ALLOC_GROW(*argv, count + 1, size);
>  			(*argv)[count++] = cmdline + dst;
>  		} else if (!quoted && (c == '\'' || c == '"')) {
>  			quoted = c;
> @@ -76,12 +76,13 @@ int split_cmdline(char *cmdline, const char ***argv)
>  		return -SPLIT_CMDLINE_UNCLOSED_QUOTE;
>  	}
>  
> -	ALLOC_GROW(*argv, count+1, size);
> +	ALLOC_GROW(*argv, count + 1, size);
>  	(*argv)[count] = NULL;
>  
>  	return count;
>  }
>  
> -const char *split_cmdline_strerror(int split_cmdline_errno) {
> -	return split_cmdline_errors[-split_cmdline_errno-1];
> +const char *split_cmdline_strerror(int split_cmdline_errno)
> +{
> +	return split_cmdline_errors[-split_cmdline_errno - 1];
>  }
> 
