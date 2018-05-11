Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B4B61F406
	for <e@80x24.org>; Fri, 11 May 2018 03:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752454AbeEKDea (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 23:34:30 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39543 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751168AbeEKDeH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 23:34:07 -0400
Received: by mail-wm0-f67.google.com with SMTP id f8-v6so628237wmc.4
        for <git@vger.kernel.org>; Thu, 10 May 2018 20:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=E3ADAnbH7Ny1W8zF9i/EpvRVNMQUUhttsGY4P47w7xI=;
        b=pnqqyzwqVKqwYRGwkks9LTZZtInTeGvy56qJJXmg2aa289ZVoZ7ZtbeTGQ16lBl3Jn
         q8VP5TtGtq18hrrBkWiWdNzkka0mwdr9gNQOHdkssCIp54GuCUjqPOkrPFXXK3YzqUBr
         AkFbgFjz8rUWNZZcqOoLuWOSswlkQXT6nezjIasK5QxNLbt0K6bsioEo0mS6Tid5RTHw
         FqHeJb75HiPE9umBkBPDciZw+Jp8vFQZAds+kL9Hxvy17nv6EU22ImHC98+fsn8Genpf
         UXOrvmQYv4d5MVmsOd/LdwDBNFLJLEPIiNYdxW38yIjK1dxJ7qjihUEQ0aDP6V8agYne
         mr6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=E3ADAnbH7Ny1W8zF9i/EpvRVNMQUUhttsGY4P47w7xI=;
        b=qcTII5zG5GRViZ/eLzFq59Nsh44tdv83RCdpdcCABniWwjdJVUJaoig2XvJ4bmZEsr
         viTGnmljFASrFADFP/pqjGBPeGyo9uGTEOxtaPefg8+gqzXGOzqMdvpM/NVrIuk+ZEZD
         DLC4MguPM1PJdXGUsaoxYglJcRtfV3NADNVMFJDkTbtwoK8NHVq5ezQw72BzIihrNxfj
         NFyyjSJd51zC9udX4zxTIrjN4ZgWEKc8LOsDU6S96VWtGa6TOQR6Q9s4rSKfncCFi/2B
         T/q1nwpOPDxd7F7sGldogZ4/epAIfMjeaCMxsAoEwLCwSaNFousfZx/itskH7HxgCumb
         nG5w==
X-Gm-Message-State: ALKqPwe3yiefQlw7OyCLlXU0XGd6h8r3POJH8Hg6kfrkKMcnJLNlUyoK
        rylXGFh4fHyfCPiM/IiSuoQ=
X-Google-Smtp-Source: AB8JxZq+qU79/sIrhJ+S78vaa13gLAkd8W58/gBLRFVZKAOgF9pjgn6NrCFykzAnoeRI9yPWQW3mig==
X-Received: by 2002:a1c:e58a:: with SMTP id c132-v6mr734016wmh.23.1526009646192;
        Thu, 10 May 2018 20:34:06 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u37-v6sm2503759wrb.53.2018.05.10.20.34.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 May 2018 20:34:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     kelly elton <its.the.doc@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] apply: clarify "-p" documentation
References: <CALVfKe_em046aO9QUqJ0TXcLh6Oe7ydYQKr9Zwvheq8RV4=43g@mail.gmail.com>
        <20180510142924.GB25617@sigill.intra.peff.net>
Date:   Fri, 11 May 2018 12:34:05 +0900
In-Reply-To: <20180510142924.GB25617@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 10 May 2018 10:29:24 -0400")
Message-ID: <xmqqin7uhnma.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> How about this?
>
> -- >8 --
> Subject: [PATCH] apply: clarify "-p" documentation
>
> We're not really removing slashes, but slash-separated path
> components. Let's make that more clear.
>
> Reported-by: kelly elton <its.the.doc@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Documentation/git-apply.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
> index 4ebc3d3271..c993fbf714 100644
> --- a/Documentation/git-apply.txt
> +++ b/Documentation/git-apply.txt
> @@ -113,8 +113,10 @@ explained for the configuration variable `core.quotePath` (see
>  linkgit:git-config[1]).
>  
>  -p<n>::
> -	Remove <n> leading slashes from traditional diff paths. The
> -	default is 1.
> +	Remove <n> leading path components (separated by slashes) from
> +	traditional diff paths. E.g., with `-p2`, a patch against
> +	`a/dir/file` will be applied directly to `file`. The default is
> +	1.

Thanks for an obvious improvement.  Will queue.

>  
>  -C<n>::
>  	Ensure at least <n> lines of surrounding context match before
