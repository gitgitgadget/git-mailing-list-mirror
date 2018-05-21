Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 420F21F51C
	for <e@80x24.org>; Mon, 21 May 2018 21:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754491AbeEUVtB (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 17:49:01 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:42693 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754363AbeEUVs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 17:48:58 -0400
Received: by mail-yw0-f195.google.com with SMTP id q7-v6so4929931ywd.9
        for <git@vger.kernel.org>; Mon, 21 May 2018 14:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MWwdph2fX0e0BPNHkWoX+57pAq1cGso9P8vPMyaqpJs=;
        b=PkmkZw3N6j/Ack61Nvi4wSOQh/fpVasVE626o3vsHGRxMLp2rbSzz2ftCFXffs/Qd/
         P0DPqt1EkTvNhZUBrIV1IMyv00AuRFThu0e9FAF0Lzbr6PUlsIsxpVv0loJfJaRa/VU2
         sZ++rjKQy0Z8nGLyufr25NBtDY4nAnsNUhzcZWRmFb8llmWWzpT5jqTbz7iV0je3oBOC
         0QpJzQ2REVvdEpYT1Gs2WTjppiFXOV2vwlkJvy8eYtWd+BUZ9kqF15v4DUoajNz68CQM
         sTZOHj4yo1EghKp23z7CLrXEW7GTRmiHCsx6GwsdfRK4k5G05fEVabeTZ345xdTV1TSZ
         c/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MWwdph2fX0e0BPNHkWoX+57pAq1cGso9P8vPMyaqpJs=;
        b=nl6w08AfnC3olsLl19os0rHsJ97XKJvGzBqxEWQZL/XXf8gRE5B2MmnM3yjCuM3p93
         U4GxH03DNz9eTKEjjXuMhtNWPA+a7piuWqqQAVTaZfSPCtAHjKqtuhZdL941XURGUpnX
         /yRmFCc76g0gg1U5LtKfXfC0A4gBrcm9/xeNt0YsDcqyL7beXs5ifS4+HGIjoEIcCTJ6
         RlDFa78jGvARQaA2AkbN4GWa37BE2d4E6UHwaV8kaEE7Vz1JMH5l6pEbGWPtQ8oWrWKO
         WzlE7pXTUE6M05x8rlEHFVd3ut/v9mcs4+hkjxxfyPhhfADTf/BSx+crXjuAkxDTFo1I
         wYiQ==
X-Gm-Message-State: ALKqPweQ7PM9lXCRlZqMg76Y0b/qVQ4kKakhj5kIAAiDVpefohHqZel9
        mkI70y830R1OBnQY0ZKRKHibNO8IGA1PuB8AFrXZOA==
X-Google-Smtp-Source: AB8JxZodg/c2GAK+iReyV9R+LRkCV5PgD91kpvm39FZ0KRbmF0EmJtt2anKeASCil63VODa7ZtWCM2r9uQHAlCenIR8=
X-Received: by 2002:a0d:fd84:: with SMTP id n126-v6mr10933625ywf.33.1526939337541;
 Mon, 21 May 2018 14:48:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Mon, 21 May 2018 14:48:56 -0700 (PDT)
In-Reply-To: <20180521214057.GB125693@google.com>
References: <nycvar.QRO.7.76.6.1805052355190.77@tvgsbejvaqbjf.bet>
 <xmqqk1shsecd.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1805061419530.77@tvgsbejvaqbjf.bet>
 <CAPig+cS0pvdg78fGUu8m2xspDDMHxi=uAMCkbLuthy7R4p3fQw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1805062155120.77@tvgsbejvaqbjf.bet> <20180507074843.GC31170@sigill.intra.peff.net>
 <3cefc6b3-3dbd-9cb1-20d0-193116191726@gmail.com> <nycvar.QRO.7.76.6.1805211153370.77@tvgsbejvaqbjf.bet>
 <CAGZ79kYcWuVorfk7eYjUuLi2XeMS8sPrJYE0OQmgiQi2NkuDZA@mail.gmail.com>
 <20180521202414.GA14250@sigill.intra.peff.net> <20180521214057.GB125693@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 21 May 2018 14:48:56 -0700
Message-ID: <CAGZ79kbZm4B76Wg7yBs_NNEZh85HJP5QgKPogo4PU42WgDowBg@mail.gmail.com>
Subject: Re: [PATCH v2 02/18] Add a new builtin: branch-diff
To:     Brandon Williams <bmwill@google.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 21, 2018 at 2:40 PM, Brandon Williams <bmwill@google.com> wrote:
revised-compare
>> >
>> >   diff-revise
>
> I haven't really been following all of the discussion but from what I
> can tell the point of this command is to generate a diff based on two
> different versions of a series, so why not call it 'series-diff'? :)

Upon mentioning series-diff, I misheard Brandon and thought he proposed

   serious-diff

:-)
Stefan
