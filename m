Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41D091FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 22:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757683AbeAHWQM (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 17:16:12 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:39156 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756461AbeAHWQL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 17:16:11 -0500
Received: by mail-wm0-f50.google.com with SMTP id i11so16973870wmf.4
        for <git@vger.kernel.org>; Mon, 08 Jan 2018 14:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=m9YEchYwIia/4T95z5ArfiSx5pHvCmJ8hXQM9O9L0IQ=;
        b=WKlMRHOddFsaQ+6k37cg5DPGRvkwe0uQm7F/sHPbmxGIYBOUrVQ3hyOsKT/BInrM2K
         xECrqek4NVttJS62CSmM5yFsxVkxw6z7zGVC3tLoN/JLVmKwRfkxylW0BLUYkrlxwLb4
         S8t6TH8tEnoRxG0hNZXOCjF7eJ61spkb3bwuW96eg22+348U9NGgKyRdKP/jHRf+PVLP
         rVJxW4kSH9kELap22GqQQZK4/DtZurz4WhUgaulukIsfTI5KhEQpJIDyhpHzE6ONEoZ1
         HbPGfWaWKka/XmAjjUfmfef2eJmi4LhDt71b0El9CF+9OHpcM5vE4y4FU09a7dy7K2DU
         sfYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=m9YEchYwIia/4T95z5ArfiSx5pHvCmJ8hXQM9O9L0IQ=;
        b=CyBOyurdgkeMKLBSXaTipDFomeKM9PG2v/bjK9VY9YvIz6CWI7J/nJqyXXQaiYEKsg
         akYQuHjL6bKfhjIBCAsEpMsnXUYFh289qNl9Ss1F1slKLB3ebCvovjmOrlacWBKEOrq8
         5fCh0PPCsvcIKzLEMQKwJYZXtTHXz2/3V/1BSsDl69il9+jHFaNwKL2aRacVKBKT6ZQ9
         9C5Bd5dzF52TQ8bvnRvgxxZ2Vw2rIendwIRO2G1dW5j/afQ1bQ6vZTk/F5nnuzt8orTb
         upIgxJG3uLxpTEVjTnsqBxF0/vzzPbgti6SYQYa9Yw1yIFalcEwb1AenqEzhU8K9pIuE
         FKng==
X-Gm-Message-State: AKGB3mJDDNqDiUrBKqm/IG/TkTLKOhs82wZa5yvlKmM7r0P9sfGrj1wS
        UedhtOmHly1Ers+dHlOVU7A=
X-Google-Smtp-Source: ACJfBovKSNfNIa+Ke7zgWL2QevNAXqcaH92sO4CzfPGfqGSTzijXwd9nNSL+9peitOznc6Il4/nGEg==
X-Received: by 10.28.28.133 with SMTP id c127mr10985389wmc.149.1515449770370;
        Mon, 08 Jan 2018 14:16:10 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id q3sm8355752wre.28.2018.01.08.14.16.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Jan 2018 14:16:09 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Dan Jacques <dnj@google.com>
Cc:     johannes.schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v5 2/3] Makefile: add Perl runtime prefix support
References: <nycvar.QRO.7.76.6.1801082125210.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <20180108220550.66256-1-dnj@google.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20180108220550.66256-1-dnj@google.com>
Date:   Mon, 08 Jan 2018 23:16:08 +0100
Message-ID: <877essatef.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jan 08 2018, Dan Jacques jotted:

> On 2018-01-08 20:27, Johannes Schindelin wrote:
>
>> > Maybe we covered this in previous submissions, but refresh my memory,
>> > why is the *_PERL define still needed? Reading this explanation doesn't
>> > make sense to me, but I'm probably missing something.
>>
>> If the reason is to accommodate Windows, I think it'd make more sense to
>> change the way Git for Windows handles this, and use the same relative
>> paths (if possible, that is, see the GITPERLLIB problems I mentioned
>> elsewhere and which necessitated
>> https://github.com/git-for-windows/git/commit/3b2f716bd8).
>> (...)
>> What do you think? Should we just fold the RUNTIME_PREFIX_PERL handling
>> into RUNTIME_PREFIX and be done with that part?
>> (...)
>> As I mentioned in the mail I just finished and sent (I started it hours
>> ago, but then got busy with other things while the builds were running): I
>> am totally cool with changing this on Windows, too. Should simplify
>> things, right?
>
> No objections here. I see it as adding slightly more risk to this patch's
> potential impact on Windows builds, but if Git-for-Windows is okay with that,
> I'll go ahead and fold RUNTIME_PREFIX_PERL into RUNTIME_PREFIX for
> simplicity's sake.
>
> I'll add a "NO_RUNTIME_PREFIX_PERL" flag as per avarab@'s suggestion as a
> potential mitigation if a problem does end up arising in Windows builds,
> with a note that NO_RUNTIME_PREFIX_PERL can be deleted if everything seems
> to be working. What do you think?

To be clear, I meant that if it's determined by you/others that an
opt-out on Windows is needed I think it makes sense to make it a NO_*
flag, but if there's a solution where we can just turn it on for
everything then ideally we'd just have RUNTIME_PREFIX=YesPlease.
