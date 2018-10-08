Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32BEE1F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 14:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbeJHWHD (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Oct 2018 18:07:03 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37543 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbeJHWHC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Oct 2018 18:07:02 -0400
Received: by mail-wr1-f66.google.com with SMTP id y11-v6so10439633wrd.4
        for <git@vger.kernel.org>; Mon, 08 Oct 2018 07:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=yQp6TDLneR2NTmpuBfsnlEo1fqnKhV5RAGQHxScOVrQ=;
        b=rK4vKsMCTl8AUo77h1v8UZJP/v1J8lT+4XzL/AdeN1tN6m8NsfvXYIazDk4ek9g1RU
         n+juFGVH+h2CC9L+q1j3N3YxwvL9kz4Mll48Vj6lEaz8pbRJTO9oS0lbIROTQnE5N/sL
         e+hgSGLcOzTrCRXufXIbFg2FzGPkQLrcNswdfobGAi1C493t7+8lliZulJpoT/D49m0A
         SHe99dFlG6fqzYQe4WMwEis74wJr4xQpE4gEzGwN04TKQJXVBa09jxoBnUnzdNEZBuZ/
         xTk2GSZTxMmyuVe8FoSdapsU17WXNx9SiYtYihP27ZcyCUIE9JZKTTK6cg/snCCj55g6
         Ecdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=yQp6TDLneR2NTmpuBfsnlEo1fqnKhV5RAGQHxScOVrQ=;
        b=eLJ/EWfmO4umRupchLU7A7qvDl/B4FfYHlsBIyjBEwdI6AWHzdbPtOaLD3Bz2tAVfS
         ksRNE2wsNMLmacJswu/U9kjQMk+Kz2gCKaLDmcbBfo++bXr9WX3wsfxCzb3AIdhNijm9
         xiR16V4PlOoKBszUJFrHr4uY3vsP1N4wMLeSyKGJE/vtCgoudkOToiH1QrtAdpP5fVtT
         cVvUNyW/bM6CqHl5NuVhyBE7k/1BN8mPAcHfBvGKYh0c+i8i0/BJk3v+VevgqAR2ZE2h
         CWqf8xs+68ihRq/R0HTAZDtlp9udhegG1M6dBuQSLzupAFomWT6MaJwE5boGLM8lgqxQ
         y30w==
X-Gm-Message-State: ABuFfoha6zIKwA+rsd18MOuJJA21IujPqJfouK/Vrz0ov6Dw4tDMJ2fc
        pj5tO+PKt7JFs1Fy3K6/2/rOHC/s
X-Google-Smtp-Source: ACcGV63qSEzFT6eCl/teLj5V3KFfQ8AEymrZkSolyQFrepynu42AhkFdnEOKFhlWa/Lq7FHX9kNVdw==
X-Received: by 2002:adf:fe0f:: with SMTP id n15-v6mr15972244wrr.71.1539010494145;
        Mon, 08 Oct 2018 07:54:54 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id m143-v6sm6989486wmd.29.2018.10.08.07.54.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 07:54:52 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/5] Fix the racy split index problem
References: <20180927124434.30835-1-szeder.dev@gmail.com> <871s9fjbcb.fsf@evledraar.gmail.com> <20180927142336.GJ27036@localhost> <87zhw3hsiv.fsf@evledraar.gmail.com> <87k1n6hzwu.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <87k1n6hzwu.fsf@evledraar.gmail.com>
Date:   Mon, 08 Oct 2018 16:54:51 +0200
Message-ID: <878t38a3pg.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 28 2018, Ævar Arnfjörð Bjarmason wrote:

> On Thu, Sep 27 2018, Ævar Arnfjörð Bjarmason wrote:
>
>> On Thu, Sep 27 2018, SZEDER Gábor wrote:
>>
>>> On Thu, Sep 27, 2018 at 03:53:24PM +0200, Ævar Arnfjörð Bjarmason wrote:
>>>>
>>>> On Thu, Sep 27 2018, SZEDER Gábor wrote:
>>>>
>>>> > This is the second attempt to fix the racy split index problem, which
>>>> > causes occasional failures in several random test scripts when run
>>>> > with 'GIT_TEST_SPLIT_INDEX=yes'.  The important details are in patches
>>>> > 1 and 5 (corresponding to v1's 3 and 5).
>>>>
>>>> Thanks. I'm running the same sorts of tests I noted in
>>>> https://public-inbox.org/git/87va7ireuu.fsf@evledraar.gmail.com/ on
>>>> this. The fix Jeff had that you noted in
>>>> https://public-inbox.org/git/20180906151439.GA8016@localhost/ is now in
>>>> "master".
>>>>
>>>> I take it your
>>>> https://github.com/szeder/git/commits/racy-split-index-fix is the same
>>>> as this submission?
>>>
>>> Yes.
>>>
>>>> Anyway, I'm testing that cherry-picked on top of the
>>>> latest master.
>>>>
>>>> Unfortunate that we couldn't get the isolated test you made in
>>>> https://public-inbox.org/git/20180907034942.GA10370@localhost/
>>>
>>> Nah, that's not an isolated test case, that's only a somewhat
>>> narrowed-down, but rather reliable reproduction recipe while I still
>>> had no idea what was going on :)
>>>
>>> The _real_ isolated test is the last test in t1701, that's what it
>>> eventually boiled down to.
>>
>> Thanks. I had ~400 runs of the tests I ran before and they were all
>> OK. Now trying also with t1701 (which I hadn't noticed was a new
>> test...).
>
> Ran that overnight with the same conditions as before. 2683 OK runs and
> 0 failures (and counting). So it seems like the combination of the two
> fixed the split index bugs.

I forgot I ad this running, and got up to 45482 OKs and 0 FAILs before
finally Ctrl+C-ing it now :)

>>>> but I
>>>> don't see how it could be added without some very liberal
>>>> getenv("GIT_TEST_blahblah"), so it's probably best to not add it,
>>>> particularly with the C rewrite of git-stash in-flight.
>>>>
>>>> I'll report back when I have enough test data to say how these patches
>>>> affect the intermittent test failures under GIT_TEST_SPLIT_INDEX=yes.
