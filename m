Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D72D1F404
	for <e@80x24.org>; Sat,  3 Mar 2018 01:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965089AbeCCBwG (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 20:52:06 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:37369 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965064AbeCCBwF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 20:52:05 -0500
Received: by mail-ot0-f194.google.com with SMTP id t2so10433694otj.4
        for <git@vger.kernel.org>; Fri, 02 Mar 2018 17:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lgcvcJ7yH9Z/cpa75WbHEHEDWnzss2/tFI4eUdiZxRQ=;
        b=XfeV22Y9GerpS+Ku0XUy0nPsGLo7wQnZKhnxpATIlA+SJgZKwItpRJO56Qq2h/CdCR
         ScOTHzda2g4fg4j2RwZLIvnC5FSELJk7Zwkq5YTFU2XoWGyQWfvCV+B6AxgWKuco/pAZ
         ONnk8DyAMZHmbueBsEF5GcmxbwqULv6ZLSoXhUmsAqP5q1GydWVmWzN01aL4rI+QfxCr
         Wz9A44k4OlB8OMPyEYKNAL0kw/a5jI7nOQ5yVpBCmzJGppAhG5hyfyQzYqE2UDLliEuh
         LbsNjd/PsL/1NHOYOYuNuBW9IDc2L2WWceLq+MOu+Kyv6HfS5v6LRFmT9b/ulRECUNDW
         7kVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lgcvcJ7yH9Z/cpa75WbHEHEDWnzss2/tFI4eUdiZxRQ=;
        b=ayrLRFcEckwGzrNVR11/vr5FhKrYeZ9gVGc7+ZemNrcyBIxHk47KUoRMfaR7LfXXQ4
         vbyDxDBBl210qF3N8P/ect5xwWOlGEx/mNt7B3WTNgx0TCa9XuZSqoIrnnqcsgbKcJZw
         1X5EPx+sL9wRchU8vKqaf5usGM9NYXCb7aO4Z9ClK4rnb0Wz++97oI8tkbCoJAtjV0Cx
         KYKVqwi3C3HasroWwfCPTUWngbrmV7ttQfyVrnJU+B2ce1bM2BEm0I/OPo6wuI+LoEIP
         NBL4aRcbgdY1UIwoS+C7yebCoOlQzy9tmAdosAJV8V7NEaPqhOJelx+vXSx+0w37SVKa
         kOwQ==
X-Gm-Message-State: AElRT7FV7xnqn5SnsMmo1ZiTn0dkG3WlYn2QwFjyGV/eWRF0UlK4yCok
        aiyekLrjXawGanDJm+9fMUrmBdFB2XDUT8sSWuY=
X-Google-Smtp-Source: AG47ELuXxccQN1TL/v/XXr8AeHRGVoqmqYYwpnqbxGSbWb5BiMlucxkBovX42GuW3Ctv8rMtGf1x4u1+jEDlxt8+pQc=
X-Received: by 10.157.54.152 with SMTP id h24mr2814135otc.173.1520041925269;
 Fri, 02 Mar 2018 17:52:05 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Fri, 2 Mar 2018 17:51:34 -0800 (PST)
In-Reply-To: <xmqqfu5nqrf8.fsf@gitster-ct.c.googlers.com>
References: <20180214180814.GA139458@google.com> <20180223095640.25876-1-pclouds@gmail.com>
 <20180223095640.25876-3-pclouds@gmail.com> <20180223222950.GK6619@genre.crustytoothpaste.net>
 <CACsJy8AUvAv61wM5hnvhyCaOd_oKmMbhAyDGJ9pmkiSu_WveZQ@mail.gmail.com> <xmqqfu5nqrf8.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 3 Mar 2018 08:51:34 +0700
Message-ID: <CACsJy8Dpzj2XoaC6WjahKPiOhpY9i9iAPwPjmDmw1aFwbEw2OA@mail.gmail.com>
Subject: Re: [PATCH 2/2] Revert "repository: pre-initialize hash algo pointer"
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 27, 2018 at 6:09 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> Yes that's the intention. But after writing cover letter for v2 and
>> sending it out, it looks to me that this thing must stay until all our
>> code is converted to using the_hash_algo (I don't know if there are
>> more to convert or it's finished already). So an alternative is we do
>> the opposite: default to GIT_HASH_SHA1, but when an env variable is
>> set, reset it back to NULL. This env variable will _always_ be set by
>> the test suite to help us catch problems.
>
> If we were to do the "do not blindly initialize and always
> initialize explicitly for debugging" (which I doubt is a good
> direction to go in), then what you outlined above certainly is a
> less evil way to do so than what the patch under discussion did, I
> would think.

So v3 [1] should be in good condition to go to 'pu', I think?

[1] https://public-inbox.org/git/20180225111840.16421-1-pclouds@gmail.com/
-- 
Duy
