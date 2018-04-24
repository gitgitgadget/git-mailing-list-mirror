Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CC5A1F424
	for <e@80x24.org>; Tue, 24 Apr 2018 23:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751155AbeDXXoZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 19:44:25 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:51911 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751104AbeDXXoY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 19:44:24 -0400
Received: by mail-wm0-f48.google.com with SMTP id j4so4110935wme.1
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 16:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=BHCgN1vkSBUZoziGCleqm73a9KKg2sQwv+DxmsUE/Sw=;
        b=FNidO+hhswJfIsialgxxd4AHjOXnAo1Akd5MCLPvYt94nHYYFwVaUCB03iPT6vMXQF
         P00bknggJbyjC2SNkzgsucx/61yiaWGCacd5HSC8siXB6hGp5u5aLi/NQowMcFJj7sel
         JdPeoeFl+16izU4PibOJMz/f3pdNxq5tgLZSI83hdU7BDXuiEKPl5WivDSDoAnhmwWMv
         r46H/ZFfIc+ayejckp+l5eS1Je5zNpxYI1mSolyJHVdVG9HybhCMLAuOq7qWhrAXYMiT
         f9V7wnP3zcGVGtlMTdqBZFutHMUy71HGNkmORitN+xGUyaglnFWwyRdE25uZUlQWa//k
         oM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=BHCgN1vkSBUZoziGCleqm73a9KKg2sQwv+DxmsUE/Sw=;
        b=j7Qj0tlC3WGngrZUgoLHwvk6n4yiE/dW7nlsdsN1EYp/6+Ha9uLKr2pR7rBEB5/lSM
         dLRR3dUOEtiDLQkF6wv17Pfi5PMvsdatwWJsooYTQkG+gEbfI18u7cEOM9BbZhBkCSu+
         cuIB7NIjhIeQxIRFQLJRxbcHCazxtGZqTaBGIAO6jtZrnz77cxo0ZNpgmJwChjzQMufD
         3t4foJEVYfeMdSAZbiJjIIkYZ8wX/aMV94NfD2sjVEwuc3x5UoA3ct6/yWiRtO6exPHF
         nvULJgMRJhRWjrAghrnmkAMgeyfIcl2BE4Vmk4gOMFS0s284f1ktCthU9/Ca/J3TiAC6
         E70w==
X-Gm-Message-State: ALQs6tAF0dE5fyoL0eYwpW59kzEUCovoFarFiuYi9w21M9icDxj0qYwA
        8pYz1Z9JffV3vWEPGR7t7WT52zgF
X-Google-Smtp-Source: AIpwx4+Ny4i1OzC+4ftzqDdkowhnt3Q13kFck1+jgVT3Yta9mTvX3pkmpnsncCM9zcA4D/le9GhvkA==
X-Received: by 10.28.86.6 with SMTP id k6mr13162551wmb.100.1524613462611;
        Tue, 24 Apr 2018 16:44:22 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l53-v6sm37123613wrc.80.2018.04.24.16.44.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Apr 2018 16:44:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 21/41] http: eliminate hard-coded constants
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
        <20180423233951.276447-22-sandals@crustytoothpaste.net>
        <CAN0heSoCsFYqDmwTRCzh2FGDnOghBqVBTCOa7yEw0jtQ3LxDbA@mail.gmail.com>
Date:   Wed, 25 Apr 2018 08:44:19 +0900
In-Reply-To: <CAN0heSoCsFYqDmwTRCzh2FGDnOghBqVBTCOa7yEw0jtQ3LxDbA@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Tue, 24 Apr 2018 11:53:33
 +0200")
Message-ID: <xmqqpo2o5fvw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Ågren <martin.agren@gmail.com> writes:

>>                 switch (data[i]) {
>>                 case 'P':
>>                         i++;
>> -                       if (i + 52 <= buf.len &&
>> +                       if (i + hexsz + 12 <= buf.len &&
>>                             starts_with(data + i, " pack-") &&
>> -                           starts_with(data + i + 46, ".pack\n")) {
>> -                               get_sha1_hex(data + i + 6, sha1);
>> -                               fetch_and_setup_pack_index(packs_head, sha1,
>> +                           starts_with(data + i + hexsz + 6, ".pack\n")) {
>> +                               get_sha1_hex(data + i + 6, hash);
>> +                               fetch_and_setup_pack_index(packs_head, hash,
>>                                                       base_url);
>>                                 i += 51;
>
> s/51/hexsz + 11/ ?

Quite right.
