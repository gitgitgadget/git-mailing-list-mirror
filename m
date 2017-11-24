Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 827FE20954
	for <e@80x24.org>; Fri, 24 Nov 2017 10:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753136AbdKXK2v (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 05:28:51 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:45243 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752955AbdKXK2u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Nov 2017 05:28:50 -0500
Received: by mail-wm0-f51.google.com with SMTP id 9so21452065wme.4
        for <git@vger.kernel.org>; Fri, 24 Nov 2017 02:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=VKlNWs8+k7BuMCTmgx6NlxqhV/WnrejYoV097+21nKs=;
        b=mBwAURooSjB8HxHdI/vksV+2NWJ6ZF8zW0TzHc9YJCxZ7xXPwjC7+4CgItn7ovYf2P
         UoqsMmz1HoGGH9/CKtTe+uSTnAMKkZ2u4Om3sTaW+b6giLhHK4s+/G6uE+NaT0DNycn3
         GSOTiGcs6mtK5Q1ZxJd8G1XvzC0HsOFo7FBjlaI5sx1sv8oqSAL8XUliv2sra6kvluXz
         0OtXKL5St5qnsUfCgCmnh8RFL5oPI5aS+mZ59/OoyNeLsp75RU1xb2gOg8gEx65ZEqAF
         5stIWn/r6obLM3Tf7FFd5iWxG2YJF/x7qjA9WAbByXaJY5oPl1+1pE1daMa1EI22b+1z
         s8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=VKlNWs8+k7BuMCTmgx6NlxqhV/WnrejYoV097+21nKs=;
        b=A/NrN/1L9CMWRYu8upsK7zyyCslkdmJIpEEaJu2QkFhganYp1rzDhJVg1zh7TyVQUU
         l3vTINzgOa9viy9u1AhXPRwdterUdjhKVDGH5AE2ARWmILdKbi/+uHAltHQg0zjgov4K
         4F2dpZc9lQckyTA538y+jNPOQ34ie4rPhBN+6Mg0Q3RuZOmiWp7Ulb7nCCOwbQjvZm7S
         52/Pw7V0fJBWTJOlSiuq101BIPrQTyfC9UgcSEOXnrvDjkzbbxOp84qG4St346vGfPZj
         jwyUj5wETV3M50wQkaxJjtGuChoSSxjoiYqDrA0XnQe1aP9Ri8MHYHUPp9TP5nL7W5/0
         54BA==
X-Gm-Message-State: AJaThX6P7VADmTRtLTAPse+4HW5UhpPMKzc/19HktqbKGUkrZbMTp5qw
        wgASCU5iM9UfGyjoumX/EIhq0M0k
X-Google-Smtp-Source: AGs4zMbK5Vj1Peb4R2e/KPEaOaRErlF40NQqvEqI4Y3CkeDu6CeBNbQVUfuZOhHxGif8hAqdR4RNfA==
X-Received: by 10.80.163.138 with SMTP id s10mr32155881edb.302.1511519329326;
        Fri, 24 Nov 2017 02:28:49 -0800 (PST)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id r15sm16268608edi.52.2017.11.24.02.28.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Nov 2017 02:28:47 -0800 (PST)
Received: from avar by evledraar with local (Exim 4.89)
        (envelope-from <avarab@gmail.com>)
        id 1eIBDx-0007s5-Dt; Fri, 24 Nov 2017 11:28:45 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/9] perf/run: add '--config' option to the 'run' script
References: <CAP8UFD3tG3fOgftFJAB4mKD2N+uAH0aac4RmFmdXZ=ORHmKzQQ@mail.gmail.com> <0102015eb04f8927-439213ae-a464-4638-affa-f0d6484086c0-000000@eu-west-1.amazonses.com> <xmqqy3obslyb.fsf@gitster.mtv.corp.google.com>
User-agent: Debian GNU/Linux 9.2 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <xmqqy3obslyb.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 24 Nov 2017 11:28:44 +0100
Message-ID: <87wp2gug0z.fsf@evledraar.booking.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 16 2017, Junio C. Hamano jotted:

> Christian Couder <chriscool@tuxfamily.org> writes:
>
>> It is error prone and tiring to use many long environment
>> variables to give parameters to the 'run' script.
>
> This topic has been sitting in the list archive without getting much
> reaction from list participants.  Is anybody happy with these
> patches?

Very late reply, sorry. But I've looked these over and they look good to
me.
