Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DDDC433F5
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 14:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235356AbiBIO53 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 09:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbiBIO51 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 09:57:27 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67895C0613CA
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 06:57:30 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id x52-20020a05683040b400b0059ea92202daso1673084ott.7
        for <git@vger.kernel.org>; Wed, 09 Feb 2022 06:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=EHIxvG6xAKeUp5jPvVwJw7QoqmQ/+7BWREVX39om2QM=;
        b=f+G9P3bWXjeYXr9DJsRHWOYDdiKzZa3qYP+KGvuen9zeD3ehD2F1DW/cHKG+7oynmB
         xiSkfdHWHly9wjcPsOy1vpNldeM4/qQZjyZ528Fx+Jgul4H28ddYaUJm5w6CoZ+spcbd
         ISNB9Lzk4dpOdlzCyZYKoNHF7O8uvGtgbkoVN436iwxVAFVhnf17gx5atIvgQ4CTFF2X
         O52XZ32WZcc2g9aQJ6iKT5J+iQT2Jyns+qRgvFe0yLm9z+9jCvVr5UfI92IDM3iKstUt
         +4YFqqMSMa3f3WDo4DDE+WZzGh3y+dCGS8tbIymMkTDPW4KDAGk7lDJvv879njUrFOdq
         Fa9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EHIxvG6xAKeUp5jPvVwJw7QoqmQ/+7BWREVX39om2QM=;
        b=bjcR251NE2bBd88CBL8i6kEHrcZAQ9oO1o51Fl+2qJVidbqLESm36iEVSCe+qUuLRc
         ep2e5eNZSz5mHlPMx9PgDfw7dEKLJKcxmvZ51eqXk/4h5osiyNiPfPp95eQ7EX2x8ziQ
         mc7UsgyvbiZpp4b2M0vKWm4GcbojK4p9/zN1G3lOSMj+jGbgnbFdz/J35EoRMR3XHdO6
         7zWSWWPqUsEh2r/18Cyj7tMzL+0CkZlDrv+zXpYzpLPR+Jyyo50Oir372BTnqoABhnBz
         5E6z8YYK74y9HQnp6UgfcxL3pXy43GNf7siTGmLGTOvkolnCe1CE59nN0nYfNDKUkmlm
         hdtw==
X-Gm-Message-State: AOAM530niXXtOykwMn9GoF4AHudjEuKEcQ75paCxiga4SGqnNsxbEGiV
        7CrYNPfnBSoUIp3fzkHsiGI=
X-Google-Smtp-Source: ABdhPJzLDnsfXj0RJ2yEwPwAce0pyFVSpE/lucSIgLr8WqV0dx0gdcVQSTfqiHkUhO3cR3FFkvR06Q==
X-Received: by 2002:a05:6830:2709:: with SMTP id j9mr1044791otu.3.1644418649667;
        Wed, 09 Feb 2022 06:57:29 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:2177:fee8:1597:ac9f? ([2600:1700:e72:80a0:2177:fee8:1597:ac9f])
        by smtp.gmail.com with ESMTPSA id b9sm3861874ooo.16.2022.02.09.06.57.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 06:57:28 -0800 (PST)
Message-ID: <fe2346f0-f65a-6c09-e2dc-f8c4e163a2b4@gmail.com>
Date:   Wed, 9 Feb 2022 09:57:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: Opinions on merging questions (Was: What's cooking in git.git
 (Feb 2022, #01; Thu, 3))
Content-Language: en-US
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?Jean-No=c3=abl_AVILA?= <jn.avila@free.fr>
References: <xmqqr18jnr2t.fsf@gitster.g>
 <20220204081336.3194538-1-newren@gmail.com>
 <CAPig+cRrRxuTeByhKkLs_KDaWY8-r4+jrwT83A-r+sBQsmebMw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CAPig+cRrRxuTeByhKkLs_KDaWY8-r4+jrwT83A-r+sBQsmebMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/6/2022 6:41 AM, Eric Sunshine wrote:
> On Fri, Feb 4, 2022 at 7:06 AM Elijah Newren <newren@gmail.com> wrote:
>> On Fri, Feb 3, 2022 at 21:22 PM Junio C Hamano <gitster@pobox.com> wrote:
>>> * ds/sparse-checkout-requires-per-worktree-config (2022-01-31) 5 commits
>>>  - worktree: copy sparse-checkout patterns and config on add
>>>  - sparse-checkout: set worktree-config correctly
>>>  - config: add repo_config_set_worktree_gently()
>>>  - worktree: create init_worktree_config()
>>>  - Documentation: add extensions.worktreeConfig details
>>>
>>>  What's the doneness of this one?
>>>  source: <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com>
>>
>> I think it's done and ready for next.
>>
>> Eric and I weighed in quite a bit on this series, and it changed
>> direction pretty dramatically, and more than once.  But we eventually
>> all came to an agreement about what should be done (the hard part),
>> and this round implements it.  Stolee has diligently fixed or answered
>> each item I've raised and I'm very happy with this version.
> 
> This version is much improved over earlier versions, and I think
> everyone is in agreement now that the series is "doing the right
> thing". However...
> 
> I just finished reviewing this round and left a bunch of comments.
> Some of the comments are minor and wouldn't warrant a reroll, but I
> also identified some memory leaks and fragile code, as well as
> non-obvious test code which could be improved. The commit message of
> [4/5] feels too weak for future readers by not fully explaining the
> problem(s) that the patch is addressing, so I suggested a possible
> rewrite of the message. All of these issues could be fixed by
> follow-on patches (with the exception of the weak commit message),
> however, taken together it feels like one more reroll is warranted.

(I finally got these emails delivered to GMail today...)

I sent v6 since this message.

There are some further comments by Junio and Jean-Noël that will
require another re-roll. There is time for more review before then,
so I will wait until next week to see if more comments come in.

Thanks,
-Stolee
