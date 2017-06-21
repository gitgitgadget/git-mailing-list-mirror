Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9B5020401
	for <e@80x24.org>; Wed, 21 Jun 2017 14:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752589AbdFUOwL (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 10:52:11 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35467 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752528AbdFUOwK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 10:52:10 -0400
Received: by mail-lf0-f65.google.com with SMTP id n136so10348352lfn.2
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 07:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=es7b+jcsFt+OKAbUPZz/M0GLfWOb8v8gPvrvN2S+UQ8=;
        b=ig5t3IG+T9OKTdcxUfaagILYKY5GZzzOqJ0/7ObVmZu43GAtCxo1DGr9FwYb251yYd
         AGPr1pIC1OlazHPvxKILYlbiZUtUZ2oORjuwpqFwRe5HGYgCdlwvcPdAXb5ccf38nfLv
         klvt5Dq1TLfU8q1cfNt4PQtLsyPOkfJ6bsa8k3JTMXapIPEQN09iabEYT2wK/7UpxtMn
         BfUvq0JO+WaWG6QeeQr7jCp5QSNEsbUUYWSir/XyyOM8f6uZdDt/khrYGj5PgFUa2olm
         SRfasZEFNV2ortBYlw2ut+V8yGdTdvxZxfnmUfj4J7ULPRXRLnFcbs/iDNlats7wgMWl
         98qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=es7b+jcsFt+OKAbUPZz/M0GLfWOb8v8gPvrvN2S+UQ8=;
        b=IyxOkxfj/3VVjfj8W0NF3OZkkMmwU4P8X6VhsTgMH9HyKt2+wl2hOfSMGz/zUEuf8f
         2Syvv0wOG2sQiQtbJwFOdPvkS7nbGZoZrV5f/uhNtf0rpoyL3CWO+E4+VVeLv3naWSTa
         sxcT0uk1xGw8eLNyXDVlLgWROxdlW9z7nInB7xklAngCi8Q0rXZynwpyCt2Co0vFX+Es
         ZHUZPH9WIWKcmOhaeldHS8BzZZJgB0RYU+Qo+8VfedfCtjAzRoyC8ESWNl28cfR6xvHP
         80taWzEKO6yqjnX/PRAfxzG5ctkU+dZ+mwYKNgSRJ6Z0Yu+pkeODQ9nBwtZA7i/z6RcS
         /kmA==
X-Gm-Message-State: AKS2vOwmp2VNlAWcGlTkj3eBsZypdppUwbZTxpVwp7eiqouML+UEBSzQ
        YyDUSAkGbIVUxg==
X-Received: by 10.80.169.35 with SMTP id l32mr14585576edc.105.1498056729054;
        Wed, 21 Jun 2017 07:52:09 -0700 (PDT)
Received: from snth ([92.109.130.42])
        by smtp.gmail.com with ESMTPSA id e50sm7357939edb.43.2017.06.21.07.52.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Jun 2017 07:52:07 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dNgzH-0005Hy-33; Wed, 21 Jun 2017 16:52:07 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     gitster@pobox.com, peff@peff.net, git@vger.kernel.org
Subject: Re: [PATCH/FINAL] status: contextually notify user about an initial commit
References: <1498012463.1487.2.camel@gmail.com> <20170621023729.3200-1-kaarticsivaraam91196@gmail.com> <1498055714.20886.1.camel@gmail.com>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <1498055714.20886.1.camel@gmail.com>
Date:   Wed, 21 Jun 2017 16:52:07 +0200
Message-ID: <87fuet8kbs.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 21 2017, Kaartic Sivaraam jotted:

> On Wed, 2017-06-21 at 08:07 +0530, Kaartic Sivaraam wrote:
>> The existing message, "Initial commit", makes sense for the commit
>> template
>> notifying users that it's their initial commit, but is confusing when
>> merely checking the status of a fresh repository (or orphan branch)
>> without having any commits yet.
>>
>> Change the output of "status" to say "No commits yet" when "git
>> status" is run on a fresh repo (or orphan branch), while retaining
>> the
>> current "Initial commit" message displayed in the template that's
>> displayed in the editor when the initial commit is being authored.
>>
>> A few alternatives considered were,
>>
>> * Waiting for initial commit
>> * Your current branch does not have any commits
>> * Current branch waiting for initial commit
>>
>> The most succint one among the alternatives was chosen.
>>
>> Helped-by: Junio C Hamano <gitster@pobox.com>
>> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>> ---
>>
>> The 'FINAL' part in the subject is just my opinion about
>> this patch
>>
> Just for the note, the tests passed locally and all travis-ci builds
> jobs succeeded except for the one in which the 'GITTEXT_POISON'
> environment variable is enabled. I guess that isn't an issue, from what
> I came to know while digging about it.

No, this is a bug in your patch, the test suite should pass under
poison.

The issue is that you changed the test code I gave you (to also add more
tests, yay) along the way to do:

    test_must_fail test_i18ngrep ...

Instead of the correct form:

    test_i18ngrep ! ...

This fixup for your patch makes it work again:
    
    diff --git a/t/t7508-status.sh b/t/t7508-status.sh
    index e0d2c9e581..b3743ff0a8 100755
    --- a/t/t7508-status.sh
    +++ b/t/t7508-status.sh
    @@ -1618,7 +1618,7 @@ test_expect_success '"No commits yet" should not be noted in status output' '
            git checkout --orphan empty-branch-2 &&
            test_commit test-commit-1 &&
            git status >output &&
    -       test_must_fail test_i18ngrep "No commits yet" output
    +       test_i18ngrep ! "No commits yet" output
     '
     
     test_expect_success '"Initial commit" should be noted in commit template' '
    @@ -1635,7 +1635,7 @@ test_expect_success '"Initial commit" should not be noted in commit template' '
            touch to_be_committed_2 &&
            git add to_be_committed_2 &&
            git commit --dry-run >output &&
    -       test_must_fail test_i18ngrep "Initial commit" output
    +       test_i18ngrep ! "Initial commit" output
     '
     
     test_done
