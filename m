Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 206701F453
	for <e@80x24.org>; Tue,  2 Oct 2018 22:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbeJCFOc (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 01:14:32 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36187 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725198AbeJCFOb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 01:14:31 -0400
Received: by mail-ed1-f65.google.com with SMTP id f4-v6so3573301edq.3
        for <git@vger.kernel.org>; Tue, 02 Oct 2018 15:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JB4TPIMhwdkapOChzaI2KxDdkkTkQvdPOxGCkIdWq6A=;
        b=suchoT0auaNHLE9oh1fzO2WHbLMfFVNG7obt9U43NqwtS0MoYsk8MMajQP4xtoyxd7
         3K+GFJuqX7X0jd1ufzWzOjDqPorLHidQwi+XG5WvjwD8b2dXDMJTgr0lVmRFlMhFU33y
         DMCbPhzZ3TyqSylsAuJhW6+m0QHb2hd9/UwDTb3s+7a3pyMYyJOzs6H7YnOerpOl+Huk
         QDAqRnA8umg7+IKyXhQJtQG0g7N6YO9V6wzLBMYbvf5jilgQNmUybCvjdWn476Q/+X8D
         VcCOguvmnfDmuDsmZiJszV5u423CsjUquR1D4MUsNXCU2aL+nt7v6rV5sZRPC+xpmYop
         BoYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JB4TPIMhwdkapOChzaI2KxDdkkTkQvdPOxGCkIdWq6A=;
        b=bxfCuy9jdwguEy58zG+MO6l+jMMCZT30+gf87AGg6tdMh23bV94CmXxTIOmM+cZ71E
         UzQGKcrV/DqBB1mW/Q4prQLSIdOFlFOG1ixxufRgHXtJD5+lm7BscODs1sV5rLLyNbSY
         +7goquegNVvXCa6WCRE0/Rq5RJnYM72GRXU/u1/KUcTOs9ciU8qyicBNHI1WrPygXSsV
         oP+0hd+/1i692wAJUBGfmyZtlGT9kNAyGddqzX3drj7GVWAJkS1WL8q8VXuLvm2SAnvq
         pa9tuw6Yr1HbI1H2uhIWKFdu2i1xSjXZO0w3N7tKudwyfOntgzgg4TdUPd7zTLmFXBYh
         ky3Q==
X-Gm-Message-State: ABuFfoiRMBrqRBtx2cKa93lsxjx/Eh2H9NmZW9E3ORspsS9XqV8V85ud
        wFxgVVLgWBHgH/4WzSnSX9fr/s64HucKjE1xTwLBkg==
X-Google-Smtp-Source: ACcGV63bUysLuRV3eqr/rI/0PTjzJnfENrCxxgTy2t3b2vvVb+M8cDIBC1pgYHthaa+wP+X/kKzIkinAxzIwI6N0IDQ=
X-Received: by 2002:a17:906:2da9:: with SMTP id g9-v6mr4047055eji.67.1538519332663;
 Tue, 02 Oct 2018 15:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1538516853.git.steadmon@google.com> <59357266bd86e8e0ace9217a97717129a6f76188.1538516853.git.steadmon@google.com>
In-Reply-To: <59357266bd86e8e0ace9217a97717129a6f76188.1538516853.git.steadmon@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 2 Oct 2018 15:28:41 -0700
Message-ID: <CAGZ79kbD=P__8GU9rV87wREF_MbQA9i2ij6C2qXyaJfqHD3Szg@mail.gmail.com>
Subject: Re: [PATCH 1/1] protocol: limit max protocol version per service
To:     Josh Steadmon <steadmon@google.com>
Cc:     git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 2, 2018 at 3:00 PM Josh Steadmon <steadmon@google.com> wrote:
>
> For services other than git-receive-pack, clients currently advertise
> that they support the version set in the protocol.version config,
> regardless of whether or not there is actually an implementation of that
> service for the given protocol version. This causes backwards-
> compatibility problems when a new implementation for the given
> protocol version is added.
>
> This patch sets maximum allowed protocol versions for git-receive-pack,
> git-upload-archive, and git-upload-pack.
>
> Previously, git-receive-pack would downgrade from v2 to v0, but would
> allow v1 if set in protocol.version. Now, it will downgrade from v2 to
> v1.

But does git-receive-pack understand v1?
As to my understanding we have not even defined v1
for push (receive-pack) and archive --remote (upload-archive).
v1 is only known to fetch (upload-pack).

> +enum protocol_version determine_maximum_protocol_version(
> +               const char *service, enum protocol_version default_version)
> +{
> +       if (!strcmp(service, "git-receive-pack"))
> +               return protocol_v1;
> +       else if (!strcmp(service, "git-upload-archive"))
> +               return protocol_v1;

so I would think these two would be _v0.
... goes and checks ...
aa9bab29b8 (upload-pack, receive-pack: introduce protocol version 1,
2017-10-16) seems to actually teach v1 to receive-pack as well,
but upload-archive was completely off radar, so I think returning
(v1, v0, v2 in the order as in the code) would make sense?

Asides from this, I thought there was a deliberate decision
that we'd want to avoid a strict order on the protocol versions,
but I could not find prior discussion on list to back up this claim. :/

For example we'd go with e.g. enums instead of integers
for version numbers, as then some internal setup could
also have things like protocol_v2018-10-02 or protocol_vWhatever;
some protocol version may be advantageous to the client, some to
the server, and we'd need to negotiate the best version that both
are happy with. (e.g. the server may like version 0, 2 and 3, and
the client may like 0,2,4 as 3 is bad security wise for the client,
so both would negotiate to 2 as their best case)

From a maintenance perspective, do we want to keep
this part of the code central, as it ties protocol (as proxied
by service name) to the max version number?
I would think that we'd rather have the decision local to the
code, i.e. builtin/fetch would need to tell protocol.c that it
can do (0,1,2) and builtin/push can do (0,1), and then the
networking layers of code would figure out by the input
from the caller and the input from the user (configured
protocol.version) what is the best to go forward from
then on.

But I guess having the central place here is not to
bad either. How will it cope with the desire of protocol v2
to have only one end point (c.f. serve.{c,h} via builtin/serve
as "git serve") ?

Stefan
