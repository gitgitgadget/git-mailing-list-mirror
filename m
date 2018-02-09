Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 996F61F576
	for <e@80x24.org>; Fri,  9 Feb 2018 08:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750973AbeBIIWw (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 03:22:52 -0500
Received: from mail-wr0-f176.google.com ([209.85.128.176]:33159 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750925AbeBIIWv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 03:22:51 -0500
Received: by mail-wr0-f176.google.com with SMTP id s5so7334238wra.0
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 00:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=eoVBuOygmCh2HvWH5we/PVOS6WgbfMGUMB+nQuyPRsk=;
        b=ampGw+1upVuh9p6/rrlKJmN5DtV9vlvMJtqmeBKCSbcBvs4zGmXAcfCll/IjtcPFTL
         HWAj89LrjnTQKL1g/JMH7cPcA55ZB3q2oJvDNdOxwJpWh1XoAJT31QIhpiR9wIVs0G2T
         d4FLW0A6pUv9cb5IHXNlNJfPhYxaxMhBw+zIR2o4519Qxm31s82xaaDnJeMquTyGo57g
         /3l5sjBLPstUbhmpWV9xRlKJYgL8PFn4RLrWry54ggOpgEBOAxTXrHukF0DNw8WSb76I
         3VCfxB42QGlYTFMRWbAyszegbnuN1UP27lMR44xmqoaKRi9fOhXP5ssCjj8yfG7iOWBX
         uovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=eoVBuOygmCh2HvWH5we/PVOS6WgbfMGUMB+nQuyPRsk=;
        b=lK9orNdRN+Cud5XaDYc4+PZEOyZbLOcR13XYYWv7crwll33aFi6VahgiBJCdViVpAX
         gSZIXBY4u4VOPmO762a/dJevuIZoHmn4p3bhiGiTLjEiNVI2GsnluZH0GuvHhgi3Qnng
         1BJNF9jHiP5xFR2SZsuh+qtrTo1lfGcmN7HaLza3vkXWWNhlrqtrns8XEs44OTO5/jq9
         nHY6KLDEkZ59ppdT03G2p5iS/qMQZ0WsIQ5VrTP/zhYWdHAoVaV797IDeqPgI8boK8gO
         dfq2oSlAQJWtaSx3sLDNHZcYmMANdhPeo/qBlZydqwQWX/v7DVLYk1sn0nTxl702jR1e
         x/Og==
X-Gm-Message-State: APf1xPAdAY2eiJHXT6MhQbJZe/+jB6tpPS+9vEDhQiN6YZf5NOnaEcv5
        y58F/M/pvpntLwg313eUTQw=
X-Google-Smtp-Source: AH8x225cvdFb2Lp0P18ItvnezkEcXekbSLbSkmSRKPwkawra4KwEF6NVf3xkYOd3wk78VqcIiR2WZg==
X-Received: by 10.223.182.3 with SMTP id f3mr1681268wre.92.1518164570162;
        Fri, 09 Feb 2018 00:22:50 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id z11sm1286657wrh.60.2018.02.09.00.22.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Feb 2018 00:22:49 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v2 17/17] fetch: make the --fetch-prune work with <url>
References: <20180123221326.28495-1-avarab@gmail.com> <20180208161936.8196-1-avarab@gmail.com> <20180208161936.8196-18-avarab@gmail.com> <CAPig+cRJzKF9a4=-qkdUH1kUzvx3azf_gY85yqU0Y7NHXTJrdQ@mail.gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <CAPig+cRJzKF9a4=-qkdUH1kUzvx3azf_gY85yqU0Y7NHXTJrdQ@mail.gmail.com>
Date:   Fri, 09 Feb 2018 09:22:47 +0100
Message-ID: <87a7wimv1k.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 09 2018, Eric Sunshine jotted:

> On Thu, Feb 8, 2018 at 11:19 AM, Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>> fetch: make the --fetch-prune work with <url>
>
> Do you mean s/--fetch-prune/--prune-tags/ ?

Yes, sorry. Will fix.

>> Make the new --prune-tags option work properly when git-fetch is
>> invoked with a <url> parameter instead of a <remote name>
>> parameter.
>>
>> This change is split off from the introduction of --prune-tags due to
>> the relative complexity of munging the incoming argv, which is easier
>> to review as a separate change.
>>
>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

