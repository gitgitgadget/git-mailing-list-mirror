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
	by dcvr.yhbt.net (Postfix) with ESMTP id 16CF81F609
	for <e@80x24.org>; Wed, 28 Nov 2018 12:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbeK1XWr (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 18:22:47 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33530 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727724AbeK1XWr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 18:22:47 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so20447967wrr.0
        for <git@vger.kernel.org>; Wed, 28 Nov 2018 04:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=UuP339CzgEkgEgYe9+a9o0tqGZ4TVPJFmM92I4Ra6RI=;
        b=XlMFqmsyDYtSzXOOrS2CdyPCYV4XJH5BqFi/yfpEk7YJarb6n9IeFWp2C50jeGQuBO
         k+1vXDXYdTFI1hoH54UmnhiCfzsE243Y6sObfqomuWTAZ/xGySwKudJwtzlS8rKQ0pCs
         46o4SVL82FfXD5kG0DrvtO9naNmX4NR7eiRAw+kIraoyUrOg0417Gf0UuNtDSRZPiNAD
         t7JgA9fUnAszoqsKVx3Wen3wXfCg0ynZ45GaFoj6wTIzUILbsIa1ng2hZFsPQMyMgXKQ
         HWrYNG0motORSRCXOrde8YmlVLCpGXaZCyuMThqtl6Gns+bMCTdxhiSd+s4ENGJZJ1O1
         oEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=UuP339CzgEkgEgYe9+a9o0tqGZ4TVPJFmM92I4Ra6RI=;
        b=MAv8EFZ/KqVhuSGdPxqi+C/BruISt1q+BOQEm/Rhfjd1F9f4QAre6DTwc4cq4n1y5p
         73s/02jw+UGyaZUairZIccPGI7IZN/A+/HiC0sc6nC8uBAb8i9/+t/K24rqF4sdWnkoo
         7xadoNrMj6KuGxES0iyHndV4qim5S8j28FsLhFXDSgQ4rTop8+qBo4JZCcUkeBvyqLHE
         xvcLU2F8jot4foPP8NK8vXgUpZzw04F39lkkvTW+4i/0w9PvkAgGxn41jH0VlvnZoMix
         0Mg68vxsitkch3pr9pDexIpdrocCAqQk6M79/EjQvDHtzAmu3DxPv/wWGbEjv8IKS5Wf
         fdIA==
X-Gm-Message-State: AA+aEWagz2x7m81j2tUfU+/AnsZFiF2Z83vwUaieNsjXO/bbeQORzwsO
        Im6/FoDKDVE031lKlnfN03Q=
X-Google-Smtp-Source: AFSGD/Wl4HyILYmi+uQl8X/oOnP5PI7pSo/2xkf0NuWs20rP8ytQIettnyU7AWzEEre4gUgp9kf9kw==
X-Received: by 2002:adf:b30f:: with SMTP id j15mr28972561wrd.46.1543407676312;
        Wed, 28 Nov 2018 04:21:16 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id t17sm2788621wme.43.2018.11.28.04.21.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 04:21:15 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Ian Jackson <ijackson@chiark.greenend.org.uk>
Subject: Re: [PATCH] rebase: mark the C reimplementation as an experimental opt-in feature (was Re: [ANNOUNCE] Git v2.20.0-rc1)
References: <xmqqmuq25ufc.fsf@gitster-ct.c.googlers.com>
        <87y39w1wc2.fsf@evledraar.gmail.com>
        <877eh219ih.fsf@evledraar.gmail.com>
        <xmqq36rq2cp0.fsf@gitster-ct.c.googlers.com>
        <xmqq36roz7ve.fsf_-_@gitster-ct.c.googlers.com>
        <20181128043154.GA34163@google.com>
        <nycvar.QRO.7.76.6.1811281015360.41@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <nycvar.QRO.7.76.6.1811281015360.41@tvgsbejvaqbjf.bet>
Date:   Wed, 28 Nov 2018 13:21:14 +0100
Message-ID: <87bm69z939.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 28 2018, Johannes Schindelin wrote:

> Hi Jonathan,
>
> On Tue, 27 Nov 2018, Jonathan Nieder wrote:
>
>> At https://bugs.debian.org/914695 is a report of a test regression in
>> an outside project that is very likely to have been triggered by the
>> new faster rebase code.
>
> From looking through that log.gz (without having a clue where the test
> code lives, so I cannot say what it is supposed to do, and also: this is
> the first time I hear about dgit...), it would appear that this must be a
> regression in the reflog messages produced by `git rebase`.
>
>> The issue has not been triaged, so I don't know yet whether it's a
>> problem in rebase-in-c or a manifestation of a bug in the test.
>
> It ends thusly:
>
> -- snip --
> [...]
> + git reflog
> + egrep 'debrebase new-upstream.*checkout'
> + test 1 = 0
> + t-report-failure
> + set +x
> TEST FAILED
> -- snap --
>
> Which makes me think that the reflog we produce in *some* code path that
> originally called `git checkout` differs from the scripted rebase's
> generated reflog.
>
>> That said, Google has been running with the new rebase since ~1 month
>> ago when it became the default, with no issues reported by users.  As a
>> result, I am confident that it can cope with what most users of "next"
>> throw at it, which means that if we are to find more issues to polish it
>> better, it will need all the exposure it can get.
>
> Right. And there are a few weeks before the holidays, which should give me
> time to fix whatever bugs are discovered (I only half mind being the only
> one who fixes these bugs).
>
>> In the Google deployment, we will keep using rebase-in-c even if it
>> gets disabled by default, in order to help with that.
>>
>> From the Debian point of view, it's only a matter of time before
>> rebase-in-c becomes the default: even if it's not the default in 2.20,
>> it would presumably be so in 2.21 or 2.22.  That means the community's
>> attention when resolving security and reliability bugs would be on the
>> rebase-in-c implementation.  As a result, the Debian package will most
>> likely enable rebase-in-c by default even if upstream disables it, in
>> order to increase the package's shelf life (i.e. to ease the
>> maintenance burden of supporting whichever version of the package ends
>> up in the next Debian stable).
>>
>> So with either hat on, it doesn't matter whether you apply this patch
>> upstream.
>>
>> Having two pretty different deployments end up with the same
>> conclusion leads me to suspect that it's best for upstream not to
>> apply the revert patch, unless either
>>
>>   (a) we have a concrete regression to address and then try again, or
>>   (b) we have a test or other plan to follow before trying again.
>
> In this instance, I am more a fan of the "let's move fast and break
> things, then move even faster fixing them" approach.
>
> Besides, the bug that Ævar discovered was a bug already in the scripted
> rebase, but hidden by yet another bug (the missing error checking).
>
> I get the pretty firm impression that the common code paths are now pretty
> robust, and only lesser-exercised features may expose a bug (or
> regression, as in the case of the reflogs, where one could argue that the
> exact reflog message is not something we promise not to fiddle with).

Since I raised this 'should we hold off?' I thought I'd chime in and say
that I'm fine with going along with what you suggest and having the
builtin as the default in the final. IOW not merge
jc/postpone-rebase-in-c down.
