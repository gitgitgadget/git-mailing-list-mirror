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
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B0EF1F51C
	for <e@80x24.org>; Fri, 25 May 2018 07:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935822AbeEYHpN (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 03:45:13 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37190 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935235AbeEYHpM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 03:45:12 -0400
Received: by mail-wm0-f41.google.com with SMTP id l1-v6so11985986wmb.2
        for <git@vger.kernel.org>; Fri, 25 May 2018 00:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=+BKOSC+Q4xUnmNrt91wY427RbkUKLz47218ZQ7eauTU=;
        b=N8P667HnTHoR+uiXcBgQ8rQTq0X4zW+w8N8XoKlpDGLw5mj+HTAxwd8qz1eVDl5Xu0
         Wl0ScixIvZWS7GIAIXuBDprk+Voc+sGI1sbvsZaaln6EW+Afe5vkvFImA9lOkPbw6zGH
         C17A8jTBXVcY1jhuhz/jiOZsOL41FhglmrWwAc6QYqkM9rAd4Xqfhwr06INKmoDi1/dO
         NtQve4vs4vVywgKLWL/nNiRtJpCs9GVPwNHHqWLenWcitThdJWFZ4jhsEACk2CFM9G3c
         SxnAJoI9vdeVCFKu0YntFezyaABL5L5joEOv/4HtxgZShBXCZ4UQFU8ZcDUpUHCc2aCI
         em9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=+BKOSC+Q4xUnmNrt91wY427RbkUKLz47218ZQ7eauTU=;
        b=PC8K1h5yNEHuoBQIsVPWbfvAogozdG1AwEoVxiWR9qUUpJkOdxAJ/v1TlkKjT6piRs
         zs4KvpJZIxtXU3eUh6YLOs1rKcq8BBvaQNPuiiaTmcEka9LhSJiff9tT3o3JIOtc961E
         a8L9SMe17LHa3P0pmChIV8+n443i/aZsEWIZ2hrUOjLOvsgzHFpytOX8Il01Ae7/CQcZ
         02+2GWCuRpKEQ2O3XNMrEGwQAo4BiD/mfYD1eILeQpraS89cUCgFMJikJw7+xM0r/ECk
         1MEgSlMvGH7vKZZsB1ss9dlli98ZeTSwr5MgJdVkPJV0Y79yZiqWfypY8cq83fks/M0j
         o7bw==
X-Gm-Message-State: ALKqPweLhfzj4eFJoHA2FyLnOn7/MLf5BX/P7t85bDB75nnl/HL04gp2
        9l532l3LW7i1K1xDFWwTCpzRubnb
X-Google-Smtp-Source: AB8JxZpq3I0PzLIGuh+7dIDWHuXcd9UXLaUJfD6DIhSbmM5I2ZtMYw1wETgp9GHKGBm7r2CskDAcFw==
X-Received: by 2002:aa7:d489:: with SMTP id b9-v6mr1616641edr.121.1527234311389;
        Fri, 25 May 2018 00:45:11 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id j22-v6sm12381885edq.92.2018.05.25.00.45.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 May 2018 00:45:10 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: "man git-tag" inconsistent about whether you can tag non-commit objects
References: <alpine.LFD.2.21.1805241040400.14773@localhost.localdomain> <xmqqpo1kpl9i.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqpo1kpl9i.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 25 May 2018 09:45:09 +0200
Message-ID: <87muwo6uwq.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, May 25 2018, Junio C Hamano wrote:

> "Robert P. J. Day" <rpjday@crashcourse.ca> writes:
>
>>   embarrassed to admit i had no idea that you could tag non-commit
>> objects, only realized that when i was reading the man page and saw:
>>
>>   SYNOPSIS
>>      git tag [-a | -s | -u <keyid>] [-f] [-m <msg> | -F <file>] [-e]
>>            <tagname> [<commit> | <object>]
>>                                  ^^^^^^^^
>>
>> so i tried it and, sure enough, i could tag a blob object. but if you
>> read further into DESCRIPTION, about halfway through, you read:
>>
>>   "Otherwise just a tag reference for the SHA-1 object name of the
>>    commit object is created (i.e. a lightweight tag)."
>>    ^^^^^^
>>
>> which suggests only commit objects. finally, much further down, under
>> OPTIONS:
>>
>>   "<commit>, <object>
>>      The object that the new tag will refer to, usually a commit.
>>                                                 ^^^^^^^^^^^^^^^^
>>
>> so to clean this up, is it sufficient to just change that middle line
>> to say "object" rather than "commit object"? or is there more in the
>> man page that needs tweaking?
>
> As that sentence talks about a lightweight tag (i.e. a reference in
> refs/tags/ hierarchy that directly points at an object of any kind),
> another possibility would be to say
>
> 	Otherwise a tag reference that directly points at the given
> 	object (i.e. lightweight tag) is created.

Related, this recent patch of mine:
https://public-inbox.org/git/20180429202100.32353-6-avarab@gmail.com/#t

I.e. might be worth talking about this briefly in the git-tag manpage as
well, i.e. that you can create a lightweight "tag" to a commit, but then
depending on where you push it it becomes either a branch or a tag,
which may not be intuitive to users...
