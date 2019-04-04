Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6ECEB20248
	for <e@80x24.org>; Thu,  4 Apr 2019 21:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbfDDV3Q (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 17:29:16 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:42855 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbfDDV3P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 17:29:15 -0400
Received: by mail-wr1-f50.google.com with SMTP id g3so5534078wrx.9
        for <git@vger.kernel.org>; Thu, 04 Apr 2019 14:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9pNRxiI389Q3KqXdt35MAXN5OXD617bjqrIVFxGmbMg=;
        b=qDaw4zVhNjcezBst06gj+DlC/FM3aN9N6Rb4u40xbwZ74PdUVyMhSvkyHk+sFyFP9E
         tQvcrFFoa54oCl9IzvmpxWotU1MvCsmsn0kRBQg11FXocy1lRdL0K/1CTNsfGYRYh0rQ
         4bYnvI7Jw71ZQ99E7i5Fh5yteiqy7DxwSE5K9iQoxLz+c9Xu4zGg1cAgCr0Gt48PacGy
         5WTWExRYo+9bj9t3ChpA52uV1CiRJaAhJV5Yc5zxmaF4Oys2+UZBu1crhg1GmpHzXtOQ
         /7u+Y8/h2rp8M+BH+uMBImWHAQGUuFJcVX/4kBS9IeRIam4qsUNWJUTYTkvsGTxSwakX
         Lp6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=9pNRxiI389Q3KqXdt35MAXN5OXD617bjqrIVFxGmbMg=;
        b=f/Enjb1NsKzR0uiLYtv5lp36BJ+qPEh9LcA4Y51YDJnBfOuscTDKoW2Pm+yM93IpjI
         y1uu57P+etouVTvAtSvm3KhahxaRaXhvk6T/345FKqm+k14tFEtEW3qxcSzIxb0fvhiA
         /a7Go+o/UOQz3PSqAOQKxHL3k/R117/KgDX6LS+58B0EpamX7lHI/6WOEEQ1YZBhzhbU
         ChSRy3XTK6K0nTWJcaMzMj2bW7BcpSEJkthS/iAnk5EaVcC3WO+V+6WAKzZTzv9KT5Ak
         1lC/pdlcIUx4hyAvaC5d6SHeJN0whbcQOv9irKWo2XYjZw1USAUmi9HeIXxAvsCHHmCk
         cZWA==
X-Gm-Message-State: APjAAAWTeYRLml00mXZsWTQMgL8OjBusRqx+2ub2Y5wr3C5cToVaNHiX
        BYRKE+Zk9L5OnnsD9Y+SGSM=
X-Google-Smtp-Source: APXvYqwMcIdlo+QOl1EMXVxrnwq1x8nskkbRXisXlWQ+wfFjMPdmjHTKG0YqcKL7qyLCNUCd3T9ieQ==
X-Received: by 2002:adf:e94d:: with SMTP id m13mr6168848wrn.141.1554413354116;
        Thu, 04 Apr 2019 14:29:14 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id g13sm423967wmh.11.2019.04.04.14.29.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 14:29:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Apr 2019, #01; Thu, 4)
References: <xmqqr2aidpxw.fsf@gitster-ct.c.googlers.com>
        <CACsJy8CmkFNv7Fy+rSY0Q=1DhYSrpSfU=XEpSS6QRLASJtsVew@mail.gmail.com>
Date:   Fri, 05 Apr 2019 06:29:11 +0900
In-Reply-To: <CACsJy8CmkFNv7Fy+rSY0Q=1DhYSrpSfU=XEpSS6QRLASJtsVew@mail.gmail.com>
        (Duy Nguyen's message of "Thu, 4 Apr 2019 18:08:25 +0700")
Message-ID: <xmqqmul5e9y0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, Apr 4, 2019 at 5:29 PM Junio C Hamano <gitster@pobox.com> wrote:
>> * nd/precious (2019-04-01) 1 commit
>>  - Introduce "precious" file concept
>>
>>  "git clean" learned to pay attention to the 'precious' attributes
>>  and keep untracked paths with the attribute instead of removing.
>>
>>  Will merge to 'next'.
>
> There was no conclusion from the last thread if I remember correctly
> and I kind of gave up on it. If you want to include anyway, should we
> go for a more specific attribute (e.g. "clean") and leave "precious"
> for later whenever it's better defined?

I'd rather pick between (1) using the final name for the concept we
want to eventually achieve, i.e. "precious", and starting small,
i.e. "initially, only git-clean knows about it", or (2) doing
nothing.  Per-command 'precious-this', 'precious-that' that would be
left as interface wart for years is not a pretty sight I want to
see.
