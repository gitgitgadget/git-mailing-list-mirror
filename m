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
	by dcvr.yhbt.net (Postfix) with ESMTP id 04BC71F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 19:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbeK1Gg2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 01:36:28 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42502 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbeK1Gg1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 01:36:27 -0500
Received: by mail-ed1-f68.google.com with SMTP id j6so20033749edp.9
        for <git@vger.kernel.org>; Tue, 27 Nov 2018 11:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=jjUcQn9NDt2PI5DEgpNV7EsN5eRC9ffuIDrIPwdx0j4=;
        b=hNWGbqfjktgThFulgTUr7t1oRsTUBri/HpPy9NQWWK3u3d12tP2k5Ss9O6GHUSFB/w
         DqBTrOhgKl+h13QSNwUznQfOq/FCQgfryTKG6qvKKmYtRXj+pInrdfsZmgAjhz+mHXq1
         GNB0Tq0R2DVp922t6NzLITnw1QPEXo4d+8Wq9d429KsOH6bjQ+Tto04wTm9/kHqJiPcr
         gcvkEbc8+likU4pJ1EyzBuLmWgypsJ5ej8PBJwrmg3zd+iCYQMb50lJPiZ/EEqwq90PZ
         SkA/ESE7fCskNaK9FVpSZ7np/5eIiW9HNsZMvVn6RiR1SCKk3L9uvDKwyzlx7VqvYcwO
         Vucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=jjUcQn9NDt2PI5DEgpNV7EsN5eRC9ffuIDrIPwdx0j4=;
        b=o5V1qcC34W6sxMnU563WWR8knuSSjwwhepwcRH8DOeTAvHbC/6y/Wdz7/nf6j32MvS
         jFdHfmqTOZqVT3vnCcBqCzUNmVuzD8yomv1ZdaSuOlMW9J+GM26K9VQNa695GZ9CLNAV
         g2ii1Hi3ZYwKjla7rcEp7BnVFzl0kTV/bJzxuFYQooPaSA2/A/ZgG0RTTl+UYLx9yj8w
         p4pvH8BgLnRpQqpM4UFNjjM/1epO0+Dv5suH4l9P7Dvl6dS5QdvD4CeYeoilMHSWb0mG
         NPOT6m4pRo+zeUByYNwy6jAn7bE7hL0yPHFLjacmsgK5mJ8VlcnJA14H1OOn+9gfdGj1
         HNOQ==
X-Gm-Message-State: AA+aEWaopuLyDv+B+JH/Wl+BYoVAzG9tX6jh58cOfHNnnkVLJMRN2MUM
        RmTPM9QeBHcFRloEbLLp9qSWoksk
X-Google-Smtp-Source: AFSGD/UOs6JxRXF/Y4yrd2ZPguTgYEC2sip03sn1ddUo8Rt+UpAEKf+h1kS9IRReHqgwyJUkthlxwQ==
X-Received: by 2002:a50:8343:: with SMTP id 61mr28165306edh.154.1543347449359;
        Tue, 27 Nov 2018 11:37:29 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id d2sm1216881eda.92.2018.11.27.11.37.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 11:37:28 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        hsed@unimetic.com
Subject: Re: [PATCH] tests: avoid syntax triggering old dash bug
References: <20181127164253.9832-1-avarab@gmail.com> <CAPig+cS-_m8RBsCME_Gj15EEs1tcFcGn0Acfvq4HgxKiL9PaHg@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CAPig+cS-_m8RBsCME_Gj15EEs1tcFcGn0Acfvq4HgxKiL9PaHg@mail.gmail.com>
Date:   Tue, 27 Nov 2018 20:37:27 +0100
Message-ID: <87k1kyz4zs.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 27 2018, Eric Sunshine wrote:

> On Tue, Nov 27, 2018 at 11:43 AM Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>> Avoid a bug in dash that's been fixed ever since its
>> ec2c84d ("[PARSER] Fix clobbering of checkkwd", 2011-03-15)[1] first
>> released with dash v0.5.7 in July 2011.
>
> Perhaps enhance the commit message to explain the nature of the bug
> itself. It is not at all obvious from reading the above or from
> looking at the diff itself what the actual problem is that the patch
> is fixing. (And it wasn't even immediately obvious by looking at the
> commit message of ec2c84d in the dash repository.) To help readers of
> this patch avoid re-introducing this problem or diagnose such a
> failure, it might be a good idea to give an example of the syntax
> which trips up old dash (i.e. a here-doc followed immediately by a
> {...} expression) and the actual error message 'Syntax error: "}"
> unexpected'.

I haven't taken the time to understand the bug either. Our entire test
suite had one instance of this, so I think it's obscure enough that it's
fine to just fix it as a one-off and not spend any more time on making
sure it doesn't happen again or add some lint for detecting it.

>> This fixes 1/2 tests failing on Debian Lenny & Squeeze. The other
>> failure is due to 1b42f45255 ("git-svn: apply "svn.pathnameencoding"
>> before URL encoding", 2016-02-09).
>>
>> This particular test has been failing since 5f9674243d ("config: add
>> --expiry-date", 2017-11-18).
>>
>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
