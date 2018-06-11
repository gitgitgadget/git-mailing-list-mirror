Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 106091F403
	for <e@80x24.org>; Mon, 11 Jun 2018 16:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752816AbeFKQL0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 12:11:26 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:33546 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752801AbeFKQLZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 12:11:25 -0400
Received: by mail-vk0-f65.google.com with SMTP id 200-v6so12631517vkc.0
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 09:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vwzaOXMxq3kBvKF7oFOlpfEDWn3Vp0/Xs+OmrS706Vw=;
        b=SWrphmn0Qejj1Zine4qiPe26A7hzCp9jVJzcMOdz+v+xlUTfGO8MUy9Vg4zb5X1Jvq
         Eqz1gEb8/vcEGTDdKvvR1bqkSPZGEgaR3kcfT8otRdaHbo9qLX9VrE2szYZcENTc1NGk
         4cDps4uINd3o4abmvwAvmt0V933ApDL/y9rHP6N5XYFLNT0YdkLkDUd8QTHM80Rbfh5A
         xA0nnXOHeqNZ9q15ZNpIClMbyQDmm7qHFv6gmgjIzpU5jDZmykXBAHbbZcvFZvmGbJ6h
         G28K/rYXz4+jXx8PzkzTGxZLNTwjDR7xeIxpA92yWDjTYSGmxj2kEgGHcr0a1AVADpYs
         9HTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vwzaOXMxq3kBvKF7oFOlpfEDWn3Vp0/Xs+OmrS706Vw=;
        b=A6Th2fH98/JHS96El1z6iofj5iyJFGSDP/0P2pbmEmfEMFmXQv56I1RiDiDCC5GYOb
         xshHzJkiBTdn4GDQwvcFedxJ9SwmSqHQ6+G+0S1fZbiIKDPJ8Lr9Ncg1nJlXA8zBd1fn
         fqY3nJ/kvsmhg3RBlJyMQSw2Y7fYDTeU6YeFOaHxqwV8MrGcLogNlAINX/Dw9Qeewpyf
         8yJAHyHm+Vyj6zZS4ZKXUhEARUesUPkqOeLQg6mBdrCnFT9R5r1hwjBioKMwvwaIc4Yi
         vdyXwVDGm7Uf6v8pBkOVB02zWc+3ghn+bTQK9gtmxjMygY81n5y/lh26Y1fSIJIzFoZp
         kmew==
X-Gm-Message-State: APt69E3jmB5t4w0MrhzzSKfOZcyifrDXUH+KHwGpYq6gJathON0PrjaV
        4bK3YHpzMoQot/QrynL+0qJfMJUv/+Qk+czKq9Q=
X-Google-Smtp-Source: ADUXVKKqKTlgPXgTnu8Qn+dESoKx4FF47YdvbnQpAQ27n5IUTkeQBJO3o9LzVvZHa3qXxUPvZMIuSRS8bl9LegQjOsA=
X-Received: by 2002:a1f:a102:: with SMTP id k2-v6mr10846624vke.118.1528733485025;
 Mon, 11 Jun 2018 09:11:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5f28:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 09:11:24
 -0700 (PDT)
In-Reply-To: <CACsJy8Ba74iSPf4_zFxuV=_uNJgL6Z2QunOvAvi3qab-6EWi5g@mail.gmail.com>
References: <20180606073933.14755-1-pclouds@gmail.com> <20180606165016.3285-1-pclouds@gmail.com>
 <CABPp-BEngspJMEpwoiTq7SCdsQt7fOT_uePS3c6nRxTVqOnNeQ@mail.gmail.com>
 <CABPp-BGa+v2x1oeitVDMkQf3qFWx6kUT4wdWhCxjWwPyaW=3bg@mail.gmail.com> <CACsJy8Ba74iSPf4_zFxuV=_uNJgL6Z2QunOvAvi3qab-6EWi5g@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 11 Jun 2018 09:11:24 -0700
Message-ID: <CABPp-BHYm57n=ufg_SqmA-UnOEMivWJZytnPPSU3WSYNeEph0g@mail.gmail.com>
Subject: Re: [PATCH v4 00/23] Fix incorrect use of the_index
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy,

On Mon, Jun 11, 2018 at 9:05 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sat, Jun 9, 2018 at 9:58 PM Elijah Newren <newren@gmail.com> wrote:
>> I read over the rest.  Found a small grammatical error in a commit
>> message.  Found multiple places that still need conversion, from
>> pushing up &the_index usages to callers of ll-merge.c and sha1-file.c
>> instead of having them in those files, to mixes of _cache_ and _index_
>> functions as in apply.c and merge-recursive.c.  However, Duy pointed
>> out there was more work to do,
>
> Yes. This is just fyi, 40 patches later, i'm down to leaving the_index
> in three files outside builtin/: merge-recursive, notes-merge.c and
> transport.c. Even after the conversion we may need some more follow-up
> patches because it now shows places where we should _not_ touch the
> index at all, which may involve not simply passing NULL index_state to
> some functions, but fixing them up to tolerate NULL index_state. So
> it's going to be a few patch series until the_index is gone for good
> [1].
>
> [1] but like cheap horror movies, there's always a sequel:
> the_repository is still spread in many places and hides dependencies
> in the same way. We can't do anything about it though until struct
> repository conversion is more or less complete.

I was just about to send you an email to ask if you were continuing on
with the series.  I need diff-lib.c converted in order to make the
changes Junio suggested to index_has_changes at
https://public-inbox.org/git/xmqqvaaz5jcv.fsf@gitster-ct.c.googlers.com/.
Since you're already working on that, I won't duplicate your effort.
Thanks for tackling all of this.  :-)
