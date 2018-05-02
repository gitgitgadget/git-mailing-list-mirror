Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SORTED_RECIPS shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D70C421847
	for <e@80x24.org>; Wed,  2 May 2018 12:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751455AbeEBMmm (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 08:42:42 -0400
Received: from mail-qt0-f179.google.com ([209.85.216.179]:46860 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751196AbeEBMml (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 08:42:41 -0400
Received: by mail-qt0-f179.google.com with SMTP id m16-v6so18114405qtg.13
        for <git@vger.kernel.org>; Wed, 02 May 2018 05:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=MM38DiHL37tVsdfhzPThEETqyvDEeGjWP3mO+HqWygc=;
        b=OxgGq4J8s50HgvmFMxTyy4KlajtAIK4cn9S85F6XPv6+E1iobmTNweQtNGfhiafqHy
         ogn0iBPvvtK9DL5+uP04Q1pjxB4AEcZYXiyRxqbyn089U/XcQyR/Lbq/dse1u8b/hLxI
         50CaDqB4LNGq0ywq/RhF9adLLMMaowTk4EAZ3A3nGiXUKVtXihrsbJzFKoxVCDKmcb/o
         9osYury4dSCU74lSZP+zyLl5mbVXnJDAYQy0bHq0Mz/GBdtaCj1K76Yy3xnl5cw5gjIS
         Gc8R97MLfHVIUXSUaG6QedIyxFb730i3A+xHfJIph0uLbIev4iZk2ivrAGnhRNgi4Yb2
         jXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=MM38DiHL37tVsdfhzPThEETqyvDEeGjWP3mO+HqWygc=;
        b=qfYrf+1HOU0vYhkhGbWMB8LC3AqR35pVMEdDyR6qKtrYr0JPz98J9wZOcj6Q89/qnj
         +B7qaoJoUYRxW7ZQ3wOYMf7EfDvjWSxPZAUf1EiTOVr+pmKDJGDNVeSMAbkJU9Xp4/Qk
         E6qC7GDFxrj5HGwYLzhPqbcI33/RQkrLngw10kP+kLGWabIXcl+9M3rJGcqWdLLy8JvO
         QIojC/PbokY5cLqLT3JkpxHV6DSeTdFzlue+5FfzpMtZQgZwQyA9VSKn5axrio8OkLra
         LxPaPpTR/iDJlw4wwkKvBPWWh8L+NOdoQgnXaRdNHaqXGINFON8mxVAtK4aCw+ErXZD8
         vZYQ==
X-Gm-Message-State: ALQs6tCsrPNNoq3N0XsFpMEUFpP+wD2QTCP3+dLJXVtc+OtbTgn/Zdwf
        LcTmQC4Uknj1cFvib7vwY6I=
X-Google-Smtp-Source: AB8JxZr4DN2qLrlx1y42XKp9uIuF8tz/rj8f4OzGCU7cidEpAMM9Z9kKE+YcyeRYMvpg35ANRieK+w==
X-Received: by 2002:aed:3327:: with SMTP id u36-v6mr16887196qtd.422.1525264960878;
        Wed, 02 May 2018 05:42:40 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id u50-v6sm11365082qth.0.2018.05.02.05.42.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 May 2018 05:42:39 -0700 (PDT)
Subject: Re: [PATCH v3 00/12] get_short_oid UI improvements
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20180501120651.15886-1-avarab@gmail.com>
 <20180501184016.15061-1-avarab@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f35aeda5-8f41-f457-736e-393e95f530ec@gmail.com>
Date:   Wed, 2 May 2018 08:42:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180501184016.15061-1-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/1/2018 2:40 PM, Ævar Arnfjörð Bjarmason wrote:
> The biggest change in v3 is the no change at all to the code, but a
> lengthy explanation of why I didn't go for Derrick's simpler
> implementation. Maybe I'm wrong about that, but I felt uneasy
> offloading undocumented (or if I documented it, it would only be for
> this one edge-case) magic on the oid_array API. Instead I'm just
> making this patch a bit more complex.

I think that's fair. Thanks for going along with me on the thought 
experiment.

-Stolee
