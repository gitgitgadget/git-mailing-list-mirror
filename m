Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F22E51F404
	for <e@80x24.org>; Wed, 11 Apr 2018 20:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756538AbeDKUBT (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 16:01:19 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:42416 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933873AbeDKS4W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 14:56:22 -0400
Received: by mail-qt0-f176.google.com with SMTP id j3so3149159qtn.9
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 11:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=kicJFQk1mJrD2u6rKGkyj3hYeaDbIVnA6iT57OXmeYc=;
        b=DXfI27qYhqoCSrZ8tZq6UqrbGRVAjSkZjnV0PHo5hJH2IJ5o6AUVXPW85FB71Wjf/f
         Lz1+cxN0SE3V4PM2eVz+zEq+8aXfbmP3tSSyXPzNoW/kTaQDVfkP80s4FudG9wZlWVRA
         gHjE7obUpTTkBgZWIdXitKI65M3qAGq2zLwisB7oebMZ5+bRZeYqfV7ibC96YQTAwcuc
         6W+QtuyNOmE5KOWPEJF2vzbbj/h+eCM5yyiO0peL4Xzxdqq0w2fA3ONWIrV45V0rv0Nq
         4VuIfZkJFJI+nrfpc1IRXLT0YHURWY7jy1J9Dw6v9awz5eVxNJ8Nd5tN8BUEg5ILBPAC
         UxIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=kicJFQk1mJrD2u6rKGkyj3hYeaDbIVnA6iT57OXmeYc=;
        b=qFxEjxJ0TH8ah+lUPJkPAMLfyTFivV6VrHip85+wuX6YGp4ghoAhE/cQQL6uZGwsXs
         974MgG9xMgXVqL37Uieeovt6RqOdHnYD2JXVLJNsJ++VAAMvAipJojE/uJ45nWeHXzYu
         88yxXTA2tMe4LM2eSgGjQQhRFHqIeGbcGIJfuGg58a+VCwKEQHU6HH0WyD48Tk3Z5XnS
         KTJvU84VXX+RR7VzTFAFzXOuYPATOOgU6kR4yNWzZdM4vvcssJWPdM+Hgdu65slsq9oM
         umnWvZjplmfQAoXeNzmskPC8Ca56HkptcEjuZ+WAppmmjtrA1akN9AfSiiZJI6puYbhp
         7DkQ==
X-Gm-Message-State: ALQs6tDj1U/AVKig1GNZQWGCDy+/Hx2Mxr1sZhDjrU3FaMXeQXUWlFXG
        amwfX9xWzG0RKYhN6nby7ZekQQM/yL7vuyqFwmSRTA==
X-Google-Smtp-Source: AIpwx4+mI00MdZvu6J02Xy0+9x1DGte0b1YIZshZQdphT4EqBu2ALpkSmhKKb9MdhpX+BQrwhRI6FGq+9XpQI1nkB4A=
X-Received: by 10.237.33.231 with SMTP id m36mr2898221qtc.154.1523472981973;
 Wed, 11 Apr 2018 11:56:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Wed, 11 Apr 2018 11:56:21 -0700 (PDT)
In-Reply-To: <CAGZ79kYeM=CqKSWTL2tdDXWueMGoki4zAUmFy4wbhtagN7gEAA@mail.gmail.com>
References: <20180402005248.52418-1-haraldnordgren@gmail.com>
 <20180409014226.2647-1-haraldnordgren@gmail.com> <20180409014226.2647-2-haraldnordgren@gmail.com>
 <CAHwyqnURebvfW4rGz9RAbe7B9p6ZDy0jUueDFrYE30dmjCtMVA@mail.gmail.com> <CAGZ79kYeM=CqKSWTL2tdDXWueMGoki4zAUmFy4wbhtagN7gEAA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 11 Apr 2018 14:56:21 -0400
X-Google-Sender-Auth: FF17pDd7OXdq6K3AFrSy2BoRCjw
Message-ID: <CAPig+cQzWAbEVBJ8O0yKYHQ02EaGTx9CeUyF67xozeT2-FL0EA@mail.gmail.com>
Subject: Re: [PATCH v14 2/4] ref-filter: make ref_array_item allocation more consistent
To:     Stefan Beller <sbeller@google.com>
Cc:     Harald Nordgren <haraldnordgren@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 11, 2018 at 2:07 PM, Stefan Beller <sbeller@google.com> wrote:
> On Wed, Apr 11, 2018 at 10:57 AM, Harald Nordgren
> <haraldnordgren@gmail.com> wrote:
>> There have been no new comments for the last few days. I know Jeff
>> King will be away for the next two weeks, but should we still move
>> forward with this? The initial reactions to the idea seemed positive.
>
> Please see the "What's cooking?" email on the mailing list that is
> sent out periodically by Junio.
>
>> * jk/ref-array-push (2018-04-09) 3 commits
>> - ref-filter: factor ref_array pushing into its own function
>> - ref-filter: make ref_array_item allocation more consistent
>> - ref-filter: use "struct object_id" consistently
>> (this branch is used by hn/sort-ls-remote.)
>>
>> API clean-up aournd ref-filter code.
>>
>> Will merge to 'next'.
>
> It will be merged to next and if no people speak up (due to bugs
> observed or such)

I would guess, however, that Harald is wondering more specifically
about the "--sort" patch he added atop Peff's patches. Disposition for
_that_ patch is not specified in the latest "What's cooking":

    * hn/sort-ls-remote (2018-04-09) 1 commit
     - ls-remote: create '--sort' option
     (this branch uses jk/ref-array-push.)

     "git ls-remote" learned an option to allow sorting its output based
     on the refnames being shown.
