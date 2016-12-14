Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEC241FF76
	for <e@80x24.org>; Wed, 14 Dec 2016 08:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754830AbcLNIZ0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 03:25:26 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:36398 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753138AbcLNIZZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 03:25:25 -0500
Received: by mail-io0-f194.google.com with SMTP id b194so3356696ioa.3
        for <git@vger.kernel.org>; Wed, 14 Dec 2016 00:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=J97+9BFUANFt7WQjuMhIAtkbnrlzkziXDyo78eCceTc=;
        b=ku+ipRQfi7y14RF1qcps5Bv9UFGqimp45dhfSBz+qi4t4oWbyAdRNkShPGtVkRDmtc
         h82kHNDZF4aLgBoaB2D3ruXglzJ5AvNLaFDSguZKJg0uLHTo1D4trNAxXx7YbY+4yTu8
         +Nl0mlqJAAjFinwmRC7wb7P9Z72ac+rnGzztbum9yYY42svBSZYp6r+2X2/BVlvCz9B4
         X9w1EMtqgG7xcrIReU7qTfYdn16Hg+gELbU4T9DF+8gyLqXPPpmyCqHy4SLR3bJyayc3
         Kmk4r6aFLiVVlB7fnvVzz9Z1d09v0kR5aOCKjU61uhVdjmbdjjdrzAsGMEZJ+tMe3B9j
         q74w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=J97+9BFUANFt7WQjuMhIAtkbnrlzkziXDyo78eCceTc=;
        b=XKjLEQf3v164HTcOO31JPCBefMRShUeLZI6a30kM5iS+w5ZnWBpF9vvIm0F0H6SnZ5
         AIg7t24jr5yhqsiiYrOlKu0Nzhy3g5NPND7uCXpVqQVB1T1We4nhzYiCuSZg9tPwKC5V
         vJKilejmRbTSlskD0Qwo8r34JH7SX9Oi/r95fOaMhey3T+vLisxvOEXErf2+h4dFWGvo
         N731EcnOX98pr4SEzagQwdRejbQ9O6GlyDz6i5DhoWHQBKPAHJU/ytfw6S3YoK66/8C4
         kpjKJ4N1KhINK9HSXSjNfEGO3lhLP7dpEUI1CzuD4bzlyUSapGpowqvjsphEHbCUaxuj
         mwUQ==
X-Gm-Message-State: AKaTC020V2l1G2pzzPxTLKmUv0RAQvjk3e5ZbNpiv7h7xMnOWvr8sjxPiZ4B20FT7CytCu4XEGm/UoVhKXpIBw==
X-Received: by 10.107.195.204 with SMTP id t195mr83260724iof.46.1481703834329;
 Wed, 14 Dec 2016 00:23:54 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.0.93 with HTTP; Wed, 14 Dec 2016 00:23:53 -0800 (PST)
In-Reply-To: <20161213122854.pphyp342tstxbbqe@sigill.intra.peff.net>
References: <20161213092225.15299-1-judge.packham@gmail.com>
 <20161213121510.5o5axuwzztbxcvfd@sigill.intra.peff.net> <20161213122854.pphyp342tstxbbqe@sigill.intra.peff.net>
From:   Chris Packham <judge.packham@gmail.com>
Date:   Wed, 14 Dec 2016 21:23:53 +1300
Message-ID: <CAFOYHZD5iUzXFH6CFCKhG8UmQb8q0CiUZFSBAeicUmjSt9mgig@mail.gmail.com>
Subject: Re: [RFC/PATCH] Makefile: add cppcheck target
To:     Jeff King <peff@peff.net>
Cc:     GIT <git@vger.kernel.org>, Elia Pinto <gitter.spiros@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 14, 2016 at 1:28 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Dec 13, 2016 at 07:15:10AM -0500, Jeff King wrote:
>
>> I think these last two are a good sign that we need to be feeding the
>> list of source files to cppcheck. I tried your patch and it also started
>> looking in t/perf/build, which are old versions of git built to serve
>> the performance-testing suite.
>>
>> See the way that the "tags" target is handled for a possible approach.
>
> Maybe something like this:
>
> diff --git a/Makefile b/Makefile
> index 8b5976d88..e7684ae63 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2638,4 +2638,6 @@ cover_db_html: cover_db
>  .PHONY: cppcheck
>
>  cppcheck:
> -       cppcheck --force --quiet --inline-suppr $(CPPCHECK_ADD) .
> +       $(FIND_SOURCE_FILES) |\
> +       grep -v ^t/t |\
> +       xargs cppcheck --force --quiet --inline-suppr $(CPPCHECK_ADD)

Will look at something like this for v2.

>
>> My main complaint with any static checker is how we can handle false
>> positives. [...]

<snip>

> So I think it is capable of finding real problems, but I think we'd need
> some way of squelching false positives, preferably in a way that carries
> forward as the code changes (so not just saying "foo.c:1234 is a false
> positive", which will break when it becomes "foo.c:1235").

If we're prepared to wear them, the --inline-suppr will let us
annotate the code to avoid the false-positives. Suppressions can also
be specified with --suppressions-list=file-with-suppressions but that
would suffer from the moving target problem although you can specify
the file without the line number to squash a class of warning for a
whole file.
