Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD4961FC44
	for <e@80x24.org>; Mon,  8 May 2017 20:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756715AbdEHUDC (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 16:03:02 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:32854 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751883AbdEHUDC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 16:03:02 -0400
Received: by mail-qt0-f194.google.com with SMTP id a46so11036510qte.0
        for <git@vger.kernel.org>; Mon, 08 May 2017 13:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9JLrYpd/Xr5FlC4pfQ92gFAykw5vhU5BbK51ibdR1x4=;
        b=oxgQE2uF5yteLXuyWz0Abe035NBLLVWgSyYg1EMtUSm/722k1EkAubLdJz8bgcW45/
         2vWV8aEwuW+mrTc0iWsvq31kqEaJoU32LJOGjmxLtDBXLow7VCRnKDKZkX7YgRVSaDCd
         21MDW4ZiRHyfT8ulJfx+lLmDfKGtYwcvUTHuuBofz17FBnbnPvGQMH/NeEkpH7HoGRc3
         DWaMzCaPYWydqAoGAgcoEwFRaA/L7YqvLvOUmZbXn7/yhifCbfBdo8/TbZ2e7xYu794f
         Af0tHq1yuNnIYiVFvqsRxd28NO7eWugBTWJ+cek2ku+OwSEUxnX1fECvsTJK2UUYSjmJ
         Izdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9JLrYpd/Xr5FlC4pfQ92gFAykw5vhU5BbK51ibdR1x4=;
        b=pLxTtrWC+5WOcXsk90v5h65gFGh5sae0BeQestqrDzvAxVd8vBxCw76qlzPH2vDLP4
         nrJOVA2lDxVB5DpumvURHbWQGzxVAIaaEe9CpTRab2ZNtm39CJ7sru0NAywPuTiWC+OP
         usVYgjnmOu3nwjGgKaFD0JXjZReRs+H4iZwBXgET7cxqwoiYQfPy29yzS4SksXxTWmpR
         axVfQ6mxnDoz0XbW6ddfm4GIDIk2vufoClPH4l9nF6pvY6wNv7mWNZ+emv5JuQKpRlIh
         ynizCdwbV+oSdlUbiafjTyMujO/HnFacxRoLLGPbnmmrMZyBhTGeXmqMcKB+2HhkJq8a
         hQcg==
X-Gm-Message-State: AODbwcDGhzD4RpLQvGA58APsbSFkQK34Xhw+VGYA/O5tfQw0sNuuEdpV
        +XlRFBIEMwWs2owbYP3jjv/VzW3QGQ==
X-Received: by 10.200.48.196 with SMTP id w4mr13944232qta.226.1494273781145;
 Mon, 08 May 2017 13:03:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.78.212 with HTTP; Mon, 8 May 2017 13:03:00 -0700 (PDT)
In-Reply-To: <962eefec-2ea6-6b43-7bd5-51da4150bb6a@jeffhostetler.com>
References: <20170414203221.43015-1-git@jeffhostetler.com> <20170414203221.43015-2-git@jeffhostetler.com>
 <CAP8UFD2v8R8bSjUi8+1271fJ=jR5JbbGfgO_fdeYpzE=EGx_Pw@mail.gmail.com> <962eefec-2ea6-6b43-7bd5-51da4150bb6a@jeffhostetler.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 8 May 2017 22:03:00 +0200
Message-ID: <CAP8UFD1dR1QY81tCAcbB6RP61vBxXy-u8zFAhLpk9uP71Jna-Q@mail.gmail.com>
Subject: Re: [PATCH v7] read-cache: force_verify_index_checksum
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 8, 2017 at 6:50 PM, Jeff Hostetler <git@jeffhostetler.com> wrote:
>
>
> On 5/8/2017 5:45 AM, Christian Couder wrote:
>>
>> This test does not pass when the GIT_TEST_SPLIT_INDEX env variable is
>> set on my Linux machine.
>>
>> Also it looks like you sent a v8 of this patch series with a different
>> test, but what is in master looks like the above test instead of the
>> test in your v8.
>
> There was concern about using sed on a binary file not being portable
> and a request to change the test to just corrupt the checksum rather
> than an index-entry, so I changed it in v8.
>
> Does the v8 version of the test also fail on your machine ?

The v8 version of the test succeeds on my machine.
