Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D29C02090A
	for <e@80x24.org>; Mon, 20 Mar 2017 20:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756135AbdCTUFI (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 16:05:08 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:36312 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755674AbdCTUEy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 16:04:54 -0400
Received: by mail-it0-f51.google.com with SMTP id w124so100817719itb.1
        for <git@vger.kernel.org>; Mon, 20 Mar 2017 13:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=82bWegDwv+kSrgQh4W5c+9K2V3E2bakhDcddaEDQByY=;
        b=BQd+vy843SwcCIksrQJwaWRAI1ux1ZyXGQaDl+LIN/TbUIWQHqHK6hqHGgIlehAZ68
         Z7meoFNcaoqfhSixOJli2IJYfjP6yr/aKpd84Pj5KDaGt7jp9Z3V33a2CbrljFtl3EQO
         21qYbtyb9eTTw92Z+8ZuoyM9sBN5hC9nYQ/cL+bFpKaBAybk4saYfFp46jxBXvvst/RR
         Ugf1nnxUhIxMU418XUqmykv4GA0/itl2u/w3iNDkdF88VvYVvE3jIql9ogsP2BeX0/Z5
         Alup9GWqYK5rNRbHh89HjvrfRth3Yu2VhknWeo0MW0hlxqizdqiSlWiFya0PUaqW0ELQ
         byvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=82bWegDwv+kSrgQh4W5c+9K2V3E2bakhDcddaEDQByY=;
        b=uT7RGmMNvNn6khZ817Tizhc4nztG3jS05XJbia27YWXgLjDu/tQtXMC7nU68fmPPKX
         vpEVzkOuAsNFq9DR9/we3SLQSBjXydl/WEajwzw0nbHXMBzJGVwFoyRRnJ1x+nHqsuzf
         Sru1cZ6f0oo09LAD9Siwbc/wRMycFM5/OPx0Le4s0BLHySfXo0fmCee5g/emgs8Ww9Lg
         OiEjw/A9bea3a1741g5jP1IsJLXC2QSiisTGHtCxMgK2DK7+Zh2SDZ17/EhYACNRQW4o
         X9LXUoIERQeguCfYZeK9S83NJawOShiMxAIKFWAVz87qb+xlC5S0zx223Tn+pelcAyzv
         RUuA==
X-Gm-Message-State: AFeK/H2K0kmvm6IqIFPb35zFOjYXpUWkltHHxTq9VbwvI8cp50GHMZuJ1I8xP43eloq+484OsSbUxfwPR/rNGQ==
X-Received: by 10.107.200.139 with SMTP id y133mr2821376iof.147.1490040293250;
 Mon, 20 Mar 2017 13:04:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Mon, 20 Mar 2017 13:04:32 -0700 (PDT)
In-Reply-To: <20170320195209.oyivf2ta3m3kg264@sigill.intra.peff.net>
References: <20170318103256.27141-1-avarab@gmail.com> <20170318103256.27141-7-avarab@gmail.com>
 <20170320042519.srtavoxhm3fln5mw@sigill.intra.peff.net> <CACBZZX6FWjG1bXrk+ee8y=T5=ovxxybfrGzkkDxjskwDzhKPuA@mail.gmail.com>
 <20170320195209.oyivf2ta3m3kg264@sigill.intra.peff.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 20 Mar 2017 21:04:32 +0100
Message-ID: <CACBZZX5GErSBsiCz0Y2SgtvckcPE51ekfUgBpvYjNF1u44piMA@mail.gmail.com>
Subject: Re: [PATCH 6/8] ref-filter: Add --no-contains option to tag/branch/for-each-ref
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Lars Hjemli <hjemli@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 20, 2017 at 8:52 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Mar 20, 2017 at 10:32:47AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> > I think the more relevant comparison is "--no-merged", and it behaves
>> > the same way as your new --no-contains. I don't think I saw this
>> > subtlety in the documentation, though. It might be worth mentioning
>> > (unless I just missed it).
>>
>> For --contains we explicitly document "contain the specified commit",
>> i.e. you couldn't expect this to list tree-test, and indeed it
>> doesn't:
>>
>>     $ git tag tree-test master^{tree}
>>     $ git tag -l --contains master '*test*'
>
> Right, "--contains" cannot have a commit inside a tree, so we were
> correct to skip the computation entirely. But does that mean that
> "--no-contains" should be the complement of that, or should it only
> include tags whose "contains" can be computed in the first place?
>
> IOW, I don't think --contains or --merged are interesting here; they
> give the right answer by skipping the computation. The question is what
> the "--no-" variants should do.

I think both should only ever find commits. I only came up with this
tree/blob scenario for the purposes of tests, but it would make the
command less useful & way slower in practice. E.g. now you want to
find what to revert to and some blob tag shows up.

>> However the --[no-]merged option says "reachable [...] from the
>> specified commit", which seems to me to be a bit more ambiguous as to
>> whether you could expect it to print tree/blob tags.
>
> I suspect that --no-merged behaves the way it does because it originally
> came from git-branch, where you only have commits in the first place.
> The other commands only learned about it during the move to ref-filter,
> and nobody thought about this corner case.
>
> So we could just treat it like a bug and fix it.  But I doubt anybody
> cares that much in practice either way, so documenting it as "any use of
> --contains, --no-contains, --no-merged, or --merged requires that the
> ref in question be a commit" is fine, too.

It's fixed in my soon-to-be resent series.
