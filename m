Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98B921F453
	for <e@80x24.org>; Mon,  5 Nov 2018 16:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729703AbeKFCMG (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 21:12:06 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:44114 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729545AbeKFCMG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 21:12:06 -0500
Received: by mail-io1-f68.google.com with SMTP id c6-v6so6975891iob.11
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 08:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GWbYaiGCEaYsGnOXzn6viiYwhIaV0xsaGxwD77jgC24=;
        b=lJaMlCEBzdfsbPAuy3p+To4ftXdeqUByzAWPdC7g2BRsu1JpQGKc1/4AMZB5GCmFzc
         85v4Usyy4oiPvWA0h6ZgySOQC02HB0kOsf1Yd5N3yLsZCOmPlSI2uNo1/XwEPVWuzaKy
         Cdff1APUTIEVwN3cUjyMWc2wIwCWtKBrdgDBCt1CCHt+0hcTBKY5jRBheGmn2IW1Drhx
         9CVqnsS8YKj0Jp8i0MwhqhzbHBkf8OV8DID8ixq9Sl7CrxINQl0CvT72/sVF88dX+qiT
         bzes5Qpf3zPQJf6gTFyotbud2WCpBm8LnYZP3ECNGma4Z85/y3MaYLF7FCkFTPI9+P/z
         npqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GWbYaiGCEaYsGnOXzn6viiYwhIaV0xsaGxwD77jgC24=;
        b=pHHkQ8aK0yN5JEdGOlxBkhoDC//RbcwbNP6d7VTq/Ma6Ym5DKN0vHhitGqyFigS1Pc
         RTdgiEppSZk6OvwCtxL3DsTlJzVuvUtSD2yMMDy3u8a4kDPhFAiEShK2d/kYMT/nADNJ
         +sOlUUABdLY/x0+h2bqgvSOWeQkqfcpcMbn7YUtMTMcmqNTINXeT1NE+YD8XNukppBqI
         X7Ke+rKiO+v+zZUC9hbwZSB8Yzd+fK9oDXER46bvB42/M6TzRqP1ruEA5tEVwejgbuG9
         aC5hiau7dsH0P0NpsKcqWKP13WT0mtc/4qycQam5PEPxlr6wcZWgGNNwSrSDxNJ5Xm40
         kIeg==
X-Gm-Message-State: AGRZ1gJ3EyUjc9amZySDFjn+aEd7rZyFChs81tiopgafaE377tyj3i4f
        HQJcAVV9tUN+wk4xYLOHcHYrh/y2de2VcB6VN6E=
X-Google-Smtp-Source: AJdET5fulsctaj/hCvUoiG4PoAblbEvOaSRodjknINYtZ5ZxIekW2PoRce9DvMcP6RW+7mfQB6qISiXeRFdAhLjnb/4=
X-Received: by 2002:a6b:216:: with SMTP id 22-v6mr18874664ioc.118.1541436693059;
 Mon, 05 Nov 2018 08:51:33 -0800 (PST)
MIME-Version: 1.0
References: <20181105063718.GA24877@sigill.intra.peff.net>
In-Reply-To: <20181105063718.GA24877@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 5 Nov 2018 17:51:07 +0100
Message-ID: <CACsJy8Dz5Meu2fnNOiFXcw4LTROxBAn05OSZhYBih7ac0jQFzA@mail.gmail.com>
Subject: Re: [PATCH 0/13] parseopt fixes from -Wunused-parameters
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 5, 2018 at 7:39 AM Jeff King <peff@peff.net> wrote:
>
> Continuing my exploration of what -Wunused-parameters can show us, here
> are some bug-fixes related to parse-options callbacks.
>
> This is the last of the actual bug-fixes I've found. After this, I have
> about 60 patches worth of cleanups (i.e., dropping the unused
> parameters), and then I have a series to annotate parameters that must
> be unused (e.g., for functions that must conform to callback
> interfaces). After we can start compiling with -Wunused-parameters,
> assuming we don't find the annotations too cumbersome.

Another good thing from this series is there are fewer --no-options to complete.

About the annotating unused parameters related to segfault bug fixes
in this series. Should we just add something like

 if (unset)
    BUG("This code does not support --no-stuff");

which could be done in the same patches that fix the segfault, and it
extends the diff context a bit to see what these callbacks do without
opening up the editor, and also serves as a kind of annotation?
-- 
Duy
