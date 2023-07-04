Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC16EB64DA
	for <git@archiver.kernel.org>; Tue,  4 Jul 2023 09:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjGDJhI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jul 2023 05:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbjGDJgr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jul 2023 05:36:47 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73881998
        for <git@vger.kernel.org>; Tue,  4 Jul 2023 02:34:37 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fb863edcb6so8735761e87.0
        for <git@vger.kernel.org>; Tue, 04 Jul 2023 02:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688463255; x=1691055255;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E9e6YatVHwk6JIj1pVongrzhZtlyd8ZyeN2ktv9eju0=;
        b=LldobfCabypOhuDNeD6DAD6h6tYxgpNMGqTEA7gHMNjikOYbJogRniqtPoCtR9fvcr
         ZNYxiKWAsEQiWlBgWHcU37K7Nf2RHVzh8fctHxgtVGp7VgV20eay0Xnrt+qPildtV3wl
         Pem/j9H/5WL/DwKzu7IMrLY/GfWko/xWUroXhBFARdplTijvx/CEfj2n+G88vifrri3y
         oUDFuju2Xu2SqfwMCQmPzjvukuFDf2jwi7hmtMczR/r6k12ADSthzuAFAhNzNgju2JfA
         eI85eEXZLvYGXnJESmqxXXt7k1bttKXN03tygtgyB1NA11PK3OTZ+S0D8n/VJjXQSQK7
         j94A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688463255; x=1691055255;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E9e6YatVHwk6JIj1pVongrzhZtlyd8ZyeN2ktv9eju0=;
        b=JU32VIBqfATnKjeboM2bZCiWb2MENKMcXT5XpfU8dZyNJE4nuHCxF1vMmDxDXAfMxP
         PfnKv2jNna/1GTgdjg5z563PUoV9IMBgguGK8X3eyNYYFdmgSwkX7Ia9SqZ7yQHIWzz4
         eswZ4BqbIw0+xwRUd8g/PQB17uXLqmiJvxi7Opy+jp4EWKvgZ0T7HX1HyY531GqcrvvF
         JsJaj9vw6ks8SBAn1qolYPRhEsNxgy6GQos2Y/s+kqv+OCTQwS/v3eQpZ+h7Jq+g8HeB
         Hk++WHajpI7fNI7BCMwVlNshZHcfR2rcSyN2/HP/djunJx17LhG7wbqVzMndfUk0c3uw
         OMmQ==
X-Gm-Message-State: ABy/qLaYH960yG+0xKNdZblJ+mI7wrFWUMg3XD1t/frdC4qlCUywFX0F
        Q83HrOU2zz76pjHn3T9XknqaW5y0ZnqBfckcbVDvkHAWQOM=
X-Google-Smtp-Source: APBJJlGBAhuK54y2Qkz6p32swdwL9J6b8bxMhAWRdSJP+gO++kzh4ufCTqRNjCvjiGkm74DqjKO350LZCltfISpFHZk=
X-Received: by 2002:a19:8c4d:0:b0:4fb:7c40:9f95 with SMTP id
 i13-20020a198c4d000000b004fb7c409f95mr8368549lfj.47.1688463254450; Tue, 04
 Jul 2023 02:34:14 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq5y747l16.fsf@gitster.g>
In-Reply-To: <xmqq5y747l16.fsf@gitster.g>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 4 Jul 2023 11:34:02 +0200
Message-ID: <CAP8UFD1CfUm+9PTXO0wBBdBs0U=YVte+EiPbDyUyg7T152aw2g@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jun 2023, #08; Fri, 30)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> * ks/ref-filter-signature (2023-06-06) 2 commits
>  - ref-filter: add new "signature" atom
>  - t/lib-gpg: introduce new prereq GPG2
>
>  The "git for-each-ref" family of commands learned placeholders
>  related to GPG signature verification.
>
>  Needs review.
>  source: <20230604185815.15761-1-five231003@gmail.com>

I took another look at the v3 at:

https://lore.kernel.org/git/20230604185815.15761-1-five231003@gmail.com/

which properly addresses the comments made by Eric and Oswald on the
v2 and looks great to me.

The v1 and v2 were not the first times it was commented on as this
comes from the work of Nsengiyumva Wilberforce, Jaydeep Das and Hariom
Verma before Kousik took over.

Nsengiyumva Wilberforce in particular had sent 5 versions of it
previously to the mailing list:

https://lore.kernel.org/git/20230311210607.64927-2-nsengiyumvawilberforce@gmail.com/
