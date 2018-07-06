Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E74BC1F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 15:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932820AbeGFPi7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 11:38:59 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55755 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932703AbeGFPi5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 11:38:57 -0400
Received: by mail-wm0-f65.google.com with SMTP id v16-v6so15314728wmv.5
        for <git@vger.kernel.org>; Fri, 06 Jul 2018 08:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3bMXfpFOpLyzRhA+JMkvKl0qoBsYCs1R+QifNfddSYw=;
        b=Dt5YzXSXec2/079aa2kiXS11tjb96MM4x330ehlbYX7tURz9xX6DD+evWVEbZ5Bqq4
         +pot55kD9+2aKkmKlVeLxk3TJKdm071aBxN+tFOg9CZeVHhCsdd/gb9PJT658pOR3b+g
         7eiRCqQIgIZxmr9+sGJKI897KNqzbvClElGROA6iXJpsC/H04YYfbUmsPYA6QBlr5ciV
         PvW+5UA6yPdcDuOvnEcemN6h83TycD47TO3OXogB9MU2rqViV5tUyutdu7xmOGs6rFgA
         k38kXFlethgylKJnCNMgi9YGvZ0ymM/s/WTVQxOARqmZ136mXAilIC8SbmlU0Mt4jcGu
         WTJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=3bMXfpFOpLyzRhA+JMkvKl0qoBsYCs1R+QifNfddSYw=;
        b=DzZVgGh7Uxg81/iMQEbwtYn7Y4GPuHi9d71GZ8aU/+OeQ2/uOozvS5SVqQdW/OEcdD
         of82q+0ZzfEBAb22SlR4cJ9YmwfINVfzbk+tealpk5TGHGl4VqaoQ3rccLp0T7WuoE2j
         4vQrEPJqdBUV/WGAfk2RhURai0ZfsHwmbas43bJglVgfGe2lNUAONJY0D3/i0vhiLTXN
         FSVTlXuwW1rQl6tnsuWxOmyydK4lYlc3zODwoQQggoxAQje9sxVe40Hok38q6FyVI7lQ
         RutUTS7YQsD9RvUKvnOkoCcPtUVxPljCwn5kGQNt5wkajeySTGO2qwJVWzgTbJfmEckY
         RPrw==
X-Gm-Message-State: APt69E2/mY3DuLe6aPYY53DI5w/cpgb3c0vgHw6k4xGnkoLEZ4NGaG8T
        VxJIvX+v8KOK3m/CaEuGFYk=
X-Google-Smtp-Source: AAOMgpdIKiLPi//ArA8oVKE2yRO1UbQ+zdV/7A6i9ZxjuAYb8vITczsT0go7kY7Icd1s3LuWK/JMXA==
X-Received: by 2002:a1c:1748:: with SMTP id 69-v6mr1240222wmx.75.1530891536570;
        Fri, 06 Jul 2018 08:38:56 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id s17-v6sm6415784wmc.34.2018.07.06.08.38.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 08:38:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: as/safecrlf-quiet-fix, was Re: What's cooking in git.git (Jun 2018, #07; Thu, 28)
References: <xmqqd0wawpwy.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1807031344080.75@tvgsbejvaqbjf.bet>
        <xmqqd0w4ryi1.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1807041124330.75@tvgsbejvaqbjf.bet>
Date:   Fri, 06 Jul 2018 08:38:55 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1807041124330.75@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 4 Jul 2018 11:25:00 +0200 (DST)")
Message-ID: <xmqqtvpcml0w.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 3 Jul 2018, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> > On Thu, 28 Jun 2018, Junio C Hamano wrote:
>> >
>> >> * as/safecrlf-quiet-fix (2018-06-11) 1 commit
>> >>   (merged to 'next' on 2018-06-13 at b163674843)
>> >>  + config.c: fix regression for core.safecrlf false
>> >> 
>> >>  Fix for 2.17-era regression around `core.safecrlf`.
>> >
>> > Is this `maint` material?
>> 
>> Possibly.  Why do you ask?
>
> This is my feeble attempt at helping you triage. My question was more like
> a suggestion.

Ah, thanks.  That line of suggestion does help, and it would even be
more helpful when given before the topic hits 'next' or after
'master' from the workflow's point of view.

While the topic is in 'pu' I can change where the topic forks from,
and to minimize temptation to stupidly merge an inappropriate topic
(e.g. new developments and somewhat dubious fixes to commonly used
part of Git) down to 'maint' during the pre-release freeze
(i.e. when the tree is otherwise hopefully sleepily quiet and
boring), I try to base the (beginning of) good 'maint' material on
'maint' or older, and everything else on the tip of 'master' (or the
most recent feature release), when each topic is originally queued
in my tree.  If I missed a good topic and based it on 'master', it
is easier to correct such a mistake before it hits 'next', and a
suggestion like above would help me tremendously.

After the topic hits 'next', its course is pretty much set, until it
graduates to 'master'.  About a week or two after such event, I'd go
through "merge ... later to maint" entries in the draft release notes
and if the topic still looked relevant to the maintenance branch,
merge them to 'maint'.  Before that happens is another chance to stop
me from making a stupid mistake, or remind me of an urgent one that
I've been letting wait in 'master' before merging to 'maint'.

Thanks.
