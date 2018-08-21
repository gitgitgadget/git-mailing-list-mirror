Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3AD51F954
	for <e@80x24.org>; Tue, 21 Aug 2018 14:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbeHURzF (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 13:55:05 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:40100 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbeHURzF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 13:55:05 -0400
Received: by mail-io0-f195.google.com with SMTP id l14-v6so15559041iob.7
        for <git@vger.kernel.org>; Tue, 21 Aug 2018 07:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x5k3PkoZUuYHsx8Z8ihhfF3UqiYOGWFkc5dng6fisfc=;
        b=mpu0mvxqLtq6Brn6PpszH3quT+k2pZs16oCq8LTPYQbaSFUEe3QGBQfouyQk/tCJxt
         5nYWz1t6rp/gPcA0kPxZXRZkGZ/xCfjLd+9337Nh1wtzDvDXaL4ozyGwJ7b/OpkHiTCs
         F4+2tUBckYLuzdX9NVp4Jk+v9IRAPFL1EeSXJ/7xcsPyWeLrPRX8/Yadhrg34ggExKJG
         QTfIpqgt7pd4DkrshMUK/7sIX/Ev+RepPRHYUI0qep0eGYj3Ak7Rng7Dw4vDUmxp7Xcx
         ZU5wdvMnKM8YTxa4QbUodjKXckPArqPTEDoh1etpA1JB99vGgEDnTbjSMLSL5g4pornI
         XyOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x5k3PkoZUuYHsx8Z8ihhfF3UqiYOGWFkc5dng6fisfc=;
        b=Aax1QtXgETbBrCTBgvxtzj08YRg5h3bL8TIfAb05YleJIuOWj3Futb0xC7OEGw3AUs
         RPZD3egYl73f0LcT4+jfJUG6Qzzif65ZyjaHgBL0C6xRgcd7VAOlblI2JF9GxD5macAS
         IjF7KcSyn26dgeT1ZRTIDIBMdrFc2K/Mj1hBIEx5tlCbgVjdT37xR3Rnbpgy7QdU+Goh
         UaRKNAa4XKAjhUAScWV1dO5LcMEbHT/YJYqImL1nE06DaIf0XgfP66/8bwa/ZLAXnwk1
         GojyqpkNXARaC5Oxq0FbFoAfm8xtGcb+PZkAq22Md52TL4HwdcO/W7vORKbL6kq5Lg+Q
         +/iQ==
X-Gm-Message-State: APzg51Co7LxoOmZL3TR/3mvf/YITHRBpk/w59J1gPXyU6D5qT65Rmuy4
        NnRPMa1HiRSPQfOfLQy1NuQ9rosY9C87gMLavMt/sABn
X-Google-Smtp-Source: ANB0VdaE9p3FwUty04WMvBbuGTGXnfIT5yXcXbo1Qyj7ezBZrZQ0f5P6va4qxNTsd5IYf2y6FRVU9wZjieBuxPBKiZg=
X-Received: by 2002:a6b:8fd0:: with SMTP id r199-v6mr5928281iod.118.1534862081634;
 Tue, 21 Aug 2018 07:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180820165124.152146-1-dstolee@microsoft.com>
In-Reply-To: <20180820165124.152146-1-dstolee@microsoft.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 21 Aug 2018 16:34:14 +0200
Message-ID: <CACsJy8CKnXVJYkKM_W=N=Vq-TVXf+YCqZP_uP7B-dN_6xddB=g@mail.gmail.com>
Subject: Re: [PATCH 0/9] multi-pack-index cleanups
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 20, 2018 at 6:53 PM Derrick Stolee <dstolee@microsoft.com> wrote:
> To better understand the implications of the multi-pack-index with
> other scenarios, I ran the test suite after adding a step to 'git repack'
> to write a multi-pack-index, and to default core.multiPackIndex to 'true'.
> This commit is available as [1].
>
> ...
>
> [1] https://github.com/derrickstolee/git/commit/098dd1d515b592fb165a276241d7d68d1cde0036
>     DO-NOT-MERGE: compute multi-pack-index on repack.

It should be able to _merge_ this patch, but only activate it when
some test environment variable is set. On Travis x86 we run the test
suite twice, once normal, and once with special features activated
(see "if test "$jobname" = "linux-gcc"" in ci/run-build-and-tests.sh).
I don't think midx is incompatible with any of those features, so we
could activate and run the whole test suite with it too.
-- 
Duy
