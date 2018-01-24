Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC1151F404
	for <e@80x24.org>; Wed, 24 Jan 2018 18:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965011AbeAXSJl (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 13:09:41 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:45417 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964961AbeAXSJk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 13:09:40 -0500
Received: by mail-pg0-f65.google.com with SMTP id m136so3239279pga.12
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 10:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=OjJrRAtGWMTAmvg8Sd61Cwr1c5zws8s/JaDQ9ck+UXE=;
        b=gmErCEtBVO37z8ee0Bd4VlkZhJBdATFBZpodFzUvX5qT49NARz8rXynS2FflkSIk0N
         gGmcC7ljSSwQveesE7U/COXMDaFuJ0qxsSEdQfBsFt53xbL5JBWnEDTPOjyENBsikvfM
         9LRgacs4VFID4RwdfWZd4UYmcF7Tayc24w3hq8mrHnxN1k/bo1T7nEAsapBI/efLd+9x
         2ABElGGHdC/90JozmcC5LciR0ZcImK50Cj5M3dxcEXMr7nWTHZDgvMk0ci4nwxd5ngnE
         /9US+GWxFNHD9NBR43zP1IUIrOIqWmPxlm39CT8MYJvxQVsJcQajkzbcpgH/e+WCWxvA
         vXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=OjJrRAtGWMTAmvg8Sd61Cwr1c5zws8s/JaDQ9ck+UXE=;
        b=Xgl/CRfkS2hC1KTTFL3WcC0PcOYb/ohyYH4yxwYTJEn6qpKannupI7y2tNbyt/CzVn
         Ug4cXUgbYFlgN0qUW4jMpk/JlGPYOBI7Q+C/AXpkeXpJliUZX8sjzWbKJiex5MZ/VHOJ
         kUMV53qIg5+9ySUWmxGooOcKCw/FVp+ST2lIlphE9lN+E7C1fRuK9qR99pWw005VMyR1
         8lrBPiaoOyZe4+kWDX4wZgI6Xef/oaPZJP7yT5Os6jmXcc9jtrSuYj0tJr7SDK5U1n2M
         4vH7zg84o4vitzi+NnxxRDrwCjAqM4IwFsxKNYurARFiaulzz96WZH7PJEelLZ5N2gfL
         pOvg==
X-Gm-Message-State: AKwxytfckHmDmT0/ZN4smxgfwe5yQSsB3DB8V3q5mckV9DMs2X3eo1rT
        YCeAFeM5KIJYvHQzTjG3KiTtg5LKUJk=
X-Google-Smtp-Source: AH8x225tcn1BbS3SNGEbelGK4jk8PY/NfSkerYGXQDrqaV+YN/fBJxMtflgJhWE9nTIGdW2pyR27rQ==
X-Received: by 2002:a17:902:d217:: with SMTP id t23-v6mr9082391ply.303.1516817379650;
        Wed, 24 Jan 2018 10:09:39 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:69e6:5f42:e334:a0e2])
        by smtp.gmail.com with ESMTPSA id c185sm11043767pfb.146.2018.01.24.10.09.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 Jan 2018 10:09:39 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/3] nd/shared-index-fix updates
References: <xmqqfu6xjxrx.fsf@gitster.mtv.corp.google.com>
        <20180124093829.12966-1-pclouds@gmail.com>
Date:   Wed, 24 Jan 2018 10:09:38 -0800
In-Reply-To: <20180124093829.12966-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Wed, 24 Jan 2018 16:38:26 +0700")
Message-ID: <xmqq1siff7rx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> This makes the new test need both prerequisites SANITY and POSIXPERM
> instead of just SANITY (on 'pu').  This is how most other tests do it
> so we do the same to be safe.
>
> Nguyễn Thái Ngọc Duy (3):
>   read-cache.c: change type of "temp" in write_shared_index()
>   read-cache.c: move tempfile creation/cleanup out of write_shared_index
>   read-cache: don't write index twice if we can't write shared index
>
>  read-cache.c           | 40 ++++++++++++++++++++++------------------
>  t/t1700-split-index.sh | 19 +++++++++++++++++++
>  2 files changed, 41 insertions(+), 18 deletions(-)

Thanks; let's move this to 'next'.
