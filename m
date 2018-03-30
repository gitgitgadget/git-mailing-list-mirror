Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F9001F404
	for <e@80x24.org>; Fri, 30 Mar 2018 18:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752163AbeC3Spt (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 14:45:49 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37354 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751968AbeC3Sps (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 14:45:48 -0400
Received: by mail-wm0-f54.google.com with SMTP id r131so17955071wmb.2
        for <git@vger.kernel.org>; Fri, 30 Mar 2018 11:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=OR2kT6q70BB75nkBzNUCNkAOY8ezNk/O3G9t6X3DJuE=;
        b=t0UmZW6m1b7YAPdWVF/d123XTR6uYK2vwjSgQeS6i6XZgbAUpRUNftZNj9F5/KuitR
         6sDzlwUY4iOmX+BoUiZ129hugOsGJwF1n33hJGfRXHvLoUveIbgoAUqRrsPHpPOmKdID
         fwN7fhpRMoZL0UKedBDpx3KdVZl0vwvb+BRFnelff9HuNnqmbyqXMoxq2koh5sfP3fkH
         JvJdEDekj5iFX2QMQPo5UyzEY9e2ylfZdZVt3ooD2VL0wtjnrVZNdtNS/UgaMxwuU8Ya
         fqYIvxo950W2G2TfTG7NOvQ3JH87DXz1DFjiN8l3aLqV0l91QxMhaxqvI2XGEpWekuPU
         WTjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=OR2kT6q70BB75nkBzNUCNkAOY8ezNk/O3G9t6X3DJuE=;
        b=TeWcKTByaXNnTlHfRVER98AWTkAtYUw7n+TVwQYYnIQUBpx+3S0H6wxvPx5Bcu2s9O
         q3n38UOHg9h5hamSrMMCYnxy4xVZyHJcGYjDCzbSRT7BA3rRPKZjWguW3qrNFiroiX1N
         VXrK2Pjl+NJBP/kn8LET6M31TrypBdKvA5y+Nzqms3lz/2694JsYXCJkc+WxmMouUMjQ
         WFjBm8hL/6CyMBv0k7xWuduchZ1M2ie4p9+9P4Wk+pI1p8OHQpng4r8XyYVw3zVOdRhB
         fBqQhlDM4CqMo85XnOPHiZWTh0Ud2Jo7fEzytS7u198kTV6evCudG/i6sMOC8maJLiWi
         V4mw==
X-Gm-Message-State: AElRT7GLUg0qRv+LQ5NhmejRCkr1ucC0RHCQxBE8Ge0/RNWe8GnBp79m
        opIGxssP4MF3lqocsIe/0ho=
X-Google-Smtp-Source: AIpwx491S4HHdMm4RvqZxdyaVL67ovnu7SQLb86Iw0BexUany2xOpwyqq1azk8MEo6VdwvkSrJSkdA==
X-Received: by 10.80.179.202 with SMTP id t10mr3865279edd.14.1522435547315;
        Fri, 30 Mar 2018 11:45:47 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id x44sm5646205ede.80.2018.03.30.11.45.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Mar 2018 11:45:46 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>, Phil Haack <haacked@gmail.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>,
        Duy Nguyen <pclouds@gmail.com>
Subject: A potential approach to making tests faster on Windows
References: <cover.1522336130.git.johannes.schindelin@gmx.de>
        <899ea23951627426ccd0aac79f824af386c5590c.1522336130.git.johannes.schindelin@gmx.de>
        <CAGZ79kapTWGsYznt7rr0QTNX+uH85TPY8AOA1jtDJ6_q8edX1Q@mail.gmail.com>
        <20180329194159.GB2939@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1803301415240.5026@qfpub.tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <nycvar.QRO.7.76.6.1803301415240.5026@qfpub.tvgsbejvaqbjf.bet>
Date:   Fri, 30 Mar 2018 20:45:45 +0200
Message-ID: <87fu4hwgfa.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 30 2018, Johannes Schindelin wrote [expressing frustrations
about Windows test suite slowness]:

I've wondered for a while whether it wouldn't be a viable approach to
make something like an interpreter for our test suite to get around this
problem, i.e. much of it's very repetitive and just using a few shell
functions we've defined, what if we had C equivalents of those?

Duy had a WIP patch set a while ago to add C test suite support, but I
thought what if we turn that inside-out, and instead have a shell
interpreter that knows about the likes of test_cmp, and executes them
directly?

Here's proof of concept as a patch to the dash shell:

    u dash (debian/master=) $ git diff
    diff --git a/src/builtins.def.in b/src/builtins.def.in
    index 4441fe4..b214a17 100644
    --- a/src/builtins.def.in
    +++ b/src/builtins.def.in
    @@ -92,3 +92,4 @@ ulimitcmd     ulimit
     #endif
     testcmd                test [
     killcmd                -u kill
    +testcmpcmd     test_cmp
    diff --git a/src/jobs.c b/src/jobs.c
    index c2c2332..905563f 100644
    --- a/src/jobs.c
    +++ b/src/jobs.c
    @@ -1502,3 +1502,12 @@ getstatus(struct job *job) {
                    jobno(job), job->nprocs, status, retval));
            return retval;
     }
    +
    +#include <stdio.h>
    +int
    +testcmpcmd(argc, argv)
    +       int argc;
    +       char **argv;
    +{
    +       fprintf(stderr, "Got %d arguments\n", argc);
    +}

I just added that to jobs.c because it was easiest, then test_cmp
becomes a builtin:

    u dash (debian/master=) $ src/dash -c 'type test_cmp'
    test_cmp is a shell builtin
    u dash (debian/master=) $ src/dash -c 'echo foo && test_cmp 1 2 3'
    foo
    Got 4 arguments

I.e. it's really easy to add new built in commands to the dash shell
(and probably other shells, but dash is really small & fast).

We could carry some patch like that to dash, and also patch it so
test-lib.sh could know that that was our own custom shell, and we'd then
skip defining functions like test_cmp, and instead use that new builtin.

Similarly, it could then be linked to our own binaries, and the
test-tool would be a builtin that would appropriately dispatch, and we
could even eventually make "git" a shell builtin.

I don't have time or interest to work on this now, but thought it was
interesting to share. This assumes that something in shellscript like:

    while echo foo; do echo bar; done

Is no slower on Windows than *nix, since it's purely using built-ins, as
opposed to something that would shell out.
