Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 384D4207D2
	for <e@80x24.org>; Mon, 26 Jun 2017 16:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752198AbdFZQp7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Jun 2017 12:45:59 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:35376 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752171AbdFZQpy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2017 12:45:54 -0400
Received: by mail-wr0-f181.google.com with SMTP id k67so146894823wrc.2
        for <git@vger.kernel.org>; Mon, 26 Jun 2017 09:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fOgrYoXhJtwMV/txLfyoC3/5BRKd3Ztx9+zFOjC6Oqk=;
        b=kc8sxKwGlx51wCQCpkRAOO7ipm1ItdRxGLmusrvq5mKQDgylZ23iJH2Mrk9msnIWVp
         SlpgPa938G5/krxeR9hEGDc2ZsK+0RaAjnQSo/FfCl+AdE2JDNX2H2D5IaxuywrG+d2/
         5ZdkyvY7QgSzWjASCcEFsV1FY0PNlMJ2J4Uh3Y491adhtM268FNtGSzPScaft/f7Qq9D
         ZGsNWI3mbojwvhF18N9kVJeTjqAEOP2ahEfBRLKp96GHjr8/T7kuZ4QnQq99Cd1N8MLB
         VkNIF9uQjcl9nTVKYpL5onwck8lD8H/uWScQ93lMFsVtzLqVCnzzyVvvEQS6NoC8bDIk
         M+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fOgrYoXhJtwMV/txLfyoC3/5BRKd3Ztx9+zFOjC6Oqk=;
        b=Dfq4Gom+wIt+6ohfgoGbGf6+u0ts8f3/j5hj5OynyjYU3MwBFuRVpCu73/zTPOcX5h
         TO0KIeTGOqsE9HDKDFwSi+VLZ+kEl3Nt2PsqHinn0/PNMOlMPrMnoN2nVWzQQOXKv9JW
         VW5PWCThLKoIt/Vx8BDIZ0jOi2eneXJIOyhy9/orPAjN4HtM1Qew9CPbdl6shN35msIX
         8NXhPR3931LnrkR8afmEu++rx38FuMaBglRtYWezGqGKi+XCskgaUDiMeyTCNokymLRl
         x4aXlOLT2ua/OETOACuISAIqDl1Sl9PSxN3SFX0DcNbgaFUA/KFCBa7xFRniG2+aLL6s
         3izw==
X-Gm-Message-State: AKS2vOwDPqh2v03yihKF+e1XaDiAWhaEmUXP53GrTRKkwfQIzOkqO8lb
        /089p85SHojksGLR103zTA3BAdGbfZ1a8b8=
X-Received: by 10.223.171.3 with SMTP id q3mr13720350wrc.12.1498495553183;
 Mon, 26 Jun 2017 09:45:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.133.200 with HTTP; Mon, 26 Jun 2017 09:45:52 -0700 (PDT)
In-Reply-To: <20170624124522.p2dnwdah75e4ngya@sigill.intra.peff.net>
References: <cover.1497035376.git.jonathantanmy@google.com>
 <cover.1497920092.git.jonathantanmy@google.com> <ad3b02bae9db62400f89f387f0a1bb714e0a432d.1497920092.git.jonathantanmy@google.com>
 <20170624124522.p2dnwdah75e4ngya@sigill.intra.peff.net>
From:   Jonathan Tan <jonathantanmy@google.com>
Date:   Mon, 26 Jun 2017 09:45:52 -0700
Message-ID: <CAGf8dgJ8C0chOxZo5CPt56225XGBgrjaGy8HDAST+0-USfW6mA@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] sha1_file: improve sha1_object_info_extended
To:     Jeff King <peff@peff.net>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 24, 2017 at 5:45 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Jun 19, 2017 at 06:03:13PM -0700, Jonathan Tan wrote:
>
>> Subject: [PATCH v4 6/8] sha1_file: improve sha1_object_info_extended
>> Improve sha1_object_info_extended() by supporting additional flags. This
>> allows has_sha1_file_with_flags() to be modified to use
>> sha1_object_info_extended() in a subsequent patch.
>
> A minor nit, but try to avoid vague words like "improve" in your subject
> lines. Something like:
>
>   sha1_file: teach sha1_object_info_extended more flags
>
> That's not too specific either, but I think in --oneline output it gives
> you a much better clue about what part of the function it touches.
>
>> ---
>>  cache.h     |  4 ++++
>>  sha1_file.c | 43 ++++++++++++++++++++++++-------------------
>>  2 files changed, 28 insertions(+), 19 deletions(-)
>
> The patch itself looks good.

Thanks. I did try, but all my attempts exceeded 50 characters. Maybe
"sha1_file: support more flags in object info query" is good enough.
