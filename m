Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D69621F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 09:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbeKTTzB (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 14:55:01 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35742 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727396AbeKTTzA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 14:55:00 -0500
Received: by mail-wm1-f68.google.com with SMTP id c126so1417238wmh.0
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 01:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=VKf/wkyaoyea4U/pZMx6GkqCX7lk4tee3tXBilqbKwI=;
        b=slPNpAVF1hGphqohz7KDTamePPZQjlge5DZxIB4awf8Dd9CEKLKQrEsYz2T2ZE0bYm
         gnMPMiruu3+qBNqa6OvoFJ6FOfAIb1bC+GTRVrCYgVffokLljHmJkc0nrL5YS7+aSbWc
         bTN1H4AR2bT2dxFKSF+Qjz75qmnB07hgohtf7wA7l0XZfr4KQaUwa4tjnlKKf5f+H+q1
         QgXnSiR9Uiau5D+ewsLMLfgtYy2V8S58PPrq8YrKsO+zXKKg7KYCIgGMG9yBvrqgG83r
         9ijkX1xzEfI8pSwoYPTewnPPcrwc32/1MawA8o+VErKzdrBr06Fs563Skd0lAfVjjpS8
         +NFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=VKf/wkyaoyea4U/pZMx6GkqCX7lk4tee3tXBilqbKwI=;
        b=F6n/MbhQ2kEeSi0wyF+MnY86601pNEfIzT0eCQ4reW78JFOKeI77glFf182/EZFaEV
         BvugTObCvr0S/l1Kw+qfZdtgpdf4fbN6wlLoD7aY16di2/vPAj+PClhHo5iHpdvwZuTi
         tdF0t4s5qrhKg4Zt83AT13b63R/RDBla22mmOSraluYPdMVBpftSg8U8xB7/w21afNL0
         UCVBA9ASgANxJ163FWcwThN4/5dYw+IN1HUzUZcoVZW13iM3E+PrkqxISQqoWszGqyr9
         XH0k/sQvxzrG1/U3JfuWZYgzZdVqffgX9ahOREn9jwkM9wABpMQFvHorNvoVpDcY4Kg7
         zAfg==
X-Gm-Message-State: AGRZ1gKu3oh7iJAQH1h+nBE/8bNNClIeK63cDW0qCrifT7Brjp0FbxcJ
        L2Fpg8gta+m93+WYcsGDa1c=
X-Google-Smtp-Source: AJdET5dG5x/XWmaRG6YM9rTAX2YKE3WNf2i2JPFqGNuOVEKaL+HGEMt5yXzNH2nqKxjO+YW7GNIG2A==
X-Received: by 2002:a1c:b54b:: with SMTP id e72mr1433638wmf.73.1542706009622;
        Tue, 20 Nov 2018 01:26:49 -0800 (PST)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id w18sm7231321wru.54.2018.11.20.01.26.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 01:26:48 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Ben Peart <peartben@gmail.com>,
        git@vger.kernel.org, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>, jonathantanmy@google.com
Subject: Re: [PATCH 5/5] index: offer advice for unknown index extensions
References: <20180823154053.20212-1-benpeart@microsoft.com>
        <20181010155938.20996-1-peartben@gmail.com>
        <20181113003817.GA170017@google.com>
        <20181113003938.GC170017@google.com>
        <f2f8cec8-d770-a1e9-b5a1-83653575122e@gmail.com>
        <xmqqo9asqrxu.fsf@gitster-ct.c.googlers.com>
        <20181120060920.GA144753@google.com>
        <20181120061544.GF144753@google.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181120061544.GF144753@google.com>
Date:   Tue, 20 Nov 2018 10:26:47 +0100
Message-ID: <87sgzwyu94.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 20 2018, Jonathan Nieder wrote:

Just commenting here on the end-state of this since it's easier than
each patch at a time:

First, do we still need to be doing %.4s instead of just %s? It would be
easier for translators / to understand what's going on if it were just
%s. I.e. "this is the extension name" v.s. "this is the first 4 bytes of
whatever it is...".

>  			return error("index uses %.4s extension, which we do not understand",
>  				     ext);

Missing _(). Not the fault of this series, but something to fix while
we're at it.

Also not the fault of this series, the "is this upper case" test is
unportable, but this is probably the tip of the iceberg for git not
working on EBCDIC systems.

This message should say something like "Index uses the mandatory %s
extension" to clarify and distinguish it from the below. We don't
understand the upper-case one either, but the important distinction is
that one is mandatory, and the other can be dropped. The two messages
should make this clear.

Also, having advice() for that case is even more valuable since we have
a hard error at this point. So something like:

    "This is likely due to the index having been written by a future
    version of Git. All-lowercase index extensions are mandatory, as
    opposed to optional all-uppercase ones which we'll drop with a
    warning if we see them".

>  		trace_printf("ignoring %.4s extension\n", ext);
> +		if (advice_unknown_index_extension) {
> +			warning(_("ignoring optional %.4s index extension"), ext);

Should start with upper-case. Good that it says "optional".

> +			advise(_("This is likely due to the file having been written by a newer\n"
> +				 "version of Git than is reading it. You can upgrade Git to\n"
> +				 "take advantage of performance improvements from the updated\n"
> +				 "file format.\n"

Let's not promise performance improvements with this extension in a
future version. We have no idea what the extension is, yeah right now
it's going to be true for the extension that prompted this patch series,
but may not be in the future. So just something like this for the last
sentence:

    You can try upgrading Git to use this new index format.

> +				 "\n"
> +				 "Run \"%s\"\n"
> +				 "to suppress this message."),
> +			       "git config advice.unknownIndexExtension false");

Somewhat of an aside, but if I grep:

    git grep -C10 'git config advice\..*false' -- '*.[ch]'

There's a few existing examples of this, but the majority of advice()
messages don't say in the message how you can turn these off. Do we
think this a message users would especially like to turn off? I have the
opposite impression, it's a one-off in most cases, although not in the
case where an editor has an embedded git.

I think it would make sense to add this sort of thing to the advice()
API, i.e.:

    advice_with_config_hint(_("<message>"), "unknownIndexExtension");

Which would then know how to consistently print this advice about how to
turn off the warning.
