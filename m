Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C79B1F453
	for <e@80x24.org>; Wed, 24 Oct 2018 07:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbeJXPsJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 11:48:09 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40203 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbeJXPsJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 11:48:09 -0400
Received: by mail-wm1-f67.google.com with SMTP id b203-v6so4231923wme.5
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 00:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=tWTQYpjq5RAjkhiT/2CuhyKJCOYOmnB0/YPS5YxNWI8=;
        b=IkyVGL240bKhgxU0FX2SlaLTQsh5xdy4EJOaH1q18MXF2sApUfOP1dHCJ4zbh15kFK
         GpihcBTifBHAzB7byRyVj0eV6+iQLWIvUAnBZ2t2UDxHTxVz55f1JX9cKpbOj1Me4CQh
         1+XXMtBgqef8QW/NGoOx86texntiwt1w9QTvrIs40hKn1Nm7hLb6Y9VIvXDb+rK9Bie+
         0l4pChpUlLUyQ5dQ8SqBPESlOdbHn2yod8FI3PiYYNR0YJ6Y2lPCTHWSa78nxfyJ1/O6
         wYZo1NaQzrqo5bCH2E8pH3s0U7rlI03+RoRuNm15sV/8JOThEaZgrZDgPn365FbLFKXo
         SIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=tWTQYpjq5RAjkhiT/2CuhyKJCOYOmnB0/YPS5YxNWI8=;
        b=VxrGu0AYaLNdRGSW6wS5/3LknRsFtnRxWAPwQHzqX74tJm4vC9n4hBo6vkXLAizIIs
         8+tC6cYd9N0uQWLUc5W+XhFS5IeMfnlufCdGG64MqrqBGBU9kqAdPQy2ENw7Fq2/J6Jm
         ecUGzQnNfM1/wQ3EpmEa4KqHH2AcpmV5pmfht+IJekYNiyQbYPB4xQYINNVjKLBc2ar+
         C2xmlTaDvwgckmEqnMNfxmsA8an+pSArKzy1oR/bA9YyO3icpxouTqevotjdhz+F512o
         9KPeIeeVhATDXX/NAa7vk2NLA4SmUJFlf8BK6AaxAX2fQ+7aOGvubXGlv/UhuRTqc1mu
         EDQA==
X-Gm-Message-State: AGRZ1gKVmgOqPjgwQTlw2xE5N0xAZvbuAfY5oHlPsA2jsKeFVB1ETiCl
        oBnN+vJCRINAjmQ+IAlq5pA=
X-Google-Smtp-Source: AJdET5dbi2sovGuRZis+Kitoti/clYc9tcok1K6W7kmE6JWGUipiwN71nWkBOs2HnSuJHWCPkLuuHA==
X-Received: by 2002:a1c:9e8f:: with SMTP id h137-v6mr1319287wme.142.1540365677859;
        Wed, 24 Oct 2018 00:21:17 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id d15-v6sm2931481wrw.78.2018.10.24.00.21.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 00:21:17 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ben Peart <benpeart@microsoft.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 2/3] reset: add new reset.quiet config setting
References: <20181017164021.15204-1-peartben@gmail.com>
        <20181022131828.21348-1-peartben@gmail.com>
        <20181022131828.21348-3-peartben@gmail.com>
        <CACsJy8Dcf8OknyMaSZxOaib54jLSSt71XXjTZD3UjgnH6J7QFA@mail.gmail.com>
        <e1f50b07-b3bf-0805-fcc9-692331dd170a@gmail.com>
        <xmqq8t2oqchi.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 24 Oct 2018 16:21:16 +0900
Message-ID: <xmqqva5rn72r.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> Seems a bit overkill to pull a line of documentation into a separate
>> file and replace it with a line of 'import' logic.  Perhaps if/when
>> there is more documentation to pull out that would make more sense.
>
> This change (ehh, rather, perhaps nd/config-split topic) came at an
> unfortunate moment.  Until I actually did one integration cycle to
> rebuild 'pu' and merge this patch and the other topic, I had exactly
> the same reaction as yours above to Duy's comment.  But seeing the
> tree at the tip of 'pu' today, I do think the end result with a
> single liner file that has configuration for the "reset" command
> that is included in config.txt would make sense, and I also think
> you would agree with it if you see the same tree.
>
> How we should get there is a different story.  I think Duy's series
> needs at least another update to move the split pieces into its own
> subdirectory of Documentation/, and it is not all that urgent, while
> this three-patch series (with the advice.* bit added) for "reset" is
> pretty much ready to go 'next', so my gut feeling is that it is best
> to keep the description here, and to ask Duy to base the updated
> version of config-split topic on top.

I'll take the "it is not all that urgent" bit (and only that bit)
back, even though the conclusion would be the same.  It is quite
painful having to keep this topic while a few topics that touch the
huge Documentation/config.txt is in flight.  The monolithic file is
large enough that it does not cause much pain while many topics are
in flight, but the single step of spliting it into million pieces
done by nd/config-split topic is a pain to merge.

Anybody interested may fetch, and try

    $ git checkout 5c2d198e8e
    $ git merge b2358ceaca

and imagine that you'd have to redo that every time somebody adds or
touches up a byte in the description of an individual entry in the
Documentation/config.txt file.  It is not pretty until we finish the
split.

