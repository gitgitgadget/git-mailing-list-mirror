Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2747A20209
	for <e@80x24.org>; Sat,  1 Jul 2017 13:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751856AbdGANwL (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 09:52:11 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33909 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751389AbdGANwL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jul 2017 09:52:11 -0400
Received: by mail-wr0-f193.google.com with SMTP id k67so41055062wrc.1
        for <git@vger.kernel.org>; Sat, 01 Jul 2017 06:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=Y3AgJ3n9fFVz5dv6wts9y457O7TAayUpZ/T1AppOy7s=;
        b=J/GfHwSZRHvATWplN39p+0Hocw010jrhxCXwJ+GPvVZpeuL/+gcYntun4LKocuLI2y
         HQA3EIwlzBZSkVTz2fhsJwvoDpRgsHYlnHMvNQhJsdKtUkh3v+SN3dWeG99qEWOwJdV1
         va8uKUOleeQY8HnnmefXdsYAO8vWlH9Wtb1CQH5xJwNxkynbqHZeG8gWlJoThm0k3uXr
         2VLLb7jn0BgVMvLQXWuNlidVyL8iIoK3cv1RhOkq2qycJmpjmVZEXdGzSE/5EovSqK6S
         hzt/Twro8kY3QU41U+YdRsICARCYK4YwoM6EJp+oJYGjNpqG9wHvkQvHNZkgbV9tYIGq
         pTvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=Y3AgJ3n9fFVz5dv6wts9y457O7TAayUpZ/T1AppOy7s=;
        b=byWn/csleF536bncLhqyuIEV6rS87UHzqzgeBBW6QxUxTCJGc8hqqx7jHyek7c4scb
         iURVcziqmm7UVu73Gb0gWD2JdzW0adH/8+rWEQvN216iLajQ54Od434/7A63uzW1rLXk
         gfrxjo0+5rg1eoOtK7BacmhUT3h4olNBGl77DwzFpSr+aNg8UFPFl7tJQt1rnlMQ4pYB
         8bUNeE6dyYzrxlQSitk5qGxiBgDQDYy9LVRl3vEmd/enhN44rTrZPWZSaPCfi5C+UEBQ
         jizroAHrbr9zEanDQ5jMjG/Khjn0tHVbW47Anuzl37bnLNwxmvNqd/VZlGSJY30bYv/t
         2DXQ==
X-Gm-Message-State: AKS2vOyy2oCTZMSAUMmJlz4aqhPbU73fIVzbDefJ7dRYxy3OmVAOVwHF
        7/sh/ThZW3fWtg==
X-Received: by 10.223.166.148 with SMTP id t20mr18127115wrc.52.1498917129688;
        Sat, 01 Jul 2017 06:52:09 -0700 (PDT)
Received: from snth (g74110.upc-g.chello.nl. [80.57.74.110])
        by smtp.gmail.com with ESMTPSA id x131sm4507584wmg.13.2017.07.01.06.52.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Jul 2017 06:52:06 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dRIof-0006b8-4N; Sat, 01 Jul 2017 15:52:05 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     s_shestakov@playrix.com, kostix+git@007spb.ru,
        Matthieu.Moy@grenoble-inp.fr, tboegi@web.de, git@vger.kernel.org
Subject: Re: [PATCH] status: suppress additional warning output in plumbing modes
References: <70c9a162-ac2f-c347-d13b-f24ac24d1133@web.de> <20170630162826.27711-1-sbeller@google.com>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20170630162826.27711-1-sbeller@google.com>
Date:   Sat, 01 Jul 2017 15:52:05 +0200
Message-ID: <87h8ywe03e.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jun 30 2017, Stefan Beller jotted:

> When status is called with '--porcelain' (as implied by '-z'), we promise
> to output only messages as described in the man page.
>
> Suppress CRLF warnings.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
> Maybe something like this?

It looks sensibly implemented, but as for the approach I think we should
just document that you might get errors on stderr, but stable output on
stdout.

Many consumers of --porcelain, such as magit, will run arbitrary git
output and expect that if they get something on stderr they should be
showing it in some special buffer to the user as associated error
information.

I think it makes sense to do this & document it in the man page, if you
don't care about possible error messages 2>/dev/null is trivial, but
it's not trivial to discover in some non-expensive way (parsing the
non-porcelain output) that there *are* errors.

>  builtin/commit.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 00a01f07c3..3705d5ec6f 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1126,6 +1126,11 @@ static void finalize_deferred_config(struct wt_status *s)
>  			die(_("--long and -z are incompatible"));
>  	}
>
> +	/* suppress all additional output in porcelain mode */
> +	if (status_format == STATUS_FORMAT_PORCELAIN ||
> +	    status_format == STATUS_FORMAT_PORCELAIN_V2)
> +		safe_crlf = SAFE_CRLF_FALSE;
> +
>  	if (use_deferred_config && status_format == STATUS_FORMAT_UNSPECIFIED)
>  		status_format = status_deferred_config.status_format;
>  	if (status_format == STATUS_FORMAT_UNSPECIFIED)
