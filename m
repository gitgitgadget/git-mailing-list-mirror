Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAF2D1F404
	for <e@80x24.org>; Thu, 25 Jan 2018 22:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751641AbeAYW3h (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 17:29:37 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:42383 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751632AbeAYW3g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 17:29:36 -0500
Received: by mail-pg0-f66.google.com with SMTP id q67so5981162pga.9
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 14:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=o+6uZ0/cdlpe8/cU5PR1zpW+wxiDC7moKlD67M8bN1Y=;
        b=b9Yv6a98hYjo/Zn3U+nI2FZVrHbjCjcgY7YMBvlaAunwWSURoSVtLQ9iUv4jm+MOhz
         2LvUjXZtIwNnTQM3YOsSF86DwVhYqXgMcPgOYtvr0W2swT17G09STlfDOdSCZ6g7bqVP
         Qw7RBZWo2hKaWS4zplL3fyAoYyRAP3Borx8hslJHFOCHcmwdD9qzea3dyOEs8PBsMd0I
         RPFHSsEMcPp3A0GrZ5ZxNJxM+bW91UbD04/yEgrkvlS+ckfuxrmpwxz+ylM+cWt2Hmqm
         wpcJep5XjGdZ/9JUJcDuztXNfILwgy0wnChprpC5vLxFpIbl64lcVPVuGnMghgcL/ZOE
         lsOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=o+6uZ0/cdlpe8/cU5PR1zpW+wxiDC7moKlD67M8bN1Y=;
        b=ImxuFfxGTqK998znhSFm6vZOfY0KHSSPUkeThmPlAF39iaJTHqQvQlOoaX+HtapcEF
         DNNt97uG4d1XI/OKbzdW+vr+V8iWCFZ4rn2ihEHfUmBusQc2GIrqAYRq1Oy8fWuSzOy/
         1HTR3OfBUbKZR1hfFyCetFmIQwO+f9skMHmZRgCYoEGWYraNTnqvttVcpm+Q52pkSaov
         VhjdLLsEltWpRBV8Usl/Xf8sDI1CLJ9Ip9h56anxolwmY2eOOzhp+t84SgqD1T2dbv7a
         +TvWmOB7CkAkqzyggf99jQG2eDF2FiQHUbW6qTum4mOd9SbfkvJ1iXnhcTk/j8yrdvZI
         KA9g==
X-Gm-Message-State: AKwxytd9uukI1xFMMxI3OPjsRQOn4RhTk5rrXkv0zfjomCPOCwd9wVj0
        fBkvGHwoZnFbmm3PYGg7KLk=
X-Google-Smtp-Source: AH8x226Nr2TzvpDmQv9ofOnd/QZzqQ0+x6o2cx9RvrRWqUA6gtzTBFp78PC/crupSNTAi6P/O/YEDQ==
X-Received: by 10.99.180.6 with SMTP id s6mr13240984pgf.5.1516919375696;
        Thu, 25 Jan 2018 14:29:35 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3d49:4bb2:1738:a537])
        by smtp.gmail.com with ESMTPSA id s14sm5699013pgc.36.2018.01.25.14.29.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 25 Jan 2018 14:29:34 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 04/14] packed-graph: add format document
References: <20180125140231.65604-1-dstolee@microsoft.com>
        <20180125140231.65604-5-dstolee@microsoft.com>
        <xmqqr2qd8ug8.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZkhCmmF9hPRaf7RygDuWJd3edMDiAki8CDTJw3xG6BCg@mail.gmail.com>
Date:   Thu, 25 Jan 2018 14:29:33 -0800
In-Reply-To: <CAGZ79kZkhCmmF9hPRaf7RygDuWJd3edMDiAki8CDTJw3xG6BCg@mail.gmail.com>
        (Stefan Beller's message of "Thu, 25 Jan 2018 14:18:09 -0800")
Message-ID: <xmqqmv118tde.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> The downside of just having one parent or pointer into the edge list
> would be to penalize 25% of the commit lookups with an indirection
> compared to ~0% (the 35 octopus'). I'd rather want to optimize for
> speed than disk size? (4 bytes for 37k is 145kB for git.git, which I
> find is not a lot).

My comment is not about disk size but is about the size of working
set (or "size of array element").
