Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A6B21F597
	for <e@80x24.org>; Mon, 30 Jul 2018 20:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731288AbeG3Vjn (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 17:39:43 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33400 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727456AbeG3Vjn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 17:39:43 -0400
Received: by mail-wm0-f67.google.com with SMTP id r24-v6so9204023wmh.0
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 13:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=1ZOH7M2Z7O7Y/R78ZovZVVzGYPYobKDMH3zvlxpFllk=;
        b=piKZXM4JdGxYznCDHGL6ehybaT9L42IpNg8m2J1GHzWIxuu4OH/WVgEod2dYNQmsom
         S2vrsJSl7Em00JQesE29PyFy6O+QpIIeCVeP4sRq3dcHew0wJy8Z4RMeNtQtbTZLxL/t
         tSQonBa+4K1bgJ4ARX3RbrRKmE78fMseXFhfFoQzHjuc00RvqKrIckkt2WSd47DjmnUl
         MclJYCmG0ARwjquqq4vLg2O7MD/e/GW06IsriP6ppBhEDUa9s6FI/jEQbWUWYcZiH/eu
         74fDoF0X5k8uYiznkAcck28MpoSBBvnRG9Q9P25FvM1/RwWXTrSLj03skruov3z2estC
         pSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=1ZOH7M2Z7O7Y/R78ZovZVVzGYPYobKDMH3zvlxpFllk=;
        b=kJSi5cL9Oa7jj5Ezc8rqnf+w03hTfYhZ3ignQe9Ux43xBZDHETXyfnq6PAxcm/blCe
         NTeBsBfVbb15otrOmXsjIzyfDnTsOIK9iS8qBircKw39vtA15C9ioTljEMGS496FJsal
         Z0f1lvnXCM+MtVhQh2UgkpAQt8L5QL4yrHp9AHBfF+gZTGpnYsHJiGT6jcfkyMSvcT7z
         y9/7j7s7iKEAR3HBnlBQpHpN9GtfCe6mcmjI8xOxdYaidobWGNq3RiTL58qU3BRSSfFW
         RTwLeu3ogRR1S+UHTVFG1OcOVjDNAGTEpxtjKXDUnCAZ3/w8V8WUBaz0mMn7HVDi+cqd
         1c+Q==
X-Gm-Message-State: AOUpUlGHRuUG35kb4u1GzTlifzobzSARsR4crZVlY8cUPwBVj3cEC6cb
        d0gG9hEFMybjUEFp+3xDhC9Q3voS
X-Google-Smtp-Source: AAOMgpfqRaenmjTh0V7XleIhQgWz7YaIkiU7OotfrAEX+5dRGF8Ly5R99Iy8mqai93CtZgzQTjq4FQ==
X-Received: by 2002:a1c:c019:: with SMTP id q25-v6mr417862wmf.148.1532980985543;
        Mon, 30 Jul 2018 13:03:05 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id r1-v6sm13832925wrs.39.2018.07.30.13.03.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 13:03:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] Document git config getter return value.
References: <20180730122609.57058-1-hanwen@google.com>
        <CAPig+cQkFHtOw=gJ1Y5vjQipeAgRon214tUs09o3k3LkevHu4g@mail.gmail.com>
Date:   Mon, 30 Jul 2018 13:03:04 -0700
In-Reply-To: <CAPig+cQkFHtOw=gJ1Y5vjQipeAgRon214tUs09o3k3LkevHu4g@mail.gmail.com>
        (Eric Sunshine's message of "Mon, 30 Jul 2018 14:48:00 -0400")
Message-ID: <xmqqd0v4fq4n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, Jul 30, 2018 at 8:26 AM Han-Wen Nienhuys <hanwen@google.com> wrote:
>> ---
>>  config.h | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> Missing sign-off.

Besides, the patch is corrupt in that it miscounts both preimage and
postimage lines and claims it applies to a 11-line block even though
there are only 10 lines there.
