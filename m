Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E0221F4B6
	for <e@80x24.org>; Fri, 28 Jun 2019 17:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfF1RQh (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 13:16:37 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:34165 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfF1RQh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 13:16:37 -0400
Received: by mail-qk1-f201.google.com with SMTP id h198so7186723qke.1
        for <git@vger.kernel.org>; Fri, 28 Jun 2019 10:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bEIoF6/BWfCenrxHZijqhOSlJwELG5sFloXHjhzxB0Q=;
        b=gNdvrF9f5QUQsmXxfnIGfUiWtwqi7LoHtQIEXdzQzhaq7ptffLegIQus2+mjOy/3Lh
         rppvcLv38cYRxE3BxwCQonAH1km/y0aKdDCCnhoTTtEJRJfoYLr2sQcJB0KQcpBf/MZ8
         BBQVWtP/ypXoynHT611pti5eoMPL6QjK5vKp623OkaQxUHNxh5IHQ2J6syhqVnNiqcRe
         spYpl/Y2uBC4Ra3Fc9qjy3px4DpVUtZMJOyPHQmwXIG/PXvPrJK/eWnEEBbKROHNeyNI
         8KInbwonmq03IV6LLm/mQMIF59qkoUf8+e4pLTKnpcBOxnCJA1PUhmBJyBAmrF2gyRq9
         JfTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bEIoF6/BWfCenrxHZijqhOSlJwELG5sFloXHjhzxB0Q=;
        b=chCkxuYQDS5Ak1z0LG273Y082d29C0B7dZzALZja7t/Pb0d/hrHxM7OnRa7fhDF84x
         PKAbUuFGJF8Pc9KbJ/+h4cIhM7LBfwJMggJ/W1o9f/DiLeDQcX9wgXZKYOV2LQGgaHhQ
         EVqSO5stEUMmgA3qu1xZhtQm39imeaEQ3NzT2xnphIHDyoxu0XUg7nmRjrXzrjkyVajt
         kztEhJbjfEK4L1p/SBsCoylW5mQHdWXWtqRA28Da0fsEAIlWl2986DZpDpH/nP0+qmna
         Bt7te73oM+LODNKRHZ1uig9cGWR6RVE/XwjOiKsGZ19wcoq2n+vZHI54tUX2dn4fGK6O
         ykgw==
X-Gm-Message-State: APjAAAXxliwbRb/sLWX6WWfM29HHnPQTCg2Y1Eo7tJERSphzb1eHRUNY
        IehACWKgGgZW2sL9ZpH140tzzB4nITGBAsy6JESv
X-Google-Smtp-Source: APXvYqyA4wQueQ70FVheRaPp2WnbAJwr4p6lCFxxfZw64Xi7o+6AGKVB4rnPyv+aEdlvlI53btakIPCmy+nhBlAJilwB
X-Received: by 2002:a37:484a:: with SMTP id v71mr9448984qka.29.1561742196156;
 Fri, 28 Jun 2019 10:16:36 -0700 (PDT)
Date:   Fri, 28 Jun 2019 10:16:32 -0700
In-Reply-To: <cover.1561675151.git.matvore@google.com>
Message-Id: <20190628171632.114453-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1561675151.git.matvore@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: Re: [PATCH v5 00/10] Filter combination
From:   Jonathan Tan <jonathantanmy@google.com>
To:     matvore@google.com
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> This applies suggestions made by Jonathan Tan, as well as fixes a
> Coccinelle-breaking error in strbuf usage, and makes an additional string
> localizable.
> 
> Thanks,
> 
> Matthew DeVore (10):
>   list-objects-filter: encapsulate filter components
>   list-objects-filter: put omits set in filter struct
>   list-objects-filter-options: always supply *errbuf
>   list-objects-filter: implement composite filters
>   list-objects-filter-options: move error check up
>   list-objects-filter-options: make filter_spec a string_list
>   strbuf: give URL-encoding API a char predicate fn
>   list-objects-filter-options: allow mult. --filter
>   list-objects-filter-options: clean up use of ALLOC_GROW
>   list-objects-filter-options: make parser void

Thanks - the range-diff looks good to me. (I generated the range diff using a
base of a6a95cd1b4 for v4 and 8dca754b1 for v5.)
