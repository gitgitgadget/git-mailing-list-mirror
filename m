Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39DDC1F406
	for <e@80x24.org>; Wed, 16 May 2018 17:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751642AbeEPRyo (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 13:54:44 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39784 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751468AbeEPRyn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 13:54:43 -0400
Received: by mail-wm0-f68.google.com with SMTP id f8-v6so3837404wmc.4
        for <git@vger.kernel.org>; Wed, 16 May 2018 10:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=VvioFjetXeDFs/aZWmFfLXCIXgfKWvMKnFw5Xvfj13I=;
        b=UgkdZMPjL0hPlna+JWbJe0zC983639qYrMSs8hPyNTKp0GvuFIdeljCac5vYBmIM+X
         9YJkFkuc8LhYdKOKCnrmtrK0gosf89moGbcicHfavHyoPV4Zoq/o/vzP702SLry+xEpS
         coU6QcllHI2Wd2AnJRpAhu9iDHwWZw1S8E4URhJyJB2rDpr53whftDGtJDF2FR3mSgrU
         UzYcEkeCg43xYVwIaBKTqhnx96/A+kxZ8KCmxYh7AQ9yH8PhjZwz5zNjCfrFU71697EX
         +xpEDhbiUEoegPzmr4t4T/SJPbu4Uf6P9i14kQTz5xU24ubAYROnzNWc7mzLmZNgoY2L
         ipwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=VvioFjetXeDFs/aZWmFfLXCIXgfKWvMKnFw5Xvfj13I=;
        b=ZGwFMoc48lFPNFvre4ZoFNvVdFAmhoD/yMhCE9LALOH3lgvkskYSPi1zWj3Xh5frn1
         635z7c6oj6Dk1w4uq64gkLdfVoe7yzg+E8KC4K6QVqHiwtRVib++zRQqGqB6Yhbsc7p9
         4xFtcS1G72LK327aUNwABuq+cvkhkQYxKphNX6A5/0EK7RPGxNENLUQ/+HAjz7E9n5ue
         bM9o0V1ORGUj0leIxCw09eo2D+3OmypsYk7IU3Cl8RovhWlP/rFqTUJQy/yx55i43xmW
         OeuhipbLc9nvW3ej/oFySw3FplBsDV4TLJqDm2Fe8Exrr4gB4UfsFoBJX+VNJFpgfyrx
         To6w==
X-Gm-Message-State: ALKqPwecjSzVX7U9Bm+IZAt0ZvOteBhRqxp+0OWIVlD/Kc14Fmq4DOc9
        fv3g5Ewu4lL26QXcuYOWPjM=
X-Google-Smtp-Source: AB8JxZrRYt8ereg+7fZedxGGmU/Sf+5cXQIbXQ2nfpCXbx9N9xjlB6EyGvbRbSPxlH9C3hYvZuP8lw==
X-Received: by 2002:aa7:c6d0:: with SMTP id b16-v6mr2402126eds.302.1526493282115;
        Wed, 16 May 2018 10:54:42 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id e6-v6sm1528942edr.23.2018.05.16.10.54.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 May 2018 10:54:41 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: worktrees vs. alternates
References: <A33442B1-B37D-42E1-9C58-8AB583A43BC9@gmail.com>
        <87po1waqyc.fsf@evledraar.gmail.com>
        <81B00B00-00F4-487A-9D3E-6B7514098B29@gmail.com>
        <87muwzc2kv.fsf@evledraar.gmail.com>
        <fc2f1fdf-222f-aaee-9d58-aae8692920f5@gmail.com>
        <0f19f9f8-d215-622e-5090-1341c013babc@linuxfoundation.org>
        <87k1s3bomt.fsf@evledraar.gmail.com> <20180516154935.GA9712@chatter>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180516154935.GA9712@chatter>
Date:   Wed, 16 May 2018 19:54:40 +0200
Message-ID: <87in7nbi5b.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 16 2018, Konstantin Ryabitsev wrote:

> On Wed, May 16, 2018 at 05:34:34PM +0200, Ævar Arnfjörð Bjarmason wrote:
>>I may have missed some edge case, but I believe this entire workaround
>>isn't needed if you guarantee that the parent repo doesn't contain any
>>objects that will get un-referenced.
>
> You can't guarantee that, because the parent repo can have its history
> rewritten either via a forced push, or via a rebase. Obviously, this
> won't happen in something like torvalds/linux.git, which is why it's
> pretty safe to alternate off of that repo for us, but codeaurora.org
> repos aren't always strictly-ff (e.g. because they may rebase themselves
> based on what is in upstream AOSP repos) -- so objects in them may
> become unreferenced and pruned away, corrupting any repos using them for
> alternates.

Right, it wouldn't work in the general case. I was thinking of the
use-case for doing this (say with known big monorepos) where you know a
given branch won't be unwound.

Still, there's a tiny variation on this that should work with arbitrary
repos whose master may be rewound, you just setup a refspec to fetch
their upstream HEAD into master-1 without having "+" in the
refspec. Then if they never rewind you keep fetching to master-1
forever.

If they do rewind you fetch that to master-2 and so forth, so you can
follow an upstream rewinding branch while still guaranteeing that no
objects ever disappear from your parent repo. This is still a lot
simpler than the juggling approach you noted, since it's just a tiny
shellscript around the "fetch".

This assumes that:

  1. Whenever this happens the history is still similar enough that the
     parent won't balloon in size like this, or at least it won't be
     worse than not using alternates at all.

 2. You're getting most of the gains of the object sharing by just
    grabbing the upstream HEAD branch, i.e. you don't have some repo
    with huge and N unrelated histories.
