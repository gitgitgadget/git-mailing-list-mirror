Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 722301F597
	for <e@80x24.org>; Tue, 31 Jul 2018 19:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732082AbeGaUz2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 16:55:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41135 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731907AbeGaUz1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 16:55:27 -0400
Received: by mail-wr1-f68.google.com with SMTP id j5-v6so17776637wrr.8
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 12:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=6q++Uixnv/XZFhGlEPjfTIP5PF/k1jROUbw6oW741BI=;
        b=nkU3uYeFPg4FUrJ4FhcmPQX3IWSnYlrpkuCgXI0BC8rkS1S0b7Yul+V6odUGlEQFjm
         kiSGU2f9X0S+I8DDcQ/oa8oSdvxBnWf1tOutTPwfk9FqAbjsAXNNuRcANXf3O60u7hWp
         u6X4ySrad+u/JayzchLOE4QlZ7MqEt9tcdcrNBy1m6fuazX68Q0RccQujr5ocSIY6Z5v
         Expgs19bMWeRRSlOAVGH5Rv0IvWMMcC3OMN5V4BsleGCU5GVOHWtYjHKDxOLDIJE0DoQ
         /cYEElXf/HqtvD5wJ63k9Vw+mAL9uMHmjDUp0wX+1nDvgk9aUFFuFsrHsebbg8TQGXjW
         ADMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=6q++Uixnv/XZFhGlEPjfTIP5PF/k1jROUbw6oW741BI=;
        b=JLQeMkBIkI6KUI+utnLkFg0/lB6ZrkIUhrc2yZTwlEw+91kK3qvmXwX3IHVs+3SJiX
         lezfyzGwj2JZ/OqZeGUbXCUFuJFklUqs2sUAig8Ex0WCQ0JRX8kJ70aIhTxZJHbo1a73
         Lhn44bUV766gv6e4WW1HNFriO5PvOgj2ScOeChzZM4s+y6CJbqJgnlZKsQ9u2jbsnlMx
         ETdfhonXz6XTfQofHn5akF4MefxWJUwKL+rFdQDiqzl8Kl7Yd6y+uE2wlZNd+jl+s2un
         fyqWQomRIOyZBBDxEhaukkkXN/AWvgfip8swBxuqBdjRtqJJj+uu+hS9GvmKSRVnEfp6
         cdMQ==
X-Gm-Message-State: AOUpUlFmvmsspJmcmQBtfNPQEUExvR3DJSy3UifZyp3Yy2BATStC3x4k
        M+LlHcUyOZP6P+znU8W7WHw=
X-Google-Smtp-Source: AAOMgpcHY0kVt1DWjkdXI6gJozpg3ilDZGX5d6xeXuV+iTK2e5BiYx8UWRZcL/yWAw9DvgVrgWhd6g==
X-Received: by 2002:adf:df07:: with SMTP id y7-v6mr20739266wrl.117.1533064422938;
        Tue, 31 Jul 2018 12:13:42 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t69-v6sm3194816wmt.40.2018.07.31.12.13.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 12:13:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     peff@peff.net, git@vger.kernel.org, pawelparuzel95@gmail.com,
        sandals@crustytoothpaste.net
Subject: Re: [PATCH/RFC] clone: report duplicate entries on case-insensitive filesystems
References: <20180729092759.GA14484@sigill.intra.peff.net>
        <20180730152756.15012-1-pclouds@gmail.com>
Date:   Tue, 31 Jul 2018 12:13:41 -0700
In-Reply-To: <20180730152756.15012-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Mon, 30 Jul 2018 17:27:55 +0200")
Message-ID: <xmqqk1pbb4m2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> Another thing we probably should do is catch in "git checkout" too,
> not just "git clone" since your linux/unix colleage colleague may
> accidentally add some files that your mac/windows machine is not very
> happy with.

Then you would catch it not in checkout but in add, no?
