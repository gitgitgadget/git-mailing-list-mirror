Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39C0D1F404
	for <e@80x24.org>; Tue, 27 Feb 2018 23:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751881AbeB0Xck (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 18:32:40 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52601 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751550AbeB0Xci (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 18:32:38 -0500
Received: by mail-wm0-f68.google.com with SMTP id t3so1676708wmc.2
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 15:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=PggjVZ/iViQ0xHCJi+ivsfDD4Nn2kBquWlBlFnRk0Js=;
        b=Jftp9hks986VUAYM23E2dTsNvb1qGQ41ITl/IU+hj/2eBvtYheYshiEountP1EixY5
         IdovISYHXPyiil3U5wAbR8FwVaV8sAdyql16YQtSGn0xxOVIM+xGcvEZKvKm7/WBT08w
         sq7ShA/90K2EzwuF3TorCFlMTAiBEpsmxnZbQzKX6ioFu6djMSM2GuJxy5GK4IWPjSa2
         OojHvTHdemdIze/bAj1f3IuEJtP+Eda/rsOQb+o+eP5Uri4KrulsAXY+I20YjCZfLx/d
         icdKHmYrfjkIWMo5/zzOSQI81/dvY3Mypy1OXVXYpNX7VuYuQh2ZKq4p44j5WN5ydPOm
         Ve9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=PggjVZ/iViQ0xHCJi+ivsfDD4Nn2kBquWlBlFnRk0Js=;
        b=PeMkKCry0zvZVFM3uocCadVNRSdnSBu5loWRkWzKxF2YqeG/T/ryZ1L6AycAcHb+R2
         gGJV2Z+doogmFjYXEbJOkS76VnR8QfQaQm3Ml1n7zD7a0qjj2j+AL0TvUIFLq2U9Sdxg
         FF127ZeFwA2iYJ1W1IPuGaC23ZUI0boz5ifus6/61+uZjUMUswNUCKwshmHZIgExbRRj
         k11Bljzu0skAm/4awpfl2TRJs2d+L7OsGu7wRcbAJjEgdi+6jJR6NeiobSVY5MVUf5My
         sgVP2Z3bSOpSPzycaBhz19DgvnisJE2939vQXeReFWFR811iQDwmyht7Vuo1wXIUUheD
         wn9Q==
X-Gm-Message-State: APf1xPC8RacIxq5v4DoeOiNeMMFY0+C+6cBw+OnLmernxLRLknPZLJ1l
        TcdlBy51vMAIJmDKZMvrHjm9z1U1
X-Google-Smtp-Source: AH8x227gGvDLEezWsYmvpeEv/9HvSIzVwjfe1tSETcOhA4ityZWl4zTF7LuYo0FBmqJibfXX+UGEUQ==
X-Received: by 10.28.131.210 with SMTP id f201mr13027506wmd.117.1519774357454;
        Tue, 27 Feb 2018 15:32:37 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l11sm189142wrg.71.2018.02.27.15.32.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 15:32:36 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>,
        Git List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmc=?= =?utf-8?B?4buNYw==?= Duy 
        <pclouds@gmail.com>
Subject: Re: [PATCH v3 14/35] connect: request remote refs using v2
References: <20180207011312.189834-1-bmwill@google.com>
        <20180207011312.189834-15-bmwill@google.com>
        <20180221145411.35b2ea84747518a499276bdd@google.com>
        <20180222181922.GD185096@google.com>
        <20180222182657.GE19035@sigill.intra.peff.net>
        <20180222112533.0d7c6023fb8e4098efedfe31@google.com>
        <20180227062128.GG65699@aiede.svl.corp.google.com>
        <xmqq8tbep02f.fsf@gitster-ct.c.googlers.com>
        <20180227220443.GB11187@sigill.intra.peff.net>
        <CAPig+cS+G-xC51n-Ud0Wbmcc-zeHBM3-5WQQAFm9gwm9LNk3Gg@mail.gmail.com>
        <20180227221808.GE11187@sigill.intra.peff.net>
Date:   Tue, 27 Feb 2018 15:32:36 -0800
In-Reply-To: <20180227221808.GE11187@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 27 Feb 2018 17:18:08 -0500")
Message-ID: <xmqq606inh4b.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> struct strs {...};
>> 
>> void strs_init(struct strs *);
>> void strs_push(struct strs *, const char *);
>> void strs_pushf(struct strs *, const char *fmt, ...);
>> void strs_pushl(struct strs *, ...);
>> void strs_pushv(struct strs *, const char **);
>> void strs_pop(struct strs *);
>> void strs_clear(struct strs *);
>> const char **strs_detach(struct strs *);
>> 
>> ...is short, feels pretty natural, and doesn't require understanding
>> "v" for "vector".
>
> Not bad. The "v" carries the information that it _is_ a NULL-terminated
> vector and not some other list-like structure (and so is suitable for
> feeding to execv, etc). But that may just be obvious from looking at its
> uses and documentation.

And with "v", it probably is obvious without looking at its uses and
documentation, so... ;-)
