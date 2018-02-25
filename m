Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5913F1F404
	for <e@80x24.org>; Sun, 25 Feb 2018 03:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751516AbeBYDaB (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Feb 2018 22:30:01 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:35858 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751500AbeBYDaA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Feb 2018 22:30:00 -0500
Received: by mail-ot0-f193.google.com with SMTP id 108so4733400otv.3
        for <git@vger.kernel.org>; Sat, 24 Feb 2018 19:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=WQQKT3B0TPwQ9XioHlA1QU9q5VMUZOvUNMNEkVsuMiw=;
        b=i5ykCdk6Dy8d8gzfJIa1tL+/tj6eM1tzby5+pM15EG1mIbF/lxc6EV1FpAxxa56DBt
         xawMlXDCti1VrReEKQCEKQn1nBXP4Gs+hvs407Vd0to3+YS8vS53BxEYzvqnVL/ev57s
         WDFaY7zCXP2qZuw84YqYeCRsayT8K/JrovY8olk24uNdBsqr/EsmacQiKtymKFYKjA3M
         U6v7FMVkG8MyurNvEX0zk81vUtRfrV5essHT7R06ypYQ8XdM7SWmEmahe63vLaQj2Zb9
         dUg4By9AlrVs9j0ry4pvricHuOgh5wsxgz0hPqPNau8vNn4rfc95DIy6vw6v6jySrUAt
         hJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=WQQKT3B0TPwQ9XioHlA1QU9q5VMUZOvUNMNEkVsuMiw=;
        b=UK1GufKdjZttbZpSossBw6fuYb5XRd8d6XaI22VFSKp6VFNHvkKtq8kNuvPPlHavwp
         2jeWbwrqjv/Rm/aJ06WnUSMZg24fuHH9L9Y7/790+2k+RL1IBVRMHsek8113snRBfZEl
         aNEX4VN7TlysGyFpT316jICxivD+IgYv7d3Uf+fVRQGWiqcsGgC82VFaOQ9+rJ3rVxfM
         U/qKbqOZlvN9LvWO0yBNsTIb4pLNqQJEK52zkW9W5+ohvhPpkBZTSUIJEdjG4c0QEwo0
         01oK7YE2Ks5klCDGRNI6fKyTyqBTdqCUVKTrlvKyvL3xhxHRuuyAED2OtKbKRgNXMX3G
         C5lA==
X-Gm-Message-State: APf1xPAR1Q6/yatqdx8Dvmo9GYIVkY8u0U46ASdTyQJ/h4Q8erPqMDCd
        nRvD6NfnJJjEUN8lW5OvgJfRtqrAzG0d9suFWJ0=
X-Google-Smtp-Source: AG47ELsrHdI1iVXoQwUI7Oi/KOFu1PgERca2fgPZe+Pl8JYsiluJFWRKi6UmMqdqO3XGbCBgLU/BPqzvl4gqtoUU7es=
X-Received: by 10.157.67.42 with SMTP id s39mr4983070ote.14.1519529399516;
 Sat, 24 Feb 2018 19:29:59 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Sat, 24 Feb 2018 19:29:29 -0800 (PST)
In-Reply-To: <20180224225839.GD4620@genre.crustytoothpaste.net>
References: <20180223095640.25876-1-pclouds@gmail.com> <20180224033429.9656-1-pclouds@gmail.com>
 <20180224033429.9656-6-pclouds@gmail.com> <20180224225839.GD4620@genre.crustytoothpaste.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 25 Feb 2018 10:29:29 +0700
Message-ID: <CACsJy8BP0ro6raD-s4uYOqMg1BhSEtNdn-HCpHYDz_NHXgkRbA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] Revert "repository: pre-initialize hash algo pointer"
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Git Mailing List <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 25, 2018 at 5:58 AM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>> diff --git a/repository.c b/repository.c
>> index 4ffbe9bc94..0d715f4fdb 100644
>> --- a/repository.c
>> +++ b/repository.c
>> @@ -5,7 +5,7 @@
>>
>>  /* The main repository */
>>  static struct repository the_repo = {
>> -     NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, &the_index, &hash_algos[GIT_HASH_SHA1], 0, 0
>> +     NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, &the_index, NULL, 0, 0
>
> I'm wondering, now that you have the name field for the unknown value,
> if that might be a better choice here than NULL.  I don't have a strong
> preference either way, so whatever you decide here is fine.

I did try that first, but for the purpose of catching uninitialized
algo use, NULL is better.

When I set unknown hash algo here, I think some test failed
mysteriously because it used rawsz field (which has value zero), it
didn't match some expectation, the code went to the error handling
path, which eventually failed with some error message, but it's not
obvious that the problem was rawsz being zero and back tracking that
took me some time.

With NULL hash_algo, any dereferencing fails immediately with a nice
stack trace. Another reason to push me towards NULL hash algo is, even
if we prefer nice messages over segmentation faults, we can't avoid it
completely anyway (empty_tree and empty_blob are still NULL in unknown
hash algo and will cause segfaults). Might as well make things
consistent and always segfault.
-- 
Duy
