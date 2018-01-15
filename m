Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 729D11F404
	for <e@80x24.org>; Mon, 15 Jan 2018 09:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754828AbeAOJQa (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Jan 2018 04:16:30 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:46221 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752385AbeAOJQ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jan 2018 04:16:29 -0500
Received: by mail-qt0-f195.google.com with SMTP id o35so3217423qtj.13
        for <git@vger.kernel.org>; Mon, 15 Jan 2018 01:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kambanaria-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hSy1tmplfte3Ha2TZrgWVz5Vf7GTFTC8xNluNNbUd+w=;
        b=P5q2s47zEntGSEik4fFK7nl1ejljNoInpsNgfogIZG+2AZe9iM8tdfpWlGSlxfBnc1
         AMxyfsP59XIpodLx8wPv2cYCYC1w8WflenMECkOvm3NcU6M7/L3ATJuCdip05HuJrk/M
         pnDPuq9WgmBkBmoqYsV+GIDIUQlvmtJXZLPWPJTV3bLKq7reYr/f+IxeRko/f8QaQBfd
         eZ6s6SlpYogta23L5xYYaBXY+IGAimDjJlh/6sENMM/CWhGUTr9He5yl//KVyLtP8Wec
         8FdKFIiBDYoErRC11Kikks44woS6z8d7uS4SVEWEA51FW3O2FgRmO69RaHh2n5f/Qn6B
         +CVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hSy1tmplfte3Ha2TZrgWVz5Vf7GTFTC8xNluNNbUd+w=;
        b=BlJLKDvbWqeylilRfJhWLoOyM9L14fcE8+IiVBZP+XPI02ZLhSnfoZrVj6drpvFXoz
         R54FvJbMCB/huQry3RGeIBEssHLuG0pan7u3Xd3F0t6PO4ErptwdPAolwCM1B2F1gqPn
         6tm9vd1e0Q2hi5a6t74tCDcDSNWAsG+aGTgUDc+E4L8fJNYvXe/mHAfNkwXJutt5lmuh
         9NiHHHqSsmUtMmfFwISrkIttYyYGYXW8no7OyvGQRfvxdG9EmsXsBGQBYhxE9feQnb5J
         Nob/9D/02FLj/tM7WUD4QmG1Dm3XBN0vlcPSQl+PPqESxBSLiWvhOkNlNZZMUtCianLS
         175g==
X-Gm-Message-State: AKwxytcrGpgiSGHvhuxx9Q+da8JJVgYv28sHjkIv+LxLi7zDLHji+TN/
        jgNvJo7//q64Fk80KQm81D+H4cxnGdlah3BitTd6Pg==
X-Google-Smtp-Source: ACJfBovcuhMz6cNV1+ESbBjhX+MR2jAt7z/9dxHfqfagk6S4hWNN9WSqzN2VOAWM6Tlhl6QkaztqNZyWFKLLVpb9Kmk=
X-Received: by 10.237.37.202 with SMTP id y10mr24873314qtc.66.1516007788082;
 Mon, 15 Jan 2018 01:16:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.200.54.49 with HTTP; Mon, 15 Jan 2018 01:16:27 -0800 (PST)
In-Reply-To: <CAP6f5MnaMiqEMbGW_xj6X495jF=txpzeq+DEHOkz7VCg2D6D9w@mail.gmail.com>
References: <20180115054419.4112-1-ash@kambanaria.org> <20180115054419.4112-2-ash@kambanaria.org>
 <b9e734a2-52bb-08b1-6bab-3d47b0f7ebeb@kdbg.org> <CAP6f5Mnn+pRdL6ihgwcqsTwyGy+EQfBbgPxkFmGLcWL-hJx-8g@mail.gmail.com>
 <CAP6f5MnaMiqEMbGW_xj6X495jF=txpzeq+DEHOkz7VCg2D6D9w@mail.gmail.com>
From:   Alexander Shopov <ash@kambanaria.org>
Date:   Mon, 15 Jan 2018 10:16:27 +0100
Message-ID: <CAP6f5M=HdjfQT+oO76sMfcD7zOfajeukh_VxSL_diqEsCWAYWw@mail.gmail.com>
Subject: Re: [PATCH 1/1] Mark messages for translations
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        martin.agren@gmail.com, bmwill@google.com,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Xin Jiang <worldhello.net@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

And again, sigh:
>>   const char git_usage_string[] =
....
>>   const char git_more_info_string[] =
> It is not obvious to me where git_usage_string is looked up in the
> message catalog. It is used that way in builtin/help.c ..

I wanted to be consistent with the current state of the file. This is the
same way const char git_more_info_string[] is defined and initialized.
Having it this way saves the lookup on each usage I guess but any performance
gains will be negligible. Is there a convention?

> We have settled with lower-case letters at the beginning of error
> messages. (See Documentation/CodingGuidelines, "Error Messages".) You
> could fix that while you are touching die, die_errno, etc, messages.

Great! It will allow for further reduction in repetition of messages.

> I notice you change past tense to present tense in some cases.
I am reading this that messages SHOULD be in present tense (unless they MUST
be in past tense). This is good. Perhaps I will look at current messages and
then fix en masse (if there is sth to fix).

> I'm not a friend of geeky abbreviations like "chdir" or "cwd" in
> user-visible messages

I agree but I would also keep in mind that using the name of the function
may alllow to parametrize the messages like:
Cannot execute "%s" on "%s" - for example. Anyway this is not that important
for me. Will wait for other opinions.

>> -                     die_errno("fork failed");
>> +                     die_errno(_("fork failed"));
>> -             die_errno("setsid failed");
>> +             die_errno(_("setsid failed"));

> it is useful to have the function name in  the message. Which rises the
> question:why translate them at all?
Why not eat the cake while having it - one can pass function name in  a
 message like: '"%s" failed'

Regards:
al_shopov
