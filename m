Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B49DB1F404
	for <e@80x24.org>; Wed,  7 Feb 2018 23:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751186AbeBGXbY (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 18:31:24 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54104 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751123AbeBGXbY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 18:31:24 -0500
Received: by mail-wm0-f68.google.com with SMTP id t74so6224637wme.3
        for <git@vger.kernel.org>; Wed, 07 Feb 2018 15:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=iuyRmL7QW879dRX5I38T1lPnj7GCYn+kfSAlNjwj7AE=;
        b=TMOg3Vlxz8xzxOfQA61PHwZsvDkRHD4RBtfqne3hGXpkaZDWfFUHW9V19ZCZ2IthgN
         +taP/52/TymE6HrsfVQ67DNLSq7CJUh6eJmsaYm06jI8IOQBDWO4r5LoAM1KuFtU/8kb
         fwAynqDsfWOBZpga5trjOOUi1W5dKxvln55YTaHepYElNGnQUmUV10KPJp37eUOFhXRH
         YSN1WrvbOSsOnw1IHovirLZoQXSkFR63dx0v8Z5x6dA8fhkDltsG5YI7+0uzk/WiIAYt
         oVJDhTRyaTfy9k3SU6PTTYXHOgO76RjQbmNzcS+yAC2ZqHcawn4zW5ymoY2dNjez9vv8
         RBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=iuyRmL7QW879dRX5I38T1lPnj7GCYn+kfSAlNjwj7AE=;
        b=I3GBP00FMHKJD0LlVDge5WIB+y4uMH8B4BxyW90sfi9l73Uz6A9p7fdg7yGS8Dd9vZ
         vNKfRPC5Ffl/Tnbd2xu5rhgp2BmOUM6WSvbnPZRhZfrMKkV06yq6O6pmkaq0OEpLGHDy
         n2Ss0IgAEBjOF+aNAMWTjShRl1QqOcYbvjO49gvOJlo/34ZocTSng6INfegqIF1ZXKcS
         /Yhj859oRt02pbZUMnOXZqYtOsMlmSuK02I49Rtx3cFnxA4In8VB3EYk5IiNeFbpw+6q
         pen4E7kiYuNPFPA3ZuPLWojsaFj+s1xopRhw2wnZPnTzfKrcTe0RqMPJYYimyT8BdUZl
         zJ4g==
X-Gm-Message-State: APf1xPB5asUNrCBvyi0xgB6AndH/HsrPpTflE7r0AngW8XuWmejnP1nS
        YQpWuOhvvf4CaMPlNgL0VcY=
X-Google-Smtp-Source: AH8x224LfqQZpsS1i3n/1OdAN0xNv6RWHuz+OQEHl+OtDau05UaGEV87potcGDAQJbUkMKE8qVB6DA==
X-Received: by 10.28.105.80 with SMTP id e77mr3108316wmc.123.1518046282595;
        Wed, 07 Feb 2018 15:31:22 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h13sm4036240wrc.89.2018.02.07.15.31.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Feb 2018 15:31:21 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?=C3=98yvind_R=C3=B8nningstad?= <ronningstad@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Sergey Organov <sorganov@gmail.com>, git@vger.kernel.org,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 5/8] rebase: introduce the --recreate-merges option
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
        <71c42d6d3bb240d90071d5afdde81d1293fdf0ab.1516225925.git.johannes.schindelin@gmx.de>
        <87k1vpqq85.fsf@javad.com>
        <nycvar.QRO.7.76.6.1802071818240.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <1518044326.7000.4.camel@gmail.com>
Date:   Wed, 07 Feb 2018 15:31:20 -0800
In-Reply-To: <1518044326.7000.4.camel@gmail.com> (=?utf-8?Q?=22=C3=98yvind?=
 =?utf-8?Q?_R=C3=B8nningstad=22's?=
        message of "Wed, 07 Feb 2018 23:58:46 +0100")
Message-ID: <xmqqpo5g5qd3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Øyvind Rønningstad <ronningstad@gmail.com> writes:

>> So no, I do not think that --recreate-merges --first-parent is a good
> idea
>> at all. Unless you try to do that non-interactively only, *and
> disallow it
>> in interactive mode*.

Correct.  If the original side branch has commits A, B and C, you
are rebuilding the topic to have only A and C but not B and then
recreate the merge of that rebuilt topic, then you absolutely do not
want "cherry-pick -m1" of the original merge when recreating the
merge, as that would resurrect the effect of having B.  The same
argument applies if you rebuilt the topic with A and C and then a
new commit D.  "cherry-pick -m1" of the original would do a wrong
thing.

When there is no such fixing up, "cherry-pick -m1" is the right
thing to do, though, so it probably makes sense to pick merges that
way when the side topic being merged consists of the same commits as
the original.  I do not think that the code structure in the topic
as posted makes it impossible (or unnecessarily hard) to give an
enhancement like that in the future as a follow-up series.
