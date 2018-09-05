Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12AE71F404
	for <e@80x24.org>; Wed,  5 Sep 2018 18:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbeIEWr3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 18:47:29 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34808 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbeIEWr3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 18:47:29 -0400
Received: by mail-ed1-f67.google.com with SMTP id u1-v6so6852862eds.1
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 11:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ydf9jp/o8mwXdtYPhDhrPHO6Tj/Pu8d6giRBo5FeWKI=;
        b=TK/MYZXj45lcfGvWIa0R0zSNmyBQ7AUxH/3oUCTj/3xtlkVHVdxIvzSw7lK1IW+yCV
         ZF32UehU4aRE0SdcbMiQXpS4/TJmX16IUjnTODQ5FA7Ng9FT3JjTVUmlWJD6tLUZhCTD
         s9gXRAKtaBuunJWPUSAALyeHuH4yVaJom+mKUkP7cyyRNDshYE1qkJWPhTSdpwERp/9Q
         nWWl3MzZWrYrcxpX+u4sFv1BQjI6ZNjkzEEiyqg7iFl3v6x9RlfklNKJhjaEMEhvYfOi
         HE+ZH4xxoaND/fTxSSUwuWK/7WwCJh+KUYO3+kTx3HVG6JEmLELujcamuHDU2Ka0iq6N
         84yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ydf9jp/o8mwXdtYPhDhrPHO6Tj/Pu8d6giRBo5FeWKI=;
        b=JpmPM+7JNpBkyD6vYGB9Q7mBGOdLOWQovfY0buwTziE/CaM8dSby9Wmxa5UtE1ATPt
         svWYtr0XOCqMUzoPgWjF2b6AapQqHWwizgMr9TWLR75YU4vHRkzAAgkR+0P8m22KooAS
         b6L9EO42ED9EUDIiMQPbzgNzY9TOsXET/zG2tRRDU/4oYYNLs209lDQ1DqOlEftjJO3f
         CONx+dh6axCsViEzIRGjWncYNPJjtHXK/jUP+LS1YI7jgXhtWtVNnyPKCFOU0UckC/Io
         8m06xwKX+oPTzREhGePrmRVlp8hvYmELZ7+yVRmHmtsBE+LYE4+pbX3S0qVu7Nf7N0e8
         BQVg==
X-Gm-Message-State: APzg51CmrwmwcWJiu/L3JKMYqZNy/mIj28s4wtLNBjaZqo42/zUlglEu
        jRIGJv4luTBUjkjybIgSoAa7ko+m3djQYLLHgO3PSw==
X-Google-Smtp-Source: ANB0VdaWyf6YPgdLrhZ+Vr2VZnTujfvvj7xgWcTRZm9AOtYDbnUEjprpSMhxSSeBvgIr6rdjNgXgKYknLvj5rA8BWRs=
X-Received: by 2002:a50:b603:: with SMTP id b3-v6mr43917634ede.181.1536171368499;
 Wed, 05 Sep 2018 11:16:08 -0700 (PDT)
MIME-Version: 1.0
References: <pull.34.git.gitgitgadget@gmail.com> <37ee24c82bf88611808ec3bb1c36eef439c809db.1536158789.git.gitgitgadget@gmail.com>
In-Reply-To: <37ee24c82bf88611808ec3bb1c36eef439c809db.1536158789.git.gitgitgadget@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 5 Sep 2018 11:15:57 -0700
Message-ID: <CAGZ79kY7_RJfJomkpob85A4ubvXJt3BR8njkaozLgi-6ytxB9w@mail.gmail.com>
Subject: Re: [PATCH 04/11] multi-pack-index: verify packname order
To:     gitgitgadget@gmail.com
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 5, 2018 at 7:46 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> The final check we make while loading a multi-pack-index is that
> the packfile names are in lexicographical order. Make this error
> be a die() instead.

What is the advantage of having a die() here?
Would the midx work under normal operation when
not sorted correctly?

This sounds like a hack for easy testability in this context,
so could you clarify why this helps the regular user?

Thanks,
Stefan
