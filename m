Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 623831F461
	for <e@80x24.org>; Tue,  3 Sep 2019 14:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbfICOGb (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 10:06:31 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:37636 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfICOGb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 10:06:31 -0400
Received: by mail-lj1-f176.google.com with SMTP id t14so16203635lji.4
        for <git@vger.kernel.org>; Tue, 03 Sep 2019 07:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dmeLUQA/ysGoxFsoRvTm/WEtrNptHzaHMUvokK/Htvk=;
        b=d+gjVy9ksDPfBfrb1kTN7JY7MM4Ky6p+WUO6uiK7frwyoAWSbHMmouES4iQZslrvvR
         cC/3tqVCMtsBy0w8X2+lxx92vJCcugDnGXaCs5dU6/6HEauGrZp5Kohl1CJQhfLL+S3j
         DczQdJU9Rr8b5F7h5MVFSBnTVLsOgeTiCmjlvh+6FDjJP3Q6VYA60tnfItPme6Dor8Yz
         nDTgoxw/7j1N2E1Aph0bCa3V9AOeJIJvDxPln5SWp4a8R7dIgAr06IObuLNn2+OGqB+T
         ox80biRC6nUi6lgBxup7fTAaoeuku6pG2ShceIGXayv0dfn5wpsJxe2qkQt3MoMeAOi6
         w7zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dmeLUQA/ysGoxFsoRvTm/WEtrNptHzaHMUvokK/Htvk=;
        b=P1/wx5URXxtUnu58GwFc5IqNDsUf/LY0rUTRwoJVXHbr/5ftBd8hfbfZ6m0k8Vme49
         6FZTJlXEHTcVSRJ5n3grBfhDR2vH81rQNu5bue3rl+SNZm3W/AsByqxFcS7w9MI4t0JA
         Rdsa48lfz3Ds+XpjLGlKJWB6eh6jdP5b6twnkCqtWrGVTASRN0Rru50yJAR8octdsJVI
         cgnkJTG30e1d41M53McYbZN5z2RDFm7jVYN4G0ZKzBP3IeHbGOMAAHe9pNueFBkeAC8c
         E9sXDFdC1egmlDwKk/zzE7slgJBXTkCyDrxm/jHpX5uywhGvNHXGwuI9DN2hNndar9ac
         n3uQ==
X-Gm-Message-State: APjAAAVrEtOIdEzsqm8a8/CZSQ/Scp4u9uGpwu2GPaE6h5S+Xa0LczR4
        UJnOfNq8Z/1XlrrqlPWghSz0FVASV8JdyMlPeUA=
X-Google-Smtp-Source: APXvYqyg5ONu65V8KjiJ+0E26mjOm2RWmZtZWVoNB18nYhltXDE+TIKpmgVc6SCM5TTyjz6xqHyjcouu02OwO/zrwK0=
X-Received: by 2002:a2e:9b0c:: with SMTP id u12mr3521808lji.26.1567519589008;
 Tue, 03 Sep 2019 07:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAGr--=Jw4DAqTi3ROujtE=xBMYErMws6B6vhuXYMQA+5Q1ccow@mail.gmail.com>
 <CAGr--=JkNqcrcenp6F1_CHTun_9wPLVvEWGOFJW=ng=XfO+jHw@mail.gmail.com>
 <CAKPyHN3Zvf6gtKAq03s8AsguaOFG=g2huGRCTWmBVWioDBqFWw@mail.gmail.com>
 <CAGr--=JyJHTxtQWSnU7ivQ79qXcg7o4N142+5FSdre851xss6A@mail.gmail.com>
 <CAKPyHN3S-jLWmfHUyH9mCBPjHCEaBCbrkVQEKFqHv59U37=Kyg@mail.gmail.com>
 <CAKPyHN08Z_9oByA8ruKwwXRcAfYPU95JaMb=pqQWwGwPVG=_og@mail.gmail.com>
 <CAGr--=Jn87r_ySYkZmtqUBA40+fwdn0MbuN6_LNDO4mOWyoKTg@mail.gmail.com> <20190903124541.2p5hmknolh2dwqh5@yadavpratyush.com>
In-Reply-To: <20190903124541.2p5hmknolh2dwqh5@yadavpratyush.com>
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Tue, 3 Sep 2019 16:06:17 +0200
Message-ID: <CAGr--=JaTvZ_mUK5+dW6eM3-71ROUR4c58TF9G=-jAw3GDzYTQ@mail.gmail.com>
Subject: Re: feature request, git-gui: add hotkey to toggle amend/new
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Git List <git@vger.kernel.org>, bouncingcats@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pratyush,


On Tue, Sep 3, 2019 at 2:45 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
> Can you try doing a Shift+Tab? For me on Linux, if I hit Shift+Tab, it
> immediately takes me to the "Amend last commit" option. Then I can press
> space to select it and Tab again to get back to the commit message.

It seems that Shift+Tab doesn't do anything (on Windows 10).
Regardless, imo there should be a binding dedicated to toggle amend.


> Also, since we are on this topic, how about making the "Amend last
> commit" button a toggle instead? This would act as a "turn amend mode
> on/off" button. Since "Amend last commit" and "New Commit" are mutually
> exclusive, a single toggle to switch between those modes makes sense to
> me.

I assume you're talking about the button in the "Commit" dropdown
menu. I agree, it could be just a single entry which is a toggle to
enable/disable amending. And (above the commit message dialog) perhaps
just a single checkbox; "Amend Last Commit". In other git GUIs (Git
Cola and TortoiseGit) I see they're using just a single checkbox for
this option. But maybe that is a slightly different topic, the hotkey
behaviour would remain the same.


> ... do you still feel the need for a dedicated binding for amends?

How do you guys feel about it? So far it seems we're at two "yay" and
one "nay". I really feel it is in the best interest of the git-gui
project to implement this hotkey. And not just because it is my
personal preference to have it :-)


Birger
