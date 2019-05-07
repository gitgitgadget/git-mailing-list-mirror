Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2231C1F45F
	for <e@80x24.org>; Tue,  7 May 2019 15:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfEGPqv (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 11:46:51 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38070 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEGPqu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 11:46:50 -0400
Received: by mail-ed1-f65.google.com with SMTP id w11so19188164edl.5
        for <git@vger.kernel.org>; Tue, 07 May 2019 08:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=x00MCxVDieeKfaprQbAR7jZL9pF/ID0vDLNmlHqec2k=;
        b=gI6FFmfUlzctw4Ooc0SNGgTkxFxiUCjYXlXuEyyz9gGQD7uZVgQwPLIj82+/nmIqoc
         dTJF2gX4zrJ8C5iERbeBBnFqe9xxKi+bugdlIPJzFRsBWjwnX5iIXmlgu0WgdE6GhDXC
         cF2snQtBhAXJD0Wfz1TZ4aKbWSxqcSceuDXNvMMxeQBQ2PRv+1byui4y84ZKNTmZzy7Q
         LBxw6++2KXsR5bR7t70e7Juw8BpTFLsDvZsium/rbnpkHLye4uirDHTLPKsmspGmDNVJ
         TWUnCd2MMThWv8wpmXgcgvHxgEtzX7ILDWLuBnMWZ271pQuoslDyjptm00cluUiR3qr/
         50TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=x00MCxVDieeKfaprQbAR7jZL9pF/ID0vDLNmlHqec2k=;
        b=tpDMOic2lV7+uiqefO2cIXVjQJxRiCWrM8NRqH9ufRT7FReRbOd893OKWv7CC9VPug
         z4GtG9MefHQ2ChDYMoDn4HWhTYGkVafBiEbGvTtFtCr9RFk+zUIJjv/sM8XmG65R3kbX
         iV6rGRvNDsi8f7+Fciu8aUztl5Mbi2b3DY3QRDJm1ZEew44GNaS4KyL0viyTJVjsMjlH
         sfaAZ0j9skbsSGOcOOLXOD2mopJMZGe2687F5rS7SFJ+n7zY19af7D/T2cwoPS7axCjw
         eoYK4B7QccakNwpheTHwVTt/yxvK8Zstfbkh12R5YqrdCubwT8YpJktQARshs/cnQsD9
         ndaA==
X-Gm-Message-State: APjAAAVrpqyN4ZzEZHGRdP2iTepaqtRoruJnqJyFly3Yr2YL5Vt38jHu
        XM3OS5qwscZtQj4AY79Wfj0=
X-Google-Smtp-Source: APXvYqwVmewP+dvzvjoIrpIgdLLXmgAg7fbg++vE/ze7hQnYD8ZhlXKUdMslamYvXfJQJ+HEibYxKg==
X-Received: by 2002:a17:906:4bda:: with SMTP id x26mr25093253ejv.176.1557244008589;
        Tue, 07 May 2019 08:46:48 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id o3sm2186806ejb.71.2019.05.07.08.46.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 08:46:47 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/7] teach branch-specific options for format-patch
References: <cover.1557072929.git.liu.denton@gmail.com> <xmqq4l66myn3.fsf@gitster-ct.c.googlers.com> <20190507141942.GA359@archbookpro.localdomain> <xmqq36lql2yg.fsf@gitster-ct.c.googlers.com> <20190507152118.GA12057@archbookpro.localdomain>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190507152118.GA12057@archbookpro.localdomain>
Date:   Tue, 07 May 2019 17:46:46 +0200
Message-ID: <87tve6gtcp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 07 2019, Denton Liu wrote:

> On Wed, May 08, 2019 at 12:05:43AM +0900, Junio C Hamano wrote:
>> Denton Liu <liu.denton@gmail.com> writes:
>
> [snip]
>
>> >
>> > Would you suggest moving to a format.<branchname>.* approach or would it
>> > make sense to rename the configs to something like
>> > branch.<name>.{emailCoverSubject,emailTo,emailCc}?
>>
>> So if I have to pick between the two, I would probably vote for the
>> former from the philosophical ground, but operationally, I suspect
>> that the latter would be much simpler to use.  You could even have
>> "git branch -d <name>" to get rid of them at the same time.
>>
>> But as I may have hinted in the message you are responding to, I am
>> not quite convinced we want these configuration variables in the
>> first place.  Why should both description and coverSubject need to
>> exist?  Perhaps we should add a heuristic like "If the branch
>> description looks like a single line, optionally followed by 'a
>> blank line and more paragraphs', use the first line as the subject
>> of the cover letter (and the remainder as the body of the cover
>> letter) or something?
>>
>
> I considered doing something like that but I opted not to because it
> wouldn't be a backwards compatible change and I didn't want to surprise
> any future users with a change like this.
>
> For branch.<branchname>.{to,cc}, I wanted these config options because
> the current method for format-patch to handle Cc-lists is just manually
> keeping track of the people who have responded and entering them into
> the --cc option of format-patch.

This may just be more insanity to implement right now, but perhaps in
addition to "gitdir:" etc. in the IncludeIf config syntax we'd want to
aim for "HEADref" (or some saner name). I.e. allowing to include/enable
arbitrary config based on the ref name.

Chicken & egg problems though...
