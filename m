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
	by dcvr.yhbt.net (Postfix) with ESMTP id 45BB61F51C
	for <e@80x24.org>; Thu, 31 May 2018 07:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753957AbeEaHc3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 03:32:29 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55240 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753846AbeEaHc2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 03:32:28 -0400
Received: by mail-wm0-f67.google.com with SMTP id f6-v6so52095108wmc.4
        for <git@vger.kernel.org>; Thu, 31 May 2018 00:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=Oegfd0I3gezD3TQMJ535VlqueQTKuWtaxdcgtOhJjJA=;
        b=EifnsMsNb7v2epkLlkuxawOEZDkSJ4bEQhc+afBISqZRo+/Tnxjga3ff/xzHK+VnU+
         3kOkQe3gLbgNpV25n1EA2J/I2SfUh0tYIY4MZrguRNdLTm01xJLuO8HN4Cqrie7tcZol
         njt3fJtOmRMTQRZIsSub0GfPhxcjsIdT9f4hx6CE2diREAMasqavvGewdk9SIht9yg1C
         mjjr/BN//gqmU0O/Mural2nyxTRJskjmy3mkUyxRbI6cSJFh9yOws3vcGKkK0XWwNb9k
         DkJfqV4vhSeaQyO2iHIVJD2ZZws/P1XpB4/eRK7JRrGuaX8QrfvZU1mRDmypvs2YXMC3
         SrsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=Oegfd0I3gezD3TQMJ535VlqueQTKuWtaxdcgtOhJjJA=;
        b=iooJM1eIR3JmLfLAVtWTeX/9BuYAH5cFwnA8rYzfF64oX3jZOl2rxkFmZ4wVObqoH8
         kUGScrp14TFhzshcfdlJMLNdNR5Ip7vPliuEHaDjOb0zqIj8xIhKCipJk6Q3zRJOyEyE
         GfzXf86iqfvWn4BXF/ukMnqC/6h7L/kI3H3E46OxLObF5EzL8Z+c+Zh0/6W5kT2IoztV
         3TX6sk10brmJdv2+6cEM3JdsHeipyPMEOSd0weK9E5c6NBA+tpB4hIONQTVe+PFeCDPu
         8cnQaxBudAyXy2e2NU/aRw5hsHYMqUIGXXqN1PcJfkgx3QcCfXE61n85tskzDeQBTNd5
         bVtw==
X-Gm-Message-State: ALKqPweRh6RiuHMCNZQo5KhgiY/QInZhNCYEBo1xBB3QGA/q/DsatQta
        pEFJbZmEYh4OCAg725egkug=
X-Google-Smtp-Source: ADUXVKL1qtClZki3OX/mp8yuYWJIo/YY187K6iJWt7hfLXW8+PT1Gw3rLPOsDOjN8Y3ODTMnvObvWg==
X-Received: by 2002:a50:b14c:: with SMTP id l12-v6mr6543816edd.65.1527751947040;
        Thu, 31 May 2018 00:32:27 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id b4-v6sm20239983edr.29.2018.05.31.00.32.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 May 2018 00:32:25 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/4] config doc: elaborate on what transfer.fsckObjects does
References: <20180524190214.GA21354@sigill.intra.peff.net>
        <20180524193516.28713-1-avarab@gmail.com>
        <20180524193516.28713-4-avarab@gmail.com>
        <CAPig+cSd32O3ELaHxLD0_yRFmjMAo2k-jApopJmuEt7Z6W40-g@mail.gmail.com>
        <xmqq4liwpggs.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqq4liwpggs.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 31 May 2018 09:32:24 +0200
Message-ID: <87d0xc9t6f.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, May 25 2018, Junio C Hamano wrote:

> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>>> +will instead be left unreferenced in the repository. That's considered
>>> +a bug, and hopefully future git release will implement a quarantine
>>> +for the "fetch" side as well.
>>
>> If this was a "BUGS" section in a man-page, the above might be less
>> scary. In this context, however, I wonder if it makes sense to tone it
>> down a bit:
>>
>>     On the fetch side, malformed objects will instead be left
>>     unreferenced in the repository. (However, in the future, such
>>     objects may be quarantined for "fetch", as well.)
>
> I had an impression that nobody else sayd it is considered as a
> bug.  Do we need to say it in this series?  I'd rather not--with or
> without such a future modification (or lack of plan thereof),
> teaching the fetch side to pay attention to the various fsck tweaks
> is an improvement.

I changed this in v2 to tone it down, but given what Jeff's mentioned in
https://public-inbox.org/git/20180531060259.GE17344@sigill.intra.peff.net/
I'm inclined to bring back some stronger wording for it. Something like:

    Due to the non-quarantine nature of the fetch.fsckObjects
    implementation it can not be relied upon like receive.fsckObjects
    can. As objects are unpacked they're written to the object store, so
    there can be cases where malicious objects get introduced even
    though the "fetch" fail, only to have a subsequent "fetch" succeed
    because only new incoming objects are checked, not those that have
    already been written to the store.

    This is considered a bug and will likely be fixed in future versions
    of git. For now the paranoid need to find some way to emulate the
    quarantine environment if they'd like the same protection as
    "push". E.g. in the case of an internal mirror do the mirroring in
    two steps, one to fetch the untrusted objects, and then do a second
    "push" (which will use the quarantine) to another internal repo, and
    have internal clients consume this pushed-to repository, or embargo
    internal fetches and only allow them once a full "fsck" has run (and
    no new fetches have happened in the meantime).
