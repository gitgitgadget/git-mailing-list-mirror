Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E77B20A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 18:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730652AbeLNSow (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 13:44:52 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46]:46880 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730649AbeLNSow (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 13:44:52 -0500
Received: by mail-ed1-f46.google.com with SMTP id o10so5718726edt.13
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 10:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=OkszvwSD5ZyMKQQMOshAXa75sEiz1vz5lPJvd7GNfvY=;
        b=ihBVhghBgCORODicXDUQ69Nm6jy/ekchp2LAhHhLIRKTQd+IEvzDqnWDbHRkiVWz45
         Xkb+7n/IecsQjv8tdZk8mJdcJN4z6bF9BTiyNb64Nh0XBySrIWYrfkVbqfwzJEmXqbws
         yjSFX1p6QGGPCelbWALkQuC8x11VNutdxrddW4iw/mkBACDFE6Qc6XkgUoCeHgPYdS4E
         xGeK05Zufq/XX2mIA2Gu4qo9XanEDRe/6ZdrS7k+FJaXj1YAnoyAoNHB3K0w2VZMe9SO
         khxzu/9lzt+mt3/BPSprYZ2HGRQTJwfQ4nR4qpxBgaBreWOgPVDdTHYKXmcD0Vh43Mvb
         W+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=OkszvwSD5ZyMKQQMOshAXa75sEiz1vz5lPJvd7GNfvY=;
        b=ahLv9RpWAXhUEPritDBk1yvHl8RLL9Kf+tdsrPbC+FgKoxJXCU0FZt3gZSJlPtjQq8
         BsHVWqerdHoYecGnVmosNpQl78tUDgPMPkkewJGR81Rj2ugsJ4JHKogsr1tTCCJCZ4k2
         iIhxbecxLN4a8EfkcDgF94SuzayeBYksghhGXTykE5/4mO9RrMduxgJ/J81RwPfNQd5c
         19e3zZ96Jksr8fchmwpYZki+lr17HNa21BjECXDyp5ZbhnxK6s6lvCK6hVxJelq7Q85r
         LAW8CqX/ZIf7/9hFSpJxnwqhIHrbsoOKAwgaaQPBiLWjmcyTY7kUiRiCWa9AqW2fHKnb
         M9BA==
X-Gm-Message-State: AA+aEWa2k5WwmkWCJn7jvNIIYjC7abWS5tgHLuEqH9fjLNtcvSPm6pOv
        iMPmY94Lo6jECiFRLXbth5COzdxZ
X-Google-Smtp-Source: AFSGD/VknYPIUmImTSC1LKd0ExUMqvLe6T/ZtvdfXzZH2wBO7EZmRlmlFjjrjpNFCJnKahIzmxImeA==
X-Received: by 2002:a50:9923:: with SMTP id k32mr4083146edb.42.1544813090689;
        Fri, 14 Dec 2018 10:44:50 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id 49sm1684921edz.59.2018.12.14.10.44.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 10:44:49 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Josh Steadmon <steadmon@google.com>,
        gitster@pobox.com
Subject: Re: t5601 breakage at 3cd325f7be (Merge branch 'js/protocol-advertise-multi' into pu, 2018-12-14)
References: <nycvar.QRO.7.76.6.1812141318520.43@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <nycvar.QRO.7.76.6.1812141318520.43@tvgsbejvaqbjf.bet>
Date:   Fri, 14 Dec 2018 19:44:48 +0100
Message-ID: <87k1kc0wyn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 14 2018, Johannes Schindelin wrote:

> Hi,
>
> this morning Travis sounded quite a few claxons:
> https://travis-ci.org/git/git/builds/467839114
>
> It seems that quite a few tests in t5601-clone.sh fail, the first of which
> reading like this:
>
> -- snip --
> expecting success:
> 	git clone myhost:src ssh-clone &&
> 	expect_ssh "-o SendEnv=GIT_PROTOCOL" myhost src
>
> ++ git clone myhost:src ssh-clone
> Cloning into 'ssh-clone'...
> ++ expect_ssh '-o SendEnv=GIT_PROTOCOL' myhost src
> ++ test_when_finished '
> 		(cd "$TRASH_DIRECTORY" && rm -f ssh-expect ssh-output.munged && >ssh-output)
> 	'
> ++ test 0 = 0
> ++ test_cleanup='{
> 		(cd "$TRASH_DIRECTORY" && rm -f ssh-expect ssh-output.munged && >ssh-output)
>
> 		} && (exit "$eval_ret"); eval_ret=$?; :'
> ++ case "$#" in
> ++ echo 'ssh: -o SendEnv=GIT_PROTOCOL myhost git-upload-pack '\''src'\'''
> ++ cd '/Users/vsts/agent/2.144.0/work/1/s/t/trash directory.t5601-clone'
> ++ sed 's/ssh: -o SendEnv=GIT_PROTOCOL /ssh: /'
> ++ mv ssh-output.munged ssh-output
> ++ test_cmp ssh-expect ssh-output
> ++ diff -u ssh-expect ssh-output
> --- ssh-expect	2018-12-14 04:30:28.000000000 +0000
> +++ ssh-output	2018-12-14 04:30:28.000000000 +0000
> @@ -1 +1 @@
> -ssh: -o SendEnv=GIT_PROTOCOL myhost git-upload-pack 'src'
> +ssh: myhost git-upload-pack 'src'
> error: last command exited with $?=1
> not ok 37 - clone myhost:src uses ssh
> #
> #		git clone myhost:src ssh-clone &&
> #		expect_ssh "-o SendEnv=GIT_PROTOCOL" myhost src
> #
> -- snap --
>
> I've bisected this down to 3cd325f7be (Merge branch
> 'js/protocol-advertise-multi' into pu, 2018-12-14), a merge, meaning that
> two topic branches do not play nice with one another.
>
> Staring at the breakage and the changes involved, I suspected that
> 391985d7c7 (tests: mark & fix tests broken under
> GIT_TEST_PROTOCOL_VERSION=1, 2018-12-13) does not play well with the
> merged 24c10f7473 (protocol: advertise multiple supported versions,
> 2018-11-16), and indeed, reverting 391985d7c7 on top of 3cd325f7be lets
> t5601 pass again.
>
> It would appear to me, then, that these two patches step on each others'
> toes. Josh, Ævar, what should be done about this?

Looking at the two the breakage is on my side, but I got away with it
before. I'm re-rolling mine for this & other fixes, and will make sure
the two play well together. Thanks.
