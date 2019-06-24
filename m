Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5F8C1F461
	for <e@80x24.org>; Mon, 24 Jun 2019 14:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbfFXOYQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 10:24:16 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:32776 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfFXOYQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 10:24:16 -0400
Received: by mail-qt1-f195.google.com with SMTP id w40so4086262qtk.0
        for <git@vger.kernel.org>; Mon, 24 Jun 2019 07:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qZN6kI2KFPe8ec54XTVDjnMespgn20eIpv4z4GJ/1oQ=;
        b=lc/q1Mz/FDqnMkVn0xLEI7WJYgMudwTZ+W4eNh/rq2tpQenVOP6bsrgk7+4NJIK3+3
         mtQNtQ5kbSSeYGdaGjuOvqiTsrr4nRber+7hya0+XyJNO9VAi7V8Y89zu8PlOu7/lu7Q
         LG668iRT41ydnbj3x7xu2UbW7xIvLk2+85FhsjjNFqeOndojY0X2dwIMJpYG4Lcw/Sy5
         1lprBzRRAX1+0P/EQiOEq3X22lLaWKhaHMBVZKo9kToiNWQjvQVOKmn7UXrCG23iQdo+
         G5EIWuJZjsSm3Bp5JTVtA9XPKlqr17d2QrcYw2rOB4wNnWdUScpOsRzIz7gRiB5ZC8DD
         P5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qZN6kI2KFPe8ec54XTVDjnMespgn20eIpv4z4GJ/1oQ=;
        b=hwGX2a2zwdBQc+dX9WD2OtFZicXFd39xI7cHZ3N1zKojGk8OVIjp/ImpLi9whVWmuT
         XyPfO1CTMXkx3Z+P7/bPLfgtrwdnnX7yPmhx8hbJ6h+QxFv+Oo+/cOa7jTo5yEqC3wLE
         /Xwea9KCtdjfavnvLeDKIn9R6BVZrK7MESYUdUNpvfhqLGom4l5CdgtyXOI4ZQ0eEeR/
         R9RpofuVTUMvtK0vYUt3bEE8PDCbPPFmOO0arylhKC7+IYbVaj6SsuXKn9QcfFkhzN2O
         uvibcoFl1oJwAV91GCY31icjQp7631FWpe/pm5X0oFlieFC1DMqNsulq+hoCznWcYh2f
         0KWg==
X-Gm-Message-State: APjAAAVrF+tSQ5Q82RUQN0hWI+m3YOYcC5SPHS7/AthLHRSous3w7FLv
        aUwjBlug6QKI+G7GSqiVjs3dNNgH
X-Google-Smtp-Source: APXvYqxh/mhPSLkWMBL5Pc7Q8NelEjm1UDFy1VhLGtqG1oxVWp4AmK+EEu0eoWr4/zpb1l/cNLt0bg==
X-Received: by 2002:a0c:ac98:: with SMTP id m24mr42301891qvc.9.1561386255694;
        Mon, 24 Jun 2019 07:24:15 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:bd0b:1518:483a:73eb? ([2001:4898:a800:1010:6e41:1518:483a:73eb])
        by smtp.gmail.com with ESMTPSA id w56sm6463102qta.72.2019.06.24.07.24.14
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 07:24:15 -0700 (PDT)
Subject: Re: [PATCH 6/6] Use the right 'struct repository' instead of
 the_repository
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <20190624095533.22162-1-pclouds@gmail.com>
 <20190624095533.22162-7-pclouds@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <166543de-bc25-ca2c-326a-4497688aa235@gmail.com>
Date:   Mon, 24 Jun 2019 10:24:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190624095533.22162-7-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/24/2019 5:55 AM, Nguyễn Thái Ngọc Duy wrote:
> There are a couple of places where 'struct repository' is already passed
> around, but the_repository is still used. Use the right repo.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>

nit: the subject line doesn't use the standard "area: topic" format (including
the capitalization of the first word). Perhaps:

treewide: use the right 'struct repository' instead of the_repository

The changes here are straight-forward, but how do we check if we are done?

Thanks,
-Stolee
