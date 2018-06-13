Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 657C51F403
	for <e@80x24.org>; Wed, 13 Jun 2018 06:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933822AbeFMG7c (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 02:59:32 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:35280 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933318AbeFMG7b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 02:59:31 -0400
Received: by mail-vk0-f68.google.com with SMTP id o17-v6so893697vka.2
        for <git@vger.kernel.org>; Tue, 12 Jun 2018 23:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=soz1ZCeo2P13LxVdx8c5wQGEcyEgRBivwqGaM4i5AvU=;
        b=aYpvk4HgRQdpqQN9c/ecnM4hj7NM4iH1+uckFAdcCasNkcWhmWPJN1yoJDFVOZw6ax
         0o888XbKYckF1pBlgkOMYqt3qkvAAmk1grkMLQqwWp4deKdXpD+iNBJem7GXoeP4e0zZ
         CeNH12daoFDNnbASLVsQ0OljeZI3w8GFyDH2rvD+byxytBEdg6wS9FVUdM8WbX0CgEKT
         KHO82lW1HFqMyRQaRK0ZmJSpVYF7BWh071P78X8vyV/Wb8q4rGVVRa8ziq2U91ABZtHt
         Ld21Dz7t7r/no86iZFiBy+0F7mqBXgrR7xYg9tCuU5DZEukz9KB/EvyDA7mGzn/XbDHX
         pdkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=soz1ZCeo2P13LxVdx8c5wQGEcyEgRBivwqGaM4i5AvU=;
        b=shqPp4jruCRW7qNa4aVmEj7ldQsPM3DdVpbSM6wOLAtP0w7I901zfTkqiVTgq4FLUY
         DSabwnpyhPRkVdhvjTPSVa7TA0kwXxUgDE6ZROUcwJekFsJRuvxKlxBpTErSNExYaZ9d
         4ahIKFsuEoWP7aj7Q+ewDO89C1xsdhm1A8vLs0AVIvu58Qo164eOC5l7FGBJnCB8SvLW
         edYr/vC4Ns3kk7A38LnMJ4HwLSaJUqbr6WbRjQOLD2UG+3JsnTY60iHER/NP2SwxnPda
         kVSt1iRjxvwzVhp3UaSEcMDjDMtK5A0qGpPsDeaL+tf5K8/ZTM4R3uav9TLnPUXR042A
         a8QA==
X-Gm-Message-State: APt69E3Y+BpG/2o+pDwRWkRnqNy5kQwYVGKFsRHiyFlnJrC24Wzgh/HK
        uUS9HigyZTkaAiADz0k7o8h/fa3S2eKm//yrMpM=
X-Google-Smtp-Source: ADUXVKIhunIstGKjaNemIV3EG+qUMNC7yg1c4yZ9e4j0647O1qO2M9IR20AqFBxxXiVMMVaqg2ZGQwTe8JAOc1uR4sM=
X-Received: by 2002:a1f:3ec2:: with SMTP id l185-v6mr2194128vka.163.1528873170746;
 Tue, 12 Jun 2018 23:59:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180607051958.759-1-tmz@pobox.com> <20180613031040.3109-1-tmz@pobox.com>
In-Reply-To: <20180613031040.3109-1-tmz@pobox.com>
From:   Luis Marsano <luis.marsano@gmail.com>
Date:   Wed, 13 Jun 2018 02:59:17 -0400
Message-ID: <CAHqJXRHZSGQF9cR8f4N5j8oSRCAoNzXnWLAsGO4witjmHU63ZA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/4] contrib/credential/netrc Makefile & test improvements
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org, Ted Zlatanov <tzz@lifelogs.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 12, 2018 at 11:10 PM Todd Zullinger <tmz@pobox.com> wrote:
>
> This replaces my 2/2 "use in-tree Git.pm for tests" with
> Luis's improved version.  It also adds Luis's fix to ensure
> the proper exit status on test failures and a minor
> whitespace cleanup.
>
> Is it alright to forge your signoff Luis?

Thanks, that's fine.
You should sign-off on those, too: you identified the problems, told
me the solutions, tested them, and deserve the credit.
Moreover, Documentation/SubmittingPatches encourages it.

When the patches are ready, I think we'll need the primary author
(Ted) to acknowledge before the maintainer (Junio) can approve.

> Luis Marsano (2):
>   git-credential-netrc: use in-tree Git.pm for tests
>   git-credential-netrc: fix exit status when tests fail
>
> Todd Zullinger (2):
>   git-credential-netrc: make "all" default target of Makefile
>   git-credential-netrc: minor whitespace cleanup in test script
>
>  contrib/credential/netrc/Makefile                  | 3 +++
>  contrib/credential/netrc/t-git-credential-netrc.sh | 9 +++++----
>  contrib/credential/netrc/test.pl                   | 5 +++--
>  3 files changed, 11 insertions(+), 6 deletions(-)
