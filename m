Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 540651F462
	for <e@80x24.org>; Tue, 21 May 2019 07:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfEUHx3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 May 2019 03:53:29 -0400
Received: from mail-qt1-f180.google.com ([209.85.160.180]:33054 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfEUHx3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 May 2019 03:53:29 -0400
Received: by mail-qt1-f180.google.com with SMTP id m32so19448912qtf.0
        for <git@vger.kernel.org>; Tue, 21 May 2019 00:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R1U19hOTC9BgSbXDmYybAXtMVP1mQKcYCcGv+arlSPw=;
        b=dwEt3CxszkKOCQ1yDuq5AohTlWPs07jyyvy9+rJG71IznL2FMSoLn2g652GU8fpVpz
         2iI86Nrii5R3BonOLI1Esx6ldLRO7v6EZJ/zO19zqmYSvovc2PZXp9xUaoCcVCFZ5zdo
         UZqI7k4t6IgxtK2KHDqzaaojJh42GewNF7zE55J/Uup2xiKaG03vtevIVaeSncUfYOL7
         zsMWRHXUKz+H4G3jESW1iEtWvydz5qNl/oAJoVhM9jWOr+1rZ2e2/R/wctBeOPefoSxf
         B0HCCVkqYxZA93Imsr1DRSAfyUXz0+wrbDm+7ulz/cKShCcKdy0xCjVBrx2zcK8GX49W
         XjCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R1U19hOTC9BgSbXDmYybAXtMVP1mQKcYCcGv+arlSPw=;
        b=lFBuxssDG8M0kt3UzngZz+kPh9vUECJQPPgVhtY5KLWjc9AeLdhVjZveIsHyCa2cGZ
         i6zYtOTHfKgw+EYUYpABBbNPIIwAeYkCkpxeWt9tQriexUkh5N+KiASuKzgg8+B4fGVV
         mr7afmQuTfOLDRVqTuEyxI7G1sj90qEFnwgQaprdtY4X6C03beXXTwSD52D2mK4zUHYY
         RkojFXLbFs9GC6FxX4d9wvKY5JCvio+Mci5qRCc6/X2VZ2ocbQO4aI7c7HPA/3ACwt6F
         4qGxaLmYaCtZd0U7UVpFWiyY9GnpQCuKbQCjBLCDgT/u+zjJZMq1Zh2QOoKVTZ673LR2
         rUFA==
X-Gm-Message-State: APjAAAWuPj1DfIUHoaoNzgftfz76rDgpbT3/FNDSx8QgKr+LN4W2KhJq
        OQU1dLg9xr1vcgQpc7BadsGaJt/Z+/0WtrK2a+o=
X-Google-Smtp-Source: APXvYqwE59SgXtKvOfYteCP3tVojdvmj74IO4HQtztYv1mUXC/ZOVOI5oAvaIWzrOPQBhdrZPYDdLmBTAjUTfV2cOZw=
X-Received: by 2002:a0c:b89d:: with SMTP id y29mr17279978qvf.170.1558425208192;
 Tue, 21 May 2019 00:53:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAA01CsoJf+_-iowdm0EFWd52vOWE1Uo0GGZ55d3RyPJzg6gwgQ@mail.gmail.com>
 <874l5vwxhw.fsf@evledraar.gmail.com> <CABPp-BGycoHEMN27Z9rAccT5yVRf3N50o4sc3wo8uE_HLR9QbA@mail.gmail.com>
 <86a7fhp6yv.fsf@gmail.com>
In-Reply-To: <86a7fhp6yv.fsf@gmail.com>
From:   Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Date:   Tue, 21 May 2019 09:53:15 +0200
Message-ID: <CAA01Csp+RpCXO4noewBOMY6qJiBy=Gshv3rUh83ZY2RJ5Th3Ww@mail.gmail.com>
Subject: Re: Merging (joining/stiching/rewriting) history of "unrelated" git repositories
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 20, 2019 at 3:54 PM Jakub Narebski <jnareb@gmail.com> wrote:
> There is also reposurgeon tool; though its main purported purpose is to
> aid migrating from one version control system to another, it can also be
> used to edit repositories (utilizing fast-import stream).
>
>   https://gitlab.com/esr/reposurgeon
>   http://www.catb.org/~esr/reposurgeon/

If only there was real documentation for it...


[resending in plain text...]

-- 
Piotr Krukowiecki
