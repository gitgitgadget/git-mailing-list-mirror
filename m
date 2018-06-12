Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2291A1F403
	for <e@80x24.org>; Tue, 12 Jun 2018 01:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754025AbeFLBqh (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 21:46:37 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50948 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751050AbeFLBqg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 21:46:36 -0400
Received: by mail-wm0-f65.google.com with SMTP id e16-v6so17730019wmd.0
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 18:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=i1R/YbFJ9UgARuMCd8jAxfFpzHa8kt8bEdtWBB3GkrY=;
        b=Z/mN+ewyqlrPNer7UiC9ZhZ9EdIc7phNpP75HSPB+V6GInfosOfoN6V4Mr1uuQbeDz
         i21dlDeQiG/mMfsmmj5Hek9icfuOmaNrlNXhzBm0FtUOebmkTOIagqbYZbxQEMBEUG3v
         7BDELmvUzWr4+1us64U5Ux6Dz76gg9ORjlKUBusR5y3HjZ0JxWclRzBd2EqCUawW65oW
         tae8VOqDQTRZ/6IcsiyDwGjR77CGyYloM2ikLWQc3fsxVZemLT5JK3nbhv5jB3KJXT8W
         /8xivh46swCr77jDaDPCQ0Heu7mjymjt76lygUmP1Gf6oW7pip7ObeuX6eTSSM+SNJwy
         TmJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=i1R/YbFJ9UgARuMCd8jAxfFpzHa8kt8bEdtWBB3GkrY=;
        b=MQaIfBvfucTksKVKDhjzr16Jrn89uZ1C926YrGXN87hMuQ2fRg5Fn7eunmUBrBfjvR
         kS/nGKPr/gIdYU9lEwm9AfmKGmWFdP57o3RzfkZwrMRF7TI4CcaOnNWQKi86QyiouJ6j
         GTbyd1cEYckH6VKXbRsSMtXtkKQxhrjDclduBtKtn7SvmSYZoTkv3N8jxczAMfCrLNBf
         VHVcrilAfYojM5sv7sc4ox3ZB3zf6iVuGY0fQ+mDXxkqQOzCMXqPDvVr+ymUxFFWCodE
         +vGHeWWvF3wU0FkaXRc4x31AcKUJIjcT9v0fkc12jyNMPZRrmPkbDbdg5lv0XhhQ+FxK
         J/EA==
X-Gm-Message-State: APt69E1vQFKVPg+5o2Hnv+WSx8YNZCC+oQI0O/og/lj7xsyIWzjATdph
        LIS6aB0FURBQ2lzTlMEmlx+wdjPBQVcNwhEOuoMEUw==
X-Google-Smtp-Source: ADUXVKLxwQe91ZABc2JODXiGNMjgmmGvn3xH4ximMauPrtS3qWxuZdEdRXTCEzQprMb/1tyNv1Th5G/9yNAL2OK5wVo=
X-Received: by 2002:a1c:5f82:: with SMTP id t124-v6mr635954wmb.147.1528767994853;
 Mon, 11 Jun 2018 18:46:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:ef04:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 18:46:34
 -0700 (PDT)
In-Reply-To: <CAPig+cSm7My9r8KN1vNyssendf_v_nMARDAq6ALA=X7nZ+spkA@mail.gmail.com>
References: <20180604201742.18992-1-asottile@umich.edu> <CAPig+cSzJ=2Zz7jRNB7sK7FyZ+YwdAFseCTSDbM_m4E8K9WxHA@mail.gmail.com>
 <CAPig+cRyv=JuGo+OfULuvbLrqRxoYZyBZDrSJrt5F8YRwzNn6w@mail.gmail.com>
 <CA+dzEB=7tGeXduxdKrJpDpXrmNbb_ZnYg=CmByJ7J-w-iiyxsQ@mail.gmail.com> <CAPig+cSm7My9r8KN1vNyssendf_v_nMARDAq6ALA=X7nZ+spkA@mail.gmail.com>
From:   Anthony Sottile <asottile@umich.edu>
Date:   Mon, 11 Jun 2018 18:46:34 -0700
Message-ID: <CA+dzEBk8H_=a9k1DaFUK=JJBhd17bhS3+ngSUBcBV+7hD-RFMw@mail.gmail.com>
Subject: Re: [PATCH] config.c: fix regression for core.safecrlf false
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 6, 2018 at 10:22 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Jun 6, 2018 at 1:18 PM, Anthony Sottile <asottile@umich.edu> wrote:
>> On Wed, Jun 6, 2018 at 10:17 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> On Wed, Jun 6, 2018 at 1:15 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>>> On Mon, Jun 4, 2018 at 4:17 PM, Anthony Sottile <asottile@umich.edu> wrote:
>>>>> +       for w in I am all CRLF; do echo $w; done | append_cr >allcrlf &&
>>>>
>>>> Simpler: printf "%s\n" I am all CRLF | append_cr >allcrlf &&
>>>
>>> Or even simpler:
>>>
>>> printf "%s\r\n" I am all CRLF >allcrlf &&
>>
>> Yeah, I just copied the line in my test from another test in this file
>> which was doing a ~similar thing. [...]
>
> Thanks for pointing that out. In that case, it's following existing
> practice, thus certainly not worth a re-roll.

Anything else for me to do here? (sorry! not super familiar with the process)
