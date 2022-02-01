Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA6AC433EF
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 03:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbiBADX3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 22:23:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbiBADX2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 22:23:28 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0DDC061714
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 19:23:28 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id 4so6338020oil.11
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 19:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n8AFoBaJUQTTInaBUJhcDFFLSB/a/LUsnnF1Jzu9Ea4=;
        b=gBWX9SiXRgE3r3Nt68rZZmVwjpxEkSkNC6G7Re0DuZrOyELtYoJ/scKf7OFtvA3T0c
         H7yfE5JQtX+0jo+LyfdjEcUS3JAz0aNCnHlGgrSeEHN1qlPrBT8jsKYdBjLyhWdFu0zb
         0c90I8OMjebsjfDPNR69lVltTC39ei14QIno9zjN7sGTpnTmuwbMU4d9xXX0hPyJfS6o
         suy2Zwzxf56q6aa28BMSU2zn3upBLuZR+LWiU34oCW1OCmlxRe8W4rwGDk5u/cAShRfZ
         /K/VqmtxEbZBgsLxsWAyG7uLmR8FHJ5NL7D3e6b/uUBSZ5pFoHVzPW86tuBE9yJnzANL
         qHAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n8AFoBaJUQTTInaBUJhcDFFLSB/a/LUsnnF1Jzu9Ea4=;
        b=6hCrOqMzhnbCr6SWiNTKMpANMKCZFwL2zqGTfbhF6Szz/hx6W6F3jp5Cy5u1wlU70F
         T1sABPmNyF2qoRcAbDAxNA3/aRG9IZM6I5WwdxRqDI9GcbsXauiLVqMVwN3CrJdPhAik
         XAV68C6Hhkx5isjiXL2QHvoAYa13Bvi5/MnVaMjMMKkG5v6q3CPR94q6EyIN+dTxrEeB
         thWQG8NZCvaIJzlUxM2Gz6jXKb6YSxT2E2aMZAeF5vBn93OqPHz0rgM/kEIkOQfouEmi
         fx0nhakWKya3H/ScQZwCKHO6NWMTPjHcdZ4acvXNuQa8q3066DcYtJgRNdYsgg+orXPf
         tHyQ==
X-Gm-Message-State: AOAM532KEp4iWk1luVbowRN8HeEVjaHWZqaI/wr0+j7lEO+pM7FCPIc8
        LT1pMErcvQjM5SUuMANmqqwonhiXF3IE+qmuysMG9iH7b9A2Nw==
X-Google-Smtp-Source: ABdhPJzrkDKixVSN40opGVfE7XxqKIhVNo5qqnpvOB2jx6sVZfHTzu4uZgK2LJuuRphNA6uWS1h12tKIcHMvTyTL0SE=
X-Received: by 2002:a05:6808:d47:: with SMTP id w7mr32560oik.78.1643685807961;
 Mon, 31 Jan 2022 19:23:27 -0800 (PST)
MIME-Version: 1.0
References: <CAJyCBOQDBMcowKZgMp2iCbWpaMJGxNH9EtbQ8e0zB67k1g9uYg@mail.gmail.com>
In-Reply-To: <CAJyCBOQDBMcowKZgMp2iCbWpaMJGxNH9EtbQ8e0zB67k1g9uYg@mail.gmail.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Date:   Tue, 1 Feb 2022 11:23:17 +0800
Message-ID: <CAJyCBOTpmKCHaYEvNc1-r_Rs2OWMsyCO7P6iSeM78QcjjcPuHQ@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IFtHU29DXSBBZGQg4oCTbm8tc29ydCBvcHRpb24gZm9yIGdpdC1mb3ItZWFjaC1yZQ==?=
        =?UTF-8?B?Zg==?=
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        ZheNing Hu <adlternative@gmail.com>, christian.couder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 25, 2022 at 5:59 PM Shaoxuan Yuan <shaoxuan.yuan02@gmail.com> wrote:
>
> Hi git community,
>
> I'm considering if this microproject
> [https://git.github.io/Outreachy-23-Microprojects/#add-no-sort-option-for-git-for-each-ref]
>  is a good option for now. I want to spend some time on it and see if
> I can come up with something.
>
> Sincerely.
> Shaoxuan

Hi git community,

Not sure if this message is overlooked, but I'm writing to see if this
microproject is
still (valid to do | worth doing) for now.

Thanks,
Shaoxuan
