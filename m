Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6327E200B9
	for <e@80x24.org>; Thu,  3 May 2018 18:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751125AbeECSFu (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 14:05:50 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:52072 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750947AbeECSFt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 14:05:49 -0400
Received: by mail-wm0-f44.google.com with SMTP id j4so398107wme.1
        for <git@vger.kernel.org>; Thu, 03 May 2018 11:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=DoE/on8IQP8IKpCCMYnMuB7oXYfSflR/61t6sFyb00E=;
        b=Z6oQ8wMi/A/82qocH4ruCdKFDyAXh26lAbcq1sT87TpSs87GV32p3CWY9Hu0Jt5uWt
         Huvai6HXfNWkM9O8FaVD04Af3oTJuG4ZDUxoeX4qmFDETNvdDAsZG8Te8iwHeTZwdq2w
         /wD+8fPWd22VYh+nS2WBZZKig3R2GmeE/R85C7UJzcgmnHhxKOz3k2B96V56fNWvAxXo
         uKsYU04PxqnQb+v/4BSuxJuO3o4/uZ6mmG0Pyo0sUDE2D8+lGg1yJmUHo/j6jPpduvub
         OQeJI1oxMsvPcfU22CB+owasKS8ry4+EX+j/RDYEhvpVt5tWhunsZ1SD0MFABtkzJkUN
         qhKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=DoE/on8IQP8IKpCCMYnMuB7oXYfSflR/61t6sFyb00E=;
        b=dykCvlkiyKPt0p+r26wk32AUzOf3hKpGxM8/9XhGiqRoe6NHKG+3vJ5XmCY5n/bCME
         OclxZ5PyX1CJDPVGyEUNM35C5yJ0TUhNGGg8XJmeaspI49C/r5sreHRFc/h0IDRn2fA3
         aHPkF5vFZtXMkRb+Bk7tKuvhrDxHVTfCP3TSQhR480nPKj5Uc3XeKyVgcFcRezZMtcwF
         PDcI0r47aRtLXBu0kwQrA34hc9Zih0nw08Whi70idth8D5x8twISdNF4EpmBIySzosE6
         KusmDlURdUYzAoAR4ZTA0Xu1mRoReKiVnYnXpqo3YagDezunEcqgorkN3lK1f/KdMib3
         xdHg==
X-Gm-Message-State: ALQs6tCVUP6qWpQV52lrukISZH7FxvQ39o3x5QbhHecJN1sBBoNCPaEB
        8AzakaxIiD31dQjzOs+WqtM=
X-Google-Smtp-Source: AB8JxZoIBwV+qFMb7LzfKXD76AcdzPH/FIQG+SUU8axjnMT+n7wA9/G68Ns7OtVfk3iXKf5/f7kA4A==
X-Received: by 2002:a50:ba10:: with SMTP id g16-v6mr32116511edc.85.1525370748493;
        Thu, 03 May 2018 11:05:48 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id p57-v6sm8620355edc.21.2018.05.03.11.05.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 May 2018 11:05:47 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 00/18] Add `branch-diff`, a `tbdiff` lookalike
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <cover.1525361419.git.johannes.schindelin@gmx.de>
Date:   Thu, 03 May 2018 20:05:46 +0200
Message-ID: <87po2cy5qd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 03 2018, Johannes Schindelin wrote:

> The incredibly useful `git-tbdiff` tool to compare patch series (say, to see
> what changed between two iterations sent to the Git mailing list) is slightly
> less useful for this developer due to the fact that it requires the `hungarian`
> and `numpy` Python packages which are for some reason really hard to build in
> MSYS2. So hard that I even had to give up, because it was simply easier to
> reimplement the whole shebang as a builtin command.
>
> The project at https://github.com/trast/tbdiff seems to be dormant, anyway.
> Funny (and true) story: I looked at the open Pull Requests to see how active
> that project is, only to find to my surprise that I had submitted one in August
> 2015, and that it was still unanswered let alone merged.

I've been using branch-diff and haven't found issues with it yet, it
works like tbdiff but better. Faster, uses the same diff as git
(better), and spews to the pager by default.
