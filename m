Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A298D211BB
	for <e@80x24.org>; Thu, 27 Dec 2018 11:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbeL0L0p (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Dec 2018 06:26:45 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34741 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbeL0L0p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Dec 2018 06:26:45 -0500
Received: by mail-ed1-f67.google.com with SMTP id b3so15048154ede.1
        for <git@vger.kernel.org>; Thu, 27 Dec 2018 03:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=A0nVlDHiQ8fa2b0IScpRKoLLN9agR+xolYgEzohE81Y=;
        b=nLmEBSIn/5ND7bgS5Ys+qsamrl/+Hd6NJ09Vyopj+tziR3bxmhcnpOcJC0JLN7AZQH
         mtWOYjrcU3UO689xROqwR+Yznw+E6Rux78wHu/DiwlfJk+qOaRAFLi8nEzTNwMWhvKn4
         G4IzZuB4/2o+qcpeD+F9kBuOfK5Ys5d2xOmDKlzjMxmUDXiIpSYW+vS66ROvo266hyRG
         Q53mr6L5fjncPKtsZRMHZnb8lMjUvogNB+e5SPpc8rK8DKZizT5STHMhQkfKjA8L5Sjj
         RmEP/WF0iXIYDbGEMty0GmtXOhSCsnGE6T70ZuE9FryL2GeHsyAZgLL3ejHPcZaQNgyV
         bn/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=A0nVlDHiQ8fa2b0IScpRKoLLN9agR+xolYgEzohE81Y=;
        b=V1z818ou9CS00cMC+bEc5ByJL2hdoCNCEyrErmdDAnzoIMzudSGszk4NZHWTDiyYH6
         PaAgPlQCk3JEeR+YNqPhOj17mpihzzwbpfNcl0oaqAVNPDomWA5rkN/cC+UJ/AXZCsDI
         YWxeoeS3AAqp5ghXDJJhjSxfl+UgyCbwgeTIvcXp+3g7ZarV+45rXdyTdAH3+MwrbWh3
         5GAYMjXxTVC0m4X3zfR0xu9/8FYg208u/phAhlISTtkqI52nOrhwGvMszHN9nzdolwiT
         ZwatVGWZmaBCnYIrus3gHCODxGSR2nYTKh59b+kaGBGjn2xKB9GciyFq4TnptAxnfCjY
         GCJQ==
X-Gm-Message-State: AA+aEWY3iyIyWuXbUBQ9GvJzWv+gFxqbRUG+I5eNPDhD8GvsDBSlWV1A
        5KdANDn/CnjQLRVCcA+pSnQ=
X-Google-Smtp-Source: AFSGD/WXeo2zySXHVBSAd8layWoiQQRckTUBC4vMYwms3NyqsnB6FjOuUp1L1WGfxNAhe+Q/SUrhMg==
X-Received: by 2002:a17:906:81cc:: with SMTP id e12-v6mr15934210ejx.138.1545910003548;
        Thu, 27 Dec 2018 03:26:43 -0800 (PST)
Received: from evledraar (i40217.upc-i.chello.nl. [62.195.40.217])
        by smtp.gmail.com with ESMTPSA id z40sm11000273edz.86.2018.12.27.03.26.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Dec 2018 03:26:42 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        git@vger.kernel.org, Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2 8/8] tests: mark tests broken under GIT_TEST_PROTOCOL_VERSION=2
References: <xmqqimzygmz6.fsf@gitster-ct.c.googlers.com>
        <20181213155817.27666-9-avarab@gmail.com>
        <87pnu51kac.fsf@evledraar.gmail.com>
        <20181214101232.GC13465@sigill.intra.peff.net>
        <87o99o1iot.fsf@evledraar.gmail.com>
        <20181217195713.GA10673@sigill.intra.peff.net>
        <20181217231452.GA13835@google.com>
        <20181218123646.GA30471@sigill.intra.peff.net>
        <87d0pzf0as.fsf@evledraar.gmail.com>
        <xmqqlg4cq6kd.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqlg4cq6kd.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 27 Dec 2018 12:26:42 +0100
Message-ID: <87va3fdxcd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 26 2018, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>> The genreal ways I see forward from that are:
>>
>>  A) Say that v2 has a security issue and that this is a feature that
>>     works in some circumstances, but given Jeff's explanation here we
>>     should at least improve our "SECURITY" docs to be less handwaivy.
>>
>>  B) Improve security docs, turn uploadpack.allowAnySHA1InWant=true on by
>>     default, allow people to turn it off.
>>
>>  C) Like B) but deprecate
>>     uploadpack.allow{Tip,Reachable,Any}SHA1InWant=false. This is my
>>     patch upthread
>>
>>  D-Z) ???
>>
>>
>> I'm not set on C), and yeah it's probably overzelous to just rip the
>> thing out, but then what should we do?
>
> Hmph.  The other overzealous thing you could do is to strenthen A
> and "fix" the security issue in v2?  Which letter comes before A in
> the alphabet? ;-)

Sure, but that being useful is predicated on this supposed security
mechanism being useful and not just security-through-obscurity, as noted
in side-threads I don't think we have a convincing argument either way
(and the one we do have is more on the "it's not secure" side).

Of course we had that with v1 all along, but now that v2 is in released
versions and in this insecure mode, we have a reason to closely look at
whether we need to be issuing security releases, or doubling down on the
"SECURITY" wording in git-fetch and then not carrying the mode forward.
