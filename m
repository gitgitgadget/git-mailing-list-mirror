Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DFFC1F453
	for <e@80x24.org>; Thu, 21 Feb 2019 22:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbfBUW0a (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 17:26:30 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38719 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbfBUW0a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 17:26:30 -0500
Received: by mail-wr1-f65.google.com with SMTP id v13so230885wrw.5
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 14:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=oU0FSVOqHu8pbWqPMOD3msWyX5PkHq1FZ8s4R7Bil+o=;
        b=VFd3eWpKT+fBk0tn1lDFsXi3eNjJ0i50fWEx9PUkzJ001pd/3Kni04xi7ncn3Mvv4o
         qaiswoH+nfsZHmADXFBwnTWJmkuIusIL9HaDzlqTvtKzXsvVHHXm2sFpdZ4Fkw0MK2O3
         NuvGtp03Oq+ogIt7FTPf9KRUxgQ8r9a/DIvxqGXXQESb9jOK+MOPexE7MJeIS0vW/KFE
         lSGDXWd40u0Di/x05KHs/yuenjJc8fwmoleJ3qEilt9bogYdS5Mv9+EEhRNQGDHsSAzH
         6QN18/Cv/7gXMuziiPQlxIIdnl+tDddjqFMnQF1HqrrRA090+cFCNa38ok/SXSbyX2o7
         MtlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=oU0FSVOqHu8pbWqPMOD3msWyX5PkHq1FZ8s4R7Bil+o=;
        b=cN4Vhgrkvdpyc7msIEJveGFjd/j/lnAx8SUXA/bIAwTZ6wBhJl7nSjm92F3GZC0zuL
         mJqb7B1IO7B3Kf3WACtZfHRRTdKiaRitz03iOFKQyyG0UD4i1PUXdcEiOXwPQzmEZtMS
         Brcrfy/OLswk21aFOGEtSbMaTZkWw+C+J9l2kZwaSarwok24INMnFNCc6WceAwBMSVfM
         Eiu0dZm4Li98wspiVFGwnErqgygLCeXSnTr0xiJbyymwz+sP6n0tscXGDKIgjm/EoYKB
         SWv5nr2DDYANyu+gQvt+O6IQkV4Tq+gShqKEpemL2QYqqwUInh3Mk9C894yWD8xC92If
         yRlA==
X-Gm-Message-State: AHQUAubIpfK9J0NpgPXhxIxgfFadhrYGOYPjJrgKuud5uUR6X1QCf7J5
        2mNLbgFMeVREZ49KCiOqNNY7ww1t+nA=
X-Google-Smtp-Source: AHgI3IbQSBKpDJzJXIYcs0XfO4HDA7CpTc2EndFDxQU13AnmqwjBnFr1iA5Qyx2tvcb6z+oTUaKPGg==
X-Received: by 2002:adf:f3d0:: with SMTP id g16mr517204wrp.29.1550787988355;
        Thu, 21 Feb 2019 14:26:28 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id b8sm58096wmj.35.2019.02.21.14.26.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 14:26:27 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Sebastian Staudt <koraktor@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] commit-graph tests: fix cryptic unportable "dd" invocation
References: <xmqq8sybz7b2.fsf@gitster-ct.c.googlers.com> <20190221192849.6581-3-avarab@gmail.com> <20190221204310.GS1622@szeder.dev>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190221204310.GS1622@szeder.dev>
Date:   Thu, 21 Feb 2019 23:26:26 +0100
Message-ID: <878sy86anh.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 21 2019, SZEDER G=C3=A1bor wrote:

> On Thu, Feb 21, 2019 at 08:28:49PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> Change an unportable invocation of "dd" that truncated the
>> commit-graph to call Perl's truncate() function instead.
>>
>> In POSIX it is unspecified what happens when count=3D0 is
>> provided[1]. The NetBSD "dd" behavior differs from GNU (and seemingly
>> other BSDs), which as left this test broken since
>> d2b86fbaa1 ("commit-graph: fix buffer read-overflow", 2019-01-15).
>>
>> In POSIX the truncate(2) and ftruncate(2) functions are
>> portable. We've used the latter since 271421cd34 ("Update partial HTTP
>> transfers.", 2005-09-30), but the truncate(1) command-line tool is
>> GNU-specific. Thus let's use Perl's version of it. We could also just
>> introduce a "test-tool truncate" in the future if we wanted to avoid
>> shelling out to perl.
>>
>> On Linux and NetBSD we don't need the "if -s $ARGV[0] > $ARGV[1]"
>> condition I'm adding. We never have a $zero_pos longer than the file
>> being truncated. But let's have that condition to future-proof the
>> code, and because "the behavior is undefined if LENGTH is greater than
>> the length of the file" (perldoc -f truncate).
>>
>> 1. http://pubs.opengroup.org/onlinepubs/9699919799/utilities/dd.html
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  t/t5318-commit-graph.sh | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
>> index d4bd1522fe..d99bea6cce 100755
>> --- a/t/t5318-commit-graph.sh
>> +++ b/t/t5318-commit-graph.sh
>> @@ -382,7 +382,8 @@ corrupt_graph_and_verify() {
>>  	test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
>>  	cp $objdir/info/commit-graph commit-graph-backup &&
>>  	printf "$data" | dd of=3D"$objdir/info/commit-graph" bs=3D1 seek=3D"$p=
os" conv=3Dnotrunc &&
>> -	dd of=3D"$objdir/info/commit-graph" bs=3D1 seek=3D"$zero_pos" count=3D=
0 &&
>> +	perl -we 'truncate $ARGV[0], $ARGV[1] if -s $ARGV[0] > $ARGV[1]' \
>> +		$objdir/info/commit-graph $zero_pos &&
>
> This will make Dscho unhappy :)

Sorry Dscho :)

Although this is a one-off in one test, as opposed to a new "perl -e" in
test-lib-functions.sh

> Is there a problem with:
>
>   dd if=3D/dev/null of=3D"$objdir/info/commit-graph" bs=3D1 seek=3D"$zero=
_pos"
>
> ?
>
> To my understanding of the specs it's well-defined what it should do,
> even when $zero_pos is larget than the file size,  it's shorter,
> simpler, and doesn't introduce yet another Perl dependency.

I tried that as a one-off and it indeed works as a "truncate" on NetBSD
& GNU.

My reading of POSIX "dd" and "lseek" docs is that we'd need some similar
guard if we're going to be paranoid about a $zero_pos value past the end
of the file. It doesn't look like that's portable, my assumption from
reading the docs is that the seek=3D* will devolve without a stat() check
on some "dd" implementations to an "lseek".

I'm not going to submit a re-roll of this because it works, and I'd
still trust Perl's truncate(...) portability over dd.

But more importantly because it takes me *ages* to fully re-test
anything on the slow BSD VMs I have access to, and I already tore town
my one-off hacking env there after testing these patches...

>>  	generate_zero_bytes $(($orig_size - $zero_pos)) >>"$objdir/info/commit=
-graph" &&
>>  	test_must_fail git commit-graph verify 2>test_err &&
>>  	grep -v "^+" test_err >err &&
>> --
>> 2.21.0.rc0.258.g878e2cd30e
>>
