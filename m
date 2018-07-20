Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 893E41F597
	for <e@80x24.org>; Fri, 20 Jul 2018 22:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbeGTXNy (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 19:13:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46291 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728214AbeGTXNy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 19:13:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id s11-v6so12500497wra.13
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 15:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=bprodpY5hfFKEKSPIRswrTo+rFlPS2ueVirVur4k7KA=;
        b=Cm10zPFDFYQeUuejyjIrPfTUUXebnKyCpGgrbRlnCAIOyHjSRI25pk/DBhLX9PKgC2
         Z96n+mTYI+QVfXL8nOgOMqx0Qkp6OD8cHN2ROYIuFyMUVVEew+GW5HZzhzmUBjJAamC6
         1TXSWDxzaIjRgQRuIZ9ueIb5hZzeUMnZ0ju0eCBT6BS8u4hMaJBWGuhz/AIIqGQ25N67
         NLJV9wrjpO8upXVagmgxwrldrK0Rq2QznMhdbaubzT7HO2rR5bAn571llq0QwfKUIYHv
         /erWxyV5hYWGM6d23hxR1WMZ15B/vPXEPQlaWV5fHzsf5eSb6t6cADdKcPng9GF4Q5KY
         J5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=bprodpY5hfFKEKSPIRswrTo+rFlPS2ueVirVur4k7KA=;
        b=nuQrBtKNRXHdP2IMirne8ubeDLkGHdlHpxj1vsJ2zdyo4k4UEqrOkHYSE0ldTJ49/U
         irhQj+qx5+mH80aDnpaWXOhqwX97YHdpaUF9xWRw5P6Y7Z+MeaM6ejUfiYajQrK8W0SU
         huB920pGvuAeAgAWXQXXuGv/Oq2JP3KgmpmHCaJq/2ZwDapHSwnjqsv/TW5ABA5kyQ0H
         e5aaefUP4WhWPOz89X+eG2h5dkL/XYxLZ1AAUGbmCNFL/dSQMPNseykUNuYMPqTdudAD
         /5lwpwSN8VEJGQBC9hM3ImmcmXc4YPg2ZLWFOLinkWaVajNJGGXYbvMBJwqD7YpoaNfs
         Q8WA==
X-Gm-Message-State: AOUpUlF/tROjFiOsCpOh7IDJ1HiXv4eqTSXjt83uYGVPacRmuy+wY0I0
        fafnyNfnbpLFyupVpsPIZnM=
X-Google-Smtp-Source: AAOMgpcEvQ8a4GUM70WLgjkAlhC66XNqmet4+jO22IOcE+hSnYdQLnve8whOP/YN5Yz7bKO6aBUWqw==
X-Received: by 2002:adf:b519:: with SMTP id a25-v6mr2709610wrd.273.1532125417354;
        Fri, 20 Jul 2018 15:23:37 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 31-v6sm5207202wra.26.2018.07.20.15.23.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 15:23:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] Documentation/git-interpret-trailers: explain possible values
References: <20180720215349.179542-1-sbeller@google.com>
Date:   Fri, 20 Jul 2018 15:23:36 -0700
In-Reply-To: <20180720215349.179542-1-sbeller@google.com> (Stefan Beller's
        message of "Fri, 20 Jul 2018 14:53:49 -0700")
Message-ID: <xmqq1sbxa6mv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
> Maybe we rather want to refer to the options that are described further
> down in the document?

I have no strong preference either way.

The patch looks reasonable to me; Christian?

>
>  Documentation/git-interpret-trailers.txt | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
> index 9111c47a1bf..b8fafb1e8bd 100644
> --- a/Documentation/git-interpret-trailers.txt
> +++ b/Documentation/git-interpret-trailers.txt
> @@ -88,7 +88,8 @@ OPTIONS
>  	Specify where all new trailers will be added.  A setting
>  	provided with '--where' overrides all configuration variables
>  	and applies to all '--trailer' options until the next occurrence of
> -	'--where' or '--no-where'.
> +	'--where' or '--no-where'. Possible values are `after`, `before`,
> +	`end` or `start`.
>  
>  --if-exists <action>::
>  --no-if-exists::
> @@ -96,7 +97,8 @@ OPTIONS
>  	least one trailer with the same <token> in the message.  A setting
>  	provided with '--if-exists' overrides all configuration variables
>  	and applies to all '--trailer' options until the next occurrence of
> -	'--if-exists' or '--no-if-exists'.
> +	'--if-exists' or '--no-if-exists'. Possible actions are `addIfDifferent`,
> +	`addIfDifferentNeighbor`, `add`, `replace` and `doNothing`.
>  
>  --if-missing <action>::
>  --no-if-missing::
> @@ -104,7 +106,8 @@ OPTIONS
>  	trailer with the same <token> in the message.  A setting
>  	provided with '--if-missing' overrides all configuration variables
>  	and applies to all '--trailer' options until the next occurrence of
> -	'--if-missing' or '--no-if-missing'.
> +	'--if-missing' or '--no-if-missing'. Possible actions are `doNothing`
> +	or `add`.
>  
>  --only-trailers::
>  	Output only the trailers, not any other parts of the input.
