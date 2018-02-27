Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68A381F404
	for <e@80x24.org>; Tue, 27 Feb 2018 22:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751927AbeB0WIa (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 17:08:30 -0500
Received: from mail-yw0-f182.google.com ([209.85.161.182]:35177 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751853AbeB0WI3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 17:08:29 -0500
Received: by mail-yw0-f182.google.com with SMTP id d205so148036ywe.2
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 14:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QgfhTP/1cthsx+BWQcJG2cq6Eja787Ot9C/LIcDVeGo=;
        b=lfTiubchG6zSHgKdLmVBEes8z5nI7RCYUyBAnygt2YIjAnW34XtVGC6YiVM8dVkMpx
         CGpOVo07EvGBZRwsaZm+sjF5VOFc/lvYsJrF/IAF8CkCesV/XY+aWaZ5PCvOngNiXEic
         OL0BnZPbPL5f/+RHtgfoiL3BnxX7/gX3KaEanXg7t4A0D2NJZSaRc7yMIBU0Y/ZYB8j5
         VZEQew0WEnKM/85MHZLtSiC9J1cXxc+6fWxSPvXvL2eFrpPaf3r1WrKSQ1XtZdpMta+i
         +Ctpg9piw2kB8tGPONnLlv7P3Ox7Gnkxszh92E1bcDGsrwu2ZQfLoRt/bS93twVH7V/5
         Oilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QgfhTP/1cthsx+BWQcJG2cq6Eja787Ot9C/LIcDVeGo=;
        b=LFmz9yS3JHysdWLN38g6sxZB/UOALvB//yrwNw5BjXnu3iBI9sabyHI/bA7V6tBhOQ
         us1qyiEfcFetyppR6HIIFKpU31c5Zha0O+HuxnAiPlJcyqrWWpYvoCBhF0/7AI+CmMxx
         9BnAdyzmv0dt8Ye4peBdUlC/qTbo79+aBVVKnbPpBY4XM/mbZEJioHeActyzShxgGlrW
         SMl89ERJZexW9tZ5B9A25XbZEA5mb90gnBavJlPummv6Td2WnYW7q1km7UvePJkqv5VJ
         aqHXswJODhudh79acj4T4OaQUFHqUPi37NEJ83fuv5K/SKgY0hq6jvPE6QmagXAoiOwb
         Z72Q==
X-Gm-Message-State: APf1xPDFWrIZsoFKCEazXmQf/n/E+84W0GRuf6PL+VnodiCSdmfnSGnM
        j7dwVFvELikBJvwK5oulcdVphpI5O6ezmQHkDHuqow==
X-Google-Smtp-Source: AH8x224IuZMoc0JrrR+biBX2qvNllOdsZ6qPzy0luZbvLHQvTkhjLxD30rCpg8Ni1731O/gjsrSCLWt1x3+u8XVfsvk=
X-Received: by 10.129.25.214 with SMTP id 205mr10687440ywz.340.1519769308184;
 Tue, 27 Feb 2018 14:08:28 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Tue, 27 Feb 2018 14:08:27
 -0800 (PST)
In-Reply-To: <efc4af6b-53c9-bd02-65f6-9de517f6868e@linuxfoundation.org>
References: <efc4af6b-53c9-bd02-65f6-9de517f6868e@linuxfoundation.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 27 Feb 2018 14:08:27 -0800
Message-ID: <CAGZ79kbJawTH6bPWC+4is+okTf7ZRN5U68JZgOy8EFvaZOtF5g@mail.gmail.com>
Subject: Re: Is offloading to GPU a worthwhile feature?
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 27, 2018 at 12:52 PM, Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
> compression offload

Currently there is a series under review that introduces a commit graph
file[1], which would allow to not need decompressing objects for a rev walk, but
have the walking information as-needed on disk.

Once walking (as part of negotiation) is done,
we'd have to pack a pack file to return to the client,
which maybe can be improved by GPU acceleration[2].

Though once upon a time Junio had proposed to change
this part of the protocol as well. Instead of having a packfile
catered to a specific user/request, the server would store
multiple pack files, which are temporally sorted, e.g.
one "old" packfile containing everything that is roughly older
than 4 weeks ago, then a "medium pack file" that is up to last
weekend, and then a "new" pack that is just this weeks work,
followed by the on-demand pack that is just the latest
generated on the fly.

The server would just dump these different packfiles
(concatenated?) at the user, and would need to refresh
its packfiles occasionally every week or so.

[1] https://public-inbox.org/git/1519698787-190494-1-git-send-email-dstolee@microsoft.com/
[2] http://on-demand.gputechconf.com/gtc/2014/presentations/S4459-parallel-lossless-compression-using-gpus.pdf


> I realize this would be silly amounts of work. But, if it's worth it,
> perhaps we can benefit from all the GPU computation libs written for
> cryptocoin mining and use them for something good. :)

Currently there is work being done on "protocol v2"[3], which
is also motivated by the desire to have easy extensibility in the protocol,
so if you want to put in a cryptocoin-secret-handshake [into the protocol]
that improves the cost of compute or the bandwidth required for your
typical use case, it will be possible to do so with ease.

[3] https://public-inbox.org/git/20180207011312.189834-1-bmwill@google.com/

I wonder if the bitmap code can be sped up using GPUs. Every once in a while
the discussion floats up bloom filters or inverse bloom filters for
the negotiation
part, and a quick search shows that those could also be sped up using GPUs.

Stefan
