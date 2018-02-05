Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 943D01F404
	for <e@80x24.org>; Mon,  5 Feb 2018 20:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751225AbeBEUJj (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 15:09:39 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38330 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750949AbeBEUJh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 15:09:37 -0500
Received: by mail-wm0-f66.google.com with SMTP id 141so28151241wme.3
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 12:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=MzcF7DDz0Zw3RIa0za8+bqkMSL2oHq5K3APVMhNPVE0=;
        b=FeBNfTE48shkhnBlayzvCy3c62GYrZ56DwztDi3kvpHIowSncJcah23ojOi1w4fi53
         TmIFjCIW85ZP8K1anKGCQgDNHZP5/Dblv2yOaNKYdm+RPYLqfM78snK8H8/aUh3GxRHM
         srFqh5WNA2WDyvZ612+3S4ZVz3VXefwU0N/ybEO/y37QYMAEu9epNWheZsI3hHpr/g3s
         UcxjBNAFHEKQNNVtiKeePoURjbiF/YwqGgm31l0QDFAf3Sl6LahXzNuq9da7U5XwquDD
         /cVglzwSTJ3iiD3zu0H4J3CCZgcIC0AMjw/PG78FHm2gZlmyVh5+PaOgxrxGMQkFEaCE
         D5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=MzcF7DDz0Zw3RIa0za8+bqkMSL2oHq5K3APVMhNPVE0=;
        b=JgnxdJXb/x8xlC8qWAacvWYamq4hS7LfgSiV2AeERtNnfwtJuKshmJdWks9PyNQQZv
         zLRVGihXbof/f720ZyAkUqdpim6o27ZPdxG6hfXi0FcAJXY9lM+3WlBOJCaAyYSZ6uDA
         0jM5vcnYqf0dMzYoFeObSJM0uQG0EwA9SV629Eu8k39BbPVD4HeaKHcOMaIETiZxbDva
         GNG1iXgk/mc6dT4XZNAW+sl+b0JL0gDP8gU7iYQqz+AzJtY19UhO4zCrhRgpkVbZ4SV+
         k8PjwfbTs3EiB3SDWdbMkzjTJaEpOMU30otf/P10xay+m3pO+nPQF3WwDiFFWz4mOeNZ
         O1Ig==
X-Gm-Message-State: APf1xPCGlzWi26iBwc2R0pZE1YLNr9pLe/DKKoJzdNYMTmkdurwWKsDB
        kTuXHepv/FtItfGxP2+EFZI1KNU+
X-Google-Smtp-Source: AH8x226+W2aElwY35xcKLXNa3LzybyZJnoRma/3jvvnpHXTn3tojiYfy+72AuMYmeRXC6LCbWhrfQA==
X-Received: by 10.80.171.21 with SMTP id s21mr626430edc.117.1517861376265;
        Mon, 05 Feb 2018 12:09:36 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id c90sm6887903edd.12.2018.02.05.12.09.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 12:09:35 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Lucas Werkmeister <mail@lucaswerkmeister.de>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v4] daemon: add --log-destination=(stderr|syslog|none)
References: <772ae5fc-5f92-3494-613a-a44c0073e8d7@lucaswerkmeister.de> <20180204183037.23162-1-mail@lucaswerkmeister.de> <871si0mvo0.fsf@evledraar.gmail.com> <0306739c-3fba-2528-f08f-831a31c202b0@lucaswerkmeister.de>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <0306739c-3fba-2528-f08f-831a31c202b0@lucaswerkmeister.de>
Date:   Mon, 05 Feb 2018 21:09:34 +0100
Message-ID: <87vafbkxkx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Feb 04 2018, Lucas Werkmeister jotted:

> On 04.02.2018 19:55, Ævar Arnfjörð Bjarmason wrote:
>> 
>> On Sun, Feb 04 2018, Lucas Werkmeister jotted:
>> 
>>>  	     [--inetd |
>>>  	      [--listen=<host_or_ipaddr>] [--port=<n>]
>>>  	      [--user=<user> [--group=<group>]]]
>>> +	     [--log-destination=(stderr|syslog|none)]
>> 
>> I micronit, but maybe worthwhile to have a preceeding commit to fix up
>> that indentation of --listen and --user.
>
> I thought the indentation here is intentional, since we’re still inside
> the [] pair (either --inetd or --listen, --port, …).

Yes, sorry. Nevrmind.

>> 
>>> +--log-destination=<destination>::
>>> +	Send log messages to the specified destination.
>>> +	Note that this option does not imply --verbose,
>> 
>> Should `` quote --verbose, although I see similar to the WS change I
>> noted above there's plenty of existing stuff in that doc doing it wrong.
>
> I could send a follow-up to consistently ``-quote all options in
> git-daemon.txt… or would that be rejected as unnecessarily cluttering
> the history or the `git blame`?

I don't think anyone would mind. Tiny doc cleanups are neat-o.

>>> +			} else
>>> +				die("unknown log destination '%s'", v);
>> 
>> Should be die(_("unknown..., i.e. use the _() macro.
>> 
>> Anyway, this looks fine to be with our without these proposed
>> bikeshedding changes above. Thanks.
>>

