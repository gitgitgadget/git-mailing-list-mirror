From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 1/4] remote: use skip_prefix
Date: Mon, 15 Feb 2016 21:37:30 +0100
Message-ID: <20160215203730.GC13775@hank>
References: <1455558150-30267-1-git-send-email-t.gummerer@gmail.com>
 <1455558150-30267-2-git-send-email-t.gummerer@gmail.com>
 <20160215181837.GE26443@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 15 21:37:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVPtT-00057D-S7
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 21:37:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819AbcBOUhK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 15:37:10 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33834 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751555AbcBOUhH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 15:37:07 -0500
Received: by mail-wm0-f67.google.com with SMTP id b205so10108205wmb.1
        for <git@vger.kernel.org>; Mon, 15 Feb 2016 12:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=/Bf2qjqeuJvfv0U5K2bYsAPmkfB3f5wdHQ5bMuyxR7w=;
        b=sYpbNAyNyYOOM8WIG0dmrhawHFP6nM+KVbS7dXbA5TfwMM8fMj7jCD6KUfwpMhgpBw
         6AkS2bfJbusl/zC9E362xk+6OdcnHzQeNKZ8STKYkF9xUgIyrJHhiu2ynkoWqsta0Ema
         WsgxElrI1bFrPp/h6tkn2KscK7dACtLdKxm1CEdveiCbCoa9DY62zaP7MZrXQ1HRAwC+
         Ct2VWDRT0NnuicWs5zfaONOA9B6WdhnVg+2sxQZYhK1ko30bNbTd/y6z7xEjXm7jkeBy
         C8AF7oVcsmcKYcIexPKDy5Pbg0UMl3yE94QC8r9FFKGKGvzwMfqk6vsF8ANtbc4s9R6m
         81xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=/Bf2qjqeuJvfv0U5K2bYsAPmkfB3f5wdHQ5bMuyxR7w=;
        b=ARSheFIL5CwTrol2vG0uEb+x2M8+URY5AFpoWVmec4h/CrozXnyjzf4hXjUfAipDHC
         aS+xo8kAoA/s9guEoY5JKkPa2OrRtIe8L8yh3E/dgI9rdfnNUeplX8WqX11kpa+aaCfC
         GWKN5gntuk9zV6v4IpUV91Tvku1ztfKdKaQjpqufS35liuv0ccyV8pO//70FBRI9mxak
         5PrvPYGFIMnrZMx0TEbPrY8LYl/dDMj0Fb0EOm8tRZ0rTeuvq0XNroTfFeRjUUKByRbt
         fECH5/lVBttsleWa1eCavVIcgJCBshxJASFaMgWi8r+KSMLoMdjWueLQlcDT25ubUx6H
         gmVw==
X-Gm-Message-State: AG10YORqeFHIgH524B8jWgPAviBrCJY+R0gXo3NLrKGg+rKlX5wlikSlyvW3XqIhcSj2Fg==
X-Received: by 10.194.91.175 with SMTP id cf15mr18323769wjb.7.1455568626187;
        Mon, 15 Feb 2016 12:37:06 -0800 (PST)
Received: from localhost (host186-106-dynamic.41-79-r.retail.telecomitalia.it. [79.41.106.186])
        by smtp.gmail.com with ESMTPSA id os7sm27059714wjc.18.2016.02.15.12.37.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Feb 2016 12:37:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160215181837.GE26443@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286236>

On 02/15, Jeff King wrote:
> On Mon, Feb 15, 2016 at 06:42:27PM +0100, Thomas Gummerer wrote:
>
> > 95b567c7 ("use skip_prefix to avoid repeating strings") transformed
> > calls using starts_with() and then skipping the length of the prefix to
> > skip_prefix() calls.  In remote.c there are a few calls like:
> >
> >   if (starts_with(foo, "bar"))
> >       foo += 3
> >
> > These calls weren't touched by the commit mentioned above, but can
> > benefit from the same treatment to avoid magic numbers.
>
> This is definitely an improvement, but I think we can actually go a step
> further here, and use parse_config_key. Like:

Thanks, I had no idea about this function :) It makes the diff a lot
noisier, but I do think the end result is better.

> diff --git a/remote.c b/remote.c
> index 21e4ec3..8d2c3ca 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -318,15 +318,14 @@ static void read_branches_file(struct remote *remote)
>  static int handle_config(const char *key, const char *value, void *cb)
>  {
>  	const char *name;
> +	int namelen;
>  	const char *subkey;
>  	struct remote *remote;
>  	struct branch *branch;
> -	if (starts_with(key, "branch.")) {
> -		name = key + 7;
> -		subkey = strrchr(name, '.');
> -		if (!subkey)
> +	if (starts_with(key, "branch", &name, &namelen, &subkey)) {
> +		if (!name)
>  			return 0;
> -		branch = make_branch(name, subkey - name);
> +		branch = make_branch(name, namelen);
>  		if (!strcmp(subkey, ".remote")) {
>  			return git_config_string(&branch->remote_name, key, value);
>  		} else if (!strcmp(subkey, ".pushremote")) {
>
> and so on. The difference in lines of code isn't that great, but I think
> it makes the resulting code more obvious to read.
>
> -Peff

--
Thomas
