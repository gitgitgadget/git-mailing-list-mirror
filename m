Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E1D51F424
	for <e@80x24.org>; Mon, 23 Apr 2018 18:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932513AbeDWSFN (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 14:05:13 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:36050 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932506AbeDWSFI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 14:05:08 -0400
Received: by mail-ua0-f196.google.com with SMTP id v4so10809204uaj.3
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 11:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GIYJk8xkR2ekyHP2boifWatVTbdTxqf9hrrGTeqdk+k=;
        b=o6lKWnC5+faoLT0F8SUL16k7QrqdZ6xTZWsODlAZS+Il1x8rC1iFhNbUwrJXfbrTu7
         zToltFd0wvCoCZNEdH8wDheKquDQ3TeV/oVuNsuP+st3Y+EqhLG1mPYoAI8x0bnyvYeK
         IkH+HNhE/Ppl2f12+4F717KUH4vpSQmhiyixcOCaTMbwkH/FBsFkE4uMSO0fDCQScmiH
         xbegAwRnr9ybAfNgPmn74dP1CupmqseGj3kcp1RxH7LcUiuVvrBqSNtCrytdD8i6D979
         +jEcSaOpQGh8b9oS83w4MvA9GLaFSInOUd1OcHHeRNn4uVNemKBWQRwQfU+wW6XtVj1C
         7Qsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GIYJk8xkR2ekyHP2boifWatVTbdTxqf9hrrGTeqdk+k=;
        b=HETHRV8gvYHCa3G49OirUgZMLGbOwQoDcA07m0ObWxNG9EL9Xlv93/mBGYlHAxf8ha
         rMxRaRj9ZFhw9jK4m5/VfY21BRehkl+SKbN4xD4WMPAZ8a3BtaSuioMGp7JxnWZL3JDH
         zImn+B/1/gGI+0xudu6fmZOK8X6NOm5J/rSBu3oTBltt3HdxuZGAqefLGwdQu7xXK+q/
         OyMMhDU0Lrui6QU7BSPbakMD5DSYKy6/f9GFtM8T7NlZ6iwf0AON5MKgSOfFPsPzn8Gl
         GVV5JdQTGk/xDYraW1+AeZF5F94L9F5Zj0UIpgYpUFWYmQEetHtdQqjdpIpnhRtM+sZC
         9Q1A==
X-Gm-Message-State: ALQs6tALRnhMnaXDQDBLxWLdUxo4lZNIfuuV2pVChRD25u9ypre+G5NF
        40YUD93u9U4rZxzDEjTHtkoca2YGAUp3CrYHjhk=
X-Google-Smtp-Source: AB8JxZr8p1IbAiuCB6QCIiBec4dpLTGlsWwvqYhfAd/NWPFtaqfRvj3AdbsSG86eA5Yanlgfl0IGBw8RpFVlgyrDeM8=
X-Received: by 10.176.10.26 with SMTP id q26mr1075347uah.23.1524506707932;
 Mon, 23 Apr 2018 11:05:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Mon, 23 Apr 2018 11:05:07 -0700 (PDT)
In-Reply-To: <CACsJy8Bmr+rSasRJRbhPUStUjBdVE59M97cGx5_Atii_XSDXaA@mail.gmail.com>
References: <20180420122355.21416-1-szeder.dev@gmail.com> <20180421193736.12722-1-newren@gmail.com>
 <CACsJy8D4OYphLG5vStr+M9qkiqyH_LR517M-JOPS2wJeTFNGRg@mail.gmail.com>
 <CABPp-BFuuywXrJuzfb4V1bRLb9eVZpLKiCDwQWetHk8bymC6EQ@mail.gmail.com> <CACsJy8Bmr+rSasRJRbhPUStUjBdVE59M97cGx5_Atii_XSDXaA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 23 Apr 2018 11:05:07 -0700
Message-ID: <CABPp-BGQy=-k1TN-i2U89x7gJ7z8_ciTM3DJzTnVKsvi94LpBg@mail.gmail.com>
Subject: Re: [RFC PATCH v10 32.5/36] unpack_trees: fix memory corruption with
 split_index when src != dst
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 23, 2018 at 10:37 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>>> [1] To me the second parameter should be src_index, not dst_index.
>>> We're copying entries from _source_ index to "result" and we should
>>> also copy extensions from the source index. That line happens to work
>>> only when dst_index is the same as src_index, which is the common use
>>> case so far.
>>
>> That makes sense; this sounds like another fix that should be
>> submitted.  Did you want to submit a patch making that change?  Do you
>> want me to?
>
> I did not look careful enough to make sure it was right and submit a
> patch. But it sounds like it could be another regression if dst_index
> is now not the same as src_index (sorry I didn't look at your whole
> stories and don't if dst_index != src_index is a new thing or not). If
> dst_index is new, moving extensions from that to result index is
> basically no-op, in other words we fail to copy necessary extensions
> over.

Ah, got it, sounds like it should be included in this patch.

A quick summary for you so you don't have to review my whole series:
- All callers of unpack_trees() have dst_index == src_index, until my
  series.
- My series makes merge-recursive.c call unpack_trees() with
  dst_index != src_index (all other callsites unchanged)
- In merge-recursive.c, dst_index points to an entirely new index, so
  yeah we'd be dropping the extensions from the original src_index.

I think all the relevant parts of my series as far as this change is
concerned is the first few diff hunks at
  https://public-inbox.org/git/20180419175823.7946-34-newren@gmail.com/
