Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C78E71F597
	for <e@80x24.org>; Sat,  4 Aug 2018 17:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbeHDTVv (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Aug 2018 15:21:51 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37894 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbeHDTVv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Aug 2018 15:21:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id v14-v6so8337481wro.5
        for <git@vger.kernel.org>; Sat, 04 Aug 2018 10:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=AQM28kwxdvk/DOKOnovaVXQXg04BSf73XGOxNMb2uxY=;
        b=TdmHokqxMxYz0VPW8wRJDZZWjaRcokpSYZDKtbvsD11fawlPispUafX2bfPDrAzjwM
         eqFC6tW/emk/aa1hwQErj7SiUkLyl3MlktOmjQrwfWstcFAoMR3OZeoLkHhyS1rQTx3G
         qavSQKpU9MXKCKWm001TQ8CjZBCEjse8ZA7a02qkBCd+QE9phCTpdSIwMlAVi/WHKQm3
         iPYGZoIwbnhwogcHlFqkhUlmdh/WW+s7HvvTxITGDWORtz3MYB9B+B4SDMOXmVOBmeFC
         hhW4YGH19OHiXdYy/gGNnXROs/tyPkDYjcGLYo5WcsIqfRDwaJhg0Xfsi4Cuv5r/eRmk
         ChjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=AQM28kwxdvk/DOKOnovaVXQXg04BSf73XGOxNMb2uxY=;
        b=eZHaemKcXYCI1uydN4kopRrsmibGY6PvMjDsIyHntgS2QUXpCuk0gf5NS7MEHLp8Yi
         l3EZHnYp5zp+0/3NykEMcu8YzUVOM9q+90dnQ8HDgddL0Kot9gfmayF/ioco0uTWKpBq
         Rye7lmB6tJ+lYfq3hoMIB1ZLIFCTpMDzcImFAhKD/P/NMsby0xtii5lSYOt8GvXTTe4L
         IsAGX5bocK2raI2P+J9HfX2HXCO7GBYYVeehOPiaF1WXuO8Lro4P+8O1j0vC5i2YfVcn
         MHaW0KQqieh7rBGSwwRsLSpIPJTUgMrT9JrqLhoKJ5M3F9+C8U2JapCZT0bQ7CDE96TQ
         YkPg==
X-Gm-Message-State: AOUpUlHPKJ/XuUJYBHAGqjrrt3AdAuNCxeM7cF9QFZSN4FthNd8m9CE8
        uTVup8LG9YFYFFOutkZiYi3Ch6AE
X-Google-Smtp-Source: AAOMgpfFzfZHdrSJQVhP4SA/oQ90DuoPsdd2g3eRVlddL6XfHSWEX+UVs5rn0Vkxr9QVYUOkR74BXA==
X-Received: by 2002:adf:8103:: with SMTP id 3-v6mr5398226wrm.213.1533403229320;
        Sat, 04 Aug 2018 10:20:29 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j11-v6sm6015056wrr.37.2018.08.04.10.20.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Aug 2018 10:20:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Max Kirillov <max@max630.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>, manschwetus@cs-software-gmbh.de,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v9 2/3] http-backend: respect CONTENT_LENGTH as specified by rfc3875
References: <20180727034859.15769-1-max@max630.net>
        <20180727034859.15769-3-max@max630.net>
        <CACsJy8DRNHVgYYH0AjdcU68PGg1anp5g+d7Up3cXp0bmDuC0Mg@mail.gmail.com>
        <20180804112814.GA2060@jessie.local>
Date:   Sat, 04 Aug 2018 10:20:28 -0700
In-Reply-To: <20180804112814.GA2060@jessie.local> (Max Kirillov's message of
        "Sat, 4 Aug 2018 14:28:14 +0300")
Message-ID: <xmqqk1p6rqub.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Max Kirillov <max@max630.net> writes:

> On Sat, Aug 04, 2018 at 08:34:08AM +0200, Duy Nguyen wrote:
>> On Fri, Jul 27, 2018 at 5:50 AM Max Kirillov <max@max630.net> wrote:
>>> +       if (max_request_buffer < req_len) {
>>> +               die("request was larger than our maximum size (%lu): "
>>> +                   "%" PRIuMAX "; try setting GIT_HTTP_MAX_REQUEST_BUFFER",
>>> +                   max_request_buffer, (uintmax_t)req_len);
>> 
>> Please mark these strings for translation with _().
>
> It has been discussed in [1]. Since it is not a local user
> facing part, probably should not be translated.
>
> [1] https://public-inbox.org/git/20180610150727.GE27650@jessie.local/

I'd support that design decision, FWIW.
