Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DB50208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 20:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387711AbeHFW3n (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 18:29:43 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38066 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732391AbeHFW3n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 18:29:43 -0400
Received: by mail-wm0-f67.google.com with SMTP id t25-v6so15578214wmi.3
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 13:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=tG3QnMiddHPm6i3MkA2pC97F+qDZvkz8bzU6HAtTYeI=;
        b=QouNZco/c5mG8/trCvHfUN2PcwteDVvskvQKbHW62T5wLmmwugIxnXAbx69PybzgtI
         bJACWshQmiJvkBt9PYC6WZ2vgFZ7BW1ALfgyTvCzqWQQRNTL1x+DIwqtnBD+580/1VN8
         YywQ09RKhtoj2AJuAgWfJeWYUo09Hd46GnJtL/GsDzVum8bVmbZKfuvVppehTSMMyZ1J
         /ddUWmJUpTglCW/mI1OuilDV8vW9VhIXTlQXM+IkWzGvRn9k+OuVPDpJj3js7Oem9p+F
         64odIR8Ziq2la0fTdFLiuWV+8yG+1jPLXk6Zj6A6/9KGqY844Iuf+Tt93dlkt312FVTi
         Bh6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=tG3QnMiddHPm6i3MkA2pC97F+qDZvkz8bzU6HAtTYeI=;
        b=O+6TThvJl8tAvWKiXgEG5So/Y3udjGpGeAVnppMmXIVu1N/vYme0+QZwuIl96jBkqq
         dCDSx7r4doB5oRIzHbsac3ltraXGYBF3Zq1Ld1R1K/JCAVU9ZoY/FwrnS3ugtCiwYo8E
         goaJh1m8Ip+06aiEPzrs7zoR7GtGcndYGQACJ6wTJ2BzbORYlXR40hVnSg32yzsASdlL
         qhhBTtj+ouo4OdZSNU7UszMnXxp8CJmNlYzq7d6r2DiGmct0ge6zQ2lebSYO/dJQeB2e
         4DJYl1vYMiE4h/GWl1Wg+A0XmfbxJoSWl5dWMlQ8YfDUK40VCm5HdBxHeZRTf4h9yQtR
         a/Dw==
X-Gm-Message-State: AOUpUlEP8Rjmp0Y5fov7ZGKm6GpwAUejANDd3bwFfqJD/RTRitdYI5j7
        +k2ZXSEq6Rw9LApLIW/z7F0=
X-Google-Smtp-Source: AAOMgpfVeuU0g1aMoftr8s5Xey4tAp1yRT4KXvAvNLWtpwUOuvzlKC2kWgMzmVIPaXCFG4L4H4LaPg==
X-Received: by 2002:a1c:e70b:: with SMTP id e11-v6mr12043091wmh.22.1533586739131;
        Mon, 06 Aug 2018 13:18:59 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y102-v6sm10199635wmh.9.2018.08.06.13.18.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 13:18:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH 0/7] improve range-diffs coloring and [RFC] move detection
References: <20180804015317.182683-1-sbeller@google.com>
        <xmqqd0uyt6hj.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kZnVEsvpicNu7LXkRcHuRqGvESfvG3DL5O_2kPVYrW-Gg@mail.gmail.com>
Date:   Mon, 06 Aug 2018 13:18:58 -0700
In-Reply-To: <CAGZ79kZnVEsvpicNu7LXkRcHuRqGvESfvG3DL5O_2kPVYrW-Gg@mail.gmail.com>
        (Stefan Beller's message of "Sun, 5 Aug 2018 23:01:31 -0700")
Message-ID: <xmqq36vrnt8t.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Sat, Aug 4, 2018 at 9:57 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Stefan Beller <sbeller@google.com> writes:
>>
>> > This builds on top of sb/range-diff-colors, which builds on js/range-diff.
>>
>> As another round of js/range-diff is expected, according to
>>
>> <nycvar.QRO.7.76.6.1808011800570.71@tvgsbejvaqbjf.bet>
>
> Oh right. I forgot to mention that in this cover letter, but Johannes
> has had work issues last week and people threw lots of stuff at him,
> so I concluded the resend might take a while. Hence I just put it out there
> in case we're happy with the status quo of that series.
> ...
>
> Thanks! I'll resend when appropriate.

Thanks; that way I have one less thing I have to remember ;-)

