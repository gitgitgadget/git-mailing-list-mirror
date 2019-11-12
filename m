Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69A1E1F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 17:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfKLR7a (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 12:59:30 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42605 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbfKLR73 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 12:59:29 -0500
Received: by mail-pl1-f194.google.com with SMTP id j12so9695618plt.9
        for <git@vger.kernel.org>; Tue, 12 Nov 2019 09:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yAo/m1Cv/cCFnYG2rUFKRW4mvcFaeBrJxxKTiusodRs=;
        b=Ks3NnUK3LHcHpaOC78DqQWbiVOs5b5Q7dAuEse+6OvRRpjdOEjP3sRUWaB8N/B6RhN
         syLk1FN+c+WR4l8/XzMyppu/YBqgVAu770VKkUqcSyQ1QRfMNzXdDZ0AU32QhLRklBE0
         msOreYjZzWO7P4xtuQu/xMb8ctzomsZ8vAeesJjtnoXTqzabi6VZj44GPGfFzlG/PPYK
         3Y0m8dEEIRoWfFTb3RInNTvvRU43oT2GHRxYbDIn708P8SVWqN8lakcqXp7/S3xJLCIr
         21n1BwoGQY4mkvv+lq/3Pfk1Hqn6vxKySQCvBMmCSDo0H+tV54gHR7jj3f9fnxEYTNHT
         Om7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yAo/m1Cv/cCFnYG2rUFKRW4mvcFaeBrJxxKTiusodRs=;
        b=cFnSPr+0LxqfU9fOAdK+6bvSeRsqhaa3ZJkS7GIvOGoL6KNMSQvnYGtic/UyfSR7cW
         yqymH0Ca9gNyyalbF004MzhamoWRA2YOAQtNJdkoLiW0eH3vqB3/O9xSIKHB4n/mtSzT
         zoxy8CGE4dsl5iEXVE4Q99sw9A8iLlDgR5ob9047zPlkgGIyCnI6lnYHsZGiIbSak6RX
         Fl1RzZnx0aVtLM0MQH+2rGZAPHsLijI2lqSacuuwgF3Vf7eDjOZ/2j4N1O14JygZPDVN
         +3fGPGoD5vD26P3sRdiH9f5+J3ZfXc5qKlyUdIVhrHmi6q1Zaltv0bc3r2l9Thbrbdc4
         H7Ag==
X-Gm-Message-State: APjAAAW1Jbz5NrWKIjsF0yOctekrGNJ9n0eCooFrdFX+Q+yxSc+Aausz
        ERzyzdXAGsLnNDmuX9EJVjI=
X-Google-Smtp-Source: APXvYqxrzqvva8GwA6JyDTF45LKIeDhIkQkisSNpuz86BY9VGgi21dD1gnthNrYLzCluOLRAL6hthQ==
X-Received: by 2002:a17:902:a60b:: with SMTP id u11mr16400523plq.180.1573581568950;
        Tue, 12 Nov 2019 09:59:28 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id t27sm19598186pfq.169.2019.11.12.09.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 09:59:27 -0800 (PST)
Date:   Tue, 12 Nov 2019 09:59:26 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] coccinelle: merge two rules from flex_alloc.cocci
Message-ID: <20191112175926.GA41101@generichostname>
References: <f867512c-e5b2-6bca-2a37-2976f4c182bd@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f867512c-e5b2-6bca-2a37-2976f4c182bd@web.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Markus,

Thanks for the contribution.

I see that you've sent many Coccinelle patches to the mailing list. It
might be better to send them all together as a single threaded patchset
so that reviewers will have an easier time finding all of them.

On Tue, Nov 12, 2019 at 04:34:34PM +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 12 Nov 2019 16:30:14 +0100
> 
> This script contained two transformation rules for the semantic patch language
> which used duplicate code.
> Thus combine these rules by using a SmPL disjunction for the replacement
> of two identifiers.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  contrib/coccinelle/flex_alloc.cocci | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/contrib/coccinelle/flex_alloc.cocci b/contrib/coccinelle/flex_alloc.cocci
> index e9f7f6d861..1b4fa8f801 100644
> --- a/contrib/coccinelle/flex_alloc.cocci
> +++ b/contrib/coccinelle/flex_alloc.cocci
> @@ -1,13 +1,14 @@
> -@@
> +@adjustment@

None of our other cocci scripts have rulenames so I would drop the
rulename here. It also doesn't really help since its name is so generic.

I would also echo this for the other patches you've sent.

>  expression str;
> -identifier x, flexname;
> -@@
> -- FLEX_ALLOC_MEM(x, flexname, str, strlen(str));
> -+ FLEX_ALLOC_STR(x, flexname, str);
> -
> -@@
> -expression str;
> -identifier x, ptrname;
> -@@
> -- FLEXPTR_ALLOC_MEM(x, ptrname, str, strlen(str));
> -+ FLEXPTR_ALLOC_STR(x, ptrname, str);
> +identifier x, name;
> +@@
> +(
> +-FLEX_ALLOC_MEM
> ++FLEX_ALLOC_STR
> +|
> +-FLEXPTR_ALLOC_MEM
> ++FLEXPTR_ALLOC_STR
> +)
> +               (x, name, str
> +-                           , strlen(str)
> +               );

Small nitpick but to be inline with how the rest of our cocci scripts
are written, I'd write this as

	  (x, name, str
	- , strlen(str)
	  );

Thanks,

Denton

> --
> 2.24.0
> 
