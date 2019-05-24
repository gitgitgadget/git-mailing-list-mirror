Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A6A91F462
	for <e@80x24.org>; Fri, 24 May 2019 00:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388451AbfEXABz (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 May 2019 20:01:55 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38018 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388423AbfEXABz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 May 2019 20:01:55 -0400
Received: by mail-pf1-f195.google.com with SMTP id b76so4143024pfb.5
        for <git@vger.kernel.org>; Thu, 23 May 2019 17:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OEpGWQejs2uXBM0khhMRL1KHxO6gF/GjeFRy4Xo71iI=;
        b=sCDk9DIzwrFq+OsTPyAZq+07N7vH6KqW35Bhi6jlogWm6DfH1Lqv+aadtRqkjK0X1n
         KWintR4o7+KqXIfmDPBe1W3nT+1JooMIsU1SMbSDWyN3H8wjOpFXVpkkNwLudx+NV06Y
         Sqh1ad2ddTLdzMtaEID5kNsKo8fvCfSZnPkOb3YAuN7jR83quoht2XCPBM2ZGejNH4mp
         t4uwOPSZ7KG2xpgcvbXTs7hlUgdM9gvyKNgepbOQHKbT61fB4grt592vpWJlFxYshxaK
         UJwGJrCqEfHhB67f9Z+CWoaujkaNEfLTfq/l5lVdgjrRIvoiZR2JaoAI2G8EeSF6VvQo
         MA3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OEpGWQejs2uXBM0khhMRL1KHxO6gF/GjeFRy4Xo71iI=;
        b=ihcbqWH93T4O+rsao65uNPG0uxCdibnrbB6+qiTDBDZNWg4zNPNZE7EVZI1OEKAZdA
         aeh2MSrJSxeUZXwNlon0o/DQrKhXTVeKbSjVJgoFtcwyZZyWoyC9E217p9QdJ1pWfujv
         DFX8h2W2V5YeJ+6RJgATGh079lWdGy8sQS6ye9RDtZbDQ4pLXIQVKZm08npRmBbdLiKg
         XDXQMUZgBnxlm3BGwM46qmCQKzJdgt/T0wM+5D63kIUU32k4LJBi8Ut77e5XGFIfMBbm
         cp3W4mQZdzQSzWxtCllbzLsiMlQboEJMSel78EAuKNxZEUV5PNbV0X8DyRCuz+LWMMlR
         dDEQ==
X-Gm-Message-State: APjAAAV/25Ap21t8d909YBzS2RdrqBTuzjYeM5hCw1cY94iV2HRqfQMi
        lEDEgBXhS525HgD6cZqW9uE=
X-Google-Smtp-Source: APXvYqyxMAmZhMyUQt5Q0ee4ycveYkIgDQZ9kb60I6sYA9kuu6eTTjY4dfaqjxXHfVdSH5XNvP8OyQ==
X-Received: by 2002:a17:90a:cb0a:: with SMTP id z10mr5345127pjt.101.1558656112341;
        Thu, 23 May 2019 17:01:52 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id s24sm568300pfe.57.2019.05.23.17.01.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 23 May 2019 17:01:51 -0700 (PDT)
Date:   Thu, 23 May 2019 17:01:50 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Xin Li <delphij@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use user supplied origin name for extension.partialcone
 instead of hardcoded value.
Message-ID: <20190524000150.GD70860@google.com>
References: <20190523235543.4342-1-delphij@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523235543.4342-1-delphij@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Xin Li wrote:

> Subject: Use user supplied origin name for extension.partialcone instead of hardcoded value.

Good catch!

Nits:

- s/partialcone/partialclone/ (missing "l")

- subject lines in git.git tend to be of the form
  "subsystem: lowercase summary" with no trailing period.  So maybe
  something like:

	clone: respect user supplied origin name when setting up partial clone

> Signed-off-by: Xin Li <delphij@google.com>
> ---
>  builtin/clone.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

The change looks obviously good.  With or without a commit message
change like suggested above,

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
