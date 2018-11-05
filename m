Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08EA51F453
	for <e@80x24.org>; Mon,  5 Nov 2018 21:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387762AbeKFGWh (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 01:22:37 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45141 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387441AbeKFGWh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 01:22:37 -0500
Received: by mail-ed1-f65.google.com with SMTP id w39-v6so4317779edw.12
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 13:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=z/hMLYj51u0AFdQSV33UNjByTuQZmQ0kGKC8ABiNpiY=;
        b=EgqqxKgp8AyOXsnLZuznxSyOlCqnNCQLxOHwdu60hXcCQnsO3gRz+B18Vapwij2abF
         Ua8GD538wflS/+m/bLd2xC2n0RA6qX80njjfXCOyrViFoMTLHP6Sg+2Gq25YCHqB78mL
         V+tMxJCvLxnHrHVAzlLl94Oes254dy3gz7zmvr227ohxjwtLVRMqgmhoQ+idw5hy3uxj
         qkUTOVzhxFsQBsJzDV4YpB9yUM/SV4lvHugYeTaQKq7/wVUxZT4JL0KxB8USSCq7K3KD
         WDWtDY14uoyarioWlL5gpaTNuzIXxtiCFhf9TS5eUo7XsiIaSw9G/XdwUlRRIoch9LoL
         iyNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=z/hMLYj51u0AFdQSV33UNjByTuQZmQ0kGKC8ABiNpiY=;
        b=M2fpjM0DCKdKlRqWFeZCGbICGRzaJkJG6aT6YtAlAlIgmCJA2DgHZul+JQS7hQHiQe
         Vs1C18UcV2opMMu8HMLLO+w2y11GKfclDSf/mAv/bNa1/BIqtMcpBuuOTEPbQvn8Ce8R
         +KWx+zDwO5AFNVDeT0CnlkytaQFTp51FVQGZQKpj1shKFcLj6VmoewYt641i8mA2SOFC
         N+/7aU4M77wojGQNqNP49LLdkVD0l6gLGcVtpSbuONfKHYw9Qr8RHfKGjg+VzXwDZuTa
         GtyyMU4hT9sqXoLKpPdFf/3ABeU+P6k67Vp0gYN7B0NHBZJsF2H1vRW961DAJtFqujqA
         4Cug==
X-Gm-Message-State: AGRZ1gKNid00oUrTQpl+KynnsJDy4b4WYO4RtRbcompD8y6G5BsbpPS5
        kiXSO40TkwIV0DPTpP1Zxbo=
X-Google-Smtp-Source: AJdET5cu2oZnr441WR1pg16Epj6LcLpgzkZXCClsPCKF+FP8JnjxR2qxilpN/8YWA+UpvXK59uInog==
X-Received: by 2002:aa7:d48e:: with SMTP id b14-v6mr14434005edr.256.1541451662482;
        Mon, 05 Nov 2018 13:01:02 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id n25-v6sm1078382edd.31.2018.11.05.13.01.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 13:01:01 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        lucas.demarchi@intel.com, Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] range-diff: add a --no-patch option to show a summary
References: <20181105200650.31177-1-avarab@gmail.com> <CAPig+cThS8959jW9+X7bJHy5RG9Uoj4=V8ahjf2zGetTNw03SA@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CAPig+cThS8959jW9+X7bJHy5RG9Uoj4=V8ahjf2zGetTNw03SA@mail.gmail.com>
Date:   Mon, 05 Nov 2018 22:00:59 +0100
Message-ID: <87efbz6xys.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 05 2018, Eric Sunshine wrote:

> On Mon, Nov 5, 2018 at 3:07 PM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
>> Add a --no-patch option which shows which changes got removed, added
>> or moved etc., without showing the diff associated with them.
>
> This option existed in the very first version[1] of range-diff (then
> called branch-diff) implemented by Dscho, although it was called
> --no-patches (with an "es"), which it inherited from tbdiff. I think
> someone (possibly me) pointed out that --no-patch (sans "es") would be
> more consistent with existing Git options. I don't recall why Dscho
> removed the option during the re-rolls, but the explanation may be in
> that thread.

Thanks for digging. Big thread, not going to re-read it now. I'd just
like to have this.

> I was also wondering if --summarize or --summary-only might be a
> better name, describing the behavior at a higher level, but since
> there is precedent for --no-patch (or --no-patches in tbdiff), perhaps
> the name is fine as is.

I think we should aim to keep a 1=1 mapping between range-diff and
log/show options when possible, even though the output might have a
slightly different flavor as my 4th paragraph discussing a potential
--stat talks about.

E.g. I can imagine that range-diff --no-patch --stat --summary would not
show the patch, but a stat as described there, plus e.g. a "create
mode..." if applicable.

This change implements only a tiny fraction of that, but it would be
very neat if we supported more stuff, and showed it in range-diff-y way,
e.g. some compact format showing:

    1 file changed, 3->2 insertions(+), 10->9 deletions(-)
    create mode 100(6 -> 7)44 new-executable

> The patch itself looks okay.
>
> [1]: https://public-inbox.org/git/8bc517e35d4842f8d9d98f3b99adb9475d6db2d2.1525361419.git.johannes.schindelin@gmx.de/
