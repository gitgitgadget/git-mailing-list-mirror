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
	by dcvr.yhbt.net (Postfix) with ESMTP id 25D6C1F42D
	for <e@80x24.org>; Thu, 24 May 2018 20:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968878AbeEXUMg (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 16:12:36 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33166 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968880AbeEXUMc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 16:12:32 -0400
Received: by mail-wm0-f65.google.com with SMTP id x12-v6so28945861wmc.0
        for <git@vger.kernel.org>; Thu, 24 May 2018 13:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=21kd1yOrUdraup7at4WudBP8RaLY2rXqjgm6uEIw2SM=;
        b=ELSWO78C8muXEOaW1mdf5WgWfAl18fZCjx7EqKJYhlYJcFbdXQX2rNSc6OULRyzxx/
         +OTbIRcnYPzUnjOgT7nZZ5REhXyM4CDOgMUb/ify78LVG4LSwkGFWLMVDL2COul6lh8M
         /rys+Ytjq9/CQo8u5AOv8IrmX5iy+bMBuHG+CbppsLPUr4ZLY336JvkSP3aD3X2HQwVm
         6InHQ6BqyKEcaWhHGbN/k6goeIbwQ66LGFDOR5NCLRXVb58jvvK0Sk8kMGwRtdJQRMxo
         qTqxjUf5aNr3g8tIsn8WYkEteEpx/qMg4KsrdCDDeB2Y+XR/3nvP1KYsWaSMADpUGc8x
         mZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=21kd1yOrUdraup7at4WudBP8RaLY2rXqjgm6uEIw2SM=;
        b=VzZsVxYPQ4ZwabmnWeTCMTQjPfRUBwfuQ+Xw8swF/7k5E5aD9EJmmGcwiobFN5y83O
         i+3zzyCCaxm5DuzheLe6zGmRjr6hxEbw2ZjmOP68Jep89mR/UauhSnXuxC271DPmg0xG
         LP5wre6bHxmaZX14ym8O3sAJGgcsYd5cXNtD/raVTpJRIYtpXw7V8G0WN847ECKce6HP
         z4Ckbq/HGstpxaT1NsqD0y4e6PLSPg5xHRy9rLjJtXTc9Gww5ChdThZ9B1OAfFM6dYj+
         aRZcGinK5VXcW6/V22DqvNJjXhMrGdzGQvtDI+RskbqKUMWgVSySv2QnyTTYrn9K/kDS
         y/WQ==
X-Gm-Message-State: ALKqPwd+7aSy7gF6pdlz7M9uHXYeshr3HsRRnLW5CMaiUw6PgBODgGqq
        csHGWih1rnPvu7Fo2mtCS7I=
X-Google-Smtp-Source: AB8JxZpiUkORLm3nE00rk9phTynqnRfnagMn1W0cPfMa4STX1UeJu3nxyP2D7cbbZ5HrzbiV9jK3pg==
X-Received: by 2002:a50:d2d7:: with SMTP id q23-v6mr14055660edg.12.1527192751435;
        Thu, 24 May 2018 13:12:31 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id a2-v6sm11813628edn.25.2018.05.24.13.12.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 May 2018 13:12:30 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/4] config doc: unify the description of fsck.* and receive.fsck.*
References: <20180524190214.GA21354@sigill.intra.peff.net>
        <20180524193516.28713-1-avarab@gmail.com>
        <20180524193516.28713-3-avarab@gmail.com>
        <CAPig+cTr2J6yj39NNdV1vT8CQP2qyPxNB1ggaE9bGgXukuq1yQ@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CAPig+cTr2J6yj39NNdV1vT8CQP2qyPxNB1ggaE9bGgXukuq1yQ@mail.gmail.com>
Date:   Thu, 24 May 2018 22:12:29 +0200
Message-ID: <87r2m07qz6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 24 2018, Eric Sunshine wrote:

> On Thu, May 24, 2018 at 3:35 PM, Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>> The documentation for the fsck.<msg-id> and receive.fsck.<msg-id>
>> variables was mostly duplicated in two places, with fsck.<msg-id>
>> making no mention of the corresponding receive.fsck.<msg-id>, and the
>> same for fsck.skipList.
>> [...]
>> Rectify this situation by describing the feature in general terms
>> under the fsck.* documentation, and make the receive.fsck.*
>> documentation refer to those variables instead.
>> [...]
>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>> ---
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> @@ -1554,23 +1554,41 @@ filter.<driver>.smudge::
>>  fsck.skipList::
>> -       The path to a sorted list of object names (i.e. one SHA-1 per
>> -       line) that are known to be broken in a non-fatal way and should
>> -       be ignored. This feature is useful when an established project
>> -       should be accepted despite early commits containing errors that
>> -       can be safely ignored such as invalid committer email addresses.
>> -       Note: corrupt objects cannot be skipped with this setting.
>> +       Like `fsck.<msg-id>` this variable has a corresponding
>> +       `receive.fsck.skipList` variant.
>> ++
>> +The path to a sorted list of object names (i.e. one SHA-1 per line)
>> +that are known to be broken in a non-fatal way and should be
>> +ignored. This feature is useful when an established project should be
>> +accepted despite early commits containing errors that can be safely
>> +ignored such as invalid committer email addresses. Note: corrupt
>> +objects cannot be skipped with this setting.
>
> Nit: This organization seems backward. Typically, one would describe
> what the option is for and then add the incidental note ("Like
> fsck.<...>, this variable...") at the end. It's not clear why this
> patch demotes the description to a secondary paragraph and considers
> the incidental note as primary.

I could change it like that. I was thinking that later in the series
fetch.fsck.* is going to be first in the file, and then the user is told
to look at this variable, so it made sense to note from the outset that
we're describing several variables here.

What do you think?
