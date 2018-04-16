Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80CFB1F404
	for <e@80x24.org>; Mon, 16 Apr 2018 19:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753355AbeDPTYC (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 15:24:02 -0400
Received: from mail-yw0-f180.google.com ([209.85.161.180]:40136 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753239AbeDPTYB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 15:24:01 -0400
Received: by mail-yw0-f180.google.com with SMTP id p4so2147529ywm.7
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 12:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LDQ5NQnw7XNc4MxhOTSLlZalMtYVMnPzSWefP9hcjRA=;
        b=YQlmRNOjnutGWcEpg052Udbm9MhO04/OFgHShQ2EBEo8q0AP7vqX7apzncaHNB9sYH
         zKQH3tgqJoUqDh4/zVfHISQSkrOI3cgIv4wLbMyL8F4MgvELa2VVR9Q89LCWu9Xt0el9
         8JzmyVce4wTkMplrml15UWwu5odcuHKGaHfHd30BemAwgdOA3XyVlWiIeJK5Ok9c5ybI
         AovL1MAp3McW8xdg7lzKd2Bb20Ye5KlzyCxXbF1Lo5LYNPPJWG4VsnB9vXY3en94RULv
         0Tj+0cRk40nj2Dz8EEQSs9bK2fmfizA43CUz06gMRN+uZuye8x2SFeCUUQxBiqc2mfjU
         oOlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LDQ5NQnw7XNc4MxhOTSLlZalMtYVMnPzSWefP9hcjRA=;
        b=FRLaL7CDKqNfJHCxo9drgTIYwa0Jkc8OC54YUN6gGpnbU6NWDGCc6jqucBKeGNiZ3e
         PwFa5U9C7NLnphxYhrAPFX6BlMBg82yapdQIbMhV/vWIWBPlAhz1UIHtx8VZjNzoA88D
         +hxkx8rIGD+RsLTtEeQFFqR+7tm5SrzS3Sb+7aV3ZFIki+NGX2iyuXvfke2dfWrtoQAC
         wfuknMeow9t4NcV7M0ZAaa92aKLgloZGtOipy8uafIxkBUjwfaY8q52/GGXgflPDPEZQ
         SKCNYTNwWdxlreZdvm2GckgSbXRiQd5oUgS2EMg9tRMEzOoHnI9SiinroIymZkOHlbYy
         g74A==
X-Gm-Message-State: ALQs6tB5GWPJ6YlRWs2O/osO5FmFHD1StcDZMuQMjnXM3CBH1f33kw4n
        89vqW/2tBKKIKg/Ji4zMT0s6N7+KKEHPTBss8gefcw==
X-Google-Smtp-Source: AIpwx49yuu2XgeRhA8ruih3GND6CVRAFh8nUG01WFQwJjQhqDlizuCxM6wv0K1TmPHyIMFaeD+vbO/+eBKiCIOk7aR8=
X-Received: by 10.129.232.5 with SMTP id a5mr11999005ywm.421.1523906640590;
 Mon, 16 Apr 2018 12:24:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Mon, 16 Apr 2018 12:23:59
 -0700 (PDT)
In-Reply-To: <20180416181841.b486524b8b9b0e68e3a31bfa@ao2.it>
References: <20180412222047.5716-1-ao2@ao2.it> <20180412222047.5716-3-ao2@ao2.it>
 <CAGZ79kbnc17PZ9_=8QLkZgUZ0DHJKfWnxrekmgkLGFBU_0ieug@mail.gmail.com> <20180416181841.b486524b8b9b0e68e3a31bfa@ao2.it>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 16 Apr 2018 12:23:59 -0700
Message-ID: <CAGZ79kZMXjEAHewkwBR4R91c46+jEL5s9rX2D+2gXo2X6dcozA@mail.gmail.com>
Subject: Re: [RFC 02/10] submodule: fix getting custom gitmodule file in fetch command
To:     Antonio Ospite <ao2@ao2.it>
Cc:     git <git@vger.kernel.org>,
        Richard Hartmann <richih.mailinglist@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 16, 2018 at 9:18 AM, Antonio Ospite <ao2@ao2.it> wrote:

>
> Is there an API to just load one config setting?

Do you mean to

  git -c key=value foo-command --options ...
