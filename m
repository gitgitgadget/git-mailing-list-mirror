Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DC371F403
	for <e@80x24.org>; Sat,  9 Jun 2018 08:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753224AbeFIIui (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 04:50:38 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:40554 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753116AbeFIIuh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 04:50:37 -0400
Received: by mail-pg0-f67.google.com with SMTP id l2-v6so7439503pgc.7
        for <git@vger.kernel.org>; Sat, 09 Jun 2018 01:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=n8LaWcnzxLkg1jE0U62BLqm/Sv5yeS0t65SfSX3EE3E=;
        b=VJQeWN4i8Ag0PAm/BxSr/0ZX6oBs94XLKqHYiufvQYhrpYEJETVLJwvN5Yj20sBiVH
         KvbAKHgjlvANCaXGyrqDQ8kcKbjynhJL43EVMkeZrFIfertIpBbp1gtoDxqdj/eq9CBJ
         kt7zetjuv4DBBErCW5YFngPde/cvLL5o8WhBGM8O2xuws6YuwgJ8yJh2CrhVLjPq4NK3
         boydACpuSZYJZztZOyRcU8eptTzEvHg5JgMDhCerHs2hRfmZqahP69hefNOCQ2uRVhid
         8/1FxpQnpyOz15uG8ecIOt+yRnT9zOVoUs0wHXFI/Yr0QfLxFZx0fZARgjjGpYY24zRZ
         jj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=n8LaWcnzxLkg1jE0U62BLqm/Sv5yeS0t65SfSX3EE3E=;
        b=iA/YjN7S8pVr3a4z3FwrLWXdTyiK6GEYRBBxWIP0EZSe9iw3fMEY0RVK79AuxPa5Wi
         DJt5KBTdMHNUgiAW2GGhzzJIjNnctOTxfwkb3smzbxv20a1esvCT+y9zt2XXZUmAUM92
         ur0FK9GmveykuaAGmDu4B37ic2fxzXcehSK+LkOjFGpBDcOEcNE1GbNSRW5NQdzu1mBj
         2ShEqSKyKMZehvQEkD8FMOJslXltQ3IjMr+zRmtg2YvqzWxJntd+JW6P2xP+3Iyebopx
         y0OzEQnBxk4iPHQcn8BF6PBLYBIAoY+KeAqWO8lPRJpnElFKP/cx99ZPK8YvpDVdh/D0
         Tylg==
X-Gm-Message-State: APt69E1oOhGbqrKei393BUcuJwioYIiLqx08aYeLiKUO0ijIaSh8VM+g
        RFOsLW1fBOYltDF+/lafQi+gwHYeGU8nuU60cX6nBA==
X-Google-Smtp-Source: ADUXVKJfl/E+YHWPExN10YAvE/7WiD8sv2pSG3RQbp6Mcxa3Sdfe/TVOAVuS7etRZ0/I0eGRxairxX1l6U5l64DAX8o=
X-Received: by 2002:a62:da59:: with SMTP id w25-v6mr9375656pfl.161.1528534237016;
 Sat, 09 Jun 2018 01:50:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:760e:0:0:0:0 with HTTP; Sat, 9 Jun 2018 01:50:36
 -0700 (PDT)
In-Reply-To: <20180609083159.GA6158@sigill.intra.peff.net>
References: <20180609083159.GA6158@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 9 Jun 2018 10:50:36 +0200
Message-ID: <CAN0heSqHRpOerHV8tgA-ntU6QvYQMxgrXPCPsrVcHLKUSwANXQ@mail.gmail.com>
Subject: Re: [PATCH] fsck: avoid looking at NULL blob->object
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9 June 2018 at 10:32, Jeff King <peff@peff.net> wrote:
> Except it _does_ do one non-trivial thing, which is call the
> report() function, which wants us to pass a pointer to a
> "struct object". Which we don't have (we have only a "struct
> object_id"). So we erroneously passed the NULL object, which

s/passed/dereferenced/? Probably doesn't affect the fix though.

> ends up segfaulting.

>                 blob = lookup_blob(oid);
>                 if (!blob) {
> -                       ret |= report(options, &blob->object,
> +                       struct object *obj = lookup_unknown_object(oid->hash);
> +                       ret |= report(options, obj,
>                                       FSCK_MSG_GITMODULES_BLOB,
>                                       "non-blob found at .gitmodules");
