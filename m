Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 539531FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 19:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752420AbdBMTvT (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 14:51:19 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:36763 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751476AbdBMTvS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 14:51:18 -0500
Received: by mail-ot0-f194.google.com with SMTP id 36so13264819otx.3
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 11:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=mV8PKVjzipPsYh8K00KUqFqkb9XHRnQ5aqFhJOS4SfM=;
        b=VdyqfB3fMUI2EjCO6lW++72Yz3w2JOyS1+hhR94UHQmPrsfF77vVlE21wC0n5LI9Ka
         9OJHOs3DYWAuH+E/TEAvyLn5dOWjz4auHAasgAR2njvuKl8RMJOyAoBSFC+EAsaythM4
         cyUNFAfebQmZXA9SW4QBmJ6yEcWsVljxikLz6iTd4z6SOk/zH7Yp+hCeqvL4pfKxXzHk
         Gz6XaPm4Y04tk93bNYLvLJXw2P9qEXwmLTf638fmVpf74lXIR0fz3Th8hsTmcZ2KJ61Q
         P9OnDQRF1Om++ECPZcKyAr9MqGSOqDdJsWWVlejfNrxPV2mgl0KUe0lkZbbGBWNAe4tZ
         Zyfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=mV8PKVjzipPsYh8K00KUqFqkb9XHRnQ5aqFhJOS4SfM=;
        b=gBN+oXkmLqiuSJGlFTqwML8mazsihWlouBZznxPKFc9DXjVOGMZ2a6YgvhqCTjICcd
         G+L8g+cQ+DQrAuHOU3GGHXmvw/r0uA6YdykfYYW4QbR9QMR+tvxWEAxDnVVGecc1yAm7
         V3HXJ5M1RMebm3i8itS4s3c2c/vv9AswSVy6OurPNKQpLxaWCxvhfvJMr26o69nDAl7b
         Yw98UOEfkMPhwlukiEIRviWfYpQd74LzX+IIv8isc2sTjLn5RXbcr26Ndw0HEA0LEh2B
         CvAyvoMYxiS8/e8uXDBmfOLyDzmxF7CJ3BrATnRM8/X0/pdC9QIJve8sP5NYIhMk5Eh2
         NCMw==
X-Gm-Message-State: AMke39mgu13bivpIy8fOBp7S8gTfkMM3jgJckP9ot+kvl2YcMxl9UDKlVicok82nrsir3g==
X-Received: by 10.98.90.196 with SMTP id o187mr27609894pfb.30.1487015477368;
        Mon, 13 Feb 2017 11:51:17 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:d0e0:42a7:601f:5154])
        by smtp.gmail.com with ESMTPSA id o125sm16195291pfb.109.2017.02.13.11.51.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 13 Feb 2017 11:51:16 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Cc:     Siddharth Kannan <kannan.siddharth12@gmail.com>,
        git@vger.kernel.org, pranit.bauva@gmail.com, peff@peff.net,
        pclouds@gmail.com, sandals@crustytoothpaste.ath.cx
Subject: Re: [PATCH 2/2 v3] sha1_name: teach get_sha1_1 "-" shorthand for "@{-1}"
References: <1486752926-12020-1-git-send-email-kannan.siddharth12@gmail.com>
        <1486752926-12020-2-git-send-email-kannan.siddharth12@gmail.com>
        <1486752926-12020-3-git-send-email-kannan.siddharth12@gmail.com>
        <vpqbmu768on.fsf@anie.imag.fr>
Date:   Mon, 13 Feb 2017 11:51:16 -0800
In-Reply-To: <vpqbmu768on.fsf@anie.imag.fr> (Matthieu Moy's message of "Sun,
        12 Feb 2017 10:48:56 +0100")
Message-ID: <xmqq1sv1euob.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Siddharth Kannan <kannan.siddharth12@gmail.com> writes:
>
>> +	if (!strcmp(name, "-")) {
>> +		name = "@{-1}";
>> +		len = 5;
>> +	}
>
> One drawback of this approach is that further error messages will be
> given from the "@{-1}" string that the user never typed.

Right.

> There are at least:
>
> $ git grep -n -A1 'strcmp.*"-"' | grep -B 1 '@\{1\}'
> builtin/checkout.c:975: if (!strcmp(arg, "-"))
> builtin/checkout.c-976-         arg = "@{-1}";

I didn't check the surrounding context to be sure, but I think this
"- to @{-1}" conversion cannot be delegated down to revision parsing
that eventually wants to return a 40-hex as the result.  

We do want a branch _name_ sometimes when we say "@{-1}"; "checkout
master" (i.e. checkout by name) and "checkout master^0" (i.e. the
same commit object, but not by name) do different things.

> builtin/merge.c:1231:   } else if (argc == 1 && !strcmp(argv[0], "-")) {
> builtin/merge.c-1232-           argv[0] = "@{-1}";
> --
> builtin/revert.c:158:           if (!strcmp(argv[1], "-"))
> builtin/revert.c-159-                   argv[1] = "@{-1}";

These should be safe to delegate down.

> builtin/worktree.c:344: if (!strcmp(branch, "-"))
> builtin/worktree.c-345-         branch = "@{-1}";

I do not know about this one, but it smells like a branch name that
wants to be used before it gets turned into 40-hex.
