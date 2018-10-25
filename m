Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7F501F453
	for <e@80x24.org>; Thu, 25 Oct 2018 08:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbeJYQnR (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 12:43:17 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56010 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbeJYQnR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 12:43:17 -0400
Received: by mail-wm1-f68.google.com with SMTP id s10-v6so531372wmc.5
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 01:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=1j3Lq1Bs81aZz6B5hMPTJmemgpThYjpIsTVtMMTzDnw=;
        b=HX+tFVIZZPeTV0zBh2MVszqyJHNDM07PipKTFsIArIGh4r4jHfEX7QjHIeWA/mkMOU
         b54fuk/2mD/xb4QAabgM4Vlb5Yorkgl2DGg5R6OCSj9upy1ZkwzkCAL6mYk2I6jmfT8c
         Duk344yl/E0eh/Ua3maEyGqwq3bz1wmF6cOfOihPVt6tYnxNyKLIRH2SZF5wcyxBVV8N
         xvZyLV932ynh45Hnaz1FBORp55fvjRezKYWQFz4jHvSUWUNTC00wsP3kfm6lVEt5UOFi
         niJ2RN9FqBFUBpPiTE00QY03W4zoHMRiIefvJquvNjFefB2gOZwXUh5WnuV0kP4yryLr
         aFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=1j3Lq1Bs81aZz6B5hMPTJmemgpThYjpIsTVtMMTzDnw=;
        b=N7pLVeHKTztNRz2COyRnJfYbiy3dMgz015ddx1IF4iICIW0xcP7q0vpk6T0ADcUIvv
         Tf2rUvKee9J3IWucYGm7s20CQfvG7dAokNFacQ0k8hwEhzfvAtrOhTjMEwsjYnu9t85C
         n8tUhpp8oRtCz+OrzB8xo/byGXzAXRSLjWQGe25mcAWzkUZVZluj3Wu8v3QPtudTlYbf
         HMFB0AbVeb0XwkmyfDz6CxyVNSOUQvwW8S+3O47yW6OKZoFyQzAaHKYr7HIlHxEWVf0K
         upBZIGLIXA0hXSuj7Nsr9wdu2vMYT6ta/BhiJTydxg8uD5HqdWd4BIpCbqeCGcu72am4
         HW0g==
X-Gm-Message-State: AGRZ1gIYU3LwMzsGwG/bemtSlvbeK4OHMG2ZW6x1RHqpVoehmX4axQnG
        EYHAYN1dA/3h3MaIGPKI5+Y=
X-Google-Smtp-Source: AJdET5eetqvlUg1fIk6RiM8pdChi6cVv9nrDfhjqdETTv6M00gx5QoOFchI+KTzOPex3iItBYpyjPQ==
X-Received: by 2002:a1c:41c5:: with SMTP id o188-v6mr823400wma.34.1540455096244;
        Thu, 25 Oct 2018 01:11:36 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z6-v6sm1666382wrt.13.2018.10.25.01.11.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 01:11:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 00/15] Hash function transition part 15
References: <20181015000202.951965-1-sandals@crustytoothpaste.net>
Date:   Thu, 25 Oct 2018 17:11:34 +0900
In-Reply-To: <20181015000202.951965-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Mon, 15 Oct 2018 00:01:47 +0000")
Message-ID: <xmqqsh0uigy1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> This is the fifteenth series in the ongoing hash function transition.
>
> This series includes several conversions to use the_hash_algo, combined
> with some use of parse_oid_hex and GIT_MAX_RAWSZ.
>
> Changes from v1:
> * Fix several other substantially similar issues in builtin/repack.
> * Fix a comment style issue.
> * Improve commit message as suggested by Stefan.
> * Pull in Gábor's patch and place it at the beginning of the series.

The previous round had attracted a handful of suggestions for
changes, and it seems that they are all addressed here.  We haven't
seen any more input, so let's move this to 'next' and to 'master'
soonish.

Thanks.
