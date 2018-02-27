Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A7781F404
	for <e@80x24.org>; Tue, 27 Feb 2018 00:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751587AbeB0ADM (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 19:03:12 -0500
Received: from mail-ot0-f171.google.com ([74.125.82.171]:41823 "EHLO
        mail-ot0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751567AbeB0ADL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 19:03:11 -0500
Received: by mail-ot0-f171.google.com with SMTP id w38so2169936ota.8
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 16:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/OrhAhqv9uQdBtpoyBheeQl+VB8sw7CLwqOXfPJtGSQ=;
        b=AjuUDkojF0YeeJjiTOrO0tj1tgeIpXrkehEQV1cJzwY4K7ZkslU59eYzhddQQSWX7W
         gR5cvdCd0nOYK8wOGDjnaHFJaScQBzEkFCnJTF3A+Lgj0QdvwFRNUuqEYReV73HXK+ns
         9NERnhK3inTnZB/Ih90TWFHwP/KY663Zi9xHTTe/dH4FQlmy9Qt51U47f9HwDIegC353
         zT73Q2ieG/trSWoNooaJc9aRS95480MnIA+pNWwlP2zUSIXKEgjvtloeBEGP77E6z4zJ
         2GeJrn4O7SbW91Y6p4DkedMERQ2jd4o80us7midE18BnQ+aJRqwS6UqO/zHn4aFqOHev
         E4pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/OrhAhqv9uQdBtpoyBheeQl+VB8sw7CLwqOXfPJtGSQ=;
        b=rDuQkjqH9/gYY49/ZhC/2iSEfDFRaYvDPOBlzr7QZi+YuMTyRcnJ8rgocjZfeEgYtx
         BDMBXQaNy1lRAbWULSbu33bO6MlOSUpQYOlvFd+R+mKBdc2NzTt6H92MYjO5jx3RHZAG
         3Syx85bV3KBebx8d4j8rZj84C0Me+BrQFphYiWmbEfI6AWrjrJkl0GwQ1TUS0OBtdpuK
         +DAWeh/bUD2F9GhbOp9M6gpQlcm03FLBWpeM/gDfsPARx/2t0jDdfk/JVxOGVSNwocqb
         aaTNrCLxQMzNtOfBEAq9KzEAmNyiVGjOfpj3O2tV2/GK7YfgMa77RLRl/Ho+FFQxaiSR
         VoxA==
X-Gm-Message-State: APf1xPDifiToWca4TN4vGSQwsUhaXKCTrFSXXN4UKbpz9whfcKLvr2GD
        DFdYySxMIy/Q17oG5oQDy8iSnV4nUJFVDSVcVfs=
X-Google-Smtp-Source: AG47ELszaKFVCrUcH6r1ameV3Rc/jSnTK1s2qP0nbP2R2gBIdD5BxMzL8znLEymuSm2chXxXokqH4KqQwi9jz2rp3m4=
X-Received: by 10.157.11.4 with SMTP id a4mr9361771ota.65.1519689790705; Mon,
 26 Feb 2018 16:03:10 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Mon, 26 Feb 2018 16:02:40 -0800 (PST)
In-Reply-To: <CAGZ79kbgYwCjDT3wviFXakqhAKf51AvTyJOPDCW_6OtxGax87g@mail.gmail.com>
References: <20180221015430.96054-1-sbeller@google.com> <20180224004754.129721-1-sbeller@google.com>
 <CACsJy8AS5RiuXeM2u34i0hjKXJqEhsrb4Ysi9Md9OhRpP4_B-A@mail.gmail.com> <CAGZ79kbgYwCjDT3wviFXakqhAKf51AvTyJOPDCW_6OtxGax87g@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 27 Feb 2018 07:02:40 +0700
Message-ID: <CACsJy8BDxbvAigg2wVh82jh3iQ1gy5dnCh0zXQ64B6QqrGE0tA@mail.gmail.com>
Subject: Re: [PATCHv4 00/27] Moving global state into the repository object
 (part 1)
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 27, 2018 at 3:50 AM, Stefan Beller <sbeller@google.com> wrote:
>> The natural thing to do is move these to raw_object_store too (and
>> repo_submodule_init needs to check submodule's config file). But one
>> may argue these should be per-process instead of per-repo though. I
>> don't know. But I thought I should mention this.
>
> For now a process and a repository is the same as git-gc or git-repack

I think you're thinking about the pack writing part, but these are
configuration for pack reading (aka "object store"). If you read a
blob from a submodule (e.g. git-grep), you'll use these configurations
at some point.

There are of course more configuration for pack writing (like
zlib_compression_level) which I deliberately avoided to mention
because I don't even know where they belong.

> doesn't know about the --recurse-submodules flag, yet.
> I wonder if we ever want to teach those commands the submodule
> recursion, because of the issue you bring up, which settings do we apply
> for a submodule? Traditionally we'd just have the command line override
> the configuration, which I don't know if it is a good idea for these settings.
-- 
Duy
