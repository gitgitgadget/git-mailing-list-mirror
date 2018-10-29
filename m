Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D705D1F453
	for <e@80x24.org>; Mon, 29 Oct 2018 03:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbeJ2MaO (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 08:30:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42220 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729257AbeJ2MaO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 08:30:14 -0400
Received: by mail-wr1-f67.google.com with SMTP id y15-v6so7046482wru.9
        for <git@vger.kernel.org>; Sun, 28 Oct 2018 20:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6FLNDtayHUljZKaAmnWZNzET6AUyoESBt4qi/4l3hzU=;
        b=DqyhdMpYHpPItMYY0BY3a3rN50VISM1zjcqcwAe+m+8ooL7oWLrW0Br2c8pVurhWhV
         Nnyn6L5qJVSSzlFVTJaa+NV2BdxgBLQEWDku4nTVgzEfesGEUjQvT91uNzMVsW1FQoE3
         PW8/po8MSBDMyIL3J7WzRTiRulJB36ZgqmFxI8+wWcHIj/GvXYgWjuw4IuZt12juVSk/
         3ej6BFFOhrdDCopO1TUWq92eQ/NgEwWal9YEznftC1HhCOBdphqkOS4bVxdu+Z3YzbSF
         Bn6EyOHnnMlU7mdUSGtN1nF/CKbCtt7anHaAmgKFIbGIYb3ss9fH0mWruSeCYnF0nbeU
         HsRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6FLNDtayHUljZKaAmnWZNzET6AUyoESBt4qi/4l3hzU=;
        b=kZhHXcKQRHVX/DhT+SD4lS0MKL2Dw3ImlPn33pMDsfOTr4ogcX814Cjp2STsGUXEX8
         Q8YwHjdvPPE7tA4Gqpogq0fQyM1RnIukp4nQ04KH1VxeodqFwHN8//mENle0K+/5T5/N
         BoOz5OEtnhVAxrMqte+QzedCv3ZAabSgzXhttEArsTU0la97Vuay2HbPkL6d7yr+6lm4
         ENTlMJgNsPkq9kyceJtH3CVqp5wPXa2uhr9+UM57iM1meKIihEyA5M39jTD7pi7v8phh
         s/+DOhqdIM3rGQTjArcSMvk6cU0a5K5WLIakx1hnUxS7HKK3EDvUgfm/cm41rb27QZCW
         trTA==
X-Gm-Message-State: AGRZ1gI50V1eBwBip7mzrhw9XT/oSYSGewNRzzY78Fh4vmiss0KL0e6u
        N0xum97aqmDOlO+hOnJrolg=
X-Google-Smtp-Source: AJdET5f19tRUpRGf7JSne16axueSdHuxKNQCmwjC4LFIMUbgwaWTa0I33y98PgTjZrYshpnEP5SIBA==
X-Received: by 2002:adf:c550:: with SMTP id s16-v6mr3460120wrf.264.1540784601507;
        Sun, 28 Oct 2018 20:43:21 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j6-v6sm12715926wru.20.2018.10.28.20.43.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Oct 2018 20:43:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] sequencer: clarify intention to break out of loop
References: <20181028153145.25734-1-martin.agren@gmail.com>
        <CAPig+cR28OBA0rwy=X6XU0cjstAguvUiLU9Zxjvg2X7=UsB5qw@mail.gmail.com>
Date:   Mon, 29 Oct 2018 12:43:19 +0900
In-Reply-To: <CAPig+cR28OBA0rwy=X6XU0cjstAguvUiLU9Zxjvg2X7=UsB5qw@mail.gmail.com>
        (Eric Sunshine's message of "Sun, 28 Oct 2018 15:01:16 -0400")
Message-ID: <xmqqva5l76zs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> diff --git a/sequencer.c b/sequencer.c
>> @@ -2849,10 +2849,14 @@ static int do_reset(const char *name, int len, struct replay_opts *opts)
>>                 /* Determine the length of the label */
>> +               for (i = 0; i < len; i++) {
>> +                       if (isspace(name[i])) {
>>                                 len = i;
>> +                               break;
>> +                       }
>> +               }
>>                 strbuf_addf(&ref_name, "refs/rewritten/%.*s", len, name);
>
> At least for me, this would be more idiomatic if it was coded like this:
>
>     for (i = 0; i < len; i++)
>         if (isspace(name[i]))
>             break;
>     strbuf_addf(..., i, name);
>
> or, perhaps (less concise):
>
>     for (i = 0; i < len; i++)
>         if (isspace(name[i]))
>             break;
>     len = i;
>     strbuf_addf(..., len, name);

Yup, the former is more idiomatic between these two; the latter is
also fine.

The result of Martin's patch shares the same "Huh?" factor as the
original that mucks with the "supposedly constant" side of the
termination condition, and from that point of view, it is not that
much of a readability improvement, I would think.

