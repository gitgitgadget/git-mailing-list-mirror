Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6B5E1F404
	for <e@80x24.org>; Wed, 27 Dec 2017 18:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752016AbdL0Sud (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 13:50:33 -0500
Received: from mail-wr0-f180.google.com ([209.85.128.180]:33763 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751184AbdL0Suc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 13:50:32 -0500
Received: by mail-wr0-f180.google.com with SMTP id v21so26741020wrc.0
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 10:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=ZLZZsSS89scaDLZMg3Z9BaCzhpj0f4hEtXiebCDnpOM=;
        b=Sokln7Rw9bpEV3SYPreNJw3+3QleVJkGbjikJOpzy4egY4JYWjhAUvs5CinqGFUWWv
         gRo4vMtTBKxBvnb4uBwqQ4QijxAauujeqB/qcfb6aJU8CP+w/0/ReUKDajSGY6UAthnc
         eQOigSnsn2+begGWIT1Xbp1GbELZt5rsSi/0yd6cR98Krna6I57uwDI3P3R5w8SAk9xm
         sKVOzDN4ZNRAM4nQVubktLOrPeLRa0oLGoEczn8ZMRMYIsm9ID2lGhUPUZrp2jCAMyAz
         4M+fEWTZwDzpoCvWFRTlY9swkPurS5/HYWp431NXl6EwU9kJRUzafCkeJ3OgCOtFalOY
         WN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=ZLZZsSS89scaDLZMg3Z9BaCzhpj0f4hEtXiebCDnpOM=;
        b=uL0IPe0JnlCWi/ZMuUnJGezXNgkXxIsi5j8mfmyoNir49p28Dtg6FePL+SJjhdC8O1
         QhJ+AcEjhglmdp5ITFeeJG40SyeMPo+UhOSvFZRhxRsyOw23ehfijUfX4HGFNpzh3mbA
         IAs8lITawj6xc+IMHDJ8U5Bg6d3EedWcJrlHW7XZ4f2sQ5peEX9LYqUjWb37GecJSVv4
         lV/+IzWiBXYyymVh5JzrZahHnx+WhJ3MT+PwV4/zHMc6mppPLmmQNH/vGWzNwgbifm5N
         /Qo/vfTc9YUj+i/4MLVZGqli6cRNU9Nsqq78SyuOu/0zmaF0uxceXMThq1E7xGpPteyD
         VVpA==
X-Gm-Message-State: AKGB3mIT/SpLyq7aLy2aKgoVvP91hSpNl3/weoyF2YLO3dGn4yKVg/xt
        kBY722ss1WfVlV5a2L/f9Tw=
X-Google-Smtp-Source: ACJfBoswDCfOaJn034QW8Y7N4lwRo9FPE586EikVjmc7lDEk7TO/FOaAjkBdHV10L/JN0Bqc5HVM2g==
X-Received: by 10.223.132.37 with SMTP id 34mr30192029wrf.94.1514400631622;
        Wed, 27 Dec 2017 10:50:31 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id x13sm12965411wre.65.2017.12.27.10.50.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Dec 2017 10:50:30 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Ben Peart <benpeart@microsoft.com>
Subject: Re: [PATCH] status: add a failing test showing a core.untrackedCache bug
References: <20171222140032.21180-1-avarab@gmail.com> <xmqqlghoniuk.fsf@gitster.mtv.corp.google.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <xmqqlghoniuk.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 27 Dec 2017 19:50:29 +0100
Message-ID: <87mv24qa2y.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 27 2017, Junio C. Hamano jotted:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> +status_is_clean() {
>> +	>../status.expect &&
>> +	git status --porcelain >../status.actual &&
>> +	test_cmp ../status.expect ../status.actual
>> +}
>> +
>>  test_lazy_prereq UNTRACKED_CACHE '
>>  	{ git update-index --test-untracked-cache; ret=$?; } &&
>>  	test $ret -ne 1
>> @@ -683,4 +689,43 @@ test_expect_success 'untracked cache survives a commit' '
>>  	test_cmp ../before ../after
>>  '
>>
>> +test_expect_success 'teardown worktree' '
>> +    cd ..
>> +'
>
> Funny indentation.

Thanks. I'll submit a new series with all 3 patches with the issues you
brought up mentioned...

>> +test_expect_success 'setup worktree for symlink test' '
>> +	git init worktree-symlink &&
>> +	cd worktree-symlink &&
>> +	git config core.untrackedCache true &&
>> +	mkdir one two &&
>> +	touch one/file two/file &&
>> +	git add one/file two/file &&
>> +	git commit -m"first commit" &&
>> +	git rm -rf one &&
>> +	ln -s two one &&
>> +	git add one &&
>> +	git commit -m"second commit"
>> +'
>
> This needs SYMLINKS prereq, which in turn means it cannot be tested
> on certain platforms.  I thought Duy's answer was that this does not
> need to involve a symbolic link at all?  If so, perhaps we can have
> another test that does not need symlink?

... as soon as I figure out how to add such a non-symlink test as well
(seems sensible to test both), but I can't bring it to fail without
symlinks, I just adjusted my test script to do this instead:

    (
        rm -rf /tmp/testrepo &&
        git init /tmp/testrepo &&
        cd /tmp/testrepo &&
        mkdir x y &&
        touch x/a y/b &&
        git add x/a y/b &&
        git commit -msnap &&
        git rm -rf y &&
        mkdir y &&
        touch y/c &&
        git add y &&
        git commit -msnap2 &&
        git checkout HEAD~ &&
        git status &&
        git checkout master &&
        sleep 1 &&
        git status &&
        git status
    )

Duy, what am I missing here?
