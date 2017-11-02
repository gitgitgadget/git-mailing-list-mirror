Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCCF020281
	for <e@80x24.org>; Thu,  2 Nov 2017 21:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934463AbdKBVpp (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 17:45:45 -0400
Received: from mail-vk0-f51.google.com ([209.85.213.51]:52766 "EHLO
        mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934407AbdKBVpo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 17:45:44 -0400
Received: by mail-vk0-f51.google.com with SMTP id i133so624508vke.9
        for <git@vger.kernel.org>; Thu, 02 Nov 2017 14:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0gyQQeRA3IEJ/599QIjX7FLCkLJIffVEI83d60Z3330=;
        b=RH1sS6RnPC9xPH12x523gGlvp5zz2LYRzDm5PqR/yl7TmPqkBg5PF2ukJzLSG3uEbm
         fVH33twa6gvO3dx4RolqiNQ5idc/jyHAAwOaYQb7LQ7UUzhGFND2fZq1PwSgyC/zmS5W
         BPk7PikomRPfM0N7aWt4/RqzP8WEK4G+PR8yaii7zc9rtVZvH30rIcBzel4pw1Af98HA
         Is5H472alI2jI8DWrq6IpO+X8GCRiF+1udTeTEZipk5BzJH44PVGUNBkDQ23Pm7Mslwz
         nfN1c5fcwbAXa4MWWNDWXRMuCZSrAm1iUbzk7gI40xyzVGuJHEt8pYXGJrsV6pEW2kLh
         d+lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0gyQQeRA3IEJ/599QIjX7FLCkLJIffVEI83d60Z3330=;
        b=HIvE7IdDgZiOLs0JojTt8jmCIu7GHRi+GG5s9zTpsmDfRKolwlPXlnkxfRn1OPymA6
         Zv27iUHuxEvGuewTkLPqcnK14nf/vtZ8+6aRJLf6qkvAhUyjd9yLmiVcDV1OiBBWw0UX
         Nekn4St9HfoWnxyE8EEEtMU7n+UeAIyoR0UMwGj0mpkA/tCKD+i0d9p/u4yPHNK5dTQB
         6ehsjD+1iQnkxYCKypW3C/QXqdSfV/djsUx8/MRFp5ZhbzaDD3vuJth3drVJ6tKsm3Uz
         9hDVzJK7ufxXgNWobIQd6qB6D+wHLJU/4U7AxKjfSkFfQh/hXmkhkmrcEQqRsXaWyxu5
         LwCw==
X-Gm-Message-State: AMCzsaW8Ue5ht0Y8sBzWjRrwO0tFDH+RDwpCHYl2RL6mbHENgZJb8Iin
        tm8ak31/WjyykyV+YjGh9iP7auOijWUH4meCrz0=
X-Google-Smtp-Source: ABhQp+Rue4H4tXQ3XkAbTvwEpXFK+P61Gs952lECU70xaAyyNIPCXI/B1TUQS8GXro4YC3TR9D/WPJuwvu2WIAMLBk4=
X-Received: by 10.31.10.80 with SMTP id 77mr4005150vkk.46.1509659143744; Thu,
 02 Nov 2017 14:45:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.56.100 with HTTP; Thu, 2 Nov 2017 14:45:43 -0700 (PDT)
In-Reply-To: <CAGZ79kZaCe6ATXajK_HhzhDcWm9CV3bsJ5EAqE5UYXBc+_b5yA@mail.gmail.com>
References: <CAGHpTBJTm=3f_VCnNLeE=V4CwvC6dM8qCmGRPDap6rszcpb65A@mail.gmail.com>
 <CAGZ79kZaCe6ATXajK_HhzhDcWm9CV3bsJ5EAqE5UYXBc+_b5yA@mail.gmail.com>
From:   Orgad Shaneh <orgads@gmail.com>
Date:   Thu, 2 Nov 2017 23:45:43 +0200
Message-ID: <CAGHpTB+58ZeXxkprYegjA6w4Ar0sPc=_OUENuvn+_CBxLXOsNw@mail.gmail.com>
Subject: Re: Regression[2.14.3->2.15]: Interactive rebase fails if submodule
 is modified
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Brandon Williams <bmwill@google.com>,
        Heiko Voigt <hvoigt@hvoigt.net>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 2, 2017 at 8:34 PM, Stefan Beller <sbeller@google.com> wrote:
> On Thu, Nov 2, 2017 at 1:30 AM, Orgad Shaneh <orgads@gmail.com> wrote:
>> I can't reproduce this with a minimal example, but it happens in my project.
>>
>> What I tried to do for reproducing is:
>> rm -rf super sub
>> mkdir sub; cd sub; git init
>> git commit --allow-empty -m 'Initial commit'
>> mkdir ../super; cd ../super
>> git init
>> git submodule add ../sub
>> touch foo; git add foo sub
>> git commit -m 'Initial commit'
>> touch a; git add a; git commit -m 'a'
>> touch b; git add b; git commit -m 'b'
>> cd sub; git commit --allow-empty -m 'New commit'; cd ..
>> git rebase -i HEAD^^
>>
>> Then drop a.
>>
>> In my project I get:
>> error: cannot rebase: You have unstaged changes.
>>
>> This works fine with 2.14.3.
>
>   git log --oneline v2.14.3..v2.15.0 -- submodule.c
> doesn't give any promising hints (i.e. I don't think one of a
> submodule related series introduced this either by chance or
> on purpose)
>
> "rebase -i" was rewritten into C in 570676e011, though
> that series was extensively tested by DScho, so I wouldn't
> want to point fingers here quickly.
>
> Would you be willing to bisect this behavior?

Bisected to ff6f1f564c48def1f8e1852826bab58af5044b06:
submodule-config: lazy-load a repository's .gitmodules file

- Orgad
