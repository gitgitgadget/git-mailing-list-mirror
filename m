Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D3AB200B9
	for <e@80x24.org>; Thu,  3 May 2018 17:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751174AbeECRYJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 13:24:09 -0400
Received: from mail-yb0-f179.google.com ([209.85.213.179]:36065 "EHLO
        mail-yb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750947AbeECRYI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 13:24:08 -0400
Received: by mail-yb0-f179.google.com with SMTP id o14-v6so6775856ybq.3
        for <git@vger.kernel.org>; Thu, 03 May 2018 10:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kzRXjul48b1hGJwkfchGq1DTRP1i4fU5EGGSw0EmYX4=;
        b=HlORIdzosoSnh27kBASLFkil9t7DO5zCKABtQJEWUvMdwHV7ymwbk6vRDzNGRY8dcc
         6klP+ExGkG83dT9UBiEfYCysd5dgskNlFDR09uevzQNwSk7pSrFVS6zh2DpuFF5k228W
         +tLmvyEHFhXnFFz7udHxuElpFC7zyezS3z8McU5UqxQQ7x/N74CT/F+4e4jpqykSRV2M
         /REiHDQ8vmvjQxokvXFMhkeZnmYjZS7yZ17sAl1LmyieoAKAW0e2gGrPnaisCNsyaKwn
         hMq5CbcHgARDnaRGRrepTbbI7fJ40jGDSfq5NJw//cssxQFw4ZIkAh1YzcMmNB4yaqI0
         AtfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kzRXjul48b1hGJwkfchGq1DTRP1i4fU5EGGSw0EmYX4=;
        b=ro46gpLxF00eeEsUE/bLnuA2K1quFEby/zMJSuQnxMzrALD3a+yVxRrj+KoGXp+4Ul
         IHd9eTNPVskarM0ank1L6nvJUsKIz/U9Y3QOTMOGfU8KQyMVf98p0hpT5TplrlHsATVs
         30iEXBSelbduxn63bMKjltorQVsfGHg59zdxsAb8Y8gePqVeGsYbuUGr0R992h8xGmG7
         dIWsh+rttFy2+dKmXwfyMf3RcufkLLpeU/Fj3nvsM7qhnTe6eiNctSq/B/wOkVPsrZF+
         F8ZdvmwIgBqdQDNz+0D8HSjDp4+lKxm10s9I7GVvW9y2DEgWcuYPOJVVQLh28T6c58Jy
         a5dA==
X-Gm-Message-State: ALQs6tD9Cf4RaC8UvqyqE+uvOubi9vRWf0LA/A0WmgQCTxDvgKGhSste
        H/zjo2M15/PSEwu9VkiqKw86hg+HpaaT7RZLqRfSihlL
X-Google-Smtp-Source: AB8JxZpon6mRwJL0D1t9ARpLIfzwC79WSkUDwp+m6b8A5yEeBXrSDkPo1o2enkJYzytlW3ArcjI8YJVdvQk6IyIcW5o=
X-Received: by 2002:a5b:14f:: with SMTP id c15-v6mr15514986ybp.292.1525368247667;
 Thu, 03 May 2018 10:24:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Thu, 3 May 2018 10:24:07 -0700 (PDT)
In-Reply-To: <CACsJy8B=i_0EKGRLxS5N5tfz8666hm_aTns949eb9DAW1--XWg@mail.gmail.com>
References: <20180501213403.14643-1-sbeller@google.com> <20180501213403.14643-14-sbeller@google.com>
 <CACsJy8B=i_0EKGRLxS5N5tfz8666hm_aTns949eb9DAW1--XWg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 3 May 2018 10:24:07 -0700
Message-ID: <CAGZ79kaNNFYyTAH_Kq=bO_Q9tLGMgnnxQKpDZSftuh7deDoFxA@mail.gmail.com>
Subject: Re: [PATCH 13/13] alloc: allow arbitrary repositories for alloc functions
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jameson Miller <jamill@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 2, 2018 at 10:44 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, May 1, 2018 at 11:34 PM, Stefan Beller <sbeller@google.com> wrote:
>>  #include "cache.h"
>>  #include "object.h"
>> @@ -30,8 +31,25 @@ struct alloc_state {
>>         int count; /* total number of nodes allocated */
>>         int nr;    /* number of nodes left in current allocation */
>>         void *p;   /* first free node in current allocation */
>> +
>> +       /* bookkeeping of allocations */
>> +       void **slabs;
>
> Another way to manage this is linked list: you could reserve one
> "object" in each slab to store the "next" (or "prev") pointer to
> another slab, then you can just walk through all slabs and free. It's
> a bit cheaper than reallocating slabs[], but I guess we reallocate so
> few times that readability matters more (whichever way is chosen).

This is a good idea. I'll do so in a resend.

>> +void clear_alloc_state(struct alloc_state *s)
>> +{
>> +       while (s->slab_nr > 0) {
>> +               s->slab_nr--;
>> +               free(s->slabs[s->slab_nr]);
>
> I think you're leaking memory here. Commit and tree objects may have
> more allocations in them (especially trees, but I think we have
> commit_list in struct commit too). Those need to be freed as well.

I would think that tree and commit memory will be free'd in the
parsed_objects release function? (TODO: I need to add it over there)

Thanks,
Stefan
