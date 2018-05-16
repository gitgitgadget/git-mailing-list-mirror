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
	by dcvr.yhbt.net (Postfix) with ESMTP id EFC191F406
	for <e@80x24.org>; Wed, 16 May 2018 18:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751307AbeEPSC4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 14:02:56 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:52121 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751110AbeEPSCy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 14:02:54 -0400
Received: by mail-wm0-f49.google.com with SMTP id j4-v6so3626322wme.1
        for <git@vger.kernel.org>; Wed, 16 May 2018 11:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=Mo4ABGXABvfx/LGQov46mr1lbS8H9mxFKgXFn4Wt4HQ=;
        b=OZ8aGEt1DtcDNhabdtalTNrsYiagwld29dNaPl+W7cW5T8hcFl9caAqssYTuHyyL8K
         vN6dT54Y0Icd33RWg6N9EYTGGMTmsavG57YprG7UnO+xHNRABA1oifxUVesfCVLJD109
         elpcFmcWm9fLYfd9pHJGbNZD7bLQHYC15ps9+JAnjqbxvbaJjT5bJg+/ZDUh5n8esYRp
         8UpD9QzK0gSOaGGxQjtsHhPnkxgxlu9zh+7tzhoI2EHLPM8vphEbnhM/fkbffZYbSwPd
         E2nLZocaiDjlSFEv76s99ZT6clR95KIeyVgD0QL7NnnKvZV3fVmvuYzEkbf2spN4JEI0
         R7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=Mo4ABGXABvfx/LGQov46mr1lbS8H9mxFKgXFn4Wt4HQ=;
        b=YJbesuaeP6sqx7hD6A8SWDLZmmNIWb4QYB9fbqwuzzhMAEMj5sdvQ5Tp3nkSlGR9R+
         CzDilADyCNqfYBB/IyR25/o4LUhenw48nJbZ650Lgv4pKFWc853uNtrr4e+BT828ybqD
         Dnhru2aq3r22eHBFJ0IwJRizJvT/1Y3o1bfXOvQvqmHUVWZ/mtJbh7aNW7o3CygbNk7N
         sZlaAZjXKxyn9Dg2YgPoZv63Jh0HdcOIf79T4orKwXuerh8/lLkiRh6UDXHw3AG+aeaL
         W+bRgMbY8TmldwMf2kwXVUFhgY+VCw/6jFOgTcplJT6Sde6LRNtbyJCdozSOoEcVHosK
         gN7A==
X-Gm-Message-State: ALKqPwcPOO036juCc3GXLE/7SJi/dZLrLIeNt+Z1lztVcjdeQgYPNi7e
        7XeROcjIsegOEANEubo4sX0=
X-Google-Smtp-Source: AB8JxZpgoJHQspnYLT8e8KbBX0XbQMum5d8MqLV7wiKAFzdk0VJImDedUJhwyKXMZ2mOBA7J4VgCQA==
X-Received: by 2002:a50:ee8c:: with SMTP id f12-v6mr2595936edr.10.1526493773804;
        Wed, 16 May 2018 11:02:53 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id q35-v6sm1657169edq.41.2018.05.16.11.02.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 May 2018 11:02:52 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Martin Fick <mfick@codeaurora.org>,
        Derrick Stolee <stolee@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: worktrees vs. alternates
References: <A33442B1-B37D-42E1-9C58-8AB583A43BC9@gmail.com>
        <fc2f1fdf-222f-aaee-9d58-aae8692920f5@gmail.com>
        <0f19f9f8-d215-622e-5090-1341c013babc@linuxfoundation.org>
        <5972145.OdP4kjFpBj@mfick-lnx>
        <099ff2bf-c0f8-60fc-7833-9b129dd4dffe@linuxfoundation.org>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <099ff2bf-c0f8-60fc-7833-9b129dd4dffe@linuxfoundation.org>
Date:   Wed, 16 May 2018 20:02:51 +0200
Message-ID: <87h8n7bhro.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 16 2018, Konstantin Ryabitsev wrote:

> Maybe git-repack can be told to only borrow parent objects if they are
> in packs. Anything not in packs should be hardlinked into the child
> repo. That's my wishful think for the day. :)

Can you elaborate on how this would help?

We're just going to create loose objects on interactive "git commit",
presumably you're not adding someone's working copy as the alternate.

Otherwise if it's just being pushed to all those pushes are going to be
in packs, and the packs may contain e.g. pushes for the "pu" branch or
whatever, which are objects that'll go away.
