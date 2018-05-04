Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AAC2200B9
	for <e@80x24.org>; Fri,  4 May 2018 15:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751301AbeEDPNb (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 11:13:31 -0400
Received: from mail-vk0-f50.google.com ([209.85.213.50]:34716 "EHLO
        mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750707AbeEDPNa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 11:13:30 -0400
Received: by mail-vk0-f50.google.com with SMTP id t63-v6so13559997vkb.1
        for <git@vger.kernel.org>; Fri, 04 May 2018 08:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3FA1Z0nVmggz35EI2mC0CVHPCXYlh4cppV/5VYvJeXs=;
        b=o61/wkVXOKw6VcSE9zHo57d+8CK0rE/GW/qtDyFNMVbMy8B8awIsn1yZcAgwZSoSeN
         usPGFODhvGFXz7zhiFSHLOpFkkHjf5ynLyxll+lHhLWienZps39VobuNt9mzqd53jZbm
         xdvy0VG0PsNJvOnximB5nWXNWBLTdJ18ZAfQS/Jw5jKLvmHZrnC3UZz229XVIOsOqKIS
         qjEe3F/AkqndKctQvFDqUCiTVM5Vq97AHbAKKq0iUQeNw/l8Xosnctmd4c/g5TIyNslB
         SMb0deqkKAx5GwmomdIzTOqxhrC0XC6uOfdnZyhytt7j3FnMtsa1s0ThtHTBM8Sc6fbs
         WKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3FA1Z0nVmggz35EI2mC0CVHPCXYlh4cppV/5VYvJeXs=;
        b=HxKAcLHhVSFkJsqfoKTUqScKczTJTANDMLaS4lQCDgAss0AwfhSxNBNpwCdbwslZIl
         zgkGFOqeu+/rPuDsC39jYpVINyGX8DGk8hkYz/HafU6eziTR/C7hbJv07rNHFRAh+Pwl
         8Fc/22P9d0OxfBG93cl2Hv2INrX2dgE9L+6WLwjY8XD5p5o+pglc1oYbP7vX5a08uVq7
         D0Gtn1u/KppZshwpPtJ3YeZNWixsPSf/g/PNjsYzymMI5mas2rPlV6iAR7DVMjyhoau5
         G7INkT8RzKIBTu9emNmbe5NP4x6pReifApd0F8HQux2WTJSMHK4HKGzFx5wX43puwkhp
         KaCA==
X-Gm-Message-State: ALQs6tBMJ9nR6c0B4iuZcxDb5p2tU2UvcQJhDnY7jpsVqLfTv+to1QYz
        2wBiWGskHlQvorMF19f/oT4ydK+yqSPmes/FWKQ=
X-Google-Smtp-Source: AB8JxZpfRHsin3tBLMR3HpysSWV5OI7A9LhltF/ck1WvFhVnIHqPSYnaKelOsZUOGCHDypDeIsYTvbowYqKFCqTotVc=
X-Received: by 2002:a1f:c155:: with SMTP id r82-v6mr24425682vkf.76.1525446809304;
 Fri, 04 May 2018 08:13:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Fri, 4 May 2018 08:13:28 -0700 (PDT)
In-Reply-To: <20180504111215.5975-1-eckhard.s.maass@gmail.com>
References: <CABPp-BELX8u_CG8BswenAKCo8yvfxxOAOHjAbvh8jAm9gN7Qgw@mail.gmail.com>
 <20180504111215.5975-1-eckhard.s.maass@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 4 May 2018 08:13:28 -0700
Message-ID: <CABPp-BEujnVhp11L38+LJN+Tv-SoWX2YT80LKX+HZCFjta5hdg@mail.gmail.com>
Subject: Re: [PATCH v3] wt-status: use settings from git_diff_ui_config
To:     =?UTF-8?Q?Eckhard_S=2E_Maa=C3=9F?= <eckhard.s.maass@googlemail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <Matthieu.Moy@imag.fr>, Jeff King <peff@peff.net>,
        Ben Peart <peartben@gmail.com>,
        =?UTF-8?Q?Eckhard_S=2E_Maa=C3=9F?= <eckhard.s.maass@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 4, 2018 at 4:12 AM, Eckhard S. Maa=C3=9F
<eckhard.s.maass@googlemail.com> wrote:
> If you do something like
>
>     - git add .
>     - git status
>     - git commit
>     - git show (or git diff HEAD)
>
> one would expect to have analogous output from git status and git show
> (or similar diff-related programs). This is generally not the case, as
> git status has hard coded values for diff related options.
>
<snip>
> ---
>
> Hello,
>
> Hopefully I have addressed all issues that have come up so far.

Looks good to me, thanks.

Elijah
