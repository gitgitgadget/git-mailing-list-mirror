Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A43D1F404
	for <e@80x24.org>; Tue,  3 Apr 2018 00:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754668AbeDCADq (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 20:03:46 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:52004 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754620AbeDCADp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 20:03:45 -0400
Received: by mail-wm0-f50.google.com with SMTP id v21so29325025wmc.1
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 17:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xYvHzsYQBB3oL4cBV/CNcttUIenB2TWtDROCDOh4zZQ=;
        b=BMfyfsWc6Qs/YV0XJ41aCLs1bexxwo+k6hu2Z3Bk3whbC7eqg2QZjsu3bxRy1fSckj
         8SgJgCoPRu6fX9RoE4idAMcTYYl4mPR+FwmKWpobncbRxQExSmHEmFeHA2G6osjdzVW5
         9deWmMKeSMT7ox7UvP+o6H6/IHH9LLV6csom+LzWjAVApk3r1Kwwpf68QmnlHAIjKknh
         zTsUaeClVF/WuboFBp5hShoJf7Kr3EgE/hplzKFF0/CeoeErAbOPzgi7nAUHAs5YF7td
         MmYzR0QXkCtG8zYXyb8Ab+ZJ4PTNPr7hhAuX1uiLs66ZGoMcseRjiIqKvcdb1g5BRDrs
         /MtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xYvHzsYQBB3oL4cBV/CNcttUIenB2TWtDROCDOh4zZQ=;
        b=VVGrCv41F3P+Vg2nFAfsKzMsELbIHw8uItB51Xp7STOtJFBwuAbiG+qgJxkQRpsV0W
         sZvRHTFnJFlt3tanpb6//gu8F4GvVsAHu5r5MOTdytGPKGxFxzhCeGEHYuJSRTJzsAr8
         fRmpaCuxG3Vdf2szt6ufWDUjN9a9j9h/9KRpUKwUORisRquyExZjGP5egElh4pJ1VYnD
         Aj1hcPDmxrs8vvG2y6jthJ3eF3afJ2rpTAWXpufa6R/CmigSHc/dSKq1lrLe8eXJNjcM
         l8Nh/raizPdM9NE8nkx3ATjb24sbFODI/gbMjEPvti8qqxwsqKeMFwu3Fo48Cc9D2LlS
         eGRw==
X-Gm-Message-State: AElRT7HzUqXHV7OAQ1jhsYeYqYdPQ3m6U9dHbMX8HaTFPfCXz3MhQpZW
        XN2MGNC1uHLq60ma0PrddxPJkWHyfD+9YNJrW1I=
X-Google-Smtp-Source: AIpwx4/N1wl3gcr1aTlS0ePesVTK0dNq2qlmLeKmUkBRgfG7GOBap58ZS5QXR62aWGPOV4QIY/OuOzzsNJQVtJmys+s=
X-Received: by 10.80.243.136 with SMTP id g8mr14025448edm.133.1522713824196;
 Mon, 02 Apr 2018 17:03:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.203.135 with HTTP; Mon, 2 Apr 2018 17:03:23 -0700 (PDT)
In-Reply-To: <20180402164742.11d4c5507d6ee737c9935d73@google.com>
References: <20180402224854.86922-1-sbeller@google.com> <20180402164742.11d4c5507d6ee737c9935d73@google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 2 Apr 2018 17:03:23 -0700
Message-ID: <CA+P7+xpDfKSvQZ+YktsSSBPTc3JXzc9dR36tohLctfDf04iaOg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Moved code detection: ignore space on uniform indentation
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Simon Ruderich <simon@ruderich.org>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 2, 2018 at 4:47 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> On Mon,  2 Apr 2018 15:48:47 -0700
> Stefan Beller <sbeller@google.com> wrote:
>
>> This is a re-attempt of [1], which allows the moved code detection to
>> ignore blanks in various modes.
>>
>> patches 1-5 are refactoring, patch 6 adds all existing white space options
>> of regular diff to the move detection. (I am unsure about this patch,
>> as I presume we want to keep the option space at a minimum if possible).
>
> My preference is to not do this until a need has been demonstrated, but
> this sounds like it could be useful one day. I'll review the patches
> from the viewpoint that we do want this feature.
>
>> The fun is in the last patch, which allows white space sensitive
>> languages to trust the move detection, too. Each block that is marked as
>> moved will have the same delta in {in-, de-}dentation.
>> I would think this mode might be a reasonable default eventually.
>
> This sounds like a good idea. "Trust" is probably too strong a word, but
> I can see this being useful even in non-whitespace-sensitive languages
> with nested blocks (like C).

The ability to detect moved code despite whitespace changes would be
good, even while showing diffs with the whitespace intact.

We may not need *all* the options available, but allowing the internal
settings to enable this but have the user-visible controls be limited
should be totally fine.

Thanks,
Jake
