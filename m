Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SUBJ_ALL_CAPS shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A645820A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 03:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbeLMDPQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 22:15:16 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45549 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbeLMDPQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 22:15:16 -0500
Received: by mail-wr1-f65.google.com with SMTP id t6so276937wrr.12
        for <git@vger.kernel.org>; Wed, 12 Dec 2018 19:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Kdkafd6VivA6AiARjtGdFDRgdpaLI6tQwuJ/C6CJDxE=;
        b=jF/ioZ2RN7C7DVRxP7DSCR25lenZjol++kYZq641IIII/FUtUcZpjRIQpl46UTmRsN
         S6EQnIiA2WqJ/Kugs6U/GKWHnBC+iUsD62UW8/PTP9pUQn7iqgSHYo9fc/TvHuTjqiKl
         jDgJxEOMJBkXN8BYc4lbg7dWue/BtUcDNsj1bMXv6ILp8UQ/GV/ZNo0hUZJN3/TeE7np
         8wkgRZICYmAB5WC9IDEHKfFwpkTxhpV8cJdKWRUDohOIdwbW5M/MzhPaSBWvSTHN7ia2
         s6A2VbcTloKJ4TmHnb2URSx83PZ052q8faoNHErcP1WiWBa5beb5dC68g2AepYqSALxk
         xx4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Kdkafd6VivA6AiARjtGdFDRgdpaLI6tQwuJ/C6CJDxE=;
        b=UUGVnl166/+KBfQWVYhWfOZXPbZG9W/yac2N+Usyy+e9ins9KyJRiil+VCNGc41J0Q
         Zz1Hv3K8QCzI4kGhySX8SXbkw1lnmK8jF7J07QYsITTdYRSNypbwNGzBS5xl3cJA49YY
         NiHLn6utkRxHVKCowiCmp3CgK9+TWH1+rzkr6w4xWsu27DTo4oOu2r8gpyvwAfuLGmEv
         yTT3nCkMyxquq+nJJpbQPsPd62s+koY293oQXhxqfhMgGaTL2x9TtzjVUl43pDBeNiuJ
         59IrCYqiIn4+awv6FxVHTVNvFMksfMwv9CwQ/vC6p/n59vfkjZHI1Bip9mZGwtkrNuiI
         l9VQ==
X-Gm-Message-State: AA+aEWaHZnCZP5njhGgU569jruayribp5XjKCTwo0qfe1udk78/HiK8h
        5DCvuFXoUKdSsM4Ah5VRLuM=
X-Google-Smtp-Source: AFSGD/W/HZlMt9vQQqiAYgG1Wl1qhd4qXc7TgLFSb5BF8Ky8j9SWT2a1BTDlvM23gJSwkAXD0vjPvA==
X-Received: by 2002:a5d:664a:: with SMTP id f10mr11721662wrw.311.1544670914134;
        Wed, 12 Dec 2018 19:15:14 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v19sm599796wrd.46.2018.12.12.19.15.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 19:15:13 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH 0/4]
References: <20181207235425.128568-1-sbeller@google.com>
        <xmqqefas8ss4.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kbPQx4Z0FHioQWxUYoJOKU0TxZXgxEDPFE7XQCMxtRqaw@mail.gmail.com>
Date:   Thu, 13 Dec 2018 12:15:13 +0900
In-Reply-To: <CAGZ79kbPQx4Z0FHioQWxUYoJOKU0TxZXgxEDPFE7XQCMxtRqaw@mail.gmail.com>
        (Stefan Beller's message of "Wed, 12 Dec 2018 14:35:10 -0800")
Message-ID: <xmqq1s6mglry.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>>  - now these three changes that were problematic in the past is
>>    resent without any update (other than that it has one preparatory
>>    patch to add tests).
>
> One of the three changes was problematic, (e98317508c02),
> the other two are good (in company of the third).

Ah, that is what I failed to read.

> This means I need to revamp the commit messages and
> cover letter altogether.

I guess that would help future readers.  Thanks.
