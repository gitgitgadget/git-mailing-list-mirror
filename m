Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 566C11F453
	for <e@80x24.org>; Sat,  9 Feb 2019 18:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbfBISeZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Feb 2019 13:34:25 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35449 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfBISeZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Feb 2019 13:34:25 -0500
Received: by mail-wm1-f65.google.com with SMTP id t200so9239705wmt.0
        for <git@vger.kernel.org>; Sat, 09 Feb 2019 10:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=fRJnTCIefX0sNXZ1+T8gYUgDYgj9EN1hpK+JLwZXcmM=;
        b=TIa08UiSsQ++EeBOz1kXkbkMQcsZExtceuW6T6lFu+TiFrXjpSFfUoBs5IaVQfnK6V
         BDQUsjzwyUL/nQ7TmcIsmg1MfrNkwayOherBzX/7I14GyBPwi9m0STVhUoTPNkq82HQM
         2Rx4BUXsk0c1jADhx5QqPyUNwvMC9Mz1MV7A1cI9wRD3LAU+z+41wZydxVWGN0CkbApp
         GQgU54Y4KFOqaZUDM6YzCIBrRIU0A8WC06+EoXtSIE0Ii8jTVzHvxE3tki3chT9DmvCR
         F8EX0mQImNQfOPh8ld89bcUidAgWifyrSqwctYWRIICpf6nA3NwEJvfkQFQGfSwvAVuq
         q/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=fRJnTCIefX0sNXZ1+T8gYUgDYgj9EN1hpK+JLwZXcmM=;
        b=J4XOwYO2w9HJzmWJ6cZSu4Em4D6Z0mEy23Bb36faQRBc7OObENl4G/GWM+ImpAl1J9
         YfHI7yaxuKgZlR4e89ui/ZooE558cLJW47mSDTeRvzVD+QKDi0eSXAtZd3Z0CSJ7fayK
         wsVFIYfIRedEwBz+T94jKBWGQ67I70DteZYSFNXU27FzcoGrW4M4hdNYj5SwbUrfkF2o
         zqpyIfxBjx/YdaE0OyKOc1KhX7ZNdl2jWDOI/A51QnNrgW9mTNjRwfBoRK/PSnSFDo9V
         B5Buwo6hTfhbkuWbkndNr2IPO8i78PAHlXGtLpI20mspRVCJJcx+OpLaL4PL77gA2Faj
         a1Eg==
X-Gm-Message-State: AHQUAubh4dvybbQGAXzXWqbCLXAs0v34O+zzTUG36BXs6FqRlWYgdidH
        OwqRv3NKFseIluwZ/W4uGZo=
X-Google-Smtp-Source: AHgI3IZ3R7Rk58z7fcNibEfZBZ8lCQLNNO1SaZBB6VsBabbK2PUoWkKiFe+YddhpLdLGmSa5eEUWIg==
X-Received: by 2002:a1c:4681:: with SMTP id t123mr3467733wma.24.1549737262381;
        Sat, 09 Feb 2019 10:34:22 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a14sm4871922wrr.13.2019.02.09.10.34.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Feb 2019 10:34:21 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dan McGregor <dan.mcgregor@usask.ca>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] git-compat-util: undefine fileno if defined
References: <20190201193004.88736-1-dan.mcgregor@usask.ca>
        <20190209023621.75255-1-dan.mcgregor@usask.ca>
Date:   Sat, 09 Feb 2019 10:34:21 -0800
In-Reply-To: <20190209023621.75255-1-dan.mcgregor@usask.ca> (Dan McGregor's
        message of "Fri, 8 Feb 2019 20:36:21 -0600")
Message-ID: <xmqqsgwwizf6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dan McGregor <dan.mcgregor@usask.ca> writes:

> Commit 8dd2e88a92 ("http: support file handles for HTTP_KEEP_ERROR",
> 2019-01-10) introduced an implicit assumption that rewind, fileno, and
> fflush are functions. At least on FreeBSD fileno is not, and as such
> passing a void * failed.
>
> All systems tested (FreeBSD and NetBSD) that define fineo as a macro

s/fineo/fileno/

> also have a function defined. Undefine the macro on these systems so
> that the function is used.

That smells like the patch is assuming a bit too much.  A platform
you did not inspect may have it as a macro but the implementation
may still be usable without breakage like the one we saw on FreeBSD,
for example.

It also robs us the possibility of overriding fileno() with our own
macro earlier in this file, like we do for many functions you see in
the output from this:

 $ git grep '#define .* git' git-compat-util.h

In general, I'd like to see people thinking twice about an overly
simple approach when they justify it with "this should work
everywhere I know of".

> Signed-off-by: Dan McGregor <dan.mcgregor@usask.ca>
> ---
>  git-compat-util.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 29a19902aa..b5489bbcf2 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -764,6 +764,15 @@ char *gitstrdup(const char *s);
>  extern FILE *git_fopen(const char*, const char*);
>  #endif
>  
> +/* Some systems (the various BSDs for eaxmple) define

Style:

/*
 * Our multi-line comment starts with a lone slash-star
 * and ends with a lone star-slash, like this.
 */

> + * fileno as a macro as an optimization. All systems I
> + * know about also define it as a real funcion, so use
> + * the real function to allow passing void *s to fileno.
> + */
> +#ifdef fileno
> +# undef fileno
> +#endif
> +
>  #ifdef SNPRINTF_RETURNS_BOGUS
>  #ifdef snprintf
>  #undef snprintf
