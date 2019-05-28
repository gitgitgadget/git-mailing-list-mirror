Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98E161F462
	for <e@80x24.org>; Tue, 28 May 2019 23:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbfE1XCR (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 19:02:17 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35923 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727587AbfE1XCR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 19:02:17 -0400
Received: by mail-wr1-f65.google.com with SMTP id s17so307510wru.3
        for <git@vger.kernel.org>; Tue, 28 May 2019 16:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=l+EhfS69FVvD2Jjh242ZgBaeIS5c9yBbi4WmmhX754M=;
        b=LE0rhrfOp33fRlKzvSRkaHy8JWGAyCtcNiGDpRuZW3ycBDkOz9JlpVP5ZNATQObrFF
         5gbGkKwWzOesSCJ4RAuKXmjVY5WGHIM+86Plpn9nXmL/oYYFh3vJUWvos95XpUd9sD+C
         fE4TUAlh5/u2ZJMPC+xEO9NOPmXzLotNsofatSFdu8r6MsJky8T71n6G1lOFkm2iYkuU
         n3IKLgzmTubK8WyylCco9/WofYzbmS2jdB8b18LE/fLVoIvE55sjy+DDucmB0aK0cTfq
         jHeMW6NPjTKkotrC4Jgw4HLq4ZJdS6PRBDfnrKtTbkrzHvFcNeTb5QaanUZR86tx3jyI
         3IxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=l+EhfS69FVvD2Jjh242ZgBaeIS5c9yBbi4WmmhX754M=;
        b=R7L1D9uuebaSOXKqidB5B1kYvP/qN4Tt+sCGlpXJKuOMcECBO+hps1vho+rGCxeVNP
         B6qWp/jOcv6xgsX7sf6x6zEufFb8wumBFSRAS0ZKbOmn6+C8L6zbDKlgExux7kj/5ajC
         t2fCpGUJLzoKvE+dwm+SnQS8fvcQmqlu2kxEuLWABR0Cf0fqtAq2LbANhK+acprrwJQr
         YqxgTfOOz7kifJ1172FbnZzs5d1/0befQe8d5pCb7JD1yJVtMgXH+D/+q0uIf6ettvS0
         drzCiGkpvGO3AlLdYBuPplKLNJ4hOm0w3qpKPTAlrJAuz1KtxvH+Ja1Fc2XLto2DAfFl
         KHVQ==
X-Gm-Message-State: APjAAAULxoEh7NuwzfBEHUi6ZxkEpgSDe/ojhI8cVp/IgiCq5bDAePCW
        9xMCVciswVRsA+xiHncIQBuuwnmi
X-Google-Smtp-Source: APXvYqwmxmStxD+8U2sJV7Gp9BV+r4LQ2tJfAxwywl2gvKNhllwDO6+XqE+Y8O+maI8NxkxFfPrk5Q==
X-Received: by 2002:a5d:4a8d:: with SMTP id o13mr3033541wrq.350.1559084535708;
        Tue, 28 May 2019 16:02:15 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id z5sm3992206wma.36.2019.05.28.16.02.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 16:02:13 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>, git@jeffhostetler.com,
        git@vger.kernel.org
Subject: Re: [PATCH 1/2] trace2: rename environment variables to GIT_TRACE2*
References: <20190510211502.GS14763@szeder.dev> <20190519144309.9597-1-szeder.dev@gmail.com>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190519144309.9597-1-szeder.dev@gmail.com>
Date:   Wed, 29 May 2019 01:02:12 +0200
Message-ID: <87blzmmbd7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, May 19 2019, SZEDER G=C3=A1bor wrote:

> For an environment variable that is supposed to be set by users, the
> GIT_TR2* env vars are just too unclear, inconsistent, and ugly.
>
> Most of the established GIT_* environment variables don't use
> abbreviations, and in case of the few that do (GIT_DIR,
> GIT_COMMON_DIR, GIT_DIFF_OPTS) it's quite obvious what the
> abbreviations (DIR and OPTS) stand for.  But what does TR stand for?
> Track, traditional, trailer, transaction, transfer, transformation,
> transition, translation, transplant, transport, traversal, tree,
> trigger, truncate, trust, or ...?!
>
> The trace2 facility, as the '2' suffix in its name suggests, is
> supposed to eventually supercede Git's original trace facility.  It's
> reasonable to expect that the corresponding environment variables
> follow suit, and after the original GIT_TRACE variables they are
> called GIT_TRACE2; there is no such thing is 'GIT_TR'.
>
> All trace2-specific config variables are, very sensibly, in the
> 'trace2' section, not in 'tr2'.
>
> OTOH, we don't gain anything at all by omitting the last three
> characters of "trace" from the names of these environment variables.
>
> So let's rename all GIT_TR2* environment variables to GIT_TRACE2*,
> before they make their way into a stable release.

Good to see this land in 2.22.0. I wonder if we shouldn't take this
further and rename trace2.* config to trace.*, and just re-use
GIT_TRACE=3D1 instead of having GIT_TRACE2 as well, and have a
GIT_TRACE_VERSION to switch between them.

Then we could just switch in a future version. We've never promised what
the trace format was going to look like, and the existing one isn't
configurable (and we won't be making the v1 one...), so starting from
the outset with "2" in config is unfortunate.

We'd still have special snowflakes like e.g. GIT_TRACE_PACKET.

OTOH we can just do this after the release if it's deemed a good idea,
and just support trace2.* as aliases for trace.* for some amount of
time, same for the env vars.
