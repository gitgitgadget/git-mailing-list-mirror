Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 041DF1F424
	for <e@80x24.org>; Mon, 23 Apr 2018 03:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754044AbeDWDaf (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Apr 2018 23:30:35 -0400
Received: from mail-qt0-f170.google.com ([209.85.216.170]:41707 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753929AbeDWDae (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Apr 2018 23:30:34 -0400
Received: by mail-qt0-f170.google.com with SMTP id d3-v6so16150288qth.8
        for <git@vger.kernel.org>; Sun, 22 Apr 2018 20:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=QSDeaxTT69rRc6y1V4ne7G5VdaNJU60BB7Tuo9Nt09E=;
        b=MB44gDj5T2gYBZrHG6fJJ/MLWBZaxG0ZgY5ENB4pnRid9XRTEtPPCQsizXk5iWSr65
         Jmi3gDfQJjIzz/FkcB9VIVwnBfjlf/mCYFEjavjFZp62DTOLneDvbKQZAwABM5FKt+HB
         tj9m1UXMc5wbjCkBka6osXOzuEmGPs96GCBuW9g5GYRL3ZGzgb+tbO98ADnhYH8v4Ug8
         irPV+ubbTvWkiQMSA3EersGQ57bTkRxTndV3jqLT5ZEBN3yKxKOtqymQ5clSbofF+PsO
         Bpu+gzK+kkZ49NIwQM8GI0bUPVdgM4svAn6PLGrlawb1+IUEZsvVmdNnkAtfN3Hf7B0R
         gJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=QSDeaxTT69rRc6y1V4ne7G5VdaNJU60BB7Tuo9Nt09E=;
        b=iZvXCiUaJdMRgL9z5ov9FB+WsRRhaPCmAd1XivRcLnaiFeQdQj3OVwy50GFOeNhiUe
         Yj241t6WNTIJ/WIW/IFNPs1SavB3yn1sXaBykrNU8o9PRKpMaLXmIOh1Q4RdH97OPNbc
         zJZoVILW04G99uiIzLI8GhFEtZN8B8Q5qWMmzfuWX2fRVziltgPhQvaa8aKLp6i7lJxD
         gXgWtU8ybPlQIM+xirepL/h+djkYUPVak5/Jh4Hlx1i3v33/x4TlkCEAWdVTCmEteHAw
         hs9+zk3O504UOi5vVPbsRDBzy5axfOi/at2lWpNbQqq6yUyL5+wVoUgAba3qu00nSiwK
         59XQ==
X-Gm-Message-State: ALQs6tAkk5Fao1U61F76La9iwCqnDsKrvAgU4xPz4Z0/v9gLVqYzL6R3
        KOMXj1834J8JbAD4LQAabIL4noxA3+Tz7EyfyILcTg==
X-Google-Smtp-Source: AB8JxZpC7H7sffuKBjTP4NhAsiKeb9YT7wSFe8zwrc7+U+s22Si6yP6Yu9WNviAIcW1z+MFtEpRg5kvAHDW2zfsl1PA=
X-Received: by 2002:ac8:42b:: with SMTP id v43-v6mr21486408qtg.69.1524454234015;
 Sun, 22 Apr 2018 20:30:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Sun, 22 Apr 2018 20:30:33 -0700 (PDT)
In-Reply-To: <20180423011726.GD78148@syl.local>
References: <20180421034530.GB24606@syl.local> <cover.1524429778.git.me@ttaylorr.com>
 <5aaf7bebb27d385ea090cb83e97c596983ebae47.1524429778.git.me@ttaylorr.com>
 <CAPig+cQ2+wTTXE0mhnGnp2pZug=Po0SCVwCO_2agxUDaOsFRLw@mail.gmail.com> <20180423011726.GD78148@syl.local>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 22 Apr 2018 23:30:33 -0400
X-Google-Sender-Auth: znsSqf6ROmm5lxsK7F2-y8yWeZk
Message-ID: <CAPig+cR0dP2Hrb4JhuqmCNFzDPoy7KdqYX3irso6mKdmh9Y4VQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] grep.c: take column number as argument to show_line()
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 22, 2018 at 9:17 PM, Taylor Blau <me@ttaylorr.com> wrote:
> On Sun, Apr 22, 2018 at 08:16:12PM -0400, Eric Sunshine wrote:
>> One way to achieve a more coherent patch series would be to build the
>> machinery first and then expose it to the user in various ways. Also,
>> each patch which implements some user-facing functionality should also
>> document that functionality. For instance, a more understandable
>> series might be structured something like this:
>>
>>   1. grep: match_line: expose matched column
>>   2. grep: extend grep_opt to allow showing matched column
>>   3. grep: display column number of first match
>>   4. builtin/grep: add --column-number option
>>   5. grep: add configuration variables to show matched column
>>   6. contrib/git-jump: jump to match column in addition to line
>
> I appreciate the suggestion, and did not take it as harsh. I think that
> the existing structure is OK, but I think that I am biased since I'm the
> author of the series. I have given your proposed structure a shot and I
> think that it should improve the readability of this series for others
> on the list as well.
>
> To avoid sending more email than is necessary, I have pushed a draft of
> this series to my copy of Git, and would greatly appreciate your
> feedback on whether the structure of these patches is sensible. If they
> all seem OK to you, I'll happily push v3.
>
> For your consideration: https://github.com/ttaylorr/git/compare/tb/grep-colno

Thanks. Perhaps not surprisingly, I find the restructured patch series
easier to follow and review. Each patch has a very specific purpose,
thus demands lower review-time cognitive load than with the old
structure.

One important issue I noticed is that patch 3/7 neglects to update
grep.c:init_grep_defaults() to initialize opt.color_columnno.

Looking at the tests again, are you gaining anything by placing them
inside that for-loop? (Genuine question.)
