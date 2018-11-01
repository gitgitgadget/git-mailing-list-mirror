Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31FD71F453
	for <e@80x24.org>; Thu,  1 Nov 2018 20:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbeKBFKo (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 01:10:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44235 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbeKBFKo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 01:10:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id d17-v6so20959352wre.11
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 13:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=mPbwiH8/CS+vDzmVi5aFwioYJF0C6LmlDG7iPTdEo6s=;
        b=gyMA2UeZQQUf6teu9k12vMrZLF9u2zmTUsrqKv2F2gNabrWAK+dIqn2MjWUCGZWnQL
         JCZuf52XTYl6GXIwiPUTsNwheh5YSRQn5rm/TwpV5hcUskiLeNBBF9GgGFFAzP7RRcex
         swVACW7wMrt1ynYlq7RG4mFG9szobqmfDhUfUxcRrHuyWMAYu25MCiGAAddIo9MtZ8T/
         pC/gV7hOYhRh5HmHHPO2Nq+kAlvQ2s279LW+UQREByXYUNbXmLHDbnT7gMZGj/HM4bsR
         NRiew19bePWGCBRfMjGfLHFbPDBwDyeVFSRaopSYgdMYuV2+eHLQ1zz6SE99F8d6Hcyu
         S08g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=mPbwiH8/CS+vDzmVi5aFwioYJF0C6LmlDG7iPTdEo6s=;
        b=ZqJPhUwki+hSD3AwsmAI7d1S9Va7OXkTOozoQf8cBRkaC/oC0Lm4LwK3qGDkcvb+5d
         HEdkiDPygeGZDn7KuuwQIpMisPl12f9OTBZAppqjcAvMzEUn5sctNChzO6G3so4qi2WQ
         SQ1dZqG9Or3375ZyEB1ZI8px2bh1J0JMo3nI8byMnNQXPpfOWwlkAE+eorBvtgBCu4nE
         kyP8qkqqDKJj+iG6TJ6gXa/hSsrJWfCTfrrLhWavddAF1DpDOe6Po60aFuMAxheQIVDb
         zwGbzGoE/ErVvlBA5KE3AIjeFsegbaR1XrnKjWnE8tOmT7vxgqtC1+gq7IQkN8pioOkw
         T/hA==
X-Gm-Message-State: AGRZ1gJ0V0t6tYu3/0Y20OHH7zHCY1xiXHHF7IFi38t7bfpMZo8X4wyX
        Lq/NBVdfHie8++keqolmu04=
X-Google-Smtp-Source: AJdET5f1eyBeDK0jfecHpllEk8mzoE3GRP1CVd6tStA2jBbtjSxZhHMjFD2WektRUzrsIF+0B0FP0A==
X-Received: by 2002:adf:e70d:: with SMTP id c13-v6mr7562626wrm.50.1541102775507;
        Thu, 01 Nov 2018 13:06:15 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (end24.neoplus.adsl.tpnet.pl. [83.21.249.24])
        by smtp.gmail.com with ESMTPSA id k5-v6sm12546635wre.82.2018.11.01.13.06.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 13:06:14 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [RFC] Generation Number v2
References: <6367e30a-1b3a-4fe9-611b-d931f51effef@gmail.com>
        <CAGZ79ka-FTqaXdrMixjUp2THJ3L0YvEnkKxs3XFgB3WEEy2-Tg@mail.gmail.com>
Date:   Thu, 01 Nov 2018 21:06:11 +0100
In-Reply-To: <CAGZ79ka-FTqaXdrMixjUp2THJ3L0YvEnkKxs3XFgB3WEEy2-Tg@mail.gmail.com>
        (Stefan Beller's message of "Mon, 29 Oct 2018 12:22:03 -0700")
Message-ID: <86tvl0zhos.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> Based on the performance results alone, we should remove minimum
>> generation numbers, (epoch, date) pairs, and FELINE index from
>> consideration. There are enough examples of these indexes performing
>> poorly.
>>
>> In contrast, maximum generation numbers and corrected commit
>> dates both performed quite well. They are frequently the top
>> two performing indexes, and rarely significantly different.
>>
>> The trade-off here now seems to be: which _property_ is more important,
>> locally-computable or backwards-compatible?
>>
>> * Maximum generation number is backwards-compatible but not
>>    locally-computable or immutable.
>
> These maximum generation numbers sound like the reverse of
> the generation numbers as they are currently implemented, i.e.
> we count all commits between the commit A and all heads.

Actually

  maximum generation number =3D
  number of commits  -  reverse generation number

> How would this impact creation of a commit?
>
> The current generation numbers can be lazily updated or not
> updated at all. In my understanding of the maximum generation
> numbers, a new commit would make these maximum generation
> numbers invalid (i.e. they have to be recomputed).
>
> Are there ways out by deferring the computation of maximum
> generation numbers while still being able to work with some
> commits that are un-accounted for?

As I understand it, new commits added since commit-graph file was
created would get simply INFINITY maximum/maximal generation numbers (if
we were using reverse generation numbers, new commits would get ZERO for
generation number).

> When recomputing these numbers, the current generation number
> (V0) has the property that already existing numbers can be re-used
> as-is. We only need to compute the numbers for new commits,
> and then insert this to the appropriate data structures (which is
> a separate problem, one could imagine a split generation
> numbers file like the split index)

Sidenote: I wonder if there is some on-disk data structure with
similarly fast read, but easier update.

> For the V2 maximum generation numbers, would we need to
> rewrite the numbers for all commits once we recompute them?
> Assuming that is true, it sounds like the benchmark doesn't
> cover the whole costs associated with V2, which is why the
> exceptional performance can be explained.

Let's check it using a simple example

First, (minimum) parent-based generation numbers before and after
extending the commit graph:

  1   2     3   4     5   6   7    new
  1   2     3   4     5   -   -    old
  .---.-----.---.-----.---*---*
       \
        \   3   4     5   6        new
         \  3   4     5   6        old
          \-.---.-----.---.
                 \
                  \   5            new
                   \  -            old
                    \-*


Next, maximum generation numbers.  We start with 9 commits, and we end
up with 12 commits after the change

  6   7     8   9     10  11  12   new
  4   5     7   8     9   -   -    old
  .---.-----.---.-----.---*---*
       \
        \   9   10    11  12       new
         \  6   7     8   9        old
          \-.---.-----.---.
                 \
                  \   12           new
                   \  -            old
                    \-*


As you can see all maximum generation numbers got rewritten.

Though if instead using the number of commits, we use the maximum
generation number, or in other words the length of the longest path, we
get the following:

  1   2     3   4     5   6   7    new
  1   2     4   5     6   -   -    old
  .---.-----.---.-----.---*---*
       \
        \   4   5     6   7        new
         \  3   4     5   6        old
          \-.---.-----.---.
                 \
                  \   7            new
                   \  -            old
                    \-*

A bit better, but still much change in numbers.

[...]
>>
>> * Corrected commit-date is locally-computable and immutable,
>>    but not backwards-compatible.
>
> How are these dates not backwards incompatible?
> We don't have to expose these dates to the user, but
> - just like generation numbers - could store them and use them
> but not tell the user about it.
>
> We would need to be really careful to not expose them at all
> as they look like the real dates, so that could make for an
> awkward bug report.
>
> The approach of "corrected commit date" sounds like we could
> have a very lazy approach, i.e. no extra data structures needed
> for many commits (as the corrected date equals the real date)
> and only need to store the corrections for some commits.
> Such an approach however would not make it easy to know
> if we operate on corrected dates, or if we even checked them
> for correctness before.
>
> So if we'd have an additional row in the generation numbers file
> telling the corrected date, then we should be able to be backwards
> compatible?

Here, from what I understand, being "backwards compatibile" means being
able to use commit-graph file using the new format by old client,
trating the data as if they were generation numbers and not data
offsets.

Best,
--
Jakub Nar=C4=99bski
