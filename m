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
	by dcvr.yhbt.net (Postfix) with ESMTP id D45341F462
	for <e@80x24.org>; Fri, 24 May 2019 11:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391107AbfEXLRL (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 07:17:11 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37490 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391105AbfEXLRK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 07:17:10 -0400
Received: by mail-wr1-f66.google.com with SMTP id e15so9615612wrs.4
        for <git@vger.kernel.org>; Fri, 24 May 2019 04:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=YcUn0Hr8pHdl5jJZNx0Dch6KsW2RGJV35mf4/SxSaXM=;
        b=T++8Ev2C7k/ygkx/Z1ScXI4TLTY7dFxn1sQBLxNBnfrHVd2xRGt+pRAyTqsqlQKiCc
         gPft+3R2tA5J1iFE7uICu5bSH959PoQZSGwz7YKifeEF9754qHHrLlKSj9J00Wxuv6lR
         3qsexFgMyz74cTYO/kE5qZqOo4jA73/I6FFxvvCimnYl1NNdQMtgJde9L3/pCddI3bzk
         HDjjX40uC0NmwEKXwh3AM8n6LrwdSJnBwcl90XwRC8B56fFbea7XjK9hgMwo/Qojp+ZY
         3B/NDrsQ80fhiaI6On5KwfM9SdrbacVK0Zs/wt8c46/j1P+zvtVI3J5Hl6qQf2mJSyep
         1VBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=YcUn0Hr8pHdl5jJZNx0Dch6KsW2RGJV35mf4/SxSaXM=;
        b=mEDl9pPVoQ6RCYEPUNaParXADY8bAFuI9BkVgrjrKKDhfDLCEnXMLYX3cUxR3839aX
         8XnpDs21LmplYbXGLgvKHyivdRNGr/vTAbWxA/Tn7FPxpRa/Yj5cof3zHC/ltqBWnh0u
         M2+FPs7XZudUH7o0j5eMn8hDIJbcxK6/1EYIeXlZje4lKbSo1oKSU6jr+DccP4/5EI5+
         MzItOAjURjYoupHbbnOgAjlGqqhd0TScIqZqrMPWQWECLd8AqVynlP5FlsW0nXTERDt/
         8iOUUv4qS8EzF0rd4LJHRMsC2Oq2MAJ6PG8lMWW7CM1io9gMCatH1Iy/dMo2Paw3uqD2
         /49A==
X-Gm-Message-State: APjAAAWYXghSP73DVpfzhX+IaOnw1AL2Y0RSxzJRZx/2hjiJ7M/px55y
        Kkj94ZDB0GofGJURnDO5fpenWn6nQ9w=
X-Google-Smtp-Source: APXvYqzh/kWptelUEtNAq3Two5wRgYM62QJy1ke0xUswEqAREipYXgV8ZYQ4pAFwq68kX9bRJB3Mtw==
X-Received: by 2002:a5d:6b03:: with SMTP id v3mr3157143wrw.309.1558696628613;
        Fri, 24 May 2019 04:17:08 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id t13sm4164536wra.81.2019.05.24.04.17.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 04:17:07 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Jeff King <peff@peff.net>, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        git@vger.kernel.org
Subject: Re: [PATCH v3] repack: enable bitmaps by default on bare repos
References: <20190313145417.GA24101@sigill.intra.peff.net> <20190314091254.nescpfp3n6mbjpmh@dcvr> <87zhoz8b9o.fsf@evledraar.gmail.com> <20190410225721.GA32262@sigill.intra.peff.net> <20190523113031.GA17448@sigill.intra.peff.net> <87tvdlt1jp.fsf@evledraar.gmail.com> <20190524072724.GH25694@sigill.intra.peff.net> <87r28offs6.fsf@evledraar.gmail.com> <20190524082605.GB9082@sigill.intra.peff.net> <87pno8fcp8.fsf@evledraar.gmail.com> <20190524092920.GD951@szeder.dev>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190524092920.GD951@szeder.dev>
Date:   Fri, 24 May 2019 13:17:06 +0200
Message-ID: <87imu0f6fh.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, May 24 2019, SZEDER G=C3=A1bor wrote:

> On Fri, May 24, 2019 at 11:01:39AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> I don't think it's a performance problem to have an old commit-graph
>> lying around. But if you turn on the commit-graph, run gc a bunch, then
>> turn it off in config we'll have it lying around forever, even if you do
>> subsequent gc's.
>>
>> So I think we should delete such things on the general principle that
>> the end-state of a gc's shouldn't be the accumulation of the values of
>> past configuration options if we can help it.
>>
>> Maybe that screws over other users who did a "commit-graph write"
>> without setting gc.writeCommitGraph, but I think the only sane thing to
>> do is to make "gc" fully 'own' such things if its turned on at all.
>
> Note that there is 'core.commitGraph' as well; as long as it's
> enabled, no commit-graph files should be deleted.

Why? If we won't update it or write it if it's not there, why keep it
around?

It means the commit-graph code and anything else (like bitmaps) needs to
deal with stale data for the common and default gc --auto case.

You also can't have e.g. a global core.commitGraph=3Dtrue config along
with a per-repo gc.writeCommitGraph=3Dtrue config do what you expect.

Now just because you wanted to write it for some you'll end up keeping
it around forever because you'd also want to optimistically always use
it if it's there.

Note that I'm talking about the *default* gc semantics, they don't have
to cover all advanced use-cases, just be good enough for most, and it's
also important that they're as simple as possible, and don't result in
stuff like "my performance sucks because I turned this config option on
once a year ago for 2 days".
