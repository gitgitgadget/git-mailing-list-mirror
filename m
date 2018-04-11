Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF4C51F42D
	for <e@80x24.org>; Wed, 11 Apr 2018 16:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753252AbeDKQq4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 12:46:56 -0400
Received: from mail-lf0-f43.google.com ([209.85.215.43]:42826 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752664AbeDKQqz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 12:46:55 -0400
Received: by mail-lf0-f43.google.com with SMTP id q9-v6so3592531lfk.9
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 09:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=KGwiDssk1jT7MJetOzG/rmp63YO00DrmT1BfQbGos/U=;
        b=cPPSYLjZPWy2Cf3H4gI77C1HMxMlFaXxN/7Ko68pRcIEWg9318xlshBt/bt5o51EaT
         H3mnlL/cAtNJ38tt6YZFIICHiZxIYCKi6EdAsMfw5zh7g0hce1B0Qks6Vjot3thk+r8T
         uHWzQ9a5rCco4txHW8dBlaZiQRPeIz8/kNrW6yuG6y2LajDkuiEtjuraJ1D18gwizV56
         bHod5eET+Htx0eIcD3sSzfti0r5cWBeXAZF2j+OcW3dv7p9oJmPGBStCW7XYvU/t0Qx6
         UpptaOY7Jsq74TJMOj7yDK4yQHrzM1HJ0EbV+TwygyxkiYFU2vu0HGVWt+o5Pbj9lhIR
         mCPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=KGwiDssk1jT7MJetOzG/rmp63YO00DrmT1BfQbGos/U=;
        b=iGQAp4WP+8lUFBUYVPMTYqXiyRX+aQ2l9FTvrG9JrhWrJZQ16lWAdSgLw5psOFWMd8
         2JybjacQUGDEAuMFDo53SThW5nbewxiV7FlNy3Grk13Ss8VnQEdSjzP5zjZTPBxwnxah
         AQKeaxG3Cnb5r4kADq1orUzRffNacuRcXDwHWGxKw1IvSZCnIqNu/BhY6rNsG+skZ4L0
         YH6CK/PPWk97W9MDhUF4zSDvrb8Mh8+XcDSvYdO3WPzgz9/1TYEAOeJfAO/r0XEqlXAQ
         C2esdwosKLKsdG2PO/W8sFigfwV+0JI/xYUtSjjc+J5k/kq0AMb//au/FqzdJ+bsJdL9
         5aDQ==
X-Gm-Message-State: ALQs6tCDbPB/nSQQLyJyf66Ey5Gzkuy+uoiDhwRhkFC3v61nNwRjIxPE
        1vEH7F3ttm6s7NQuAZg00KKviaKc
X-Google-Smtp-Source: AIpwx49PruTEYXH1HL9G3A9zn4ajNTdEM/aQ5u3rwLEvX/jjUVY27HyCw3kMinCA5Ey/vM/z5GBgnA==
X-Received: by 2002:a19:4f5d:: with SMTP id a29-v6mr3258306lfk.97.1523465213852;
        Wed, 11 Apr 2018 09:46:53 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (abrk101.neoplus.adsl.tpnet.pl. [83.8.104.101])
        by smtp.gmail.com with ESMTPSA id l1sm268733ljj.30.2018.04.11.09.46.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Apr 2018 09:46:51 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     git@vger.kernel.org
Subject: Re: Is offloading to GPU a worthwhile feature?
References: <efc4af6b-53c9-bd02-65f6-9de517f6868e@linuxfoundation.org>
        <86k1thdck7.fsf@gmail.com>
        <57c33d0a-458e-f591-164d-33f8257d3972@linuxfoundation.org>
Date:   Wed, 11 Apr 2018 18:46:46 +0200
In-Reply-To: <57c33d0a-458e-f591-164d-33f8257d3972@linuxfoundation.org>
        (Konstantin Ryabitsev's message of "Mon, 9 Apr 2018 13:57:55 -0400")
Message-ID: <86h8oh6689.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:
> On 04/08/18 09:59, Jakub Narebski wrote:

>>> This is an entirely idle pondering kind of question, but I wanted to
>>> ask. I recently discovered that some edge providers are starting to
>>> offer systems with GPU cards in them -- primarily for clients that need
>>> to provide streaming video content, I guess. As someone who needs to run
>>> a distributed network of edge nodes for a fairly popular git server, I
>>> wondered if git could at all benefit from utilizing a GPU card for
>>> something like delta calculations or compression offload, or if benefits
>>> would be negligible.
>>=20
>> The problem is that you need to transfer the data from the main memory
>> (host memory) geared towards low-latency thanks to cache hierarchy, to
>> the GPU memory (device memory) geared towards bandwidth and parallel
>> access, and back again.  So to make sense the time for copying data plus
>> the time to perform calculations on GPU (and not all kinds of
>> computations can be speed up on GPU -- you need fine-grained massively
>> data-parallel task) must be less than time to perform calculations on
>> CPU (with multi-threading).
>
> Would something like this be well-suited for tasks like routine fsck,
> repacking and bitmap generation? That's the kind of workloads I was
> imagining it would be most well-suited for.

All of those, I think, would need to use some graph algorithms.  While
there are here ready graph libraries on GPU (like nVidia's nvGRAPH),
graphs are irregular structures not that well souted to the SIMD type of
parallelism that GPU is best for.

I also wonder if the amound of memory on GPU would be enough (and if
not, would be it possible to perform calculations in batches).

>> Also you would need to keep non-GPU and GPGPU code in sync.  Some parts
>> of code do not change much; and there also solutions to generate dual
>> code from one source.
>>=20
>> Still, it might be good idea,
>
> I'm still totally the wrong person to be implementing this, but I do
> have access to Packet.net's edge systems which carry powerful GPUs for
> projects that might be needing these for video streaming services. It
> seems a shame to have them sitting idle if I can offload some of the
> RAM- and CPU-hungry tasks like repacking to be running there.

Happily, GPGPU programming (in CUDA C mainly, which limits use to nVidia
hardware) is one of my areas if interests...

Best regards,
--
Jakub Nar=C4=99bski
