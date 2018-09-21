Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 103131F453
	for <e@80x24.org>; Fri, 21 Sep 2018 16:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390568AbeIUW26 (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 18:28:58 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:52428 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390065AbeIUW26 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 18:28:58 -0400
Received: by mail-wm1-f51.google.com with SMTP id y139-v6so3690993wmc.2
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 09:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=XtU8iYwBqou9WgdpGettFVzmbmCtsWwAxYnB6scwBIU=;
        b=ptJKrz5uDbZpRmCANM6NdxrqNGbV5kCaE3WaEfqD2TA1GclEyOkOjmv6M4U3r5pzsz
         Fc25xB/fM0xulEMEkU85Si6keVFZYD3gOE+YlznYBMdW6hqV3vBlHR3eW7ND4YrE3yzw
         DVzj/qdYBYzX6MVQbX1cmFZWXa3WKdQA5y8h0chdKtBxahWYTcx1YWNvyTWVnb6A18E/
         keCvoPbWb1Ykm8DG7e1pWan9vb7WdRvSZwo4qvzXwXhQPk6o8EwzTtRaVfGDUR2MUcWu
         kdDS+yWyMeoKBn6YxClb2PaoxX405tVnln76Svg7BzRf6xmwjZeO4Vzy1X/VHYkjk1qP
         9G3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=XtU8iYwBqou9WgdpGettFVzmbmCtsWwAxYnB6scwBIU=;
        b=Iyl/XQW2HJFn8d/NcDbBRfI2TWdnQjh2Ie3jx1S6n1Lg9PI6Sd1VA1ZEjZEIRNwMhO
         JtoBAZqtan6sSrOM0yqDqQvsYiLj5JGexXvs1gz3NpvVjBeE1tCXQz9jkw5Oj5RmpbQ1
         B8p/AdHLLt48+8kzr9sW6zJjzr6LWp6fGVv6CWRVOD01ZMwV0vlbvk4pFzoBXHX/hWMx
         B/gsVJ2qQOPLEj5rAkyJfoxn6e1ENybJA5mNcqT0cDOzTWdDmeZidFyhyOQVKeXz0ujo
         FgyH6z1/4zV2wwFc514RGRaxsxBHKjaWhbTTe56G4NqSsdLPuF6bfWEfMYa6qXYGZyoO
         5/2Q==
X-Gm-Message-State: ABuFfoja4e1BGPULqgQZqZbJ5njFvHNlwwS6VpDJrsONL2+aO09O88Dw
        IFvR1aThHvjmn5SfaGKB2I+4pCdE
X-Google-Smtp-Source: ANB0VdbF9vIO/1B6FsLOVlj32F5Wc9P8QeKQwxCwWt5BuLPkN95LgUya5nrKAAzkFWlWiRT+ElypAQ==
X-Received: by 2002:a1c:c3:: with SMTP id 186-v6mr8443568wma.126.1537547955113;
        Fri, 21 Sep 2018 09:39:15 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id e133-v6sm8138314wma.33.2018.09.21.09.39.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 09:39:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <ttaylorr@github.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 2/3] transport.c: introduce core.alternateRefsCommand
References: <cover.1537466087.git.me@ttaylorr.com>
        <4c4900722cab253b3ce33cb28910c4602ce44536.1537466087.git.me@ttaylorr.com>
Date:   Fri, 21 Sep 2018 09:39:14 -0700
In-Reply-To: <4c4900722cab253b3ce33cb28910c4602ce44536.1537466087.git.me@ttaylorr.com>
        (Taylor Blau's message of "Thu, 20 Sep 2018 14:04:11 -0400")
Message-ID: <xmqqlg7ux0st.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <ttaylorr@github.com> writes:

> +extract_haves () {
> +	depacketize - | grep -o '^.* \.have'

Not portable, isn't it?

cf. http://pubs.opengroup.org/onlinepubs/9699919799/utilities/grep.html

