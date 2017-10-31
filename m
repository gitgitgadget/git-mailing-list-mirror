Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 587AB20437
	for <e@80x24.org>; Tue, 31 Oct 2017 17:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932342AbdJaRz0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 13:55:26 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:43548 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751295AbdJaRzZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 13:55:25 -0400
Received: by mail-io0-f195.google.com with SMTP id 134so649004ioo.0
        for <git@vger.kernel.org>; Tue, 31 Oct 2017 10:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+iRUtLdutFks1K4XgSgNhB1DduvQOOzoQMNsDiCMNLY=;
        b=pFR7ocYcU33wH2zL8Yr2Khdu9NAGWnESPdRXb1D9hU7gjxnYjeNvSbLBWswL1/80lr
         ZyaAAU68IxlQhsQl3Jm4k43K/b/aH0+Lg+tsZrGjZ3FXmyNGeUDTrmB13KOQ0yqmXfxu
         51tITZZ6BXMcqRzrzX0bzejO3+nQ0tYj6i2/wpX7lI72Hk3eW48JrTE4kso/T8H6q5d+
         nDgi5sFdbPEYO3rz9XR3PGk2MdQw7/Ozk3+mnXOJd7SXT7rgoj0af67psGJqU74QYxrH
         bW4VYysrqFy6ex5qMHRtQR7JSSblr37y9If0wTU/EJL0w0OgamUtSs/2zsklEhDY2UBq
         3Stw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+iRUtLdutFks1K4XgSgNhB1DduvQOOzoQMNsDiCMNLY=;
        b=eEBcCZq7iOZ62w8p2rV/g0+cPG4EwfpZIxjRBJdrEG1Oi153plcYfUc6taaHwp4jfl
         9vPKSwN7uPsOc5ViAOyD1o7BaNS5y//8lBAINlyIIiPWVdhdqoKDIF2NWfYXCM7KYfrS
         PBUduLhrWjxqKQ/Nrf4HjuIcn6pUsf1GVUaBJ3Omr203P0++1arwjQN65COVfGrJucc0
         DbWpSbPSNQuoeH9HgYyWYTM8gqMVj3IuKVZiOcp+urxJPuSUTvu7tC2iBEfJxjBzYaaC
         /9ctSLE4FwOlFH4l6DaxW1AlKGEa0YwKgYPnSJfLaZ4QPkbDQDCvH0Kli0YBfHyTZ0Db
         xQYg==
X-Gm-Message-State: AMCzsaXA0zhiFlff7qVm3r1IjWrUZWH54Jm5GqNAWBdIJZfV938uZaaa
        BuExua83HkvukWszACZb7rXN2Q==
X-Google-Smtp-Source: ABhQp+QZNZZlSHwvlkWqrN2d1IImbcdjNSv15vahjdUAGWxltBX6akaa1J3mgT+lJ7RMbckMl+fDhQ==
X-Received: by 10.36.172.82 with SMTP id m18mr4252044iti.39.1509472524614;
        Tue, 31 Oct 2017 10:55:24 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:65da:c046:b1c4:7dde])
        by smtp.gmail.com with ESMTPSA id w195sm1105519ita.44.2017.10.31.10.55.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 31 Oct 2017 10:55:23 -0700 (PDT)
Date:   Tue, 31 Oct 2017 10:55:22 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH 3.5/4] diff: set TEXTCONV_VIA_CMDLINE only when it is set
 to true
Message-ID: <20171031175522.GC94048@google.com>
References: <20171027222853.180981-1-bmwill@google.com>
 <20171030194646.27473-1-bmwill@google.com>
 <20171030194646.27473-4-bmwill@google.com>
 <xmqqvaiv28n2.fsf_-_@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqvaiv28n2.fsf_-_@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/31, Junio C Hamano wrote:
> Change the meaning of the bit to "the user explicitly set the
> allow-textconv bit to true from the command line".
> 
> The "touched" mechanism in the old code meant to express "the user
> explicitly set the allow-textconv bit to something from the command
> line" and recorded that fact upon "--no-textconv", too, by setting
> the corresponding touched bit.  The code in the previous step to
> clear the bit did not make much sense.
> 
> Again, this may want be squashed into the previous step, but its log
> message needs to be adjusted somewhat (e.g. "s/is requested via/is
> set to true via/").

I don't have any opinions on this, but I agree that if we want a more
true conversion then we would wanted to squash this in, which I'll do
and update the log message.

> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  diff.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/diff.c b/diff.c
> index 8b700b1bd2..11fccbd107 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -4765,10 +4765,9 @@ int diff_opt_parse(struct diff_options *options,
>  	else if (!strcmp(arg, "--textconv")) {
>  		DIFF_OPT_SET(options, ALLOW_TEXTCONV);
>  		DIFF_OPT_SET(options, TEXTCONV_SET_VIA_CMDLINE);
> -	} else if (!strcmp(arg, "--no-textconv")) {
> +	} else if (!strcmp(arg, "--no-textconv"))
>  		DIFF_OPT_CLR(options, ALLOW_TEXTCONV);
> -		DIFF_OPT_CLR(options, TEXTCONV_SET_VIA_CMDLINE);
> -	} else if (!strcmp(arg, "--ignore-submodules")) {
> +	else if (!strcmp(arg, "--ignore-submodules")) {
>  		DIFF_OPT_SET(options, OVERRIDE_SUBMODULE_CONFIG);
>  		handle_ignore_submodules_arg(options, "all");
>  	} else if (skip_prefix(arg, "--ignore-submodules=", &arg)) {
> -- 
> 2.15.0-224-g5109123e6a
> 

-- 
Brandon Williams
