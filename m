Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E30461F597
	for <e@80x24.org>; Mon, 16 Jul 2018 18:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbeGPSdZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 14:33:25 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:42789 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728794AbeGPSdZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 14:33:25 -0400
Received: by mail-yw0-f195.google.com with SMTP id y203-v6so14503965ywd.9
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 11:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q4Bi1HXll2Ye8ed1DNkaQ45pvd230NPy1xSR+MOzIwM=;
        b=kX7V0Cd/2/0s5y/s1hzuzW2Aj0R4vWNTpiS+sYVJTxgfiuPUy+NiilBtpti86pwhPS
         sayS0ykHUFatbld+dTC8jTEGaHIADiU77i/3XQnLLuz4tB/JvtdXDT/c3mvNuVO/2f9S
         pnVrrXvnI3zyq365f31U9i1bvpFlzry/Fi4d+Kci/xM57WaDnbFij/4Q7wAYAtqcg3Uc
         63Wg0IqgqVL7TjubgLz0L48G+8u0PUFeNaDMIwSZXiq58CPK3bdhK8ijoskUVJ+SWCw+
         5TnMSAudLZ2aA6wQd8G3fuYVfFsoWydK16iNySRNpWJtT73gjM7wJ7tN/a/HXonXc7iR
         ZVXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q4Bi1HXll2Ye8ed1DNkaQ45pvd230NPy1xSR+MOzIwM=;
        b=N1ze1vx5mZgpLUTeQgIuPqLH3wkoN2edxy68AtJfRk5Yom04Znp4dZJ4+/8aPsyLns
         MJawmCIXQb1sdsEXbuqJp9T6zWK4A1SZejpKIwyPJ+T4AQV0B0JoAWC5wLhsNr2t+juB
         TcqFfdoY3yHxRUPM4NKsKnCwGNtY/pdFob9VwKdxXHhbs69ozHGTALhHNCsY31xES+4Y
         WPi9DxpcmhQ1k1kLZbquezYnOIBVWmLv/kyvKktAtXRswCUJXqQqBkBnFmaKsUpamlWf
         82x0CHAoPjf+TZLfO1cK5yiHOq+3aeC3O+CyhcLG6f/AKtIQee8SROUOT9a/i5Qc0XQz
         536A==
X-Gm-Message-State: AOUpUlGIqPnaN82EcKo5KNHtmit353d6GFuhli9wVpy1RvBAk7uI0J8h
        KBJaLnHdjZXRVg3x8+emj6HmpJ9E1GRj4PRwgquz5w==
X-Google-Smtp-Source: AAOMgpcZWdcN6PVeAIXYDyuOyp9OGiSfwOOHQwtNyVXkevfJd1MUCNpx1eyHRV8KoBchgIos5BsCyxxhNFP4c0PRT2E=
X-Received: by 2002:a0d:c5c7:: with SMTP id h190-v6mr9063252ywd.421.1531764292322;
 Mon, 16 Jul 2018 11:04:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180716012808.961328-1-sandals@crustytoothpaste.net> <20180716152152.GA51419@syl.attlocal.net>
In-Reply-To: <20180716152152.GA51419@syl.attlocal.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 16 Jul 2018 11:04:41 -0700
Message-ID: <CAGZ79kbAMJXAPtc5b45_PRDC=AQRKUYLC8seXqfMrJZEaL-KfQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/16] object_id part 14
To:     Taylor Blau <me@ttaylorr.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 16, 2018 at 8:21 AM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Mon, Jul 16, 2018 at 01:27:52AM +0000, brian m. carlson wrote:
> > This is the fourteenth series of patches to switch to using struct
> > object_id and the_hash_algo.  This series converts several core pieces
> > to use struct object_id, including the oid* and hex functions.
> >
> > All of these patches have been tested with both SHA-1 and a 256-bit
> > hash.
> >
> > Most of these patches are fixes for things that will clearly cause
> > segfaults or other very obvious breakage on a Git with a 256-bit hash.
> >
> > Changes from v1:
> > * Drop patch that's been replaced by one from Ben Peart.
> > * Update patch handling hash* and oid* functions.
>
> Along with Derrick, I also read this series and found it to be without
> problems. This looks good to me, too.

I just had a hickup with the patch replacing number magic
( "(num_parents * 50) + 20") in a strbuf_grow, but I do not
see the problem there, it is just a bit of overly large grow estimates.
Despite that said, this series is

Reviewed-by: Stefan Beller <sbeller@google.com>

Thanks,
Stefan
