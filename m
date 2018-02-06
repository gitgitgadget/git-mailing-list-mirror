Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 732CC1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 14:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752166AbeBFOgF (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 09:36:05 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35736 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750990AbeBFOgD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 09:36:03 -0500
Received: by mail-wm0-f65.google.com with SMTP id r78so4291329wme.0
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 06:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=SS/LOR7svsz4ftFVmto5XqrXYIZpGioQqQo4YEKHSU4=;
        b=sr5ThRToOIRa/GgD7S2lO/kzkacP4Y9UcSh1hg75B1zv9X617tbLd2lZlCa/JNczaM
         3IJ+zogjProS1rpH/A37SeEEFr6cQXAQJ3Rt1EkhnTCkEQzN8UoX3aBpj+4MPvzVVq6x
         FRHIEId5hMlkUzaJO9MJVwLc52CrhWly6UMS2i206gPaErnJ3cIsYvy0Aya1alD284n7
         Kj212HlSygNaKatRtBeEgPRqnV/+4W7ro+FHN+8mmgely/tQgTnqUHDhFpJXov7ExcZb
         bufhDT9i+0EJaINJOHGKOa8orj0FMOxLrq/4Um6YPJep0NDrUclmfq8aPvJQK9uuRHKS
         e1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=SS/LOR7svsz4ftFVmto5XqrXYIZpGioQqQo4YEKHSU4=;
        b=sS+zjk3a1SQo5XBkdO4OmND9ogJ2RlS7F8HvOWCr6tZwoURwfVqsw4O1HZbyDpVEZz
         xcPuqSNlKIfky1NMqS4SxFYoDXI0n/uHG12oXdal6MZvXnXTH71ppcPXx6wNLeNrRlqE
         FtwJy+oUfuJvVJX9Q+0jRGAsUXoKz6kx1vS3N9ZnaE08Li99OEwWWTfC0KX2xBYlEWPc
         Vr+pobHRQSQVheM33tdH+7AHX/B8/J3y4Gz1fBsoRlRVy1f/QbOn4X9W0L9jG4cgMHM2
         u749UELLh1viY++/mNu8qwVFwUCQvSQYSJ8owvpbZeHIpuTE9y+S4B3W4AmtgyjtK/M2
         UOgA==
X-Gm-Message-State: APf1xPAj0DHYFrbamgJ5FZTxjvGHM0dEkxhMSzWA1kiVHUHEdfwEgJId
        hshFka0B+pDWwAq8yEB4kxI=
X-Google-Smtp-Source: AH8x224XsbkPW3xHI5j+45NxFZGZ/ITeTEbulpcJXpufJ7NeZnSFoIJyQ4S78Bc4dr5t47bLJTLTzQ==
X-Received: by 10.28.209.206 with SMTP id i197mr1925122wmg.102.1517927761659;
        Tue, 06 Feb 2018 06:36:01 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g8sm23090311wra.18.2018.02.06.06.36.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Feb 2018 06:36:01 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Filip Jorissen <filip.jorissen@kuleuven.be>,
        Torsten =?utf-8?Q?B=C3=B6g?= =?utf-8?Q?ershausen?= 
        <tboegi@web.de>, "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Cloned repository has file changes -> bug?
References: <BCFDB3A3-B515-4932-AC67-F720AEB4B0BE@kuleuven.be>
        <87607nvzrd.fsf@evledraar.gmail.com> <20180128075731.GA17412@tor.lan>
        <CD3563ED-5E0D-4238-A664-4F2335598FE2@kuleuven.be>
        <87lgg6l08m.fsf@evledraar.gmail.com>
        <20180206141423.GA28721@sigill.intra.peff.net>
Date:   Tue, 06 Feb 2018 06:36:00 -0800
In-Reply-To: <20180206141423.GA28721@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 6 Feb 2018 09:14:23 -0500")
Message-ID: <xmqqinba89tb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I'm not entirely convinced it's worth all of this effort, but I think it
> would be _possible_ at least.

I thought that the original poster wants to have a knob that the
project can ask its participants to enable in their clones of the
repository that wars this situation when they "git add".  When a
projects considers that macOS users must dictate the world order
because its source must be checked out on case insensitive HFS+, it
may be sensible to force participants on other platforms whose
filesystem does not guarantee that two paths that "normalize" to the
same string will not enter in the project history to spend
application cycles to do so instead.

That admittedly is quite a macOS centric view, and it is not a very
pleasant one, as it means almost all individual _applications_ on
other platforms that conceivably could be used to work on a project
macOS folks would want to be treated as first-class citizens would
need to learn about the peculiar filesystem limitation of one
particular platform they otherwise may not necessarily care about.

