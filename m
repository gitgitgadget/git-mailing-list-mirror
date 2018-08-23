Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EF0D1F954
	for <e@80x24.org>; Thu, 23 Aug 2018 17:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbeHWUvm (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 16:51:42 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41628 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbeHWUvm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 16:51:42 -0400
Received: by mail-ed1-f65.google.com with SMTP id f38-v6so4093754edd.8
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 10:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=p3aMY+vVMmxB6Why2Qc4hkBlm8LHmq7IoBobbCXY8Iw=;
        b=N2HANvmZLYRNwvPa8qTHxuMyUfHEFZ2aN2/5gRps0H79/p3MGPKn2WmlWqEoAi2fk3
         Vr3IwbcTXtJsskVa2MLkteDLrTrbntcTsoNV+o1KFSGCGnRJR3lHaA04+8+6sY5FVyNl
         HwP2cRfLT0QFK6R+R1Ye7nzhr8YJzV8NgfGE6th3IuMuWIgWjzQhlGTgNuE3agrnoIPm
         W0e9fa5YOhmosWVG6SWsU69SPy2XZ2mEZOijrtkqj61/z+9kwGyMLYcIAYn7svJPEFGT
         bzDmWRRYA6becDUl0JXFGNJKeZSPgSW92BOINaaaTzXzgzlFvwNbAnuJ0mST/MPJ9zzT
         98VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=p3aMY+vVMmxB6Why2Qc4hkBlm8LHmq7IoBobbCXY8Iw=;
        b=o9yU167Ws6IXPNg4nj53NMzsmQ87GQj7Eh5LZ+OaIpRyhya2SviYXB8LPJ68ftFD2m
         viAraEKVV0bFYHcUAbjohsOJ19izWXYskYs1jzYx3tCltDnGPS3A7GTMZ9qdLY3VZjpc
         J5kc1djwaAoyB6682AEkvYSdLqns91DtjkOATNY2H5vgQbTpT2zGTA458T8wXVysNaj2
         xrHCt8pi6X0owXc2gRj+/qfPbxiDLrBIz+h3TjpsT0IIx1kVeCc6aLIBILcPYgpvIPU0
         YTioOVGIy8jufBK7UgKBm5HQ5zniZvQCNl7mD6xGZJ5vXeztKnK4X6fQa80EMXE1U/6k
         4U6A==
X-Gm-Message-State: AOUpUlFU8k3po3J8m/Jh+O7OT4kp91HnNhsu8IF/byl28DidUxgAtXnK
        3vaYba2PV+PbnApXHsTloi4=
X-Google-Smtp-Source: AA+uWPyjh42nCkOv/ncKWc2hrS0dDtLh7E0oyMWCi+UF66OLLTz2koHcLdC9glc6YAptlIZVtkHYig==
X-Received: by 2002:a50:c082:: with SMTP id k2-v6mr69730903edf.294.1535044858592;
        Thu, 23 Aug 2018 10:20:58 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id m52-v6sm2333702edd.46.2018.08.23.10.20.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 10:20:57 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Benoit Lecocq <benoit@openbsd.org>, kn@openbsd.org
Subject: Re: [PATCH v2 2/2] tests: fix and add lint for non-portable seq
References: <20180823091427.1756-1-avarab@gmail.com> <20180823152502.3886-2-avarab@gmail.com> <xmqqefepjcam.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqefepjcam.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 23 Aug 2018 19:20:56 +0200
Message-ID: <874lflf18n.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Aug 23 2018, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> GNU seq is not a POSIX command, and doesn't exist on
>
> s/GNU //; the command did not even originate there, but came from V8
> and/or Plan9 IIRC.
>
>> e.g. OpenBSD. We've had the test_seq wrapper since d17cf5f3a3 ("tests:
>> Introduce test_seq", 2012-08-04), but use of it keeps coming back,
>> e.g. in the recently added "fetch negotiator" tests being added here.
>>
>> So let's also add a check to "make test-lint". The regex is aiming to
>> capture the likes of $(seq ..) and "seq" as a stand-alone command,
>> without capturing some existing cases where we e.g. have files called
>> "seq".
>>
>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>> ---
>>
>> Now with a fix & check in v2 for the seq issue mentioned in
>> https://public-inbox.org/git/87a7pdfltp.fsf@evledraar.gmail.com/
>
> Thanks.
>
>>  t/check-non-portable-shell.pl        |  1 +
>>  t/t5552-skipping-fetch-negotiator.sh | 12 ++++++------
>>  t/t5703-upload-pack-ref-in-want.sh   |  4 ++--
>>  3 files changed, 9 insertions(+), 8 deletions(-)
>>
>> diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.pl
>> index c8f10d40a1..75f38298d7 100755
>> --- a/t/check-non-portable-shell.pl
>> +++ b/t/check-non-portable-shell.pl
>> @@ -42,6 +42,7 @@ sub err {
>>  	/\btest\s+[^=]*==/ and err '"test a == b" is not portable (use =)';
>>  	/\bwc -l.*"\s*=/ and err '`"$(wc -l)"` is not portable (use test_line_count)';
>>  	/\bhead\s+-c\b/ and err 'head -c is not portable (use test_copy_bytes BYTES <file >out)';
>> +	/(?:\$\(seq|^\s*seq\b)/ and err 'seq is not portable (use test_seq)';
>
> Looking at $(wc -l) thing a few lines above, I am not sure if this
> deviation is a good idea.  Wouldn't /\bseq\s/ be sufficient?

As alluded to in the commit message that will find cases like:

    $ git grep -P '\bseq\b' -- t | grep -P -v '(?:\$\(seq|^\s*seq\b)'
    t/perf/p3400-rebase.sh:16:              seq 1000 >>unrelated-file$i &&
    t/perf/p3400-rebase.sh:21:              seq 1000 | tac >>unrelated-file$i &&
    t/t3404-rebase-interactive.sh:1227:             test_seq 5 | sed "s/$double/&&/" >seq &&
    t/t3404-rebase-interactive.sh:1228:             git add seq &&
    t/t3404-rebase-interactive.sh:1230:             git commit -m seq-$double
    t/t3404-rebase-interactive.sh:1232:     git tag seq-onto &&
    t/t3404-rebase-interactive.sh:1234:     git cherry-pick seq-onto &&
    t/t3404-rebase-interactive.sh:1236:     test_must_fail env FAKE_LINES= git rebase -i seq-onto &&
    t/t3404-rebase-interactive.sh:1239:     git diff --exit-code seq-onto &&
    t/t4022-diff-rewrite.sh:69:     test_seq 1 99 >seq &&
    t/t4022-diff-rewrite.sh:70:     printf 100 >>seq &&
    t/t4022-diff-rewrite.sh:71:     git add seq &&
    t/t4022-diff-rewrite.sh:72:     git commit seq -m seq
    t/t4022-diff-rewrite.sh:76:     test_seq 1 5 >seq &&
    t/t4022-diff-rewrite.sh:77:     test_seq 9331 9420 >>seq &&
    t/t4022-diff-rewrite.sh:78:     test_seq 96 100 >>seq
    t/t4022-diff-rewrite.sh:82:     git diff -B seq >res &&
    t/t4022-diff-rewrite.sh:87:     git diff seq >res &&
    t/t4022-diff-rewrite.sh:93:     git diff -B seq >res &&
    t/t4150-am.sh:933:      git format-patch -2 --stdout >seq.patch &&
    t/t4150-am.sh:945:      test_must_fail git am -3 seq.patch &&
    t/t4150-am.sh:955:      test_must_fail git am -3 seq.patch &&
    t/t5520-pull.sh:295:    git checkout -b seq &&
    t/t5520-pull.sh:296:    test_seq 5 >seq.txt &&
    t/t5520-pull.sh:297:    git add seq.txt &&
    t/t5520-pull.sh:299:    git commit -m "Add seq.txt" &&
    t/t5520-pull.sh:300:    echo 6 >>seq.txt &&
    t/t5520-pull.sh:302:    git commit -m "Append to seq.txt" seq.txt &&
    t/t5520-pull.sh:304:    echo conflicting >>seq.txt &&
    t/t5520-pull.sh:306:    git commit -m "Create conflict" seq.txt &&
    t/t5520-pull.sh:307:    test_must_fail git pull --rebase . seq 2>err >out &&
