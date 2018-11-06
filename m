Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 269D51F453
	for <e@80x24.org>; Tue,  6 Nov 2018 17:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730780AbeKGDLG (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 22:11:06 -0500
Received: from mail-ed1-f48.google.com ([209.85.208.48]:37911 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730671AbeKGDLG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 22:11:06 -0500
Received: by mail-ed1-f48.google.com with SMTP id a2-v6so6635616edi.5
        for <git@vger.kernel.org>; Tue, 06 Nov 2018 09:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=66sVDiwZQ/pGDLMiGhs/QqeNFGVbH1hQQNM7Potc55Q=;
        b=j+lOWp6d4awUyXZhJ3NyExXsDdNdQNcHWSgSKPFGOiKPFt5eP0z7f1dmfvkVvNLe1E
         LeLkXKcm8j9gBRbSP3GATsKKJpHJcQUpEBObj7S2WveDg8KQ5UmG6LAduBCsHDeGuCAE
         NT33Vnj9BithG/W16U+pptHlUd71zZ4ogruG94O0cjHttWN3V/b+hrAguOOnTKxahEMv
         /43ZQNUvC+uTzXUyBV6E2Ohiav2J7uJONmnBwD8RRv0HdDstWhwZ0Gqqg4YSJ7bXfRI6
         UA2hbkPA6+JDNaZuYpl9b/qrS+0sSVhzJ1I6Sq3p/6C6bT7O4O/MldsmoCGjSMgNPO/i
         iGHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=66sVDiwZQ/pGDLMiGhs/QqeNFGVbH1hQQNM7Potc55Q=;
        b=hG919wBluzFHbYlOvJrCSl+Nq+IPKZn66s5pMlLGUn0ytazUUaDyJZBrHsiFo8+XNw
         rpJW9xi2r8lWwpWdMMrwGD4O85LWUmZvnpQhxZkjGnayKpptjF5hYM1LvFc+vSpxlKY4
         X2HTqVAx9FDtwUZRH5xMkBaEY5un22KmeOJjgV8eA5RL4+sx/0TL7hmhyDDDK8w5H6Ja
         CPAnlAjpxDNL0zmdXdCopFjmqjGXtnb+kWvh83nVpiRL1kubvg1BP36H5ZdJqxSeFRFG
         uYItFShA0zFZhojR6KAhYuK12G4P1vwZRRdONo58WO9m9gdcu4s9PJx2kqtn7Y0p3ZV+
         ZA/g==
X-Gm-Message-State: AGRZ1gJP/SP3vleUgWMYzX+lHnhY+/AtgAz0JoWZp88SG0V6Bk2x/fr9
        A4Z1nvaOyal8ivMJApOneA4=
X-Google-Smtp-Source: AJdET5eckBgJmU7XOYY/I/o5wn+7y8vtESEgBJ7gHR7c6h9P2DCOyymzRbaSQwQ+C6R7u/dRbhudOg==
X-Received: by 2002:a50:aca2:: with SMTP id x31-v6mr22069044edc.76.1541526285792;
        Tue, 06 Nov 2018 09:44:45 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id p26-v6sm2236736ejd.15.2018.11.06.09.44.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 09:44:44 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH/RFC] sequencer.c: record revert/cherry-pick commit with trailer lines
References: <20181104072253.12357-1-pclouds@gmail.com> <87bm727fcw.fsf@evledraar.gmail.com> <CACsJy8Cm6EBVDf6pk47dBdbpe+qdJAM97vQXXW-B1VHF10nTmw@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CACsJy8Cm6EBVDf6pk47dBdbpe+qdJAM97vQXXW-B1VHF10nTmw@mail.gmail.com>
Date:   Tue, 06 Nov 2018 18:44:43 +0100
Message-ID: <8736se6qyc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 06 2018, Duy Nguyen wrote:

> On Tue, Nov 6, 2018 at 9:57 AM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
>> Leaving aside the question of whether the pain of switching is worth it,
>> I think it's a worthwihle to consider if we could stop hardcoding one
>> specific human language in commit messages, and instead leave something
>> machine-readable behind.
>>
>> We do that with reverts, and also with merge commits, which could be
>> given a similar treatment where we change e.g. "Merge branches
>> 'jc/convert', 'jc/bigfile' and 'jc/replacing' into jc/streaming" (to use
>> git.git's 02071b27f1 as an example) to:
>>
>>     Merge-branch-1: jc/convert
>>     Merge-branch-2: jc/bigfile
>>     Merge-branch-3: jc/replacing
>>     Merge-branch-into: jc/streaming
>>
>> Then, when rendering the commit in the UI we could parse that out, and
>> put a "Merge branches[...]" message at the top, except this time in the
>> user's own language.
>
> My first reaction of this was "but branch name is a local thing and
> not significant anyway!". But then if people use one branch as a
> bundle of other branches like 'pu', then the ability to recreate
> branches (with the right name of course) from those merges may be
> useful. So... yeah, maybe.

Yeah, in theory, in practice no. But all I'm observing is that we're
*already* encoding this information, so to me at least the logical end
game to changes like what you're proposing is something like the above,
otherwise why bother?

But having thought about it a bit more I wonder if
git-interpret-trailers (or some command like it) shouldn't just as a
special-case learn to do more parsing of commit messages we've
historically generated.

E.g. know how to parse out a merge message we've produced and spew out
something like the above Merge-* output. Same for existing "Revert"
output, if anyone cares about parsing this they'll need to do that
anyway.
