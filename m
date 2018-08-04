Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D62C01F597
	for <e@80x24.org>; Sat,  4 Aug 2018 06:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbeHDIiO (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Aug 2018 04:38:14 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:51340 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbeHDIiO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Aug 2018 04:38:14 -0400
Received: by mail-it0-f65.google.com with SMTP id e14-v6so11225590itf.1
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 23:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/J6IlBVcQfe9YDMgm1Ilrc4pU1sdjwYErR5l40yhG+E=;
        b=lXyzDo9p0ogOXVMJAAaLW1pFhvwLqjPJM6XSaV0BFO9/Nq4KPiuBV1jyTqGyaF+vWO
         aS0LxyyY/7hoaPa3fEgItHYhys4Ppgk+M0dpeEzuE6BCKn1mxG+7sNR1/27E7mSh7swp
         Dwi0ChmaT5kXBS7L/mbybmTTM8hyDaLsV9J+Ft0NqXz9hu7QflbXR8rdc6UDA7RFK1XG
         WH9gnnYkIJekpYHEVHD+7nR0g6BXDID5U45rKKHyLGqL4H/eJBVFKlMuS/osf0Z7oxcH
         wcfNkLHI3UUiubMpGHoaMvcg9IXJ8ukWRq342wC84pfC58CI1yo0/hIxcD8mC06TcHqp
         oAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/J6IlBVcQfe9YDMgm1Ilrc4pU1sdjwYErR5l40yhG+E=;
        b=TCotGzdv1QhUx2/U2nPM9bLm7187Dr+mnyk2mu5LBCGejkdaRFvqPQAb1q+UathK5F
         FT6K1jzJywjlasxNRVroWc2N/ExGcRQUCMjgquEqUltz1TDGN/WJaexC3/mZ7Dglaf/z
         R3PhAL9qTRkQ6FQEP62V2Clto1OZQ8ccz678lJBOvSZ0iNDpmL4K+Nsv0L1p+qVbto/D
         KG9eAnc05E9q9qp52JqN38kLYQ3oU15BnvB1TdTXw2sm0af1Nu6fRYRns5Cts1u9tTAc
         DmnmJ3olQYfGxmxjd3DrANuVp8jpFz244qejp6UYW5lKlm5txvQhoOmoqdZeU+2tQdUj
         Kk2w==
X-Gm-Message-State: AOUpUlHuqH8wfWUKNJVVJK9k6CB+2Zac3kl6sSlfeco6APmaZFYnNR3d
        HBj41BeQSZjEgal7cWm32/A6qn7+/qCP7vVwVT4=
X-Google-Smtp-Source: AAOMgpfO5PLIoXv0p0QPL/hsb+fagRbYoqsFmy1N9A390v8tJQcMhcffioqqc5GuQKtlFJBmDHWIIPMQM9RJ6uVczE8=
X-Received: by 2002:a02:c50b:: with SMTP id s11-v6mr6059561jam.61.1533364720700;
 Fri, 03 Aug 2018 23:38:40 -0700 (PDT)
MIME-Version: 1.0
References: <20180804020009.224582-1-sbeller@google.com> <20180804020255.225573-1-sbeller@google.com>
 <20180804060928.GB55869@aiede.svl.corp.google.com>
In-Reply-To: <20180804060928.GB55869@aiede.svl.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 4 Aug 2018 08:38:14 +0200
Message-ID: <CACsJy8DxSDLD7B8Z+GBFOuU7d7VQ4-M=BP=wptra5rBiZGspSQ@mail.gmail.com>
Subject: Re: [PATCH] Makefile: enable DEVELOPER by default
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        git-packagers@googlegroups.com,
        Han-Wen Nienhuys <hanwen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 4, 2018 at 8:11 AM Jonathan Nieder <jrnieder@gmail.com> wrote:
> My main concern is not about them but about other
> people building from source in order to run (instead of to develop)
> Git, and by extension, the people they go to for help when it doesn't
> work.  I have lots of bitter experience of -Werror being a support
> headache and leading to bad workarounds when someone upgrades their
> compiler and the build starts failing due to a new warning it has
> introduced.

Even old compilers can also throw some silly, false positive warnings
(which now turn into errors) because they are not as smart as new
ones.
-- 
Duy
