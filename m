Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BD5B1F453
	for <e@80x24.org>; Thu,  1 Nov 2018 22:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbeKBHSl (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 03:18:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43471 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbeKBHSl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 03:18:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id t10-v6so5165wrn.10
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 15:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=1ZFVta9dzrdR6IqPKT4cO6sz7twCJmouFfMgysHP24s=;
        b=ljkBb2UhQwcU1gUtTGhjl8LDtFhbL6ssno3KUM7zbze6SI5UUguHS0LXtt7dWW6r3g
         zHfDvGpbWodhO5S3hMWQveZbO8rrrUKe3dgKl8DAE49Vz96Ell2kNkvHvxhCEyS098th
         A190/KtyK7w0f2JXgTgooHeEKrQ7XTCf4e7/kX1HPaFFL2GnExPiX/H9EBhABuUYN3Vq
         OnzsBFxkEkKENsMXX8N30vlBpzgChS+41QvHJNRdPPCLQT8CbSAg3E2N57wZbGW7h2ga
         vMPDPDeobGrRFz/c+6Nh25plvVwt8F0aLRd+7uhT1EPRWToa8gcS5FrYVbRvWgOvtoj3
         lTbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=1ZFVta9dzrdR6IqPKT4cO6sz7twCJmouFfMgysHP24s=;
        b=UD0xMUuznGHhuI+yJ/kvZIcZR/vObOxd8Lp8DAu2QEgOcrb9rVKZYx2GKjXPEE6aLb
         RYnovVaDiDoP0XJO+nfr9FkZl7yKY5wuDdcKRFFcbDtB2fCwECVmx7uO7zrhn2tE4B0B
         ZhJjPt/zAHBtKZfcR2nU5biWlZQv8Apbg4O99um+HI5bZa/rZLmd8NVR1SYFMnv4Il7d
         9wnXsLocObalYJtr++Mq8Tfei7rFbBBMfq/WetpYCzw9HGsWdjt6ORdCuIxdgWJpUuIB
         VvWG4AVNPCcXRHFi89JWKVz26I3GX6N+CUlRKP1jsd7h268I+QbSO3bxiOxcazQa5EC3
         X7QA==
X-Gm-Message-State: AGRZ1gITEQ0Gv0kVQqqwIlMYVBpJ4FRsmX+Hn6wDlYlQsl5svEv3tbQh
        Bv8+5MHGusdkVp/DgNC4ioiTLvbK
X-Google-Smtp-Source: AJdET5cQwNgdHXHgnICS5cuA/PPLCY/guTZq3VodDF5QJibsKDk95K/GutPZgi8AYirrI0lY0DjtiQ==
X-Received: by 2002:adf:9d4a:: with SMTP id o10-v6mr5275119wre.94.1541110426687;
        Thu, 01 Nov 2018 15:13:46 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (ekn166.neoplus.adsl.tpnet.pl. [83.21.181.166])
        by smtp.gmail.com with ESMTPSA id l9-v6sm13921161wrf.4.2018.11.01.15.13.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 15:13:45 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [RFC] Generation Number v2
References: <6367e30a-1b3a-4fe9-611b-d931f51effef@gmail.com>
        <3576719c-3cfb-547a-3548-3aaebfe6e8a2@gmail.com>
Date:   Thu, 01 Nov 2018 23:13:42 +0100
In-Reply-To: <3576719c-3cfb-547a-3548-3aaebfe6e8a2@gmail.com> (Derrick
        Stolee's message of "Mon, 29 Oct 2018 16:25:40 -0400")
Message-ID: <86o9b8zbs9.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> Here is a re-formatted version of the tables I introduced earlier.
> The tables were too wide for public-inbox to render correctly (when
> paired with my email client). Hopefully this bulleted-list format
> works better. Thanks, Stefan, for pointing out the rendering
> problems!
>
> ### Test 1: `git log --topo-order -N`
>
> This test focuses on the number of commits that are parsed during
> a `git log --topo-order` before writing `N` commits to output.
>
> You can reproduce this test using `topo-order-tests.sh` and
> see all the data in `topo-order-summary.txt`. The values reported
> here are a sampling of the data, ignoring tests where all values
> were the same or extremely close in value.
>
> android-base, N =3D 100
> =C2=A0=C2=A0=C2=A0 V0: 5487
> =C2=A0=C2=A0=C2=A0 V1: 8534
> =C2=A0=C2=A0=C2=A0 V2: 6937
> =C2=A0=C2=A0=C2=A0 V3: 6419
> =C2=A0=C2=A0=C2=A0 V4: 6453
[...]

> ### Test 2: `git log --topo-order -10 A..B`
[...]
> android-base 53c1972bc8f 92f18ac3e39
> =C2=A0 OLD: 39403
> =C2=A0=C2=A0 V0:=C2=A0 1544
> =C2=A0=C2=A0 V1:=C2=A0 6957
> =C2=A0=C2=A0 V2:=C2=A0=C2=A0=C2=A0 26
> =C2=A0=C2=A0 V3:=C2=A0 1015
> =C2=A0=C2=A0 V4:=C2=A0 1098

Two minor issues.  First, now that the data is not in the table format,
where every bit of horizontal space matters, why not spell the names of
new proposed "generation numbers" (or rather reachability orderings) in
full, instead of using V0...V4 shortcuts?  It is not as if we were short
of space.

Second, why OLD data is present in tests 2 and 3, but not in test 1?

Best,
--=20
Jakub Nar=C4=99bski
